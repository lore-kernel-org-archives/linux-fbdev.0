From: daeinki <inki.dae@samsung.com>
Date: Thu, 14 Apr 2011 12:15:13 +0000
Subject: [PATCH 0/2] video: add Samsung SoC based MIPI-DSI support.
Message-Id: <4DA6E551.1060300@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <4CE5D2BB.2060308@samsung.com>
In-Reply-To: <4CE5D2BB.2060308@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hello, all.

Samsung S5PV210 and EXYNOS4 SoC platform have one or two MIPI-DSI
controller and MIPI-DSI based LCD Panel could be used with this one.
this patch adds Samsung SoC based MIPI-DSI support.

to use MIPI-DSI based LCD Panel driver, mipi_dsim_lcd_device shoule be
registered to MIPI-DSI driver through s5p_mipi_dsi_register_lcd_device()
at machine code or machine specific somewhere first, and
mipi_dsim_lcd_driver should be registered when
s5p_mipi_dsi_register_driver() is called at init function of lcd driver,
and then probe() of that driver would be called by MIPI-DSI controller
driver if lcd panel name and id of mipi_dsim_lcd_device are same as ones
of mipi_dsim_lcd_driver.

for this, you can refer to sample lcd panel driver.
please see "Documentation/s5p_mipi_dsim/dsim_sample_lcd.c"

this patch series includes the following.

[PATCH 1/2] video: add Samsung SoC MIPI-DSI controller driver.
[PATCH 2/2] video: add Samsung SoC MIPI-DSI based sample lcd panel driver.
