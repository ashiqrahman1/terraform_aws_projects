resource "aws_elb" "classic" {
    subnets = [aws_subnet.pub1.id,aws_subnet.pub2.id]
    security_groups = [aws_security_group.elb_sg.id]
    internal = false
    listener {
        instance_port  = 80
        instance_protocol = "http"
        lb_port = 80
        lb_protocol = "http"
    }

    listener {
        instance_port  = 80
        instance_protocol = "http"
        lb_port = 81
        lb_protocol = "http"
    }

    health_check {
        healthy_threshold  = 2
        unhealthy_threshold = 2
        timeout = 3
        target = "HTTP:80/"
        interval = 30
    }
    cross_zone_load_balancing = true
    instances = [aws_instance.app1.id, aws_instance.app2.id]
    # depends_on = [aws_instance.app1, aws_instance.app2]
}