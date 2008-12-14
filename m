From: "Jaya Kumar" <jayakumar.lkml@gmail.com>
Subject: Re: [PATCH 1/2] pxa: introduce GPIOxx_LCD_*
	macros for easier pin configuration
Date: Mon, 15 Dec 2008 00:22:04 +0800
Message-ID: <45a44e480812140822j541d81f3x63cf13ccc4e4e24e@mail.gmail.com>
References: <f17812d70812110104y4b3d9b40i2f1c5d22e97988db@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jayakumar.lkml@gmail.com>) id 1LBtjN-000480-Lk
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 14 Dec 2008 16:22:09 +0000
Received: from mail-ew0-f21.google.com ([209.85.219.21])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1LBtjK-0003cB-Qh for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 14 Dec 2008 16:22:09 +0000
Received: by ewy14 with SMTP id 14so2690402ewy.10
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 14 Dec 2008 08:22:05 -0800 (PST)
In-Reply-To: <f17812d70812110104y4b3d9b40i2f1c5d22e97988db@mail.gmail.com>
Content-Disposition: inline
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
Cc: linux-fbdev-devel@lists.sourceforge.net, Ian Molton <spyro@f2s.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Marek Vasut <marek.vasut@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, pHilipp Zabel <philipp.zabel@gmail.com>, Marc Zyngier <maz@misterjones.org>, Juergen Schindele <linux@schindele.name>, ARM Linux <linux-arm-kernel@lists.arm.linux.org.uk>, Stefan Schmidt <stefan@datenfreihafen.org>

On Thu, Dec 11, 2008 at 5:04 PM, Eric Miao <eric.y.miao@gmail.com> wrote:
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
>
> Signed-off-by: Eric Miao <eric.miao@marvell.com>

Looks good for the am200epd changes. Thanks.

Acked-by: Jaya Kumar <jayakumar.lkml@gmail.com>

------------------------------------------------------------------------------
SF.Net email is Sponsored by MIX09, March 18-20, 2009 in Las Vegas, Nevada.
The future of the web can't happen without you.  Join us at MIX09 to help
pave the way to the Next Web now. Learn more and register at
http://ad.doubleclick.net/clk;208669438;13503038;i?http://2009.visitmix.com/
