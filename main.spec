# -*- mode: python -*-

block_cipher = None


a = Analysis(['C:\\Users\\GODWIN\\Documents\\GitHub\\GGuides\\main.py'],
             pathex=['C:\\Users\\GODWIN\\Documents\\GitHub\\GGuides'],
             binaries=[],
             datas=[],
             hiddenimports=[],
             hookspath=[],
             runtime_hooks=[],
             excludes=[],
             win_no_prefer_redirects=False,
             win_private_assemblies=False,
             cipher=block_cipher,
             noarchive=False)
pyz = PYZ(a.pure, a.zipped_data,
             cipher=block_cipher)
exe = EXE(pyz,
          a.scripts,
          [],
          exclude_binaries=True,
          name='GGuides',
          icon=None,
          debug=False,
          strip=False,
          upx=False,
          console=True )
coll = COLLECT(exe,
               a.binaries,
               a.datas,
               a.zipfiles,
               strip=False,
               upx=False,
               name='GGuides')
