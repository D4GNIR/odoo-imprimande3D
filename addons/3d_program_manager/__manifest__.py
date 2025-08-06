# -*- coding: utf-8 -*-
{
    'name': "Gestionnaire de Programmes 3D",
    'summary': """
        Gestion des programmes d'impression 3D (fichiers .gcode, .stl, .obj)""",
    'description': """
        Module personnalisé pour enregistrer, stocker et gérer les programmes d'impression 3D.
        
        Fonctionnalités:
        - Upload de fichiers 3D (.gcode, .stl, .obj, etc.)
        - Versioning des programmes
        - Métadonnées et notes
        - Interface de recherche et filtrage
        - Centralisation des fichiers d'impression
    """,
    'author': "Atelier Impression 3D",
    'website': "https://www.example.com",
    'category': 'Manufacturing',
    'version': '17.0.1.0.0',
    'depends': ['base', 'stock'],
    'data': [
        'security/ir.model.access.csv',
        'views/printing_program_views.xml',
        'views/menu_views.xml',
    ],
    'demo': [],
    'installable': True,
    'auto_install': False,
    'application': True,
    'license': 'LGPL-3',
}