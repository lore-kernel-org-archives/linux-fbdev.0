From: Richard Drummond <lists@rcdrummond.net>
Subject: [PATCH] Add tdfx palette hack to offb driver
Date: Tue, 18 Mar 2003 23:47:38 -0500
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200303182344.50481.lists@rcdrummond.net>
Reply-To: lists@rcdrummond.net
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_qZ/d+gDUsyIULlo"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from snipe.mail.pas.earthlink.net ([207.217.120.62])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18vVOt-00081P-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 18 Mar 2003 20:42:03 -0800
Received: from sdn-ap-029ilchicp0029.dialsprint.net ([65.178.168.29])
	by snipe.mail.pas.earthlink.net with esmtp (Exim 3.33 #1)
	id 18vVOr-00005k-00
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 18 Mar 2003 20:42:02 -0800
Content-Disposition: inline
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
To: linux-fbdev-devel@lists.sourceforge.net


--Boundary-00=_qZ/d+gDUsyIULlo
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi All

Attached is a patch (against 2.4.20) which adds a palette hack for Voodoo3/4/5 
cards to the offb driver. It's tested and working here on a Voodoo3 and a 
Voodoo4. I'd welcome comments, though. Particularly, I think the probing for 
a Voodoo card may be a bit shaky. Basically I'm match the OF name with the 
pattern "3Dfx,Voodoo*". This may cause problems if there are Voodoo1 or 2 
cards available with OF drivers, and so need tightening up.

Cheers,
Rich

--Boundary-00=_qZ/d+gDUsyIULlo
Content-Type: text/x-diff;
  charset="us-ascii";
  name="offb-tdfx_hack.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="offb-tdfx_hack.diff"

--- drivers/video/offb.orig	2003-03-14 13:49:21.000000000 -0500
+++ drivers/video/offb.c	2003-03-18 23:37:35.000000000 -0500
@@ -53,7 +53,8 @@
 	cmap_M3A,	/* ATI Rage Mobility M3 Head A */
 	cmap_M3B,	/* ATI Rage Mobility M3 Head B */
 	cmap_radeon,	/* ATI Radeon */
-	cmap_gxt2000	/* IBM GXT2000 */
+	cmap_gxt2000,	/* IBM GXT2000 */
+	cmap_3dfx	/* 3Dfx Voodoo3/4/5 */
 };
 
 struct fb_info_offb {
@@ -462,6 +463,10 @@
 		unsigned long regbase = dp->addrs[0].address;
 		info->cmap_adr = ioremap(regbase + 0x6000, 0x1000);
 		info->cmap_type = cmap_gxt2000;
+	} else if (!strncmp( name, "3Dfx,Voodoo", 11)) {
+		unsigned long regbase = dp->addrs[2].address;
+		info->cmap_adr  = ioremap( regbase, 0xFF );
+		info->cmap_type = cmap_3dfx;
 	}
         fix->visual = info->cmap_adr ? FB_VISUAL_PSEUDOCOLOR
 				     : FB_VISUAL_STATIC_PSEUDOCOLOR;
@@ -679,6 +684,7 @@
     if (blank)
 	for (i = 0; i < 256; i++) {
 	    switch(info2->cmap_type) {
+		int regno;
 	    case cmap_m64:
 	        *info2->cmap_adr = i;
 	  	mach_eieio();
@@ -711,6 +717,16 @@
 	    case cmap_gxt2000:
 		out_le32((unsigned *)info2->cmap_adr + i, 0);
 		break;
+	    case cmap_3dfx:
+		/* Wait for three slots in the FIFO (is this necessary?) */
+		while((in_le32((unsigned *)info2->cmap_adr) & 0x1F) < 3 );
+		/* Is the desktop using the upper 256 entries of the CLUT? */
+		regno = (in_le32((unsigned *)info2->cmap_adr + 0x5C) & 1<<12) ?
+		    i+256 : i;
+		/* Stuff the palette index and data */
+		out_le32((unsigned *)(info2->cmap_adr + 0x50), regno);
+		out_le32((unsigned *)(info2->cmap_adr + 0x54), 0);
+		break;
 	    }
 	}
     else
@@ -800,6 +816,17 @@
 	out_le32((unsigned *)info2->cmap_adr + regno,
 		 (red << 16 | green << 8 | blue));
 	break;
+    case cmap_3dfx:
+	/* Wait for three slots in the FIFO (is this necessary?) */
+	while((in_le32((unsigned *)info2->cmap_adr) & 0x1F) < 3 );
+	/* Is the desktop using the upper 256 entries of the CLUT */
+	if((in_le32((unsigned *)info2->cmap_adr + 0x5C) & 1<<12))
+	    regno += 256;
+	/* Stuff the palette index and data */
+	out_le32((unsigned *)(info2->cmap_adr + 0x50), regno);
+	out_le32((unsigned *)(info2->cmap_adr + 0x54),
+	         (red << 16 | green << 8 | blue));
+	break;
     }
 
     if (regno < 16)

--Boundary-00=_qZ/d+gDUsyIULlo--



-------------------------------------------------------
This SF.net email is sponsored by: Does your code think in ink? 
You could win a Tablet PC. Get a free Tablet PC hat just for playing. 
What are you waiting for?
http://ads.sourceforge.net/cgi-bin/redirect.pl?micr5043en
