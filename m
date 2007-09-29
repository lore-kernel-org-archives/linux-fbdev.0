From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 15/17] ps3av: remove unused
	ps3av_set_mode()
Date: Sat, 29 Sep 2007 09:39:56 +0800
Message-ID: <46FDACEC.9060704@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IbSP6-0008Ec-IN for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 28 Sep 2007 19:50:04 -0700
Received: from an-out-0708.google.com ([209.85.132.246])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IbSP6-0007Ud-8m
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 28 Sep 2007 19:50:04 -0700
Received: by an-out-0708.google.com with SMTP id b38so604623ana
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Fri, 28 Sep 2007 19:50:04 -0700 (PDT)
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

remove unused ps3av_set_mode()

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/ps3/ps3av.c         |   21 ---------------------
 include/asm-powerpc/ps3av.h |    1 -
 2 files changed, 0 insertions(+), 22 deletions(-)

diff --git a/drivers/ps3/ps3av.c b/drivers/ps3/ps3av.c
index cae4af9..53179f3 100644
--- a/drivers/ps3/ps3av.c
+++ b/drivers/ps3/ps3av.c
@@ -903,27 +903,6 @@ int ps3av_get_auto_mode(int boot)
 
 EXPORT_SYMBOL_GPL(ps3av_get_auto_mode);
 
-int ps3av_set_mode(u32 id, int boot)
-{
-	int res;
-
-	res = ps3av_set_video_mode(id, boot);
-	if (res)
-		return res;
-
-	res = ps3av_set_audio_mode(PS3AV_CMD_AUDIO_NUM_OF_CH_2,
-				   PS3AV_CMD_AUDIO_FS_48K,
-				   PS3AV_CMD_AUDIO_WORD_BITS_16,
-				   PS3AV_CMD_AUDIO_FORMAT_PCM,
-				   PS3AV_CMD_AUDIO_SOURCE_SERIAL);
-	if (res)
-		return res;
-
-	return 0;
-}
-
-EXPORT_SYMBOL_GPL(ps3av_set_mode);
-
 int ps3av_get_mode(void)
 {
 	return ps3av ? ps3av->ps3av_mode : 0;
diff --git a/include/asm-powerpc/ps3av.h b/include/asm-powerpc/ps3av.h
index 7de59b6..556bc72 100644
--- a/include/asm-powerpc/ps3av.h
+++ b/include/asm-powerpc/ps3av.h
@@ -712,7 +712,6 @@ extern int ps3av_cmd_video_get_monitor_i
 extern int ps3av_set_video_mode(u32, int);
 extern int ps3av_set_audio_mode(u32, u32, u32, u32, u32);
 extern int ps3av_get_auto_mode(int);
-extern int ps3av_set_mode(u32, int);
 extern int ps3av_get_mode(void);
 extern int ps3av_get_scanmode(int);
 extern int ps3av_get_refresh_rate(int);


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
