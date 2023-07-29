name             = "{{ cookiecutter.project_slug }}"
environment      = "prod"
container_cpu    = 2048
container_memory = 4096
service_desired_count     = 1
lb_listener_rule_priority = 100
