From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: [Question] Colour management
Date: Sun, 1 Aug 2004 01:10:14 +0300
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040731221014.GA17669@sci.fi>
References: <20040722184937.GA11361@sci.fi> <200407252036.52194.alex.kern@gmx.de> <200407260647.03489.adaplas@hotpop.com> <200407302012.36325.alex.kern@gmx.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="huq684BweRXVnRxX"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Br23W-0004j0-HK
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 31 Jul 2004 15:10:18 -0700
Received: from gw02.mail.saunalahti.fi ([195.197.172.116])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1Br23V-0002Qp-SR
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 31 Jul 2004 15:10:18 -0700
Received: from kuori.saunalahti.fi (kuori.saunalahti.fi [195.197.175.23])
	by gw02.mail.saunalahti.fi (Postfix) with ESMTP id 1D95DD2E5
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun,  1 Aug 2004 01:10:15 +0300 (EEST)
Content-Disposition: inline
In-Reply-To: <200407302012.36325.alex.kern@gmx.de>
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


--huq684BweRXVnRxX
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 30, 2004 at 08:12:36PM +0200, Alexander Kern wrote:
>=20
> Hallo Tony,
>=20
> can you explain the deep mining of fb_setcolreg. Background, I observe =
wrong=20
> palette using in 15 and 16 bpp modes, but can not understand, what is=20
> the right approach. In both cases from penguin logo I can see only cont=
our in=20
> honey yellow and blue vertical string jsimmons, pretty scury ;-) The re=
st is=20
> black! The simple text or ncurses applications have always right colour=
s.
> Additionally and only by 16bpp fbi shows blurry images.

I just had a look at the fbi code and it's wrong. It was initializing the=
=20
clut to 555. The attached patch fixes the problem.

I think the boot logo code is broken. No, I haven't actually looked at it=
=20
but everything else works... Or does it work on some other directcolor hw=
?

--=20
Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/

--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
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

--huq684BweRXVnRxX--


-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
