From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: [PATCH] atyfb: another double scan fix
Date: Wed, 11 Feb 2004 14:21:05 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040211122105.GA26947@sci.fi>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="9amGYk9869ThD9tj"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AqtN8-0007ZY-QH
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 11 Feb 2004 04:21:42 -0800
Received: from gw02.mail.saunalahti.fi ([195.197.172.116])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1AqtLS-0008HG-Cn
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 11 Feb 2004 04:19:58 -0800
Received: from kuori.saunalahti.fi (kuori.saunalahti.fi [195.197.175.23])
	by gw02.mail.saunalahti.fi (Postfix) with ESMTP id 7D998EFD125
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 11 Feb 2004 14:21:06 +0200 (EET)
Content-Disposition: inline
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


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Here's another doublescan fix for atyfb.

Previosly var<->crtc conversion would do different things depending on=20
which way the conversion was made.=20
var->crtc: vdisp =3D ((yres-1)<<1)=20
crtc->var: yres  =3D ((vdisp+1)>>1)

That's obviously wrong. And thus fbset would report incorrect yres value.=
=20
The patch changes var->crtc conversion to do vdisp =3D ((yres<<1)-1).

I'm not entirely sure which way is the right way but at least now things=20
work as expected.

--=20
Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/

--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="atyfb_dblscan_fix.patch"

--- linux-2.4.24/drivers/video/aty/atyfb_base.c.pan	2004-02-11 13:12:47.000000000 +0200
+++ linux-2.4.24/drivers/video/aty/atyfb_base.c	2004-02-11 13:16:23.000000000 +0200
@@ -600,6 +600,18 @@
     sync = var->sync;
     vmode = var->vmode;
 
+    /* In double scan mode, the vertical parameters need to be doubled.
+       But in interlaced mode, there is no need to half the vertical parameters.
+       Code has been tested in 1024x768, 43 Hz interlaced and 640x480, 60 Hz
+       double scan.
+     */
+    if ((vmode & FB_VMODE_MASK) == FB_VMODE_DOUBLE) {
+        ryres <<= 1;
+        upper <<= 1;
+        lower <<= 1;
+        vslen <<= 1;
+    }
+
     /* convert (and round up) and validate */
     xres = (xres+7) & ~7;
     xoffset = (xoffset+7) & ~7;
@@ -623,7 +635,7 @@
 
     if (vyres < yres+yoffset)
         vyres = yres+yoffset;
-    v_disp = yres-1;
+    v_disp = ryres-1;
     if (v_disp > 0x7ff)
         FAIL("v_disp too large");
     v_sync_strt = v_disp+lower;
@@ -636,18 +648,6 @@
     if (v_total > 0x7ff)
         FAIL("v_total too large");
     v_sync_pol = sync & FB_SYNC_VERT_HIGH_ACT ? 0 : 1;
-    /* In double scan mode, the vertical parameters need to be doubled.
-       But in interlaced mode, there is no need to half the vertical parameters.
-       Code has been tested in 1024x768, 43 Hz interlaced and 640x480, 60 Hz
-       double scan.
-     */
-   if ((vmode & FB_VMODE_MASK) == FB_VMODE_DOUBLE) {
-       ryres <<= 1;
-       v_total <<= 1;
-       v_disp <<= 1;
-       v_sync_strt <<= 1;
-       v_sync_wid <<= 1;
-   };
                                                            
     c_sync = sync & FB_SYNC_COMP_HIGH_ACT ? CRTC_CSYNC_EN : 0;
 

--9amGYk9869ThD9tj--


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
