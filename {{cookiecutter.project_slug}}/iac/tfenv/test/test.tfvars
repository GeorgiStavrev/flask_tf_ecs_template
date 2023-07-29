name             = "test-{{ cookiecutter.project_slug }}"
environment      = "test"
container_cpu    = 1024
container_memory = 2048
service_desired_count     = 1
lb_listener_rule_priority = 101