# Aseprite Build Container
## (Currently windows only, but could extend to linux and macos in similar fashion)
Run:
- `docker build . -t delapf/aseprite_builder:latest`
- `docker compose -up -d`
- `docker ps` (note container id)
- `docker exec -it <container_id> cmd` (enter interactive mode if something goes wrong)

Refs:
- https://github.com/aseprite/aseprite/blob/main/INSTALL.md
- https://learn.microsoft.com/en-us/visualstudio/install/build-tools-container?view=vs-2022
- https://learn.microsoft.com/en-us/visualstudio/install/workload-component-id-vs-build-tools?view=vs-2022
