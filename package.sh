version=$(python -c 'import sys; print(f"{sys.version_info[0]}.{sys.version_info[1]}")')
PYPATH=${PYTHONUSERBASE}/lib/python${version}/site-packages/
mv ${PYPATH}/* ${PYTHONUSERBASE}/
rm -rf ${PYTHONUSERBASE}/lib

echo "Create archive"
cd $PYTHONUSERBASE && zip -r9q /tmp/layer.zip *

cp /tmp/layer.zip /local/geoutils.zip