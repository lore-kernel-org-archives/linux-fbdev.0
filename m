From: InKi Dae <daeinki@gmail.com>
Date: Mon, 01 Aug 2011 04:06:27 +0000
Subject: Fwd: [PATCH 0/2] video: add Samsung SoC based MIPI-DSI support.
Message-Id: <CAAQKjZPP3Kr3aGHkjP1PMY+ZugLPeocE4mD=SHX6NLo2s7fajA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <4CE5D2BB.2060308@samsung.com>
	<4DA6E551.1060300@samsung.com>
In-Reply-To: <4DA6E551.1060300@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

Hello, Paul.

I had posted patch sets below on 15 Apr.
but there is no any comments.
please review this patch sets.

thank you.


---------- Forwarded message ----------
From: daeinki <inki.dae@samsung.com>
Date: 2011/4/14
Subject: [PATCH 0/2] video: add Samsung SoC based MIPI-DSI support.
To: linux-fbdev@vger.kernel.org, lethal@linux-sh.org
=C2=FC=C1=B6: kyungmin.park@samsung.com, Kukjin Kim <kgene.kim@samsung.com>,
akpm@linux-foundation.org, linux-arm-kernel@lists.infradead.org


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

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
