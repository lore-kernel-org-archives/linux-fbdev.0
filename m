From: Alexander Kern <alex.kern@gmx.de>
Subject: Re: Re: [Fwd: AtyFB in 2.6.10, still not perfect]
Date: Wed, 23 Mar 2005 22:35:31 +0100
Message-ID: <200503232235.31597.alex.kern@gmx.de>
References: <200503151826.46073.adaplas@hotpop.com> <200503191615.32610.alex.kern@gmx.de> <1111521961.6402.4.camel@willis>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_jEeQCxmp5gSbcto"
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DEDWR-0007L2-VK
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 23 Mar 2005 13:36:15 -0800
Received: from mail.gmx.de ([213.165.64.20] helo=mail.gmx.net)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1DEDWR-0001sO-5N
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 23 Mar 2005 13:36:15 -0800
In-Reply-To: <1111521961.6402.4.camel@willis>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Luigi Gangitano <luigi@debian.org>, "Antonino A. Daplas" <adaplas@hotpop.com>

--Boundary-00=_jEeQCxmp5gSbcto
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Am Dienstag, 22. M=C3=A4rz 2005 21:06 schrieb Luigi Gangitano:
> Il giorno sab, 19-03-2005 alle 16:15 +0100, Alexander Kern ha scritto:
> > Copyed from oldest mail...
> >
> > > (as known) with 2.6.10. Latest 2.6.10 source in
> > > debian adds the fix that
> > > was integrated in 2.6.11, from
> > >
> > >
> > > http://lists.debian.org/debian-sparc/2005/02/msg00063.html
> >
> > It's mean you run 2.6.10 + "always hsync on SPARC" patch ?
>
> Right. Same behaviour with 2.6.11, however.
>
> > And if you try any fixes from Tony, you see mclk 100 xclk 100 in your
> > dmesg, bur screen is steel garbage?
>
> Yes. dmesg reports the setting passed on cmdline and screen is still
> garbled. Setting xclk to 100 makes things worse.
>
> Regards,
Ok, try this patch...

or in combination with setting mclk and xclk to 100

Regards
Alex

--Boundary-00=_jEeQCxmp5gSbcto
Content-Type: text/x-diff;
  charset="utf-8";
  name="atyfb_xl_gr_try.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="atyfb_xl_gr_try.diff"

--- atyfb_base.c.orig	2004-12-24 22:35:23.000000000 +0100
+++ atyfb_base.c	2005-03-23 22:32:58.553823808 +0100
@@ -403,7 +403,7 @@
 	{ PCI_CHIP_MACH64GM, "3D RAGE XL (Mach64 GM, AGP)", 230, 83, 63, ATI_CHIP_264XL },
 	{ PCI_CHIP_MACH64GN, "3D RAGE XL (Mach64 GN, AGP)", 230, 83, 63, ATI_CHIP_264XL },
 	{ PCI_CHIP_MACH64GO, "3D RAGE XL (Mach64 GO, PCI-66/BGA)", 230, 83, 63, ATI_CHIP_264XL },
-	{ PCI_CHIP_MACH64GR, "3D RAGE XL (Mach64 GR, PCI-33MHz)", 230, 83, 63, ATI_CHIP_264XL },
+	{ PCI_CHIP_MACH64GR, "3D RAGE XL (Mach64 GR, PCI-33MHz)", 230, 83, 63, ATI_CHIP_264XL | M64F_SDRAM_MAGIC_PLL },
 	{ PCI_CHIP_MACH64GL, "3D RAGE XL (Mach64 GL, PCI)", 230, 83, 63, ATI_CHIP_264XL },
 	{ PCI_CHIP_MACH64GS, "3D RAGE XL (Mach64 GS, PCI)", 230, 83, 63, ATI_CHIP_264XL },
 

--Boundary-00=_jEeQCxmp5gSbcto--


-------------------------------------------------------
This SF.net email is sponsored by Microsoft Mobile & Embedded DevCon 2005
Attend MEDC 2005 May 9-12 in Vegas. Learn more about the latest Windows
Embedded(r) & Windows Mobile(tm) platforms, applications & content.  Register
by 3/29 & save $300 http://ads.osdn.com/?ad_id=6883&alloc_id=15149&op=click
