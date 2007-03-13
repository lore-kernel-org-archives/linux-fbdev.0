From: Geert.Uytterhoeven@sonycom.com
Subject: [patch 3/5] ps3av: thread updates
Date: Tue, 13 Mar 2007 15:19:13 +0100
Message-ID: <20070313142153.182598000@sonycom.com>
References: <20070313141910.001573000@sonycom.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HR7tQ-0007jK-I1 for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 13 Mar 2007 07:22:24 -0700
Received: from [80.88.33.193] (helo=vervifontaine.sonycom.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HR7tN-0005Ol-PS
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 13 Mar 2007 07:22:24 -0700
Content-Disposition: inline; filename=ps3-stable/ps3av-workqueue.diff
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
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>, linux-fbdev-devel@lists.sourceforge.net, James Simmons <jsimmons@infradead.org>, "Antonino A. Daplas" <adaplas@gmail.com>, linuxppc-dev@ozlabs.org

ps3av: Replace the kernel_thread and the ping pong semaphores by a singlethread
workqueue and a completion.

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
---
 drivers/ps3/ps3av.c         |   30 ++++++++++++++----------------
 include/asm-powerpc/ps3av.h |    5 +++--
 2 files changed, 17 insertions(+), 18 deletions(-)

--- ps3-linux-2.6.21-rc3.orig/drivers/ps3/ps3av.c
+++ ps3-linux-2.6.21-rc3/drivers/ps3/ps3av.c
@@ -440,7 +440,7 @@ static int ps3av_set_videomode(void)
 	ps3av_set_av_video_mute(PS3AV_CMD_MUTE_ON);
 
 	/* wake up ps3avd to do the actual video mode setting */
-	up(&ps3av.ping);
+	queue_work(ps3av.wq, &ps3av.work);
 
 	return 0;
 }
@@ -515,18 +515,10 @@ static void ps3av_set_videomode_cont(u32
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
@@ -725,7 +717,7 @@ int ps3av_set_video_mode(u32 id, int boo
 	}
 
 	/* set videomode */
-	down(&ps3av.pong);
+	wait_for_completion(&ps3av.done);
 	ps3av.ps3av_mode_old = ps3av.ps3av_mode;
 	ps3av.ps3av_mode = id;
 	if (ps3av_set_videomode())
@@ -881,12 +873,16 @@ static int ps3av_probe(struct ps3_vuart_
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
@@ -926,6 +922,8 @@ static int ps3av_remove(struct ps3_vuart
 {
 	if (ps3av.available) {
 		ps3av_cmd_fin();
+		if (ps3av.wq)
+			destroy_workqueue(ps3av.wq);
 		ps3av.available = 0;
 	}
 
--- ps3-linux-2.6.21-rc3.orig/include/asm-powerpc/ps3av.h
+++ ps3-linux-2.6.21-rc3/include/asm-powerpc/ps3av.h
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
