From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 3/9] nvidiafb: Fallback to firmware EDID
Date: Sat, 20 Aug 2005 00:38:19 +0800
Message-ID: <43060AFB.90508@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E6HH7-0002Jg-MM
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 19 Aug 2005 17:31:53 -0700
Received: from wproxy.gmail.com ([64.233.184.194])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1E6HH7-0000hQ-Ez
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 19 Aug 2005 17:31:53 -0700
Received: by wproxy.gmail.com with SMTP id i21so610594wra
        for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 19 Aug 2005 17:31:47 -0700 (PDT)
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
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

    If nvidiafb fails to probe the EDID block, get the EDID from the BIOS.

    Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 nv_i2c.c   |   16 ++++++++++++----
 nv_proto.h |    2 +-
 nv_setup.c |    6 +++---
 3 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/video/nvidia/nv_i2c.c b/drivers/video/nvidia/nv_i2c.c
--- a/drivers/video/nvidia/nv_i2c.c
+++ b/drivers/video/nvidia/nv_i2c.c
@@ -194,8 +194,9 @@ static u8 *nvidia_do_probe_i2c_edid(stru
 	return NULL;
 }
 
-int nvidia_probe_i2c_connector(struct nvidia_par *par, int conn, u8 **out_edid)
+int nvidia_probe_i2c_connector(struct fb_info *info, int conn, u8 **out_edid)
 {
+	struct nvidia_par *par = info->par;
 	u8 *edid = NULL;
 	int i;
 
@@ -205,10 +206,17 @@ int nvidia_probe_i2c_connector(struct nv
 		if (edid)
 			break;
 	}
+
+	if (!edid && conn == 1) {
+		/* try to get from firmware */
+		edid = kmalloc(EDID_LENGTH, GFP_KERNEL);
+		if (edid)
+			memcpy(edid, fb_firmware_edid(info->device),
+			       EDID_LENGTH);
+	}
+
 	if (out_edid)
 		*out_edid = edid;
-	if (!edid)
-		return 1;
 
-	return 0;
+	return (edid) ? 0 : 1;
 }
diff --git a/drivers/video/nvidia/nv_proto.h b/drivers/video/nvidia/nv_proto.h
--- a/drivers/video/nvidia/nv_proto.h
+++ b/drivers/video/nvidia/nv_proto.h
@@ -34,7 +34,7 @@ void NVLockUnlock(struct nvidia_par *par
 #if defined(CONFIG_FB_NVIDIA_I2C) || defined (CONFIG_PPC_OF)
 void nvidia_create_i2c_busses(struct nvidia_par *par);
 void nvidia_delete_i2c_busses(struct nvidia_par *par);
-int nvidia_probe_i2c_connector(struct nvidia_par *par, int conn,
+int nvidia_probe_i2c_connector(struct fb_info *info, int conn,
 			       u8 ** out_edid);
 #else
 #define nvidia_create_i2c_busses(...)
diff --git a/drivers/video/nvidia/nv_setup.c b/drivers/video/nvidia/nv_setup.c
--- a/drivers/video/nvidia/nv_setup.c
+++ b/drivers/video/nvidia/nv_setup.c
@@ -401,7 +401,7 @@ void NVCommonSetup(struct fb_info *info)
 	nvidia_create_i2c_busses(par);
 	if (!par->twoHeads) {
 		par->CRTCnumber = 0;
-		nvidia_probe_i2c_connector(par, 1, &edidA);
+		nvidia_probe_i2c_connector(info, 1, &edidA);
 		if (edidA && !fb_parse_edid(edidA, &var)) {
 			printk("nvidiafb: EDID found from BUS1\n");
 			monA = &monitorA;
@@ -488,14 +488,14 @@ void NVCommonSetup(struct fb_info *info)
 		oldhead = NV_RD32(par->PCRTC0, 0x00000860);
 		NV_WR32(par->PCRTC0, 0x00000860, oldhead | 0x00000010);
 
-		nvidia_probe_i2c_connector(par, 1, &edidA);
+		nvidia_probe_i2c_connector(info, 1, &edidA);
 		if (edidA && !fb_parse_edid(edidA, &var)) {
 			printk("nvidiafb: EDID found from BUS1\n");
 			monA = &monitorA;
 			fb_edid_to_monspecs(edidA, monA);
 		}
 
-		nvidia_probe_i2c_connector(par, 2, &edidB);
+		nvidia_probe_i2c_connector(info, 2, &edidB);
 		if (edidB && !fb_parse_edid(edidB, &var)) {
 			printk("nvidiafb: EDID found from BUS2\n");
 			monB = &monitorB;



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
