From: Petr Stehlik <pstehlik@sophics.cz>
Subject: Re: patch fixing background next to penguin
	logo in monochrome
Date: Thu, 12 Aug 2004 14:02:51 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1092312171.27772.73.camel@joy.sophics>
References: <1092254183.4209.16.camel@joy.home>
	 <200409120616.43518.adaplas@hotpop.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BvEJE-0000Y2-4h
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 12 Aug 2004 05:03:52 -0700
Received: from www.sophics.cz ([194.108.6.2] helo=proxy.sophics)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1BvEJC-0001w9-R8
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 12 Aug 2004 05:03:52 -0700
Received: from unknown by localhost (amavisd-new, unix socket)
	id client-XX2dsHlL for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 12 Aug 2004 14:03:42 +0200 (CEST)
In-Reply-To: <200409120616.43518.adaplas@hotpop.com>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="iso-8859-1"
To: adaplas@pol.net
Cc: linux-fbdev-devel@lists.sourceforge.net, Geert Uytterhoeven <geert@linux-m68k.org>, "Christian T. Steigies" <cts@debian.org>

V Ne, 12. 09. 2004 v 00:16, Antonino A. Daplas p=ED=B9e:
> On Thursday 12 August 2004 03:56, Petr Stehlik wrote:
> > I have developed a simple workaround for a problem existing in
> > framebuffer when it interprets VGA attribute bits in monochrome mode.
> > Instead of empty chars we get underlines

> Anyway, the simplest solution is to use a vc->vc_video_erase_char with th=
e
> underline attribute removed.  Check drivers/video/fbcon.c and look at the
> function fbcon_setup. Note, the logo space is erased using the scr_memset=
w
> function with conp->vc_video_erase_char. Just replace them with
> (conp->vc_video_erase_char & ~0x400) if conp->can_do_color is false. (0x4=
00
> is the underline attribute).=20

Good idea. Tested, works. Included below.

Thanks.

Petr

Index: drivers/video/fbcon.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /home/linux-m68k/cvsroot/linux/drivers/video/Attic/fbcon.c,v
retrieving revision 1.1.1.2.2.6
diff -u -r1.1.1.2.2.6 fbcon.c
--- drivers/video/fbcon.c	26 Aug 2003 03:13:09 -0000	1.1.1.2.2.6
+++ drivers/video/fbcon.c	12 Aug 2004 11:59:22 -0000
@@ -692,9 +692,13 @@
     		conp->vc_pos +=3D logo_lines * conp->vc_size_row;
     	    }
     	}
-    	scr_memsetw((unsigned short *)conp->vc_origin,
-		    conp->vc_video_erase_char,=20
-		    conp->vc_size_row * logo_lines);
+	{
+		int erase_char =3D conp->vc_video_erase_char;
+		if (! conp->vc_can_do_color)
+			erase_char &=3D ~0x400; /* disable underline */
+		scr_memsetw((unsigned short *)conp->vc_origin,
+			erase_char, conp->vc_size_row * logo_lines);
+	}
     }
    =20
     /*




-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
