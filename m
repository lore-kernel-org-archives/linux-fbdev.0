From: John Zielinski <grim@undead.cc>
Subject: Re: [PATCH] atyfb (2.6): Add RGB565 support
Date: Thu, 13 May 2004 21:11:47 -0400
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <40A41CD3.2010908@undead.cc>
References: <20040511213607.GB6854@sci.fi> <Pine.GSO.4.58.0405121110360.19967@waterleaf.sonytel.be> <20040512185724.GA825@sci.fi> <Pine.GSO.4.58.0405131121210.9790@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030304020200060806050905"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BOREz-0008OA-L9
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 13 May 2004 18:11:57 -0700
Received: from ghoul.undead.cc ([216.126.84.18] helo=mail.undead.cc)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1BOREy-0002qz-S6
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 13 May 2004 18:11:57 -0700
In-Reply-To: <Pine.GSO.4.58.0405131121210.9790@waterleaf.sonytel.be>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: =?ISO-8859-15?Q?Ville_Syrj=E4l=E4?= <syrjala@sci.fi>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------030304020200060806050905
Content-Type: text/plain; charset="iso-8859-15"; format="flowed"
Content-Transfer-Encoding: quoted-printable

Geert Uytterhoeven wrote:

>	Hi Ville,
>
>On Wed, 12 May 2004, Ville [iso-8859-1] Syrj=E4l=E4 wrote:
> =20
>
>>On Wed, May 12, 2004 at 11:11:21AM +0200, Geert Uytterhoeven wrote:
>>   =20
>>
>>>On Wed, 12 May 2004, Ville [iso-8859-1] Syrj=E4l=E4 wrote:
>>>     =20
>>>
>>>>This patch adds RGB565 support to atyfb.
>>>>       =20
>>>>
>>>Nice! Have you tried fbtest on it?
>>>
>>>I once tried to implement it myself, but it didn't work reliably.
>>>     =20
>>>
>>I just tried fbtest and most tests look ok. The penguin images are wrong
>>(green instead of white stuff aroung the penguin) and the test009 looks
>>wrong too. Are you sure fbtest is doing the right thing with rgb565
>>directcolor visuals? DirectFB or mplayer don't have any problems.
>>   =20
>>
>
>It's always possible there's a bug in fbtest w.r.t. 565 handling, but I di=
dn't
>see it.
> =20
>

It's a bug in fbtest's directcolor routines.   Directcolor sets the clut=20
using using the min of the RGB sizes so 565 becomes 555.  The problem is=20
that tests 4, 8 and 9 use the buffer as 565 (VISUAL_GENERIC &=20
VISUAL_TRUECOLOR) and the directcolor routines don't reset the clut to=20
it's full range.  Fix attached.

John


--------------030304020200060806050905
Content-Type: text/plain;
 name="fbtest_565_fix"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fbtest_565_fix"

diff -urNX dontdiff2 fbtest.old/clut.c fbtest/clut.c
--- fbtest.old/clut.c	2002-10-06 16:14:20.000000000 -0400
+++ fbtest/clut.c	2004-05-13 21:12:53.000000000 -0400
@@ -114,6 +114,29 @@
 
 
     /*
+     *  Create table with maximum dynamic range
+     */
+
+void clut_create_maximum(rgba_t *clut, u32 rlen, u32 glen, u32 blen, u32 alen)
+{
+    u32 i;
+    u32 len = max(max(rlen, glen), max(blen, alen));
+
+    Debug("clut_create_maximum: RGBA %dx%dx%dx%d\n", rlen, glen, blen, alen);
+    for (i = 0; i < len; i++) {
+	if (i < rlen)
+	    clut->r = EXPAND_TO_16BIT(i, rlen-1);
+	if (i < glen)
+    	    clut->g = EXPAND_TO_16BIT(i, glen-1);
+	if (i < blen)
+	    clut->b = EXPAND_TO_16BIT(i, blen-1);
+	if (i < alen)
+	    clut->a = (alen-1) ? EXPAND_TO_16BIT(i, alen-1) : 0xffff;
+	clut++;
+    }
+}
+
+    /*
      *  Create a linear ramp
      */
 
@@ -158,7 +181,7 @@
 	clut_create_rgbcube(clut, 4, 4, 4);
     } else if (idx_len >= 32) {
 	clut_create_rgbcube(clut, 3, 3, 3);
-	/* FIXME: still 3 entries left */
+	/* FIXME: still 5 entries left */
     } else if (idx_len >= 16) {
 	memcpy(clut, clut_console, sizeof(clut_console));
     } else if (idx_len >= 8) {
diff -urNX dontdiff2 fbtest.old/include/clut.h fbtest/include/clut.h
--- fbtest.old/include/clut.h	2001-05-01 10:39:20.000000000 -0400
+++ fbtest/include/clut.h	2004-05-13 20:36:03.000000000 -0400
@@ -16,6 +16,7 @@
 extern const rgba_t clut_windows[4];
 
 extern void clut_create_rgbcube(rgba_t *clut, u32 rlen, u32 glen, u32 blen);
+extern void clut_create_maximum(rgba_t *clut, u32 rlen, u32 glen, u32 blen, u32 alen);
 extern void clut_create_linear(rgba_t *clut, u32 len);
 extern void clut_init_nice(void);
 
diff -urNX dontdiff2 fbtest.old/pnmtohex/Makefile fbtest/pnmtohex/Makefile
--- fbtest.old/pnmtohex/Makefile	2003-01-20 07:58:47.000000000 -0500
+++ fbtest/pnmtohex/Makefile	2004-05-13 19:00:43.000000000 -0400
@@ -3,7 +3,7 @@
 
 HOST_TARGET = pnmtohex
 
-LIBS += -lnetpnm -lnetpbm -lnetpgm -lnetppm
+LIBS += -lnetpbm
 
 include $(TOPDIR)/Rules.make
 
diff -urNX dontdiff2 fbtest.old/visops/directcolor.c fbtest/visops/directcolor.c
--- fbtest.old/visops/directcolor.c	2003-03-18 11:53:44.000000000 -0500
+++ fbtest/visops/directcolor.c	2004-05-13 21:11:37.000000000 -0400
@@ -94,7 +94,18 @@
 
 
     /*
-     *  Truecolor/Grayscale
+     *  Truecolor/Generic
+     */
+
+static void directcolor_set_maximum(void)
+{
+    clut_create_maximum(clut, red_len, green_len, blue_len, alpha_len);
+    directcolor_update_cmap();
+}
+
+
+    /*
+     *  Grayscale
      */
 
 static void directcolor_set_linear(void)
@@ -119,11 +130,14 @@
 	case VISUAL_DIRECTCOLOR:
 	    break;
 
-	case VISUAL_GENERIC:
 	case VISUAL_GRAYSCALE:
-	case VISUAL_TRUECOLOR:
 	    directcolor_set_linear();
 	    break;
+	
+	case VISUAL_GENERIC:
+	case VISUAL_TRUECOLOR:
+	    directcolor_set_maximum();
+	    break;
 
 	default:
 	    return 0;

--------------030304020200060806050905--



-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
