From: Paul Mackerras <paulus@samba.org>
Subject: Re: PPC64 prom logo
Date: Sun, 23 Mar 2003 22:33:31 +1100 (EST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <15997.39819.528276.259757@nanango.paulus.ozlabs.org>
References: <Pine.GSO.4.21.0303231141590.9116-100000@vervain.sonytel.be>
Reply-To: paulus@samba.org
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from dp.samba.org ([66.70.73.150] helo=lists.samba.org)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18x3nX-0004ij-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 23 Mar 2003 03:37:55 -0800
In-Reply-To: <Pine.GSO.4.21.0303231141590.9116-100000@vervain.sonytel.be>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: James Simmons <jsimmons@infradead.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, Linux/PPC64 Development <linuxppc64-dev@lists.linuxppc.org>

Geert Uytterhoeven writes:

> Sorry, it seems I missed a RELOC in the PPC64 prom logo code. Is this (patch
> against current BK) OK?

You missed a PTRRELOC in the ppc32 code too:

diff -urN linux-2.5/arch/ppc/syslib/prom_init.c linuxppc-2.5/arch/ppc/syslib/prom_init.c
--- linux-2.5/arch/ppc/syslib/prom_init.c	2003-03-23 16:29:31.000000000 +1100
+++ linuxppc-2.5/arch/ppc/syslib/prom_init.c	2003-03-23 21:38:46.000000000 +1100
@@ -369,7 +369,7 @@
 					break;
 
 #ifdef CONFIG_LOGO_LINUX_CLUT224
-			clut = logo_linux_clut224.clut;
+			clut = PTRRELOC(logo_linux_clut224.clut);
 			for (i = 0; i < logo_linux_clut224.clutsize;
 			     i++, clut += 3)
 				if (prom_set_color(ih, i + 32, clut[0],

Regards,
Paul.


-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
