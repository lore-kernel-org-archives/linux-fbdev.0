From: domen@coderock.org
Subject: [patch 3/3] sis_main.c - vfree() checking cleanups
Date: Mon, 10 Jan 2005 20:42:08 +0100
Message-ID: <20050110194208.F03A91F20A@trashy.coderock.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Co5Qd-0004hi-Iv
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 10 Jan 2005 11:42:15 -0800
Received: from coderock.org
	([193.77.147.115] helo=trashy.coderock.org ident=postfix)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1Co5Qc-0003fU-9K
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 10 Jan 2005 11:42:15 -0800
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
Cc: linux-fbdev-devel@lists.sourceforge.net, domen@coderock.org, jlamanna@gmail.com



sis_main.c vfree() checking cleanups.

Signed-off by: James Lamanna <jlamanna@gmail.com>


Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/drivers/video/sis/sis_main.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/video/sis/sis_main.c~vfree-drivers_video_sis_sis_main drivers/video/sis/sis_main.c
--- kj/drivers/video/sis/sis_main.c~vfree-drivers_video_sis_sis_main	2005-01-10 18:01:05.000000000 +0100
+++ kj-domen/drivers/video/sis/sis_main.c	2005-01-10 18:01:05.000000000 +0100
@@ -5674,7 +5674,7 @@ static void __devexit sisfb_remove(struc
 	/* Unmap */
 	iounmap(ivideo->video_vbase);
 	iounmap(ivideo->mmio_vbase);
-	if(ivideo->bios_abase) vfree(ivideo->bios_abase);
+	vfree(ivideo->bios_abase);
 
 	/* Release mem regions */
 	release_mem_region(ivideo->video_base, ivideo->video_size);
_


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
