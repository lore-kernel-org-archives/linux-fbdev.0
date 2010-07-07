From: InKi Dae <inki.dae@samsung.com>
Date: Wed, 07 Jul 2010 06:34:37 +0000
Subject: [PATCH v2 0/2] ARM: S5PV210: Add MIPI-DSI support.
Message-Id: <4C341FFD.6010405@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hello all,

This patch is for MIPI-DSI controller based on S5PV210 (or S5PC110).

this version corrects some problems Ben pointed out.

v1 patch includes below contents.
- set callbacks to MIPI Client driver at mipi_ddi_platform_data declaration.
- use MIPI regulator names set at s5p_platform_dsim declaration to get regulators for them.
- use a table to get freq_band value.
- code clean and fix minor bugs.

v2 patch includes below contents.
- use generic header(include/video/mipi_display.h) for MIPI-DSI commands.
- remove lcd panel specific definitions from dsim.h.

LCD Panel can use following interfaces,
- RGB or CPU Interface.
- RGB or CPU Interface based on MIPI-DSI.

in case of cell phone device, small size lcd panel(less then 480x800) was ok only rgb or cpu interface not using mipi controller.
but big size panel(bigger then 480x800) needs MIPI-DSI Interface or other hardwares like LVDS to transfer image data to lcd panel fine.

I tested this patch on cpu interface based on MIPI-DSI and also considered RGB interface.

This patch set consists of the following patches,

[PATCH v2 1/2] S5PV210: FB: Add MIPI-DSI and CPU Interface features.
[PATCH v2 2/2] S5PV210: Add MIPI-DSI Driver.

Best regards,
InKi Dae

