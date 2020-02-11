FROM remotepixel/amazonlinux:gdal2.4-py3.7-cogeo

ENV PREFIX='/opt'

RUN find $PREFIX/python -type f -name '*.pyc' | while read f; do n=$(echo $f | sed 's/__pycache__\///' | sed 's/.cpython-[2-3][0-9]//'); cp $f $n; done; \
find $PREFIX/python -type d -a -name '__pycache__' -print0 | xargs -0 rm -rf \
find $PREFIX/python -type f -a -name '*.py' -print0 | xargs -0 rm -f

COPY rasterioutils.py /opt/python/rasterioutils.py

RUN cd $PREFIX && find lib -name \*.so\* -exec strip {} \;

RUN cd $PREFIX && zip -r9q /tmp/package.zip python \
cd $PREFIX && zip -r9q --symlinks /tmp/package.zip lib/*.so* share \
cd $PREFIX && zip -r9q --symlinks /tmp/package.zip bin/gdal* bin/ogr* bin/geos* bin/nearblack