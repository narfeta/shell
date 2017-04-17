update_pip_repo() {
    #
    # require twine
    #
    rm -r dist
    rm -r build
        find . -name \000*.py -type f -delete
        find . -name \*.pyc -type f -delete
    python setup.py sdist
    python setup.py bdist_wheel
    twine upload dist/*
}
