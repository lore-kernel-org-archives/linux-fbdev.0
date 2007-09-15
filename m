From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 04/12] ps3: Fix black and white stripes
Date: Sat, 15 Sep 2007 08:02:30 +0800
Message-ID: <46EB2116.4030808@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IWLEd-0007lu-Se for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 14 Sep 2007 17:10:08 -0700
Received: from wa-out-1112.google.com ([209.85.146.177])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IWLEb-0003qG-59
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 14 Sep 2007 17:10:07 -0700
Received: by wa-out-1112.google.com with SMTP id k22so1238382waf
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Fri, 14 Sep 2007 17:10:04 -0700 (PDT)
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
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Masashi Kimoto <Masashi_Kimoto@hq.scei.sony.co.jp>, Geoff Levand <geoffrey.levand@am.sony.com>

From: Masashi Kimoto <Masashi_Kimoto@hq.scei.sony.co.jp>

Fix the black and white stripes issue with WUXGA monitor via HDMI.

It seems that when we use a VESA resolution from boot up, the AV settings
driver could not be initialized correctly.
In that case we need a dummy packet before VESA setting.

[Geert] Refactored to reduce code duplication.

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
CC: Geoff Levand <geoffrey.levand@am.sony.com>
Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/ps3/ps3av.c |   58 +++++++++++++++++++++++++++++++++------------------
 1 files changed, 38 insertions(+), 20 deletions(-)

diff --git a/drivers/ps3/ps3av.c b/drivers/ps3/ps3av.c
index 85e2161..a1f63cb 100644
--- a/drivers/ps3/ps3av.c
+++ b/drivers/ps3/ps3av.c
@@ -491,10 +491,10 @@ static int ps3av_set_videomode(void)
 	return 0;
 }
 
-static void ps3av_set_videomode_cont(u32 id, u32 old_id)
+static void ps3av_set_videomode_packet(u32 id)
 {
 	struct ps3av_pkt_avb_param avb_param;
-	int i;
+	unsigned int i;
 	u32 len = 0, av_video_cs;
 	const struct avset_video_mode *video_mode;
 	int res;
@@ -507,24 +507,6 @@ static void ps3av_set_videomode_cont(u32
 					ps3av->av_hw_conf.num_of_avmulti;
 	avb_param.num_of_av_audio_pkt = 0;
 
-	/* video signal off */
-	ps3av_set_video_disable_sig();
-
-	/* Retail PS3 product doesn't support this */
-	if (id & PS3AV_MODE_HDCP_OFF) {
-		res = ps3av_cmd_av_hdmi_mode(PS3AV_CMD_AV_HDMI_HDCP_OFF);
-		if (res == PS3AV_STATUS_UNSUPPORTED_HDMI_MODE)
-			dev_dbg(&ps3av->dev->core, "Not supported\n");
-		else if (res)
-			dev_dbg(&ps3av->dev->core,
-				"ps3av_cmd_av_hdmi_mode failed\n");
-	} else if (old_id & PS3AV_MODE_HDCP_OFF) {
-		res = ps3av_cmd_av_hdmi_mode(PS3AV_CMD_AV_HDMI_MODE_NORMAL);
-		if (res < 0 && res != PS3AV_STATUS_UNSUPPORTED_HDMI_MODE)
-			dev_dbg(&ps3av->dev->core,
-				"ps3av_cmd_av_hdmi_mode failed\n");
-	}
-
 	/* video_pkt */
 	for (i = 0; i < avb_param.num_of_video_pkt; i++)
 		len += ps3av_cmd_set_video_mode(&avb_param.buf[len],
@@ -555,6 +537,42 @@ #endif
 		       __func__);
 	else if (res)
 		dev_dbg(&ps3av->dev->core, "ps3av_cmd_avb_param failed\n");
+}
+
+static void ps3av_set_videomode_cont(u32 id, u32 old_id)
+{
+	static int vesa = 0;
+	int res;
+
+	/* video signal off */
+	ps3av_set_video_disable_sig();
+
+	/*
+	 * AV backend needs non-VESA mode setting at least one time
+	 * when VESA mode is used.
+	 */
+	if (vesa == 0 && (id & PS3AV_MODE_MASK) >= 11) {
+		/* vesa mode */
+		ps3av_set_videomode_packet(2);	/* 480P */
+	}
+	vesa = 1;
+
+	/* Retail PS3 product doesn't support this */
+	if (id & PS3AV_MODE_HDCP_OFF) {
+		res = ps3av_cmd_av_hdmi_mode(PS3AV_CMD_AV_HDMI_HDCP_OFF);
+		if (res == PS3AV_STATUS_UNSUPPORTED_HDMI_MODE)
+			dev_dbg(&ps3av->dev->core, "Not supported\n");
+		else if (res)
+			dev_dbg(&ps3av->dev->core,
+				"ps3av_cmd_av_hdmi_mode failed\n");
+	} else if (old_id & PS3AV_MODE_HDCP_OFF) {
+		res = ps3av_cmd_av_hdmi_mode(PS3AV_CMD_AV_HDMI_MODE_NORMAL);
+		if (res < 0 && res != PS3AV_STATUS_UNSUPPORTED_HDMI_MODE)
+			dev_dbg(&ps3av->dev->core,
+				"ps3av_cmd_av_hdmi_mode failed\n");
+	}
+
+	ps3av_set_videomode_packet(id);
 
 	msleep(1500);
 	/* av video mute */


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
