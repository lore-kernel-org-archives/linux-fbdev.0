From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 14/17] ps3av: add quirk database for
	broken monitors
Date: Sat, 29 Sep 2007 09:39:10 +0800
Message-ID: <46FDACBE.8080707@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IbSP1-0008BZ-97 for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 28 Sep 2007 19:49:59 -0700
Received: from nz-out-0506.google.com ([64.233.162.230])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IbSP1-0007VV-0h
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 28 Sep 2007 19:49:59 -0700
Received: by nz-out-0506.google.com with SMTP id f1so7463085nzc
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Fri, 28 Sep 2007 19:49:57 -0700 (PDT)
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

add a quirk database for broken monitors where the `best' advertised
video mode doesn't work

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/ps3/ps3av.c |   41 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 41 insertions(+), 0 deletions(-)

diff --git a/drivers/ps3/ps3av.c b/drivers/ps3/ps3av.c
index fbf8dcd..cae4af9 100644
--- a/drivers/ps3/ps3av.c
+++ b/drivers/ps3/ps3av.c
@@ -721,6 +721,45 @@ static void ps3av_monitor_info_dump(cons
 	}
 }
 
+static const struct ps3av_monitor_quirk {
+	const char *monitor_name;
+	u32 clear_60, clear_50, clear_vesa;
+} ps3av_monitor_quirks[] = {
+	{
+		.monitor_name	= "DELL 2007WFP",
+		.clear_60	= PS3AV_RESBIT_1920x1080I
+	}, {
+		.monitor_name	= "L226WTQ",
+		.clear_60	= PS3AV_RESBIT_1920x1080I |
+				  PS3AV_RESBIT_1920x1080P
+	}, {
+		.monitor_name	= "SyncMaster",
+		.clear_60	= PS3AV_RESBIT_1920x1080I
+	}
+};
+
+static void ps3av_fixup_monitor_info(struct ps3av_info_monitor *info)
+{
+	unsigned int i;
+	const struct ps3av_monitor_quirk *quirk;
+
+	for (i = 0; i < ARRAY_SIZE(ps3av_monitor_quirks); i++) {
+		quirk = &ps3av_monitor_quirks[i];
+		if (!strncmp(info->monitor_name, quirk->monitor_name,
+			     sizeof(info->monitor_name))) {
+			pr_info("%s: Applying quirk for %s\n", __func__,
+				quirk->monitor_name);
+			info->res_60.res_bits &= ~quirk->clear_60;
+			info->res_60.native &= ~quirk->clear_60;
+			info->res_50.res_bits &= ~quirk->clear_50;
+			info->res_50.native &= ~quirk->clear_50;
+			info->res_vesa.res_bits &= ~quirk->clear_vesa;
+			info->res_vesa.native &= ~quirk->clear_vesa;
+			break;
+		}
+	}
+}
+
 static int ps3av_auto_videomode(struct ps3av_pkt_av_get_hw_conf *av_hw_conf,
 				int boot)
 {
@@ -739,6 +778,8 @@ static int ps3av_auto_videomode(struct p
 		ps3av_monitor_info_dump(&monitor_info);
 
 		info = &monitor_info.info;
+		ps3av_fixup_monitor_info(info);
+
 		switch (info->monitor_type) {
 		case PS3AV_MONITOR_TYPE_DVI:
 			dvi = PS3AV_MODE_DVI;


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
