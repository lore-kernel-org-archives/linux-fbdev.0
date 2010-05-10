From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 10 May 2010 00:11:25 +0000
Subject: Re: [PATCH 3/4 v2] ARM: add framebuffer support for ap4evb
Message-Id: <uvdawbopi.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <Pine.LNX.4.64.1005071054510.4777@axis700.grange>
 <Pine.LNX.4.64.1005071105140.4777@axis700.grange>
 <Pine.LNX.4.64.1005071641440.4777@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1005071641440.4777@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@nokia.com>


Dear Guennadi

Thank you for your hard work

> diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
> index 9003ea9..e216132 100644
> --- a/arch/arm/mach-shmobile/Kconfig
> +++ b/arch/arm/mach-shmobile/Kconfig
> @@ -42,6 +42,7 @@ config MACH_AP4EVB
>  	bool "AP4EVB board"
>  	depends on ARCH_SH7372
>  	select ARCH_REQUIRE_GPIOLIB
> +	select SH_LCD_MIPI_DSI

Why is this "select" needed here ?
Do you want "force select MIPI DSI" on AP4 ?

I asked because AP4 board can select other type LCD.
(not only MIPI DSI)

Best regards
--
Kuninori Morimoto
 
