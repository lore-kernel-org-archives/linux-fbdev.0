From: domen@coderock.org
Subject: [patch 2/3] video/sa1100fb: reorder set_current_state() and add_wait_queue()
Date: Mon, 10 Jan 2005 20:42:05 +0100
Message-ID: <20050110194205.EB4151F208@trashy.coderock.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Co5Qa-0004hT-NL
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 10 Jan 2005 11:42:12 -0800
Received: from coderock.org
	([193.77.147.115] helo=trashy.coderock.org ident=postfix)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1Co5QZ-0003fC-3M
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 10 Jan 2005 11:42:11 -0800
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: adaplas@pol.net
Cc: linux-fbdev-devel@lists.sourceforge.net, domen@coderock.org, nacc@us.ibm.com




Any comments would be, as always, appreciated.

-Nish

Description: Reorder add_wait_queue() and set_current_state() as a
signal could be lost in between the two functions.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/drivers/video/sa1100fb.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/video/sa1100fb.c~reorder-state-drivers_video_sa1100fb drivers/video/sa1100fb.c
--- kj/drivers/video/sa1100fb.c~reorder-state-drivers_video_sa1100fb	2005-01-10 18:00:25.000000000 +0100
+++ kj-domen/drivers/video/sa1100fb.c	2005-01-10 18:00:25.000000000 +0100
@@ -1072,8 +1072,8 @@ static void sa1100fb_disable_controller(
 		GPCR |= SHANNON_GPIO_DISP_EN;
 	}	
 
-	add_wait_queue(&fbi->ctrlr_wait, &wait);
 	set_current_state(TASK_UNINTERRUPTIBLE);
+	add_wait_queue(&fbi->ctrlr_wait, &wait);
 
 	LCSR = 0xffffffff;	/* Clear LCD Status Register */
 	LCCR0 &= ~LCCR0_LDM;	/* Enable LCD Disable Done Interrupt */
_


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
