From: domen@coderock.org
Subject: [patch 1/3] video/pxafb: reorder add_wait_queue() and set_current_state()
Date: Mon, 10 Jan 2005 20:42:02 +0100
Message-ID: <20050110194202.E59701F203@trashy.coderock.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Co5QY-0004hM-4q
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 10 Jan 2005 11:42:10 -0800
Received: from coderock.org
	([193.77.147.115] helo=trashy.coderock.org ident=postfix)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1Co5QW-0001KF-H7
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 10 Jan 2005 11:42:10 -0800
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

Description: Reorder set_current_state() and add_wait_queue(). There is
a chance that a signal could be missed in between the two functions
currently.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/drivers/video/pxafb.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/video/pxafb.c~reorder-state-drivers_video_pxafb drivers/video/pxafb.c
--- kj/drivers/video/pxafb.c~reorder-state-drivers_video_pxafb	2005-01-10 18:00:25.000000000 +0100
+++ kj-domen/drivers/video/pxafb.c	2005-01-10 18:00:25.000000000 +0100
@@ -740,8 +740,8 @@ static void pxafb_disable_controller(str
 
 	DPRINTK("Disabling LCD controller\n");
 
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
