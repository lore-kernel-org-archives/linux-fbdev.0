From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: [PATCH 8/10] ps3: disable display flipping
	during mode changes
Date: Tue, 30 Jan 2007 18:02:45 +0100 (CET)
Message-ID: <Pine.LNX.4.62.0701301802280.29487@pademelon.sonytel.be>
References: <Pine.LNX.4.62.0701301754050.29343@pademelon.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HBwNj-0007s7-PK for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 30 Jan 2007 09:02:56 -0800
Received: from [80.88.33.193] (helo=vervifontaine.sonycom.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HBwNj-0002Tk-2P
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 30 Jan 2007 09:02:55 -0800
In-Reply-To: <Pine.LNX.4.62.0701301754050.29343@pademelon.sonytel.be>
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
To: James Simmons <jsimmons@infradead.org>, Paul Mackerras <paulus@samba.org>
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

If ps3fb is available, we have to disable display flipping while changing the
audio or video mode.

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
---
 drivers/ps3/ps3av_cmd.c     |    5 ++++-
 include/asm-powerpc/ps3fb.h |   10 ++++++++++
 2 files changed, 14 insertions(+), 1 deletion(-)

--- ps3-linux-2.6.20-rc6.orig/drivers/ps3/ps3av_cmd.c
+++ ps3-linux-2.6.20-rc6/drivers/ps3/ps3av_cmd.c
@@ -22,6 +22,7 @@
 #include <linux/kernel.h>
 #include <linux/delay.h>
 #include <asm/ps3av.h>
+#include <asm/ps3fb.h>
 #include <asm/ps3.h>
 
 
@@ -850,8 +851,9 @@ int ps3av_cmd_avb_param(struct ps3av_pkt
 {
 	int res;
 
-	/* avb packet */
+	ps3fb_flip_ctl(0);	/* flip off */
 
+	/* avb packet */
 	res = ps3av_do_pkt(PS3AV_CID_AVB_PARAM, send_len, sizeof(*avb),
 			   &avb->send_hdr);
 	if (res < 0)
@@ -863,6 +865,7 @@ int ps3av_cmd_avb_param(struct ps3av_pkt
 			 res);
 
       out:
+	ps3fb_flip_ctl(1);	/* flip on */
 	return res;
 }
 
--- ps3-linux-2.6.20-rc6.orig/include/asm-powerpc/ps3fb.h
+++ ps3-linux-2.6.20-rc6/include/asm-powerpc/ps3fb.h
@@ -41,4 +41,14 @@ struct ps3fb_ioctl_res {
 	__u32 num_frames; /* num of frame buffers */
 };
 
+#ifdef __KERNEL__
+
+#ifdef CONFIG_FB_PS3
+extern void ps3fb_flip_ctl(int);
+#else
+static inline void ps3fb_flip_ctl(int) {}
+#endif
+
+#endif /* __KERNEL__ */
+
 #endif /* _ASM_POWERPC_PS3FB_H_ */

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Sony Network and Software Technology Center Europe (NSCE)
Geert.Uytterhoeven@sonycom.com ------- The Corporate Village, Da Vincilaan 7-D1
Voice +32-2-7008453 Fax +32-2-7008622 ---------------- B-1935 Zaventem, Belgium

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
