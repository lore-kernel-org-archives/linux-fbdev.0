From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 17/22] uvesafb: always use mutexes when
	accessing uvfb_tasks
Date: Mon, 13 Aug 2007 20:40:30 +0800
Message-ID: <46C0513E.3020903@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IKaxi-0007ym-5m for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 13 Aug 2007 07:32:09 -0700
Received: from rv-out-0910.google.com ([209.85.198.189])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IKZL4-0005O6-Qc
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 13 Aug 2007 05:48:08 -0700
Received: by rv-out-0910.google.com with SMTP id k15so3930196rvb
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 13 Aug 2007 05:48:06 -0700 (PDT)
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
Cc: Michal Januszewski <spock@gentoo.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

From: Michal Januszewski <spock@gentoo.org>

Accesses to the uvfb_tasks array should be always be protected by a
mutex to avoid race conditions.

Signed-off-by: Michal Januszewski <spock@gentoo.org>
Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/uvesafb.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/video/uvesafb.c b/drivers/video/uvesafb.c
index aa5a9c3..30ce50b 100644
--- a/drivers/video/uvesafb.c
+++ b/drivers/video/uvesafb.c
@@ -208,6 +208,10 @@ static int uvesafb_exec(struct uvesafb_k
 		err = !wait_for_completion_timeout(task->done,
 				msecs_to_jiffies(UVESAFB_TIMEOUT));
 
+	mutex_lock(&uvfb_lock);
+	uvfb_tasks[seq] = NULL;
+	mutex_unlock(&uvfb_lock);
+
 	seq++;
 	if (seq >= UVESAFB_TASKS_MAX)
 		seq = 0;


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
