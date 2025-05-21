terraform {
  backend "remote" {
    organization = "devops-blue" 

    workspaces {
      name = "devops-blue-workspace" 
    }
  }
}

