From: Alexander Kern <alex.kern@gmx.de>
Subject: Fwd: Re: [Question] Colour management
Date: Sun, 1 Aug 2004 00:50:22 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200408010050.23031.alex.kern@gmx.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_uICDBDt5CF7x/Rz"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Br2gZ-0006WS-Mr
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 31 Jul 2004 15:50:39 -0700
Received: from pop.gmx.net ([213.165.64.20] helo=mail.gmx.net)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.34)
	id 1Br2gZ-0001SK-08
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 31 Jul 2004 15:50:39 -0700
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
To: kraxel@bytesex.org
Cc: Ville =?utf-8?q?Syrj=C3=A4l=C3=A4?= <syrjala@sci.fi>, fbdev <linux-fbdev-devel@lists.sourceforge.net>


--Boundary-00=_uICDBDt5CF7x/Rz
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello,

here is a very good patch, that correct fbi with 16 bpp(565) mode.
Tested on Mach64. Please commit it.

Regards
Alex Kern

=2D---------  Weitergeleitete Nachricht  ----------

Subject: [Linux-fbdev-devel] Re: [Question] Colour management
Date: Sonntag, 1. August 2004 00:10
=46rom: Ville Syrj=E4l=E4 <syrjala@sci.fi>
To: linux-fbdev-devel@lists.sourceforge.net

On Fri, Jul 30, 2004 at 08:12:36PM +0200, Alexander Kern wrote:
> Hallo Tony,
>
> can you explain the deep mining of fb_setcolreg. Background, I observe
> wrong palette using in 15 and 16 bpp modes, but can not understand, what =
is
> the right approach. In both cases from penguin logo I can see only contour
> in honey yellow and blue vertical string jsimmons, pretty scury ;-) The
> rest is black! The simple text or ncurses applications have always right
> colours. Additionally and only by 16bpp fbi shows blurry images.

I just had a look at the fbi code and it's wrong. It was initializing the
clut to 555. The attached patch fixes the problem.

I think the boot logo code is broken. No, I haven't actually looked at it
but everything else works... Or does it work on some other directcolor hw?

=2D-
Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/

=2D------------------------------------------------------



--Boundary-00=_uICDBDt5CF7x/Rz
Content-Type: text/plain;
  charset="us-ascii";
  name=" "
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="fbi_directcolor_565_fix.patch"

--- fbi-1.31/fbi.c	2004-02-22 14:24:29.000000000 +0200
+++ fbi-1.31/fbi.c	2004-08-01 00:57:45.375251160 +0300
@@ -760,12 +760,19 @@
 }
 
 static void
-linear_palette(int bit)
+linear_palette(int r, int g, int b)
 {
-    int i, size = 256 >> (8 - bit);
-    
+    int i, size;
+
+    size = 256 >> (8 - r);
+    for (i = 0; i < size; i++)
+	red[i] = calc_gamma(i,size);
+    size = 256 >> (8 - g);
     for (i = 0; i < size; i++)
-        red[i] = green[i] = blue[i] = calc_gamma(i,size);
+	green[i] = calc_gamma(i,size);
+    size = 256 >> (8 - b);
+    for (i = 0; i < size; i++)
+	blue[i] = calc_gamma(i,size);
 }
 
 static void
@@ -1391,21 +1398,23 @@
 	break;
     case 15:
     case 16:
-        if (fb_fix.visual == FB_VISUAL_DIRECTCOLOR)
-            linear_palette(5);
 	if (fb_var.green.length == 5) {
+	    if (fb_fix.visual == FB_VISUAL_DIRECTCOLOR)
+		linear_palette(5,5,5);
 	    lut_init(15);
 	} else {
+	    if (fb_fix.visual == FB_VISUAL_DIRECTCOLOR)
+		linear_palette(5,6,5);
 	    lut_init(16);
 	}
 	break;
     case 24:
         if (fb_fix.visual == FB_VISUAL_DIRECTCOLOR)
-            linear_palette(8);
+            linear_palette(8,8,8);
 	break;
     case 32:
         if (fb_fix.visual == FB_VISUAL_DIRECTCOLOR)
-            linear_palette(8);
+            linear_palette(8,8,8);
 	lut_init(24);
 	break;
     default:

--Boundary-00=_uICDBDt5CF7x/Rz--


-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
