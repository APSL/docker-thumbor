import os
import pytest


@pytest.fixture(scope='session')
def docker_compose_file(pytestconfig):
    return os.path.join(str(pytestconfig.rootdir), 'docker-compose-travis.yml')


@pytest.fixture(scope='session')
def original_image():
    """
    Return the image served by `imageserver` docker service.
    :return str: The url to the original image
    """
    return 'imageserver:8000/original.png'
