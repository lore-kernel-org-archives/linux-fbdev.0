From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 4/9] nvidiafb: Reduce stack usage
Date: Tue, 20 Dec 2005 20:49:43 +0800
Message-ID: <43A7FDE7.5010002@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EoyEu-0002Be-DD
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 20 Dec 2005 23:18:20 -0800
Received: from zproxy.gmail.com ([64.233.162.205])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EoyEr-0005Kv-3s
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 20 Dec 2005 23:18:20 -0800
Received: by zproxy.gmail.com with SMTP id z3so76970nzf
        for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 20 Dec 2005 23:18:16 -0800 (PST)
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
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Reduce stack usage of NVCommonSetup()
    
Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/nvidia/nv_proto.h |    2 +-
 drivers/video/nvidia/nv_setup.c |   34 +++++++++++++++++++++++-----------
 drivers/video/nvidia/nvidia.c   |    3 ++-
 3 files changed, 26 insertions(+), 13 deletions(-)

diff --git a/drivers/video/nvidia/nv_proto.h b/drivers/video/nvidia/nv_proto.h
index 3353103..b149a69 100644
--- a/drivers/video/nvidia/nv_proto.h
+++ b/drivers/video/nvidia/nv_proto.h
@@ -4,7 +4,7 @@
 #define __NV_PROTO_H__
 
 /* in nv_setup.c */
-void NVCommonSetup(struct fb_info *info);
+int NVCommonSetup(struct fb_info *info);
 void NVWriteCrtc(struct nvidia_par *par, u8 index, u8 value);
 u8 NVReadCrtc(struct nvidia_par *par, u8 index);
 void NVWriteGr(struct nvidia_par *par, u8 index, u8 value);
diff --git a/drivers/video/nvidia/nv_setup.c b/drivers/video/nvidia/nv_setup.c
index 2c02452..a18a9ae 100644
--- a/drivers/video/nvidia/nv_setup.c
+++ b/drivers/video/nvidia/nv_setup.c
@@ -290,22 +290,29 @@ static void nv10GetConfig(struct nvidia_
 	par->MaxVClockFreqKHz = par->twoStagePLL ? 400000 : 350000;
 }
 
-void NVCommonSetup(struct fb_info *info)
+int NVCommonSetup(struct fb_info *info)
 {
 	struct nvidia_par *par = info->par;
-	struct fb_var_screeninfo var;
+	struct fb_var_screeninfo *var;
 	u16 implementation = par->Chipset & 0x0ff0;
 	u8 *edidA = NULL, *edidB = NULL;
-	struct fb_monspecs monitorA, monitorB;
+	struct fb_monspecs *monitorA, *monitorB;
 	struct fb_monspecs *monA = NULL, *monB = NULL;
 	int mobile = 0;
 	int tvA = 0;
 	int tvB = 0;
 	int FlatPanel = -1;	/* really means the CRTC is slaved */
 	int Television = 0;
+	int err = 0;
 
-	memset(&monitorA, 0, sizeof(struct fb_monspecs));
-	memset(&monitorB, 0, sizeof(struct fb_monspecs));
+	var = kzalloc(sizeof(struct fb_var_screeninfo), GFP_KERNEL);
+	monitorA = kzalloc(sizeof(struct fb_monspecs), GFP_KERNEL);
+	monitorB = kzalloc(sizeof(struct fb_monspecs), GFP_KERNEL);
+
+	if (!var || !monitorA || !monitorB) {
+		err = -ENOMEM;
+		goto done;
+	}
 
 	par->PRAMIN = par->REGS + (0x00710000 / 4);
 	par->PCRTC0 = par->REGS + (0x00600000 / 4);
@@ -407,9 +414,9 @@ void NVCommonSetup(struct fb_info *info)
 		par->CRTCnumber = 0;
 		if (nvidia_probe_i2c_connector(info, 1, &edidA))
 			nvidia_probe_of_connector(info, 1, &edidA);
-		if (edidA && !fb_parse_edid(edidA, &var)) {
+		if (edidA && !fb_parse_edid(edidA, var)) {
 			printk("nvidiafb: EDID found from BUS1\n");
-			monA = &monitorA;
+			monA = monitorA;
 			fb_edid_to_monspecs(edidA, monA);
 			FlatPanel = (monA->input & FB_DISP_DDI) ? 1 : 0;
 
@@ -495,17 +502,17 @@ void NVCommonSetup(struct fb_info *info)
 
 		if (nvidia_probe_i2c_connector(info, 1, &edidA))
 			nvidia_probe_of_connector(info, 1, &edidA);
-		if (edidA && !fb_parse_edid(edidA, &var)) {
+		if (edidA && !fb_parse_edid(edidA, var)) {
 			printk("nvidiafb: EDID found from BUS1\n");
-			monA = &monitorA;
+			monA = monitorA;
 			fb_edid_to_monspecs(edidA, monA);
 		}
 
 		if (nvidia_probe_i2c_connector(info, 2, &edidB))
 			nvidia_probe_of_connector(info, 2, &edidB);
-		if (edidB && !fb_parse_edid(edidB, &var)) {
+		if (edidB && !fb_parse_edid(edidB, var)) {
 			printk("nvidiafb: EDID found from BUS2\n");
-			monB = &monitorB;
+			monB = monitorB;
 			fb_edid_to_monspecs(edidB, monB);
 		}
 
@@ -640,4 +647,9 @@ void NVCommonSetup(struct fb_info *info)
 
 	kfree(edidA);
 	kfree(edidB);
+done:
+	kfree(var);
+	kfree(monitorA);
+	kfree(monitorB);
+	return err;
 }
diff --git a/drivers/video/nvidia/nvidia.c b/drivers/video/nvidia/nvidia.c
index ae6f2ff..dbcb896 100644
--- a/drivers/video/nvidia/nvidia.c
+++ b/drivers/video/nvidia/nvidia.c
@@ -1617,7 +1617,8 @@ static int __devinit nvidiafb_probe(stru
 
 	sprintf(nvidiafb_fix.id, "NV%x", (pd->device & 0x0ff0) >> 4);
 
-	NVCommonSetup(info);
+	if (NVCommonSetup(info))
+		goto err_out_arch;
 
 	par->FbAddress = nvidiafb_fix.smem_start;
 	par->FbMapSize = par->RamAmountKBytes * 1024;




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
