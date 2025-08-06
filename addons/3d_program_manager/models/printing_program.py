# -*- coding: utf-8 -*-

from odoo import models, fields, api
from datetime import date


class PrintingProgram(models.Model):
    _name = 'printing.program'
    _description = 'Programme d\'impression 3D'
    _order = 'name, version desc'

    name = fields.Char(
        string='Nom du programme',
        required=True,
        help="Nom du programme d'impression 3D"
    )
    
    version = fields.Char(
        string='Version',
        default='1.0',
        help="Version du programme (ex: 1.0, 1.1, 2.0)"
    )
    
    import_date = fields.Date(
        string='Date d\'import',
        default=fields.Date.today,
        help="Date d'ajout du programme dans le système"
    )
    
    file = fields.Binary(
        string='Fichier',
        attachment=True,
        help="Fichier du programme (.gcode, .stl, .obj, etc.)"
    )
    
    filename = fields.Char(
        string='Nom du fichier',
        help="Nom original du fichier uploadé"
    )
    
    notes = fields.Text(
        string='Notes',
        help="Notes et commentaires sur le programme"
    )
    
    file_size = fields.Float(
        string='Taille (Ko)',
        compute='_compute_file_size',
        store=True,
        help="Taille du fichier en kilo-octets"
    )
    
    file_extension = fields.Char(
        string='Extension',
        compute='_compute_file_extension',
        store=True,
        help="Extension du fichier (.gcode, .stl, etc.)"
    )
    
    @api.depends('filename')
    def _compute_file_extension(self):
        for record in self:
            if record.filename:
                extension = record.filename.split('.')[-1].lower() if '.' in record.filename else ''
                record.file_extension = f".{extension}" if extension else ''
            else:
                record.file_extension = ''
    
    @api.depends('file')
    def _compute_file_size(self):
        for record in self:
            if record.file:
                # Le fichier est stocké en base64, calcul de la taille approximative
                try:
                    if isinstance(record.file, str):
                        # Si c'est une string base64
                        size_bytes = len(record.file.encode('utf-8')) * 0.75
                    else:
                        # Si c'est déjà des bytes
                        size_bytes = len(record.file) * 0.75
                    record.file_size = round(size_bytes / 1024, 2)
                except (AttributeError, TypeError):
                    record.file_size = 0.0
            else:
                record.file_size = 0.0
    
    def name_get(self):
        result = []
        for record in self:
            name = f"{record.name}"
            if record.version:
                name += f" (v{record.version})"
            result.append((record.id, name))
        return result
    
    @api.onchange('file', 'filename')
    def _onchange_file(self):
        """Déclencher le recalcul des champs quand le fichier change"""
        if self.file:
            self._compute_file_size()
        if self.filename:
            self._compute_file_extension()
    
    def write(self, vals):
        """Override write pour s'assurer que les champs sont recalculés"""
        result = super().write(vals)
        if 'file' in vals or 'filename' in vals:
            for record in self:
                record._compute_file_size()
                record._compute_file_extension()
        return result
    
    @api.model
    def create(self, vals):
        """Override create pour s'assurer que les champs sont recalculés"""
        record = super().create(vals)
        if record.file or record.filename:
            record._compute_file_size()
            record._compute_file_extension()
        return record