From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: Rivafb won't work with DVI connector
Date: Wed, 24 Nov 2004 01:07:11 +0800
Message-ID: <200411240107.13362.adaplas@hotpop.com>
References: <200411191137.14649.andrew@walrond.org> <200411232318.00795.adaplas@hotpop.com> <200411231608.19517.andrew@walrond.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_B52oBbF+co1hQTg"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CWe8V-00050V-PL
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 23 Nov 2004 09:07:27 -0800
Received: from smtp-out.hotpop.com ([38.113.3.71])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CWe8U-0002NF-GZ
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 23 Nov 2004 09:07:27 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id C30D6120453C
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 23 Nov 2004 17:07:14 +0000 (UTC)
In-Reply-To: <200411231608.19517.andrew@walrond.org>
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
To: linux-fbdev-devel@lists.sourceforge.net, Andrew Walrond <andrew@walrond.org>


--Boundary-00=_B52oBbF+co1hQTg
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wednesday 24 November 2004 00:08, Andrew Walrond wrote:
> On Tuesday 23 Nov 2004 15:18, Antonino A. Daplas wrote:
> > On Tuesday 23 November 2004 23:09, Andrew Walrond wrote:
> > > On Tuesday 23 Nov 2004 14:28, Antonino A. Daplas wrote:
> > > > Okay, try the attached patch.
> > >
> > > Ok, booting on dsub without params now results in a good 1024x768
> > > (128x48) console and boots cleanly. (Note this was a 1600x1200
> > > (200xwhatever) before the patch, which is the preferred, native
> > > resolution of the screen.)
>
> Actually, I think this is die to having both dsub and dvi attached during
> that test. Just dsub boots to 1600x1200 as before
>

Okay, I think I this should fix the dvi misdetection, and I think it should
also fix the preferred timing of 1600x1200 even if both dsub and dvi are
attached.  Try the attached patch.

Tony

--Boundary-00=_B52oBbF+co1hQTg
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="nvidiafb2-inc3.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="nvidiafb2-inc3.diff"

diff -Nru a/drivers/video/nvidia/nv_setup.c b/drivers/video/nvidia/nv_setup.c
--- a/drivers/video/nvidia/nv_setup.c	2004-11-23 22:19:56 +08:00
+++ b/drivers/video/nvidia/nv_setup.c	2004-11-24 01:02:51 +08:00
@@ -400,7 +400,7 @@
 			printk("nvidiafb: EDID found from BUS1\n");
 			monA = &monitorA;
 			fb_edid_to_monspecs(edidA, monA);
-			FlatPanel = (monA->input == FB_DISP_DDI) ? 1 : 0;
+			FlatPanel = (monA->input & FB_DISP_DDI) ? 1 : 0;
 			
 			/* NV4 doesn't support FlatPanels */
 			if((par->Chipset & 0x0fff) <= 0x0020)
@@ -531,9 +531,9 @@
 			printk("nvidiafb: CRTC 1 is currently programmed for "
 			       "TV\n");
 		} else if (monA) {
-			FlatPanel = (monA->input == FB_DISP_DDI) ? 1 : 0;
+			FlatPanel = (monA->input & FB_DISP_DDI) ? 1 : 0;
 		} else if (monB) {
-			FlatPanel = (monB->input == FB_DISP_DDI) ? 1 : 0;
+			FlatPanel = (monB->input & FB_DISP_DDI) ? 1 : 0;
 		}
 		
 		if(par->FlatPanel == -1) {
@@ -574,9 +574,9 @@
 		}
 		
 		if (monA) {
-			if (((monA->input == FB_DISP_DDI) &&
+			if (((monA->input & FB_DISP_DDI) &&
 			     par->FlatPanel) ||
-			    ((monA->input != FB_DISP_DDI) &&
+			    ((!(monA->input & FB_DISP_DDI)) &&
 			     !par->FlatPanel)) {
 				if (monB) {
 					fb_destroy_modedb(monB->modedb);
@@ -589,9 +589,9 @@
 		}
 		
 		if (monB) {
-			if (((monB->input == FB_DISP_DDI) &&
+			if (((monB->input & FB_DISP_DDI) &&
 			     !par->FlatPanel) ||
-			    ((monB->input != FB_DISP_DDI) &&
+			    ((!(monB->input & FB_DISP_DDI)) &&
 			     par->FlatPanel)) {
 				fb_destroy_modedb(monB->modedb);
 				monB = NULL;

--Boundary-00=_B52oBbF+co1hQTg--




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
