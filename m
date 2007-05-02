From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: [patch 6/8] ps3: Make `ps3videomode -v 0 (auto
	mode) work again
Date: Wed, 02 May 2007 14:48:36 +0200
Message-ID: <20070502124840.650035000@pademelon.sonytel.be>
References: <20070502124830.911142000@pademelon.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HjEHn-0007Ni-Cq for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 02 May 2007 05:50:26 -0700
Received: from [80.88.33.193] (helo=vervifontaine.sonycom.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HjEHm-0005xs-Sc
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 02 May 2007 05:50:23 -0700
Content-Disposition: inline; filename=ps3-stable/ps3videomode-auto-mode.diff
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: James Simmons <jsimmons@infradead.org>, Antonino Daplas <adaplas@gmail.com>, linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>, Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>, linux-fbdev-devel@lists.sourceforge.net

From: Masashi Kimoto <Masashi_Kimoto@hq.scei.sony.co.jp>

ps3: Make `ps3videomode -v 0' (auto mode) work again

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
---
 drivers/ps3/ps3av.c         |    7 +++++++
 drivers/video/ps3fb.c       |    5 +++++
 include/asm-powerpc/ps3av.h |    1 +
 3 files changed, 13 insertions(+)

--- ps3-linux-2.6.21.orig/drivers/ps3/ps3av.c
+++ ps3-linux-2.6.21/drivers/ps3/ps3av.c
@@ -744,6 +744,13 @@ int ps3av_set_video_mode(u32 id, int boo
 
 EXPORT_SYMBOL_GPL(ps3av_set_video_mode);
 
+int ps3av_get_auto_mode(int boot)
+{
+	return ps3av_auto_videomode(&ps3av.av_hw_conf, boot);
+}
+
+EXPORT_SYMBOL_GPL(ps3av_get_auto_mode);
+
 int ps3av_set_mode(u32 id, int boot)
 {
 	int res;
--- ps3-linux-2.6.21.orig/drivers/video/ps3fb.c
+++ ps3-linux-2.6.21/drivers/video/ps3fb.c
@@ -732,6 +732,11 @@ static int ps3fb_ioctl(struct fb_info *i
 			if (copy_from_user(&val, argp, sizeof(val)))
 				break;
 
+			if (!(val & PS3AV_MODE_MASK)) {
+				u32 id = ps3av_get_auto_mode(0);
+				if (id > 0)
+					val = (val & ~PS3AV_MODE_MASK) | id;
+			}
 			DPRINTK("PS3FB_IOCTL_SETMODE:%x\n", val);
 			retval = -EINVAL;
 			old_mode = ps3fb_mode;
--- ps3-linux-2.6.21.orig/include/asm-powerpc/ps3av.h
+++ ps3-linux-2.6.21/include/asm-powerpc/ps3av.h
@@ -706,6 +706,7 @@ extern int ps3av_vuart_read(struct ps3_v
 
 extern int ps3av_set_video_mode(u32, int);
 extern int ps3av_set_audio_mode(u32, u32, u32, u32, u32);
+extern int ps3av_get_auto_mode(int);
 extern int ps3av_set_mode(u32, int);
 extern int ps3av_get_mode(void);
 extern int ps3av_get_scanmode(int);

--
Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Sony Network and Software Technology Center Europe (NSCE)
Geert.Uytterhoeven@sonycom.com ------- The Corporate Village, Da Vincilaan 7-D1
Voice +32-2-7008453 Fax +32-2-7008622 ---------------- B-1935 Zaventem, Belgium


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
