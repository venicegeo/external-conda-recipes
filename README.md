# External Conda Recipes

Provisioning Nexus for Beachfront dependencies. 

## Purpose

The purpose of this repository to provision the Nexus repository with all of the dependencies (direct & transitive) that Beachfront projects require. This includes the `bf-tideprediction` and `pzsvc-ndwi-py` projects. Those projects will declare required dependencies in their respective `environment.yml` files; while this repository will be responsible for uploading all of those dependencies into Nexus. 

Updating a dependency in either `bf-tideprediction`, `pzsvc-ndwi-py`, or any of its children will require that update to be reflected in this repository as well. If that change is not made, then that dependency may not be available in Nexus. 

This repository pulls artifacts from all sources of the open internet. Meanwhile, every other project in VeniceGeo must only be allowed to pull its dependencies from the Nexus Conda channel. As such, this should be the only point of origin for any dependency that is not built directly by VeniceGeo projects.

## Recipes

While most dependencies can be pulled from public Conda channels such as `bioconda`, there are some dependencies that do not have any Conda recipes at all. As such, this repository declares the `recipes` folder as a series of recipes used to build those such dependencies. 

### Recipe Ordering

Most of the recipe directories in the `recipes` folder are numbered numerically. This is because there's no good way, when defining these recipes, to declare which recipes depend on previous recipes. Conda's default behavior will be to build these recipes in order of folder name. 

## Provisioning

This repository is meant to be run whenever the Conda artifacts in the Beachfront Nexus repository must be updated. This Jenkins job need not be run unless any of those dependencies change. 
