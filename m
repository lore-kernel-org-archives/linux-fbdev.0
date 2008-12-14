From: Mike Rapoport <mike@compulab.co.il>
Subject: Re: [PATCH 1/2] pxa: introduce GPIOxx_LCD_*
 macros for easier pin configuration
Date: Sun, 14 Dec 2008 08:54:06 +0200
Message-ID: <4944AD8E.7080504@compulab.co.il>
References: <f17812d70812110104y4b3d9b40i2f1c5d22e97988db@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mike@compulab.co.il>) id 1LBks3-0003GD-Jh
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 14 Dec 2008 06:54:31 +0000
Received: from 89.6b.364a.static.theplanet.com ([74.54.107.137]
	helo=cathcart.site5.com)
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1LBks1-0001yB-SU
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 14 Dec 2008 06:54:31 +0000
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



Eric Miao wrote:
>>From ed2c9a22a9653880fad7e22333c7d6155c45c399 Mon Sep 17 00:00:00 2001
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

For CM-X2xx and EM-X270:
Acked-by: Mike Rapoport <mike@compulab.co.il>

-- 
Sincerely yours,
Mike.


------------------------------------------------------------------------------
SF.Net email is Sponsored by MIX09, March 18-20, 2009 in Las Vegas, Nevada.
The future of the web can't happen without you.  Join us at MIX09 to help
pave the way to the Next Web now. Learn more and register at
http://ad.doubleclick.net/clk;208669438;13503038;i?http://2009.visitmix.com/
