# HealthcheckCloud
[![LinkedIn][linkedin-shield]][linkedin-url]

# About the project

Project was developed to monitor html pages that do not have a publicly exposed API.

## Requirement

* Docker

## Features

### [HTML Status Page Azure](https://status.azure.com/en-us/status)

- [x] Americas - Route /api/v1/azure/americas
- [ ] Europe
- [ ] Asia Pacific
- [ ] Middle East and Africa
- [ ] Azure Government
- [ ] Azure China
- [ ] Jio

### Start project
```bash
make start-latest-version
```
##### O servidor inciará na 4000 - acesse <http://localhost:4000>

#
The response return is in json, making it easy to filter the service you want.

```json

[
  {
    "*Non-Regional": null,
    "Brazil South": null,
    "Brazil Southeast": null,
    "Canada Central": null,
    "Canada East": null,
    "Central US": null,
    "East US": "Good",
    "East US 2": null,
    "North Central US": null,
    "South Central US": "Good",
    "West Central US": null,
    "West US": "Good",
    "West US 2": null,
    "West US 3": null,
    "name": "Azure VMware Solution by CloudSimple"
  },
  {
    "*Non-Regional": null,
    "Brazil South": "Good",
    "Brazil Southeast": "Good",
    "Canada Central": "Good",
    "Canada East": "Good",
    "Central US": "Good",
    "East US": "Good",
    "East US 2": "Good",
    "North Central US": "Good",
    "South Central US": "Good",
    "West Central US": "Good",
    "West US": "Good",
    "West US 2": "Good",
    "West US 3": "Good",
    "name": "Virtual Machines"
  },
  ...
```

[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555
[linkedin-url]: https://www.linkedin.com/in/gilbertosj