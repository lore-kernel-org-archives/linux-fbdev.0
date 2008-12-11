From: Stefan Schmidt <stefan@datenfreihafen.org>
Subject: Re: [PATCH 1/2] pxa: introduce GPIOxx_LCD_*
	macros for easier pin	configuration
Date: Thu, 11 Dec 2008 17:39:12 +0100
Message-ID: <20081211163912.GB4407@excalibur.local>
References: <f17812d70812110104y4b3d9b40i2f1c5d22e97988db@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <stefan@datenfreihafen.org>) id 1LAoZW-00072Y-F8
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 11 Dec 2008 16:39:30 +0000
Received: from sirius.lasnet.de ([78.47.116.19])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1LAoZS-0006cp-Dj
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 11 Dec 2008 16:39:30 +0000
Content-Disposition: inline
In-Reply-To: <f17812d70812110104y4b3d9b40i2f1c5d22e97988db@mail.gmail.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Eric Miao <eric.y.miao@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, Ian Molton <spyro@f2s.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Marek Vasut <marek.vasut@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, pHilipp Zabel <philipp.zabel@gmail.com>, Marc Zyngier <maz@misterjones.org>, Juergen Schindele <linux@schindele.name>, Jaya Kumar <jayakumar.lkml@gmail.com>, ARM Linux <linux-arm-kernel@lists.arm.linux.org.uk>, Stefan Schmidt <stefan@datenfreihafen.org>

Hello.

On Thu, 2008-12-11 at 17:04, Eric Miao wrote:
> From ed2c9a22a9653880fad7e22333c7d6155c45c399 Mon Sep 17 00:00:00 2001
> From: Eric Miao <eric.miao@marvell.com>
> Date: Thu, 11 Dec 2008 13:34:54 +0800
> Subject: [PATCH] [ARM] pxa: introduce GPIOxx_LCD_* macros for easier
> pin configuration
> 
> For those peripherals with only one possible pin configuration, introduce
> handy macros of GPIOxx_*, it also avoids potential copy-and-paste errors.
> 
> Let's start from LCD for PXA25x/PXA27x, depending on the different mode
> used: passive (STN), active (TFT) and LCD with internal framebuffer (i.e.
> smart panel), and the actual number of pins used to connect to the LCD
> panel, the configurations slightly differ.
> 
> Also, let's fix the issue of LCD pin configurations are missed from some
> platforms (e.g. am200epd, cm-x270, e400)
> 
> NOTE: the 18bpp and smart panel are only available on PXA27x.

[SNIP]

> diff --git a/arch/arm/mach-pxa/ezx.c b/arch/arm/mach-pxa/ezx.c
> index 4f212e1..051fc49 100644
> --- a/arch/arm/mach-pxa/ezx.c
> +++ b/arch/arm/mach-pxa/ezx.c
> @@ -147,6 +147,9 @@ static unsigned long gen1_pin_config[] __initdata = {
>  	/* flip / lockswitch */
>  	GPIO12_GPIO,
> 
> +	/* LCD */
> +	GPIOxx_LCD_TFT_16BPP,
> +
>  	/* bluetooth (bcm2035) */
>  	GPIO14_GPIO | WAKEUP_ON_LEVEL_HIGH,	/* HOSTWAKE */
>  	GPIO48_GPIO,				/* RESET */
> @@ -205,6 +208,9 @@ static unsigned long gen2_pin_config[] __initdata = {
>  	/* EOC */
>  	GPIO10_GPIO,
> 
> +	/* LCD */
> +	GPIOxx_LCD_TFT_18BPP,
> +
>  	/* bluetooth (bcm2045) */
>  	GPIO13_GPIO | WAKEUP_ON_LEVEL_HIGH,	/* HOSTWAKE */
>  	GPIO37_GPIO,				/* RESET */

The ezx.c part looks fine to me. If you like you could put my ACK in, but I
don't think you need it being a pxa maintainer.

regards
Stefan Schmidt

------------------------------------------------------------------------------
SF.Net email is Sponsored by MIX09, March 18-20, 2009 in Las Vegas, Nevada.
The future of the web can't happen without you.  Join us at MIX09 to help
pave the way to the Next Web now. Learn more and register at
http://ad.doubleclick.net/clk;208669438;13503038;i?http://2009.visitmix.com/
