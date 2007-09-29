From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 11/17] ps3av: use PS3 video mode ids in
	autodetect code
Date: Sat, 29 Sep 2007 09:35:56 +0800
Message-ID: <46FDABFC.4040704@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IbSOS-0008Ay-IK for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 28 Sep 2007 19:49:24 -0700
Received: from wa-out-1112.google.com ([209.85.146.181])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IbSOS-0007Nu-5g
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 28 Sep 2007 19:49:24 -0700
Received: by wa-out-1112.google.com with SMTP id k22so5644187waf
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Fri, 28 Sep 2007 19:49:23 -0700 (PDT)
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@osdl.org>
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>

It doesn't make much sense to use the PS3AV_CMD_VIDEO_VID_* values in the
autodetection code, just to convert them to PS3 video mode ids afterwards.

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/ps3/ps3av.c         |   90 +++++++++++++++++++------------------------
 include/asm-powerpc/ps3av.h |   11 +++--
 2 files changed, 46 insertions(+), 55 deletions(-)

diff --git a/drivers/ps3/ps3av.c b/drivers/ps3/ps3av.c
index c1bcad6..51feb7e 100644
--- a/drivers/ps3/ps3av.c
+++ b/drivers/ps3/ps3av.c
@@ -585,75 +585,65 @@ static void ps3avd(struct work_struct *w
 	complete(&ps3av->done);
 }
 
-static int ps3av_vid2table_id(int vid)
+static int ps3av_resbit2id(u32 res_50, u32 res_60)
 {
-	int i;
-
-	for (i = 1; i < ARRAY_SIZE(video_mode_table); i++)
-		if (video_mode_table[i].vid == vid)
-			return i;
-	return -1;
-}
-
-static int ps3av_resbit2vid(u32 res_50, u32 res_60)
-{
-	int vid = -1;
+	int id = 0;
 
 	if (res_50 > res_60) {	/* if res_50 == res_60, res_60 will be used */
 		if (res_50 & PS3AV_RESBIT_1920x1080P)
-			vid = PS3AV_CMD_VIDEO_VID_1080P_50HZ;
+			id = 10;
 		else if (res_50 & PS3AV_RESBIT_1920x1080I)
-			vid = PS3AV_CMD_VIDEO_VID_1080I_50HZ;
+			id = 9;
 		else if (res_50 & PS3AV_RESBIT_1280x720P)
-			vid = PS3AV_CMD_VIDEO_VID_720P_50HZ;
+			id = 8;
 		else if (res_50 & PS3AV_RESBIT_720x576P)
-			vid = PS3AV_CMD_VIDEO_VID_576P;
+			id = 7;
 		else
-			vid = -1;
+			id = 0;
 	} else {
 		if (res_60 & PS3AV_RESBIT_1920x1080P)
-			vid = PS3AV_CMD_VIDEO_VID_1080P_60HZ;
+			id = 5;
 		else if (res_60 & PS3AV_RESBIT_1920x1080I)
-			vid = PS3AV_CMD_VIDEO_VID_1080I_60HZ;
+			id = 4;
 		else if (res_60 & PS3AV_RESBIT_1280x720P)
-			vid = PS3AV_CMD_VIDEO_VID_720P_60HZ;
+			id = 3;
 		else if (res_60 & PS3AV_RESBIT_720x480P)
-			vid = PS3AV_CMD_VIDEO_VID_480P;
+			id = 2;
 		else
-			vid = -1;
+			id = 0;
 	}
-	return vid;
+	return id;
 }
 
-static int ps3av_hdmi_get_vid(struct ps3av_info_monitor *info)
+static int ps3av_hdmi_get_id(struct ps3av_info_monitor *info)
 {
 	u32 res_50, res_60;
-	int vid = -1;
+	int id;
 
 	if (info->monitor_type != PS3AV_MONITOR_TYPE_HDMI)
-		return -1;
+		return 0;
 
 	/* check native resolution */
 	res_50 = info->res_50.native & PS3AV_RES_MASK_50;
 	res_60 = info->res_60.native & PS3AV_RES_MASK_60;
 	if (res_50 || res_60) {
-		vid = ps3av_resbit2vid(res_50, res_60);
-		return vid;
+		id = ps3av_resbit2id(res_50, res_60);
+		return id;
 	}
 
 	/* check resolution */
 	res_50 = info->res_50.res_bits & PS3AV_RES_MASK_50;
 	res_60 = info->res_60.res_bits & PS3AV_RES_MASK_60;
 	if (res_50 || res_60) {
-		vid = ps3av_resbit2vid(res_50, res_60);
-		return vid;
+		id = ps3av_resbit2id(res_50, res_60);
+		return id;
 	}
 
 	if (ps3av->region & PS3AV_REGION_60)
-		vid = PS3AV_DEFAULT_HDMI_VID_REG_60;
+		id = PS3AV_DEFAULT_HDMI_MODE_ID_REG_60;
 	else
-		vid = PS3AV_DEFAULT_HDMI_VID_REG_50;
-	return vid;
+		id = PS3AV_DEFAULT_HDMI_MODE_ID_REG_50;
+	return id;
 }
 
 static void ps3av_monitor_info_dump(const struct ps3av_pkt_av_get_monitor_info *monitor_info)
