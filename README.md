# Despliegue de un servicio Proxy Web escalable y altamente disponible mediante AWS Academy Learner Labs

Los servidores Proxy web permiten que los clientes de una red puedan navegar por Internet, mediante los protocolos HTTP y HTTPS de forma segura, permitiendo el enmascaramiento de las direcciones IP de los clientes, el filtrado de solicitudes y el cacheo de respuestas.

El objetivo de este repositorio es proporcionar indicaciones para diseñar y desplegar la infraestructura necesaria para un clúster de servidores proxy balanceados y escalable, atendiendo a las mejores prácticas de seguridad y fiabilidad.

## **Requerimientos**

* Disponer de acceso a un sandbox en un AWS Academy Learner Lab
* Disponer de un entorno configurado con AWS CLI y el motor de contenerización Docker

## Servicios utilizados

* **Amazon ECS**, para crear un servicio definido mediante una tarea de AWS Fargate. Cada tarea ejecutará un contenedor Docker personalizado con un servicio Squid (Proxy web)
*  Un **Balanceador de carga de red (NLB)** que permitirá distribuir la carga de solicitudes HTTP y HTTPS entre los diferentes contenedores Docker que componen el servicio Proxy. Además, se utilizarán puntos de enlace de servicio para exponer el servicio Proxy en diferentes VPCs de la misma región (podrían encontrarse en la misma o diferentes cuentas de AWS)
*  Un repositorio privado de **Amazon ECR** donde se alojará la imagen personalizada del contenedor Docker que implementa el servicio Proxy Web
*  Una instancia de **Amazon EC2** con sistema operativo Amazon Linux 2 que simulará solicitudes HTTP y HTTPS mediante Lynx (navegador web de consola)
*  Una plantilla de **AWS CloudFormation** para simplificar el aprovisionamiento de la infraestructura de VPCs
*  Dos **Gateway NAT** para permitir el acceso a Internet de los contenedores Docker que implementan el servicio Proxy Web
*  **AWS Systems Manager Session Manager** que se utilizará para el acceso seguro y privado a la instancia EC2 (cliente web)

## Arquitectura propuesta

![Arquitectura](images/arch.png)

## Instrucciones

1. Previamente, se establece la región donde se aprovisionará la infraestructura. En los AWS Academy Learner Labs sólo puede ser us-east-1 o us-west-2:

		REGION=us-east-1

2. Para crear la infraestructura de las VPCs se utilizará una plantilla de AWS CloudFormation. Tanto la VPC de servicio como la VPC de cliente vienen parametrizadas en dos archivos JSON. Para lanzar la VPC de servicio se ejecutará:

		aws cloudformation deploy --template-file vpc/vpc.yaml --stack-name service --parameter-overrides file://vpc/service-vpc.json --region $REGION
		 



