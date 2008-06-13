From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RFC 2.6.26-rc3 06/10] gumstix: conversion
	to MFP support and add bluetooth support
Date: Fri, 13 Jun 2008 08:42:51 +0100
Message-ID: <20080613074250.GF20702@flint.arm.linux.org.uk>
References: <1213289961-1562-1-git-send-email-jayakumar.lkml@gmail.com>
	<1213289961-1562-7-git-send-email-jayakumar.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1K73wD-0001FE-6q for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 13 Jun 2008 00:43:14 -0700
Received: from caramon.arm.linux.org.uk ([78.32.30.218])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1K73wC-0005vq-Co
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 13 Jun 2008 00:43:09 -0700
Content-Disposition: inline
In-Reply-To: <1213289961-1562-7-git-send-email-jayakumar.lkml@gmail.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Jaya Kumar <jayakumar.lkml@gmail.com>
Cc: ymiao3@marvell.com, linux-fbdev-devel@lists.sourceforge.net, linux-arm-kernel@lists.arm.linux.org.uk

On Thu, Jun 12, 2008 at 12:59:17PM -0400, Jaya Kumar wrote:
> +static unsigned long gumstix_pin_config[] __initdata = {
> +#ifdef CONFIG_BT
> +	GPIO12_32KHz,
> +	/* BTUART */
> +	GPIO42_HWUART_RXD,
> +	GPIO43_HWUART_TXD,
> +	GPIO44_HWUART_CTS,
> +	GPIO45_HWUART_RTSL,
> +#endif
> +#ifdef CONFIG_MMC_PXA
> +	/* MMC */
> +	GPIO6_MMC_CLK,
> +	GPIO53_MMC_CLK,
> +	GPIO8_MMC_CS0,
> +#endif

Should GPIO configurations depend on whether the driver support's built
in or not?  Surely the hardware is there irrespective of the kernel's
configuration - especially if these are built as a module.

>  static struct clk pxa25x_clks[] = {
> +	{
> +		.name           = "CLK_32K",
> +		.ops            = &clk_32k_ops,
> +		.rate           = 32000,

Most 32kHz clocks are 32768Hz not 32000Hz.  Are you sure this is correct?

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
