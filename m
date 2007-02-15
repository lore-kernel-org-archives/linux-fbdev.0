From: Geert.Uytterhoeven@sonycom.com
Subject: [patch 4/4] ps3av: misc updates
Date: Thu, 15 Feb 2007 16:23:05 +0100
Message-ID: <20070215152432.561356000@sonycom.com>
References: <20070215152301.573853000@sonycom.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HHiV0-00068Q-7p for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 15 Feb 2007 07:26:18 -0800
Received: from [80.88.33.193] (helo=vervifontaine.sonycom.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HHiUz-0001Y3-IJ
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 15 Feb 2007 07:26:18 -0800
Content-Disposition: inline; filename=ps3-wip/ps3av-misc.diff
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>, linuxppc-dev@ozlabs.org, linux-fbdev-devel@lists.sourceforge.net

ps3av:
  - Move the definition of struct ps3av to ps3av.c, as it's used locally only.
  - Kill ps3av.sem, use the existing ps3av.mutex instead.
  - Make the 512-byte buffer in ps3av_do_pkt() static to reduce stack usage.
    Its use is protected by a semaphore anyway.

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
---
 drivers/ps3/ps3av.c         |   29 ++++++++++++++++++++++-------
 include/asm-powerpc/ps3av.h |   22 +---------------------
 2 files changed, 23 insertions(+), 28 deletions(-)

--- ps3-linux-2.6.20.orig/drivers/ps3/ps3av.c
+++ ps3-linux-2.6.20/drivers/ps3/ps3av.c
@@ -36,7 +36,24 @@
 static int timeout = 5000;	/* in msec ( 5 sec ) */
 module_param(timeout, int, 0644);
 
-static struct ps3av ps3av;
+static struct ps3av {
+	int available;
+	struct mutex mutex;
+	struct work_struct work;
+	struct completion done;
+	struct workqueue_struct *wq;
+	int open_count;
+	struct ps3_vuart_port_device *dev;
+
+	int region;
+	struct ps3av_pkt_av_get_hw_conf av_hw_conf;
+	u32 av_port[PS3AV_AV_PORT_MAX + PS3AV_OPT_PORT_MAX];
+	u32 opt_port[PS3AV_OPT_PORT_MAX];
+	u32 head[PS3AV_HEAD_MAX];
+	u32 audio_port;
+	int ps3av_mode;
+	int ps3av_mode_old;
+} ps3av;
 
 static struct ps3_vuart_port_device ps3av_dev = {
 	.match_id = PS3_MATCH_ID_AV_SETTINGS
@@ -248,7 +265,7 @@ int ps3av_do_pkt(u32 cid, u16 send_len, 
 		 struct ps3av_send_hdr *buf)
 {
 	int res = 0;
-	union {
+	static union {
 		struct ps3av_reply_hdr reply_hdr;
 		u8 raw[PS3AV_BUF_SIZE];
 	} recv_buf;
@@ -257,8 +274,7 @@ int ps3av_do_pkt(u32 cid, u16 send_len, 
 
 	BUG_ON(!ps3av.available);
 
-	if (down_interruptible(&ps3av.sem))
-		return -ERESTARTSYS;
+	mutex_lock(&ps3av.mutex);
 
 	table = ps3av_search_cmd_table(cid, PS3AV_CID_MASK);
 	BUG_ON(!table);
@@ -288,11 +304,11 @@ int ps3av_do_pkt(u32 cid, u16 send_len, 
 		goto err;
 	}
 
-	up(&ps3av.sem);
+	mutex_unlock(&ps3av.mutex);
 	return 0;
 
       err:
-	up(&ps3av.sem);
+	mutex_unlock(&ps3av.mutex);
 	printk(KERN_ERR "%s: failed cid:%x res:%d\n", __FUNCTION__, cid, res);
 	return res;
 }
@@ -870,7 +886,6 @@ static int ps3av_probe(struct ps3_vuart_
 
 	memset(&ps3av, 0, sizeof(ps3av));
 
-	init_MUTEX(&ps3av.sem);
 	mutex_init(&ps3av.mutex);
 	ps3av.ps3av_mode = 0;
 	ps3av.dev = dev;
--- ps3-linux-2.6.20.orig/include/asm-powerpc/ps3av.h
+++ ps3-linux-2.6.20/include/asm-powerpc/ps3av.h
@@ -18,8 +18,6 @@
 #ifndef _ASM_POWERPC_PS3AV_H_
 #define _ASM_POWERPC_PS3AV_H_
 
-#include <linux/mutex.h>
-
 /** command for ioctl() **/
 #define PS3AV_VERSION 0x205	/* version of ps3av command */
 
@@ -643,25 +641,6 @@ struct ps3av_pkt_avb_param {
 	u8 buf[PS3AV_PKT_AVB_PARAM_MAX_BUF_SIZE];
 };
 
-struct ps3av {
-	int available;
-	struct semaphore sem;
-	struct work_struct work;
-	struct completion done;
-	struct workqueue_struct *wq;
-	struct mutex mutex;
-	int open_count;
-	struct ps3_vuart_port_device *dev;
-
-	int region;
-	struct ps3av_pkt_av_get_hw_conf av_hw_conf;
-	u32 av_port[PS3AV_AV_PORT_MAX + PS3AV_OPT_PORT_MAX];
-	u32 opt_port[PS3AV_OPT_PORT_MAX];
-	u32 head[PS3AV_HEAD_MAX];
-	u32 audio_port;
-	int ps3av_mode;
-	int ps3av_mode_old;
-};
 
 /** command status **/
 #define PS3AV_STATUS_SUCCESS			0x0000	/* success */
@@ -719,6 +698,7 @@ static inline void ps3av_cmd_av_monitor_
 extern int ps3av_cmd_video_get_monitor_info(struct ps3av_pkt_av_get_monitor_info *,
 					    u32);
 
+struct ps3_vuart_port_device;
 extern int ps3av_vuart_write(struct ps3_vuart_port_device *dev,
 			     const void *buf, unsigned long size);
 extern int ps3av_vuart_read(struct ps3_vuart_port_device *dev, void *buf,

--
Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Sony Network and Software Technology Center Europe (NSCE)
Geert.Uytterhoeven@sonycom.com ------- The Corporate Village, Da Vincilaan 7-D1
Voice +32-2-7008453 Fax +32-2-7008622 ---------------- B-1935 Zaventem, Belgium


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
