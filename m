From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 12/17] ps3av: treat DVI-D like HDMI in
	autodetect
Date: Sat, 29 Sep 2007 09:37:15 +0800
Message-ID: <46FDAC4B.1080008@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IbSOd-0008B8-VI for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 28 Sep 2007 19:49:36 -0700
Received: from wr-out-0506.google.com ([64.233.184.232])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IbSOd-0007Pn-Jz
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 28 Sep 2007 19:49:35 -0700
Received: by wr-out-0506.google.com with SMTP id 36so1487068wra
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Fri, 28 Sep 2007 19:49:34 -0700 (PDT)
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

treat DVI-D monitors like HDMI monitors when autodetecting the best
video mode

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/ps3/ps3av.c         |   24 ++++++++----------------
 include/asm-powerpc/ps3av.h |    1 -
 2 files changed, 8 insertions(+), 17 deletions(-)

diff --git a/drivers/ps3/ps3av.c b/drivers/ps3/ps3av.c
index 51feb7e..21f69a7 100644
--- a/drivers/ps3/ps3av.c
+++ b/drivers/ps3/ps3av.c
@@ -620,9 +620,6 @@ static int ps3av_hdmi_get_id(struct ps3a
 	u32 res_50, res_60;
 	int id;
 
-	if (info->monitor_type != PS3AV_MONITOR_TYPE_HDMI)
-		return 0;
-
 	/* check native resolution */
 	res_50 = info->res_50.native & PS3AV_RES_MASK_50;
 	res_60 = info->res_60.native & PS3AV_RES_MASK_60;
@@ -712,7 +709,7 @@ static int ps3av_auto_videomode(struct p
 	struct ps3av_info_monitor *info;
 
 	/* get mode id for hdmi */
-	for (i = 0; i < av_hw_conf->num_of_hdmi; i++) {
+	for (i = 0; i < av_hw_conf->num_of_hdmi && !id; i++) {
 		res = ps3av_cmd_video_get_monitor_info(&monitor_info,
 						       PS3AV_CMD_AVPORT_HDMI_0 +
 						       i);
@@ -720,24 +717,19 @@ static int ps3av_auto_videomode(struct p
 			return -1;
 
 		ps3av_monitor_info_dump(&monitor_info);
+
 		info = &monitor_info.info;
-		/* check DVI */
-		if (info->monitor_type == PS3AV_MONITOR_TYPE_DVI) {
+		switch (info->monitor_type) {
+		case PS3AV_MONITOR_TYPE_DVI:
 			dvi = PS3AV_MODE_DVI;
-			break;
-		}
-		/* check HDMI */
-		id = ps3av_hdmi_get_id(info);
-		if (id) {
-			/* got valid mode id */
+			/* fall through */
+		case PS3AV_MONITOR_TYPE_HDMI:
+			id = ps3av_hdmi_get_id(info);
 			break;
 		}
 	}
 
-	if (dvi) {
-		/* DVI mode */
-		id = PS3AV_DEFAULT_DVI_MODE_ID;
-	} else if (!id) {
+	if (!id) {
 		/* no HDMI interface or HDMI is off */
 		if (ps3av->region & PS3AV_REGION_60)
 			id = PS3AV_DEFAULT_AVMULTI_MODE_ID_REG_60;
diff --git a/include/asm-powerpc/ps3av.h b/include/asm-powerpc/ps3av.h
index c023c5d..014673e 100644
--- a/include/asm-powerpc/ps3av.h
+++ b/include/asm-powerpc/ps3av.h
@@ -305,7 +305,6 @@ #define PS3AV_DEFAULT_HDMI_MODE_ID_REG_6
 #define PS3AV_DEFAULT_AVMULTI_MODE_ID_REG_60	1	/* 480i */
 #define PS3AV_DEFAULT_HDMI_MODE_ID_REG_50	7	/* 576p */
 #define PS3AV_DEFAULT_AVMULTI_MODE_ID_REG_50	6	/* 576i */
-#define PS3AV_DEFAULT_DVI_MODE_ID		2	/* 480p */
 
 #define PS3AV_REGION_60				0x01
 #define PS3AV_REGION_50				0x02


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
