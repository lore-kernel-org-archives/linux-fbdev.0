From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: Rivafb won't work with DVI connector
Date: Tue, 23 Nov 2004 22:28:59 +0800
Message-ID: <200411232229.00311.adaplas@hotpop.com>
References: <200411191137.14649.andrew@walrond.org> <200411230950.24311.adaplas@hotpop.com> <200411231232.57420.andrew@walrond.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_sk0oBWfd2TZtFBG"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CWbgx-0005hG-RD
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 23 Nov 2004 06:30:51 -0800
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CWbgw-0001QJ-Iz
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 23 Nov 2004 06:30:51 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id DE6ECA29FBD
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 23 Nov 2004 14:30:40 +0000 (UTC)
In-Reply-To: <200411231232.57420.andrew@walrond.org>
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


--Boundary-00=_sk0oBWfd2TZtFBG
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tuesday 23 November 2004 20:32, Andrew Walrond wrote:
> On Tuesday 23 Nov 2004 01:50, Antonino A. Daplas wrote:
> > On Tuesday 23 November 2004 07:47, Andrew Walrond wrote:
> > > Note the erroneous panel detection; this is a 1600x1200 tft lcd. The
> > > panel is detected as 1024x768 in every following case.
> >
> > The panel size is programmed by the BIOS, not sure what what we can do
> > about that.  So even if your display supports 1600x1200, you're still
> > limited to 1024x768.
>
> What, the video-card BIOS? Shouldn't it get the correct info from the EDID?

If the display has an analog input, then yes.  It's different when the input
is digital. 

(Also, the EDID block may differ depending on the input type, this I'm not
sure).


> Ok, with your incremental patch, DSUB connection and no kernel params, the
> kernel boots into a corruption free 1600x1200 (200xwhatever) console with
> two nice penguins, after detecting EDIDs on BUS2 and BUS3.
> Unfortunately, it then  Oops's like this: (copied by hand)
>
>  Oops : PREEMPT SMP
>
>  tty_open+342  chrdev_open+457
>  dentry_open+315 filp_open+62
>  get_unused_fd+244 sys_open+76
>  init+652   child_rip+8
>  init+0    child_rip+0
>

Okay, try the attached patch.

Tony


--Boundary-00=_sk0oBWfd2TZtFBG
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="nvidiafb2-inc2.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="nvidiafb2-inc2.diff"

diff -Nru a/drivers/video/nvidia/nv_setup.c b/drivers/video/nvidia/nv_setup.c
--- a/drivers/video/nvidia/nv_setup.c	2004-11-23 06:01:00 +08:00
+++ b/drivers/video/nvidia/nv_setup.c	2004-11-23 22:19:56 +08:00
@@ -289,7 +289,8 @@
 	u16 implementation = par->Chipset & 0x0ff0;
 	u8 *edidA, *edidB;
 	struct fb_monspecs monitorA, monitorB;
-	int mobile = 0, validA = 0, validB = 0;
+	struct fb_monspecs *monA = NULL, *monB = NULL;
+	int mobile = 0;
 	int tvA = 0;
 	int tvB = 0;
 	int FlatPanel = -1;   /* really means the CRTC is slaved */
