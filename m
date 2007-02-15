From: Geert.Uytterhoeven@sonycom.com
Subject: [patch 2/4] ps3av: thread updates
Date: Thu, 15 Feb 2007 16:23:03 +0100
Message-ID: <20070215152432.363210000@sonycom.com>
References: <20070215152301.573853000@sonycom.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HHiV2-00068a-4q for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 15 Feb 2007 07:26:20 -0800
Received: from [80.88.33.193] (helo=vervifontaine.sonycom.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HHiUw-0004ha-Lj
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 15 Feb 2007 07:26:20 -0800
Content-Disposition: inline; filename=ps3-wip/ps3av-workqueue.diff
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

ps3av: Replace the kernel_thread and the ping pong semaphores by a singlethread
workqueue and a completion.

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
---
 drivers/ps3/ps3av.c         |   30 ++++++++++++++----------------
 include/asm-powerpc/ps3av.h |    5 +++--
 2 files changed, 17 insertions(+), 18 deletions(-)

--- ps3-linux-2.6.20.orig/drivers/ps3/ps3av.c
+++ ps3-linux-2.6.20/drivers/ps3/ps3av.c
@@ -438,7 +438,7 @@ static int ps3av_set_videomode(void)
 	ps3av_set_av_video_mute(PS3AV_CMD_MUTE_ON);
 
 	/* wake up ps3avd to do the actual video mode setting */
-	up(&ps3av.ping);
+	queue_work(ps3av.wq, &ps3av.work);
 
 	return 0;
 }
@@ -513,18 +513,10 @@ static void ps3av_set_videomode_cont(u32
 	ps3av_set_av_video_mute(PS3AV_CMD_MUTE_OFF);
 }
 
-static int ps3avd(void *p)
+static void ps3avd(struct work_struct *work)
 {
-	struct ps3av *info = p;
-
-	daemonize("ps3avd");
-	while (1) {
-		down(&info->ping);
-		ps3av_set_videomode_cont(info->ps3av_mode,
-					 info->ps3av_mode_old);
-		up(&info->pong);
-	}
-	return 0;
+	ps3av_set_videomode_cont(ps3av.ps3av_mode, ps3av.ps3av_mode_old);
+	complete(&ps3av.done);
 }
 
 static int ps3av_vid2table_id(int vid)
@@ -723,7 +715,7 @@ int ps3av_set_video_mode(u32 id, int boo
 	}
 
 	/* set videomode */
-	down(&ps3av.pong);
+	wait_for_completion(&ps3av.done);
 	ps3av.ps3av_mode_old = ps3av.ps3av_mode;
 	ps3av.ps3av_mode = id;
 	if (ps3av_set_videomode())
@@ -879,12 +871,16 @@ static int ps3av_probe(struct ps3_vuart_
 	memset(&ps3av, 0, sizeof(ps3av));
 
 	init_MUTEX(&ps3av.sem);
-	init_MUTEX_LOCKED(&ps3av.ping);
-	init_MUTEX(&ps3av.pong);
 	mutex_init(&ps3av.mutex);
 	ps3av.ps3av_mode = 0;
 	ps3av.dev = dev;
-	kernel_thread(ps3avd, &ps3av, CLONE_KERNEL);
+
+	INIT_WORK(&ps3av.work, ps3avd);
+	init_completion(&ps3av.done);
+	complete(&ps3av.done);
+	ps3av.wq = create_singlethread_workqueue("ps3avd");
+	if (!ps3av.wq)
+		return -ENOMEM;
 
 	ps3av.available = 1;
 	switch (ps3_os_area_get_av_multi_out()) {
@@ -924,6 +920,8 @@ static int ps3av_remove(struct ps3_vuart
 {
 	if (ps3av.available) {
 		ps3av_cmd_fin();
+		if (ps3av.wq)
+			destroy_workqueue(ps3av.wq);
 		ps3av.available = 0;
 	}
 
--- ps3-linux-2.6.20.orig/include/asm-powerpc/ps3av.h
+++ ps3-linux-2.6.20/include/asm-powerpc/ps3av.h
@@ -646,8 +646,9 @@ struct ps3av_pkt_avb_param {
 struct ps3av {
 	int available;
 	struct semaphore sem;
-	struct semaphore ping;
-	struct semaphore pong;
+	struct work_struct work;
+	struct completion done;
+	struct workqueue_struct *wq;
 	struct mutex mutex;
 	int open_count;
 	struct ps3_vuart_port_device *dev;

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
