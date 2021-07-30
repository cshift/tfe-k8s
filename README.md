# tfe-k8s : Load Balancer on k8s Cluster

- 시나리오: Private (On-prem 등) 환경에 구축된 k8s Cluster 에서 Load Balancer 구성 및 Web Service 외부 노출
  
- 참고정보
  -  hashicorp official docs: https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs
  -  MetalLB official docs: https://metallb.universe.tf/

- Test 환경 및 시나리오 흐름
  - VCS (Gitlab) 와 TFE 연동
  - VCS 에 Code Commit 시 TFE 에서 전달 받아 terraform apply
  - k8s provider 에 등록된 k8s config 정보 기반 k8s cluster 에 작업 수행 전달
  - MetalLB 생성 및 NGINX 기반 Load Balancer 서비스 노출
  - 브라우저에서 서비스 IP 정상 접속 및 메세지 확인  

<img width="1356" alt="Screen Shot 2021-07-30 at 9 03 36 AM" src="https://user-images.githubusercontent.com/51940925/127580409-fc195703-b642-4a9b-8449-84f31d0ef9db.png">

<img width="1285" alt="Screen Shot 2021-07-30 at 9 09 30 AM" src="https://user-images.githubusercontent.com/51940925/127580773-5c4d616a-a904-4cf6-953d-cfff721f2ca3.png">

<img width="1312" alt="Screen Shot 2021-07-30 at 9 09 56 AM" src="https://user-images.githubusercontent.com/51940925/127580781-cca292a1-55d2-4846-9a42-e86166090a54.png">

- MetalLB 구성 목적
  - 제공 되는 Load Balancer 를 k8s cluster 에 활용한 가능한 Public Cloud 와 달리 Private 환경 기반 k8s 에서는 load balancer 별도 구성 필요
  
<img width="1308" alt="Screen Shot 2021-07-30 at 9 10 48 AM" src="https://user-images.githubusercontent.com/51940925/127580894-426fbcdb-9ae9-4834-b19e-ad57c5a76db0.png">