@@ -397,13 +398,13 @@
 		nvidia_probe_i2c_connector(par, 1, &edidA);
 		if(edidA && !fb_parse_edid(edidA, &var)) {
 			printk("nvidiafb: EDID found from BUS1\n");
-			fb_edid_to_monspecs(edidA, &monitorA);
-			FlatPanel = (monitorA.input == FB_DISP_DDI) ? 1 : 0;
+			monA = &monitorA;
+			fb_edid_to_monspecs(edidA, monA);
+			FlatPanel = (monA->input == FB_DISP_DDI) ? 1 : 0;
 			
 			/* NV4 doesn't support FlatPanels */
 			if((par->Chipset & 0x0fff) <= 0x0020)
 				FlatPanel = 0;
-			validA = 1;
 		} else {
 			VGA_WR08(par->PCIO, 0x03D4, 0x28);
 			if(VGA_RD08(par->PCIO, 0x03D5) & 0x80) {
@@ -484,15 +485,15 @@
 		nvidia_probe_i2c_connector(par, 1, &edidA);
 		if (edidA && !fb_parse_edid(edidA, &var)) {
 			printk("nvidiafb: EDID found from BUS1\n");
-			fb_edid_to_monspecs(edidA, &monitorA);
-			validA = 1;
+			monA = &monitorA;
+			fb_edid_to_monspecs(edidA, monA);
 		}
 
 		nvidia_probe_i2c_connector(par, 2, &edidB);
 		if (edidB && !fb_parse_edid(edidB, &var)) {
 			printk("nvidiafb: EDID found from BUS2\n");
-			fb_edid_to_monspecs(edidB, &monitorB);
-			validB = 1;
+			monB = &monitorB;
+			fb_edid_to_monspecs(edidB, monB);
 		}
 
 		if(slaved_on_A && !tvA) {
@@ -529,10 +530,10 @@
 			Television = 1;
 			printk("nvidiafb: CRTC 1 is currently programmed for "
 			       "TV\n");
-		} else if (validA) {
-			FlatPanel = (monitorA.input == FB_DISP_DDI) ? 1 : 0;
-		} else if (validB) {
-			FlatPanel = (monitorB.input == FB_DISP_DDI) ? 1 : 0;
+		} else if (monA) {
+			FlatPanel = (monA->input == FB_DISP_DDI) ? 1 : 0;
+		} else if (monB) {
+			FlatPanel = (monB->input == FB_DISP_DDI) ? 1 : 0;
 		}
 		
 		if(par->FlatPanel == -1) {
@@ -572,25 +573,30 @@
 			       "specified\n", par->CRTCnumber);
 		}
 		
-		if (validA) {
-			if (((monitorA.input == FB_DISP_DDI) &&
+		if (monA) {
+			if (((monA->input == FB_DISP_DDI) &&
 			     par->FlatPanel) ||
-			    ((monitorA.input != FB_DISP_DDI) &&
-			     !par->FlatPanel)) { 
-				if(validB)
-					fb_destroy_modedb(monitorB.modedb);
-			} else 
-				fb_destroy_modedb(monitorA.modedb);
+			    ((monA->input != FB_DISP_DDI) &&
+			     !par->FlatPanel)) {
+				if (monB) {
+					fb_destroy_modedb(monB->modedb);
+					monB = NULL;
+				}
+			} else {
+				fb_destroy_modedb(monA->modedb);
+				monA = NULL;
+			}
 		}
 		
-		if (validB) {
-			if (((monitorB.input == FB_DISP_DDI) &&
+		if (monB) {
+			if (((monB->input == FB_DISP_DDI) &&
 			     !par->FlatPanel) ||
-			    ((!monitorB.input != FB_DISP_DDI) &&
-			     par->FlatPanel)) 
-				fb_destroy_modedb(monitorB.modedb);
-			else
-				monitorA = monitorB;
+			    ((monB->input != FB_DISP_DDI) &&
+			     par->FlatPanel)) {
+				fb_destroy_modedb(monB->modedb);
+				monB = NULL;
+			} else 
+				monA = monB;
 		}
 
 		if(implementation == 0x0110)
@@ -615,10 +621,12 @@
 		printk("Panel size is %i x %i\n", par->fpWidth, par->fpHeight);
 	}
 	
-	if (validA || validB)
-		info->monspecs = monitorA;
+	if (monA)
+		info->monspecs = *monA;
+
 	kfree(edidA);
 	kfree(edidB);
+	
 	if(!par->FlatPanel || (info->var.bits_per_pixel != 24) ||
 	   !par->twoHeads)
 		par->FPDither = 0;

--Boundary-00=_sk0oBWfd2TZtFBG--




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
