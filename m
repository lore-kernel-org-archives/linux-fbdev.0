From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 3/5] rivafb: Fix I2C getscl callback
	function
Date: Thu, 10 May 2007 07:46:38 +0800
Message-ID: <46425D5E.20603@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Hlvuc-0002MK-AN for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 09 May 2007 16:49:38 -0700
Received: from py-out-1112.google.com ([64.233.166.182])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Hlvua-0005Lu-0y
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 09 May 2007 16:49:38 -0700
Received: by py-out-1112.google.com with SMTP id a29so322085pyi
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 09 May 2007 16:49:35 -0700 (PDT)
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
To: Andrew Morton <akpm@osdl.org>
Cc: Jean Delvare <khali@linux-fr.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

From: Jean Delvare <khali@linux-fr.org>

Fix rivafb's I2C getscl callback function, as was done in nvidiafb
recently.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---
Andrew,

This chunk somehow got lost in the merge.

Tony

 drivers/video/riva/rivafb-i2c.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/video/riva/rivafb-i2c.c b/drivers/video/riva/rivafb-i2c.c
index 76e6ce3..a0e22ac 100644
--- a/drivers/video/riva/rivafb-i2c.c
+++ b/drivers/video/riva/rivafb-i2c.c
@@ -70,8 +70,6 @@ static int riva_gpio_getscl(void* data)
 	if (VGA_RD08(par->riva.PCIO, 0x3d5) & 0x04)
 		val = 1;
 
-	val = VGA_RD08(par->riva.PCIO, 0x3d5);
-
 	return val;
 }
 


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
