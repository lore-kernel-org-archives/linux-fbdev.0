From: daeinki <inki.dae@samsung.com>
Date: Wed, 05 Jan 2011 10:31:32 +0000
Subject: [PATCH 0/2] add Samsung SoC based MIPI-DSI support.
Message-Id: <4D244884.70204@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hello, all.

S5PC110 and S5PC210 SoC platform have one or two MIPI-DSI controller.
MIPI-DSI controller can be used to connect MIPI-DSI based LCD Panel.
this patch adds MIPI-DSI controller driver.

to use this driver, MIPI-DSI based LCD panel driver have to register
mipi_dsim_lcd_driver object to MIPI-DSI driver and then when MIPI-DSI
driver is probed, probe callback of LCD panel driver registered would be
called.

this patch includes just only MIPI-DSI driver because now mainline
kernel has no any machine support with MIPI-DSI based LCD panel so this
driver has been tested locally. I will have patch work for it and send
it including machine specific codes in the future.

The patch series contains:

[PATCH 1/2] s5pc110: add clock gate for MIPI-DSI controller.
[PATCH 2/2] s5pc110: add MIPI-DSI controller driver.

thank you.
