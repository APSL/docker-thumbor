import os
import pytest
import urllib.request


def compare_images(docker_ip, docker_services, url_original, filename, service, port=8000, version='v1'):
    expected_result_image = open(os.path.join('.', 'tests', 'images', version, filename), 'rb').read()
    url = 'http://{service_host}:{service_port}/unsafe/200x100/{image_url}'.format(
        service_host=docker_ip, service_port=docker_services.port_for(service, port), image_url=url_original)
    result_image = urllib.request.urlopen(url).read()
    return result_image == expected_result_image


@pytest.mark.integration
def test_thumbor_unsafe_200x100(docker_ip, docker_services, original_image):
    assert compare_images(docker_ip, docker_services, original_image, 'result_thumbor-200x100.png', 'thumbor')


@pytest.mark.integration
def test_nginx_unsafe_200x100(docker_ip, docker_services, original_image):
    assert compare_images(docker_ip, docker_services, original_image, 'result_thumbor-200x100.png', 'nginx', 80)
