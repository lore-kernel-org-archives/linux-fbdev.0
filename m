From: <JosephChan@via.com.tw>
Subject: Re: [PATCH 9/13] viafb: Makefile, share.h
Date: Tue, 1 Jul 2008 09:14:52 +0800
Message-ID: <C80EF34A3D2E494DBAF9AC29C7AE4EB8074E7CF3@exchtp03.taipei.via.com.tw>
References: <20080630104753.GA16040@uranus.ravnborg.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0522393051=="
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KDUSO-00026Z-If for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 30 Jun 2008 18:14:56 -0700
Received: from mailtp.via.com.tw ([61.66.243.2])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KDUSO-0001aP-5g
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 30 Jun 2008 18:14:56 -0700
Content-class: urn:content-classes:message
In-Reply-To: <20080630104753.GA16040@uranus.ravnborg.org>
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
To: sam@ravnborg.org
Cc: geert@linux-m68k.org, akpm@linux-foundation.org, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

--===============0522393051==
Content-class: urn:content-classes:message
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: quoted-printable

Sam,

Got that, Thanks.

BRs,
Joseph Chan=20
-----Original Message-----
From: Sam Ravnborg [mailto:sam@ravnborg.org]=20
Sent: Monday, June 30, 2008 6:48 PM
To: Joseph Chan
Cc: linux-fbdev-devel@lists.sourceforge.net; =
linux-kernel@vger.kernel.org; akpm@linux-foundation.org; =
geert@linux-m68k.org
Subject: Re: [PATCH 9/13] viafb: Makefile, share.h

On Mon, Jun 30, 2008 at 03:38:52PM +0800, JosephChan@via.com.tw wrote:
> Makefile for drivers/video/via/
> share.h: shared macro for viafb
>=20
>=20
> Signed-off-by: Joseph Chan <josephchan@via.com.tw>
>=20
> diff -Nur a/drivers/video/via/Makefile b/drivers/video/via/Makefile
> --- a/drivers/video/via/Makefile	1970-01-01 08:00:00.000000000 +0800
> +++ b/drivers/video/via/Makefile	2008-06-30 08:53:33.000000000 +0800
> @@ -0,0 +1,9 @@
> +#
> +# Makefile for the VIA framebuffer driver (for Linux Kernel 2.6) #
> +                                                                      =
         =20
> +obj-$(CONFIG_FB_VIA) +=3D viafb.o
> +
> +viafb-y	:=3Dviafbdev.o hw.o iface.o  via_i2c.o dvi.o lcd.o ioctl.o =
accel.o via_utility.o vt1636.o global.o tblDPASetting.o viamode.o =
tbl1636.o
> +
> +viafb-objs	:=3D	$(viafb-y)

This assignmnet is not needed - please drop it.
kbuild already understands <modulename>-y

	Sam



--===============0522393051==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
--===============0522393051==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--===============0522393051==--
