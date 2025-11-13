# Qt WASM Example

This repository contains a **Qt 6.8.3 WebAssembly (WASM) example** built with **Emscripten**. The project demonstrates how to build Qt applications for the web and deploy them to **GitHub Pages**.

It also includes a Docker image in the `docker/` directory that you can modify if needed. Additionally, the project can be developed using **Qt Creator** for local development and testing.

---

## Table of Contents

- [Prerequisites](#prerequisites)
- [Docker Build](#docker-build)
- [Local Testing](#local-testing)
- [Qt Creator Development](#qt-creator-development)
- [GitHub Pages Deployment](#github-pages-deployment)
- [Links](#links)

---

## Prerequisites

- Docker installed on your system
- GitHub account (for Pages deployment)
- Qt WASM Docker image (provided in `docker/` directory)
- Basic knowledge of CMake and Qt projects
- Qt Creator (optional, for local development)

---

## Docker Build

A prebuilt Docker image is available in the `docker/` directory with **Qt 6.8.3** and **Emscripten** installed. You can modify it if needed.

### Build your Docker image (optional)

```bash
cd docker
docker build -t qt-wasm-build-image:6.8.3 -f Dockerfile.wasm .
```

### Build the Qt WASM app

Run the following inside the repository root:

```bash
docker run --rm -u 0 \
  -v $(pwd):/app \
  -w /app/qt_wasm_example \
  qt-wasm-build-image:6.8.3 \
  bash -lc "
    source /opt/emsdk/emsdk_env.sh && \
    mkdir -p build && cd build && \
    /qtbase/bin/qt-cmake .. -DCMAKE_BUILD_TYPE=Release && \
    cmake --build . --parallel $(nproc)
  "
```

After the build completes, the output files will be in:

```
qt_wasm_example/build/
```

---

## Local Testing

You can serve the built WASM app locally with Python:

```bash
cd qt_wasm_example/build
python3 -m http.server 8080
```

Then open [http://localhost:8080](http://localhost:8080) in your browser.  
You should see the Qt WASM application running.

---

## Qt Creator Development

You can also open the project in **Qt Creator**:  

1. Open Qt Creator  
2. Choose **File → Open File or Project** and select `qt_wasm_example/CMakeLists.txt`  
3. Configure with your local Qt version and Emscripten kit  
4. Build and run directly from Qt Creator for faster development feedback

---

## GitHub Pages Deployment

The workflow for building and deploying to GitHub Pages is automated using **GitHub Actions**:

- Build the Qt WASM app using the Docker image
- Upload the output as an artifact
- Deploy it to GitHub Pages

After the first successful deployment, your app will be live at:

```
https://nesiodime.github.io/qt-wasm-github-page/
```

> ⚠️ Make sure the `index.html` exists in the root of the deployed folder (the workflow automatically copies `qt_wasm_exampleApp.html` to `index.html`).

---

## Links

- Qt WebAssembly official guide: [https://doc.qt.io/qt-6/wasm.html](https://doc.qt.io/qt-6/wasm.html)
- Emscripten official site: [https://emscripten.org](https://emscripten.org)
- GitHub Pages documentation: [https://docs.github.com/en/pages](https://docs.github.com/en/pages)

---