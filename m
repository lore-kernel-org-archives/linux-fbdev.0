From: Jean Delvare <khali@linux-fr.org>
Subject: [PATCH 1/3] matrox maven: Fix a broken error
	path
Date: Fri, 8 Aug 2008 16:58:23 +0200
Message-ID: <20080808165823.71d9bea3@hyperion.delvare>
References: <20080808164937.141a95e0@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KRTQM-0000A4-0a for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 08 Aug 2008 07:58:38 -0700
Received: from zone0.gcu-squad.org ([212.85.147.21]
	helo=services.gcu-squad.org)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KRTQK-00060G-LR
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 08 Aug 2008 07:58:38 -0700
In-Reply-To: <20080808164937.141a95e0@hyperion.delvare>
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
To: linux-fbdev-devel@lists.sourceforge.net, Antonino Daplas <adaplas@gmail.com>
Cc: Petr Vandrovec <vandrove@vc.cvut.cz>, LKML <linux-kernel@vger.kernel.org>

I broke an error path with d03c21ec0be7787ff6b75dcf56c0e96209ccbfbd,
sorry about that.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/video/matrox/matroxfb_maven.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.26-rc6.orig/drivers/video/matrox/matroxfb_maven.c	2008-06-17 17:22:42.000000000 +0200
+++ linux-2.6.26-rc6/drivers/video/matrox/matroxfb_maven.c	2008-06-17 17:23:18.000000000 +0200
@@ -1266,7 +1266,7 @@ static int maven_detect_client(struct i2
 ERROR4:;
 	i2c_detach_client(new_client);
 ERROR3:;
-	kfree(new_client);
+	kfree(data);
 ERROR0:;
 	return err;
 }


-- 
Jean Delvare

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
