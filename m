From: InKi Dae <daeinki@gmail.com>
Date: Fri, 04 Mar 2011 04:19:03 +0000
Subject: Re: [PATCH 0/2] add Samsung SoC based MIPI-DSI support.
Message-Id: <AANLkTi=e_ONRgG8YAMhakgSg4_0Nuyu6abWtJUeE-Ts-@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <4D244884.70204@samsung.com>
In-Reply-To: <4D244884.70204@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hello, Mr. Kukjin.

how are you doing on these patches below?

with previous call, you said that they have no problem.
so please, apply them below to your samsung git.

thank you.

2011/1/5 daeinki <inki.dae@samsung.com>:
> Hello, all.
>
> S5PC110 and S5PC210 SoC platform have one or two MIPI-DSI controller.
> MIPI-DSI controller can be used to connect MIPI-DSI based LCD Panel.
> this patch adds MIPI-DSI controller driver.
>
> to use this driver, MIPI-DSI based LCD panel driver have to register
> mipi_dsim_lcd_driver object to MIPI-DSI driver and then when MIPI-DSI
> driver is probed, probe callback of LCD panel driver registered would be
> called.
>
> this patch includes just only MIPI-DSI driver because now mainline
> kernel has no any machine support with MIPI-DSI based LCD panel so this
> driver has been tested locally. I will have patch work for it and send
> it including machine specific codes in the future.
>
> The patch series contains:
>
> [PATCH 1/2] s5pc110: add clock gate for MIPI-DSI controller.
> [PATCH 2/2] s5pc110: add MIPI-DSI controller driver.
>
> thank you.
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
