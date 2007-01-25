From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: [PATCH 7/9] ps3: disable display flipping
	during mode changes
Date: Thu, 25 Jan 2007 18:51:13 +0100 (CET)
Message-ID: <Pine.LNX.4.62.0701251850470.24610@pademelon.sonytel.be>
References: <Pine.LNX.4.62.0701251825390.14799@pademelon.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HA8ku-0007pc-TY for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 25 Jan 2007 09:51:26 -0800
Received: from [80.88.33.193] (helo=vervifontaine.sonycom.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HA8kt-0000kK-H5
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 25 Jan 2007 09:51:24 -0800
In-Reply-To: <Pine.LNX.4.62.0701251825390.14799@pademelon.sonytel.be>
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
 drivers/ps3/ps3av_cmd.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletion(-)

--- ps3-linux.orig/drivers/ps3/ps3av_cmd.c
+++ ps3-linux/drivers/ps3/ps3av_cmd.c
@@ -33,6 +33,12 @@
 #define DPRINTK(fmt, args...) do { } while (0)
 #endif
 
+#ifdef CONFIG_FB_PS3
+extern int ps3fb_flip_ctl(int);
+#else
+#define ps3fb_flip_ctl(x)
+#endif
+
 static const struct video_fmt {
 	u32 format;
 	u32 order;
@@ -884,8 +890,9 @@ int ps3av_cmd_avb_param(struct ps3av_pkt
 {
 	int res;
 
-	/* avb packet */
+	ps3fb_flip_ctl(0);	/* flip off */
 
+	/* avb packet */
 	res = ps3av_do_pkt(PS3AV_CID_AVB_PARAM, send_len, sizeof(*avb),
 			   &avb->send_hdr);
 	if (res < 0)
@@ -896,6 +903,7 @@ int ps3av_cmd_avb_param(struct ps3av_pkt
 		DPRINTK("PS3AV_CID_AVB_PARAM: failed %x\n", res);
 
       out:
+	ps3fb_flip_ctl(1);	/* flip on */
 	return res;
 }
 

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
