From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: [PATCH 9/11] sa1100fb: Reorder add_wait_queue() and set_current_state()
Date: Fri, 14 Jan 2005 05:44:37 +0800
Message-ID: <20050113214654.81C3C1A0150@smtp-1.hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CpCoI-00016J-3t
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 13 Jan 2005 13:47:18 -0800
Received: from smtp-out.hotpop.com ([38.113.3.51])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CpCoG-0000Jz-LW
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 13 Jan 2005 13:47:18 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 3320370095
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 13 Jan 2005 21:46:59 +0000 (UTC)
Content-Disposition: inline
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Nishanth Aravamudan <nacc@us.ibm.com>, Domen Puncer <domen@coderock.org>

  Reorder add_wait_queue() and set_current_state() as a
  signal could be lost in between the two functions.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Domen Puncer <domen@coderock.org>
Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 sa1100fb.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -Nru a/drivers/video/sa1100fb.c b/drivers/video/sa1100fb.c
--- a/drivers/video/sa1100fb.c	2005-01-12 06:10:17 +08:00
+++ b/drivers/video/sa1100fb.c	2005-01-11 01:00:25 +08:00
@@ -1072,8 +1072,8 @@
 		GPCR |= SHANNON_GPIO_DISP_EN;
 	}	
 
-	add_wait_queue(&fbi->ctrlr_wait, &wait);
 	set_current_state(TASK_UNINTERRUPTIBLE);
+	add_wait_queue(&fbi->ctrlr_wait, &wait);
 
 	LCSR = 0xffffffff;	/* Clear LCD Status Register */
 	LCCR0 &= ~LCCR0_LDM;	/* Enable LCD Disable Done Interrupt */




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
