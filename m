From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 09/17] ps3av: eliminate unneeded
	temporary variables
Date: Sat, 29 Sep 2007 09:33:54 +0800
Message-ID: <46FDAB82.4020800@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IbSNc-00084R-KA for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 28 Sep 2007 19:48:33 -0700
Received: from wa-out-1112.google.com ([209.85.146.182])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IbSNc-0003FN-D9
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 28 Sep 2007 19:48:32 -0700
Received: by wa-out-1112.google.com with SMTP id k22so5642791waf
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Fri, 28 Sep 2007 19:48:32 -0700 (PDT)
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

ps3av: eliminate unneeded temporary variables

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/ps3/ps3av_cmd.c |   17 ++++++-----------
 1 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/ps3/ps3av_cmd.c b/drivers/ps3/ps3av_cmd.c
index f72f5dd..83d7e8f 100644
--- a/drivers/ps3/ps3av_cmd.c
+++ b/drivers/ps3/ps3av_cmd.c
@@ -512,7 +512,6 @@ static const u32 ps3av_ns_table[][5] = {
 static void ps3av_cnv_ns(u8 *ns, u32 fs, u32 video_vid)
 {
 	u32 av_vid, ns_val;
-	u8 *p = ns;
 	int d;
 
 	d = ns_val = 0;
@@ -551,24 +550,22 @@ static void ps3av_cnv_ns(u8 *ns, u32 fs,
 	else
 		ns_val = ps3av_ns_table[PS3AV_CMD_AUDIO_FS_44K-BASE][d];
 
-	*p++ = ns_val & 0x000000FF;
-	*p++ = (ns_val & 0x0000FF00) >> 8;
-	*p = (ns_val & 0x00FF0000) >> 16;
+	*ns++ = ns_val & 0x000000FF;
+	*ns++ = (ns_val & 0x0000FF00) >> 8;
+	*ns = (ns_val & 0x00FF0000) >> 16;
 }
 
 #undef BASE
 
 static u8 ps3av_cnv_enable(u32 source, const u8 *enable)
 {
-	const u8 *p;
 	u8 ret = 0;
 
 	if (source == PS3AV_CMD_AUDIO_SOURCE_SPDIF) {
 		ret = 0x03;
 	} else if (source == PS3AV_CMD_AUDIO_SOURCE_SERIAL) {
-		p = enable;
-		ret = ((p[0] << 4) + (p[1] << 5) + (p[2] << 6) + (p[3] << 7)) |
-		      0x01;
+		ret = ((enable[0] << 4) + (enable[1] << 5) + (enable[2] << 6) +
+		       (enable[3] << 7)) | 0x01;
 	} else
 		printk(KERN_ERR "%s failed, source:%x\n", __func__, source);
 	return ret;
@@ -576,11 +573,9 @@ static u8 ps3av_cnv_enable(u32 source, c
 
 static u8 ps3av_cnv_fifomap(const u8 *map)
 {
-	const u8 *p;
 	u8 ret = 0;
 
-	p = map;
-	ret = p[0] + (p[1] << 2) + (p[2] << 4) + (p[3] << 6);
+	ret = map[0] + (map[1] << 2) + (map[2] << 4) + (map[3] << 6);
 	return ret;
 }
 


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
