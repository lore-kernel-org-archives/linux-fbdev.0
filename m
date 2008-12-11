From: "Eric Miao" <eric.y.miao@gmail.com>
Subject: [PATCH 4/5] pxafb: avoid the racing condition
	in pxafb_smart_thread
Date: Thu, 11 Dec 2008 17:50:34 +0800
Message-ID: <f17812d70812110150p6eb6b122kbe18991dd8653868@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <eric.y.miao@gmail.com>) id 1LAiBw-0006vQ-0E
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 11 Dec 2008 09:50:44 +0000
Received: from rv-out-0708.google.com ([209.85.198.245])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1LAiBo-0005Ek-Jc for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 11 Dec 2008 09:50:43 +0000
Received: by rv-out-0708.google.com with SMTP id f25so797388rvb.22
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 11 Dec 2008 01:50:34 -0800 (PST)
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: ARM Linux <linux-arm-kernel@lists.arm.linux.org.uk>
Cc: linux-fbdev-devel@lists.sourceforge.net

fbi->state change shall really be protected by fbi->ctrlr_lock, where
the change is sheltered. There is a possibility that pxafb_smart_thread
will start update the LCD panel when fbi->state == C_ENABLE, while
all other initialization isn't done.

Signed-off-by: Eric Miao <eric.miao@marvell.com>
---
 drivers/video/pxafb.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/video/pxafb.c b/drivers/video/pxafb.c
index 15177ef..fde4971 100644
--- a/drivers/video/pxafb.c
+++ b/drivers/video/pxafb.c
@@ -794,11 +794,15 @@ static int pxafb_smart_thread(void *arg)
 		if (try_to_freeze())
 			continue;

+		mutex_lock(&fbi->ctrlr_lock);
+
 		if (fbi->state == C_ENABLE) {
 			inf->smart_update(&fbi->fb);
 			complete(&fbi->refresh_done);
 		}

+		mutex_unlock(&fbi->ctrlr_lock);
+
 		set_current_state(TASK_INTERRUPTIBLE);
 		schedule_timeout(30 * HZ / 1000);
 	}
-- 
1.6.0.4

------------------------------------------------------------------------------
SF.Net email is Sponsored by MIX09, March 18-20, 2009 in Las Vegas, Nevada.
The future of the web can't happen without you.  Join us at MIX09 to help
pave the way to the Next Web now. Learn more and register at
http://ad.doubleclick.net/clk;208669438;13503038;i?http://2009.visitmix.com/
