From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: [PATCH] atyfb: fix pan with doublescan
Date: Tue, 10 Feb 2004 20:28:22 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040210182822.GA13022@sci.fi>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="vkogqOf2sHV7VnPd"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Aqcca-0001Hv-JB
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 10 Feb 2004 10:28:32 -0800
Received: from gw01.mail.saunalahti.fi ([195.197.172.115])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1AqccV-0001Xs-2F
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 10 Feb 2004 10:28:27 -0800
Received: from kuori.saunalahti.fi (kuori.saunalahti.fi [195.197.175.23])
	by gw01.mail.saunalahti.fi (Postfix) with ESMTP id BD25110E780C
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 10 Feb 2004 20:28:22 +0200 (EET)
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


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This patch fixes panning with doublescan in atyfb.

--=20
Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/

--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="atyfb_dblscan_pan.patch"

--- linux-2.4.24/drivers/video/aty/atyfb_base.c.orig	2003-11-28 20:26:20.000000000 +0200
+++ linux-2.4.24/drivers/video/aty/atyfb_base.c	2004-02-10 20:15:15.000000000 +0200
@@ -1475,6 +1475,8 @@
 
     xres = (((par->crtc.h_tot_disp>>16) & 0xff)+1)*8;
     yres = ((par->crtc.v_tot_disp>>16) & 0x7ff)+1;
+    if (par->crtc.gen_cntl & CRTC_DBL_SCAN_EN)
+        yres >>= 1;
     xoffset = (var->xoffset+7) & ~7;
     yoffset = var->yoffset;
     if (xoffset+xres > par->crtc.vxres || yoffset+yres > par->crtc.vyres)

--vkogqOf2sHV7VnPd--


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