@@ -717,11 +707,11 @@ static void ps3av_monitor_info_dump(cons
 static int ps3av_auto_videomode(struct ps3av_pkt_av_get_hw_conf *av_hw_conf,
 				int boot)
 {
-	int i, res, vid = -1, dvi = 0, rgb = 0;
+	int i, res, id = 0, dvi = 0, rgb = 0;
 	struct ps3av_pkt_av_get_monitor_info monitor_info;
 	struct ps3av_info_monitor *info;
 
-	/* get vid for hdmi */
+	/* get mode id for hdmi */
 	for (i = 0; i < av_hw_conf->num_of_hdmi; i++) {
 		res = ps3av_cmd_video_get_monitor_info(&monitor_info,
 						       PS3AV_CMD_AVPORT_HDMI_0 +
@@ -737,49 +727,49 @@ static int ps3av_auto_videomode(struct p
 			break;
 		}
 		/* check HDMI */
-		vid = ps3av_hdmi_get_vid(info);
-		if (vid != -1) {
-			/* got valid vid */
+		id = ps3av_hdmi_get_id(info);
+		if (id) {
+			/* got valid mode id */
 			break;
 		}
 	}
 
 	if (dvi) {
 		/* DVI mode */
-		vid = PS3AV_DEFAULT_DVI_VID;
-	} else if (vid == -1) {
+		id = PS3AV_DEFAULT_DVI_MODE_ID;
+	} else if (!id) {
 		/* no HDMI interface or HDMI is off */
 		if (ps3av->region & PS3AV_REGION_60)
-			vid = PS3AV_DEFAULT_AVMULTI_VID_REG_60;
+			id = PS3AV_DEFAULT_AVMULTI_MODE_ID_REG_60;
 		else
-			vid = PS3AV_DEFAULT_AVMULTI_VID_REG_50;
+			id = PS3AV_DEFAULT_AVMULTI_MODE_ID_REG_50;
 		if (ps3av->region & PS3AV_REGION_RGB)
 			rgb = PS3AV_MODE_RGB;
 	} else if (boot) {
-		/* HDMI: using DEFAULT HDMI_VID while booting up */
+		/* HDMI: using DEFAULT HDMI_MODE_ID while booting up */
 		info = &monitor_info.info;
 		if (ps3av->region & PS3AV_REGION_60) {
 			if (info->res_60.res_bits & PS3AV_RESBIT_720x480P)
-				vid = PS3AV_DEFAULT_HDMI_VID_REG_60;
+				id = PS3AV_DEFAULT_HDMI_MODE_ID_REG_60;
 			else if (info->res_50.res_bits & PS3AV_RESBIT_720x576P)
-				vid = PS3AV_DEFAULT_HDMI_VID_REG_50;
+				id = PS3AV_DEFAULT_HDMI_MODE_ID_REG_50;
 			else {
 				/* default */
-				vid = PS3AV_DEFAULT_HDMI_VID_REG_60;
+				id = PS3AV_DEFAULT_HDMI_MODE_ID_REG_60;
 			}
 		} else {
 			if (info->res_50.res_bits & PS3AV_RESBIT_720x576P)
-				vid = PS3AV_DEFAULT_HDMI_VID_REG_50;
+				id = PS3AV_DEFAULT_HDMI_MODE_ID_REG_50;
 			else if (info->res_60.res_bits & PS3AV_RESBIT_720x480P)
-				vid = PS3AV_DEFAULT_HDMI_VID_REG_60;
+				id = PS3AV_DEFAULT_HDMI_MODE_ID_REG_60;
 			else {
 				/* default */
-				vid = PS3AV_DEFAULT_HDMI_VID_REG_50;
+				id = PS3AV_DEFAULT_HDMI_MODE_ID_REG_50;
 			}
 		}
 	}
 
-	return (ps3av_vid2table_id(vid) | dvi | rgb);
+	return id | dvi | rgb;
 }
 
 static int ps3av_get_hw_conf(struct ps3av *ps3av)
diff --git a/include/asm-powerpc/ps3av.h b/include/asm-powerpc/ps3av.h
index 4ac93a2..c023c5d 100644
--- a/include/asm-powerpc/ps3av.h
+++ b/include/asm-powerpc/ps3av.h
@@ -300,11 +300,12 @@ #define PS3AV_RES_MASK_50			(PS3AV_RESBI
 
 #define PS3AV_MONITOR_TYPE_HDMI			1	/* HDMI */
 #define PS3AV_MONITOR_TYPE_DVI			2	/* DVI */
-#define PS3AV_DEFAULT_HDMI_VID_REG_60		PS3AV_CMD_VIDEO_VID_480P
-#define PS3AV_DEFAULT_AVMULTI_VID_REG_60	PS3AV_CMD_VIDEO_VID_480I
-#define PS3AV_DEFAULT_HDMI_VID_REG_50		PS3AV_CMD_VIDEO_VID_576P
-#define PS3AV_DEFAULT_AVMULTI_VID_REG_50	PS3AV_CMD_VIDEO_VID_576I
-#define PS3AV_DEFAULT_DVI_VID			PS3AV_CMD_VIDEO_VID_480P
+
+#define PS3AV_DEFAULT_HDMI_MODE_ID_REG_60	2	/* 480p */
+#define PS3AV_DEFAULT_AVMULTI_MODE_ID_REG_60	1	/* 480i */
+#define PS3AV_DEFAULT_HDMI_MODE_ID_REG_50	7	/* 576p */
+#define PS3AV_DEFAULT_AVMULTI_MODE_ID_REG_50	6	/* 576i */
+#define PS3AV_DEFAULT_DVI_MODE_ID		2	/* 480p */
 
 #define PS3AV_REGION_60				0x01
 #define PS3AV_REGION_50				0x02


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
