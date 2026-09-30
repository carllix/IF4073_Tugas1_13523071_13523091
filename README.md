<div align="center">
    <h1>ParaPix</h1>
    <p><em>A MATLAB image enhancement app with hand-written algorithms</em></p>
    <p>
        <img src="https://img.shields.io/badge/MATLAB-R2026a-orange" alt="MATLAB R2026a"/>
        <img src="https://img.shields.io/badge/App%20Designer-GUI-blue" alt="App Designer"/>
    </p>
    <img src="assets/app-logo.png" width="250" alt="ParaPix logo"/>
</div>

---

## Description

ParaPix is a desktop image enhancement application built with MATLAB App Designer. It loads a grayscale or RGB image, applies image enhancement methods to it, and shows the input and result side by side together with their histograms and statistics. Every enhancement algorithm is implemented from scratch in `src/`.

---

## Features

**Intensity transformation**

| Method | Parameters |
| --- | --- |
| Brightening | Gain `a` (0.1 – 5), offset `b` (-255 – 255) |
| Negative | – |
| Log Transform | – |
| Power Law | Gamma `γ` (0.1 – 5) |
| Contrast Stretching | `r1`, `r2` (0 – 255), defaulting to the 1st and 99th percentile |

**Histogram processing**

| Method | Parameters |
| --- | --- |
| Histogram Equalization | – |
| Histogram Specification | A reference image (channels are matched R→R, G→G, B→B) |

**Image filtering**

| Method | Parameters |
| --- | --- |
| Mean Filter | Kernel size (3×3, 5×5, 7×7, 9×9) |
| Median Filter | Kernel size (3×3, 5×5, 7×7, 9×9) |
| Gaussian Filter | Blur spread `σ` (0.5 – 5)|
| Sharpen Filter | Mode (4-neighbors or 8-neighbors), strength (0.1 – 2) |

---

## Project Structure

```
.
├── main.mlapp          # App Designer GUI
├── assets/             # app logo and button icons
├── src/
│   ├── pipeline/       # single entry point called by the GUI
│   ├── intensity/      # brightening, negative, log, power law, contrast stretching
│   ├── histogram/      # histogram, CDF, percentile
│   ├── equalization/   # histogram equalization
│   ├── specification/  # histogram specification
│   ├── filtering/      # convolution, mean, median, gaussian, sharpen
│   ├── features/       # image statistics
│   └── utils/          # image loading, per-channel wrapper, histogram plotting
├── data/               # test images (kasus-1..4, histogram-citra)
└── tests/              # validateHistogram 
```

---

## Dependencies

- MATLAB R2026a or newer 
- Image Processing Toolbox, only needed to run the histogram validation test

---

## How to Run

1. Clone the repository

   ```bash
   git clone https://github.com/carllix/IF4073_Tugas1_13523071_13523091.git
   cd IF4073_Tugas1_13523071_13523091
   ```

2. Open `main.mlapp` in MATLAB App Designer and press **Run**.

3. In the app:
   1. Click **Upload from Files** and choose an image.
   2. Pick a method and set its parameters. For Histogram Specification, also upload a reference image.
   3. Click **Apply**. Repeat to stack more methods, or use **Undo** / **Reset**.
   4. Click **Save** to export the result and its histogram.

---

## Authors

<table>
  <tr>
    <td align="center">
      <a href="https://github.com/adndax">
        <img src="https://avatars.githubusercontent.com/adndax" width="100" style="border-radius: 50%;" /><br />
        <span><b>Adinda Putri</b></span><br/>
        <p>13523071 </p>
      </a>
    </td>
    <td align="center">
      <a href="https://github.com/carllix">
        <img src="https://avatars.githubusercontent.com/carllix" width="100" style="border-radius: 50%;" /><br />
        <span><b>Carlo Angkisan</b></span><br/>
        <p>13523091</p>
      </a>
    </td>
  </tr>
</table>
