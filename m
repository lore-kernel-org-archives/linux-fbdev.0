From: Jesper Juhl <juhl-lkml@dif.dk>
Subject: [PATCH][trivial] matroxfb_maven remove pointless semicolons after
 label
Date: Sun, 20 Mar 2005 17:41:01 +0100 (CET)
Message-ID: <Pine.LNX.4.62.0503201737250.2501@dragon.hyggekrogen.localhost>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel <linux-kernel@vger.kernel.org>


Having a semicolon at the end as in  labelname:;  is pointless, remove.


Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

diff -up linux-2.6.11-mm4-orig/drivers/video/matrox/matroxfb_maven.c linux-2.6.11-mm4/drivers/video/matrox/matroxfb_maven.c
--- linux-2.6.11-mm4-orig/drivers/video/matrox/matroxfb_maven.c	2005-03-02 08:37:30.000000000 +0100
+++ linux-2.6.11-mm4/drivers/video/matrox/matroxfb_maven.c	2005-03-20 17:35:48.000000000 +0100
@@ -1263,11 +1263,11 @@ static int maven_detect_client(struct i2
 	if (err)
 		goto ERROR4;
 	return 0;
-ERROR4:;
+ERROR4:
 	i2c_detach_client(new_client);
-ERROR3:;
+ERROR3:
 	kfree(new_client);
-ERROR0:;
+ERROR0:
 	return err;
 }
 
