From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: [PATCH] atyfb (2.6): Fix mmio_start
Date: Fri, 7 May 2004 05:13:22 +0300
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040507021322.GA11715@sci.fi>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="sdtB3X0nJg68CQEu"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BLurd-0007IX-N1
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 06 May 2004 19:13:25 -0700
Received: from gw02.mail.saunalahti.fi ([195.197.172.116])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1BLurc-0000ca-4a
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 06 May 2004 19:13:24 -0700
Received: from kuori.saunalahti.fi (kuori.saunalahti.fi [195.197.175.23])
	by gw02.mail.saunalahti.fi (Postfix) with ESMTP id 7151CF38E39
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri,  7 May 2004 05:13:23 +0300 (EEST)
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


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This patch fixes info->fix.mmio_start value.

--=20
Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/

--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="atyfb-2.6-mmio_start.patch"

--- linux/drivers/video/aty/atyfb_base.c.orig	2004-05-07 03:48:44.109865088 +0300
+++ linux/drivers/video/aty/atyfb_base.c	2004-05-07 03:48:48.282230792 +0300
@@ -2221,11 +2221,11 @@
 		info->fix.mmio_len = 0x400;
 		info->fix.accel = FB_ACCEL_ATI_MACH64CT;
 	} else if (M64_HAS(VT)) {
-		info->fix.mmio_start = -0x400;
+		info->fix.mmio_start -= 0x400;
 		info->fix.mmio_len = 0x800;
 		info->fix.accel = FB_ACCEL_ATI_MACH64VT;
 	} else {/* GT */
-		info->fix.mmio_start = -0x400;
+		info->fix.mmio_start -= 0x400;
 		info->fix.mmio_len = 0x800;
 		info->fix.accel = FB_ACCEL_ATI_MACH64GT;
 	}

--sdtB3X0nJg68CQEu--


-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to 
deliver higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
