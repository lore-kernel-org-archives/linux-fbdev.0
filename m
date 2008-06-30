From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH 9/13] viafb: Makefile, share.h
Date: Mon, 30 Jun 2008 12:47:53 +0200
Message-ID: <20080630104753.GA16040@uranus.ravnborg.org>
References: <C80EF34A3D2E494DBAF9AC29C7AE4EB8074E786A@exchtp03.taipei.via.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KDGuh-0002Ve-5F for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 30 Jun 2008 03:47:15 -0700
Received: from pasmtpa.tele.dk ([80.160.77.114])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KDGuf-0006Uw-Pn
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 30 Jun 2008 03:47:15 -0700
Content-Disposition: inline
In-Reply-To: <C80EF34A3D2E494DBAF9AC29C7AE4EB8074E786A@exchtp03.taipei.via.com.tw>
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
To: JosephChan@via.com.tw
Cc: geert@linux-m68k.org, akpm@linux-foundation.org, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

On Mon, Jun 30, 2008 at 03:38:52PM +0800, JosephChan@via.com.tw wrote:
> Makefile for drivers/video/via/ 
> share.h: shared macro for viafb
> 
> 
> Signed-off-by: Joseph Chan <josephchan@via.com.tw>
> 
> diff -Nur a/drivers/video/via/Makefile b/drivers/video/via/Makefile
> --- a/drivers/video/via/Makefile	1970-01-01 08:00:00.000000000 +0800
> +++ b/drivers/video/via/Makefile	2008-06-30 08:53:33.000000000 +0800
> @@ -0,0 +1,9 @@
> +#
> +# Makefile for the VIA framebuffer driver (for Linux Kernel 2.6)
> +#
> +                                                                                
> +obj-$(CONFIG_FB_VIA) += viafb.o
> +
> +viafb-y	:=viafbdev.o hw.o iface.o  via_i2c.o dvi.o lcd.o ioctl.o accel.o via_utility.o vt1636.o global.o tblDPASetting.o viamode.o tbl1636.o
> +
> +viafb-objs	:=	$(viafb-y)

This assignmnet is not needed - please drop it.
kbuild already understands <modulename>-y

	Sam

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
