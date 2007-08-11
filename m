From: Michal Januszewski <spock@gentoo.org>
Subject: [PATCH 2/7] uvesafb: always use mutexes when
	accessing uvfb_tasks
Date: Sat, 11 Aug 2007 16:39:23 +0200
Message-ID: <20070811143923.GC13632@spock.one.pl>
Reply-To: spock@gentoo.org, linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IJs85-0005O0-Di for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 11 Aug 2007 07:39:49 -0700
Received: from ipn26-148.piekary.net ([83.238.26.148] helo=spock.one.pl)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IJs84-0003KT-1L
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 11 Aug 2007 07:39:49 -0700
Content-Disposition: inline
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org

Accesses to the uvfb_tasks array should be always be protected by a
mutex to avoid race conditions.

Signed-off-by: Michal Januszewski <spock@gentoo.org>
---
diff --git a/drivers/video/uvesafb.c b/drivers/video/uvesafb.c
index aa5a9c3..e480670 100644
--- a/drivers/video/uvesafb.c
+++ b/drivers/video/uvesafb.c
@@ -208,6 +208,10 @@ static int uvesafb_exec(struct uvesafb_ktask *task)
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
