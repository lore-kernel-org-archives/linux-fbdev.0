From: Nicolas Ferre <nicolas.ferre@rfo.atmel.com>
Subject: [PATCH] atmel_lcdfb: Use spare bits in 32bpp
	mode as alpha channel
Date: Wed, 18 Jul 2007 11:18:24 +0200
Message-ID: <469DDAE0.4010106@rfo.atmel.com>
References: <11826149894079-git-send-email-hskinnemoen@atmel.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IB5gn-0005JC-Ec for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 18 Jul 2007 02:19:21 -0700
Received: from mail.atmel.fr ([81.80.104.162] helo=atmel-es2.atmel.fr)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IB5gl-0001br-PS
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 18 Jul 2007 02:19:21 -0700
In-Reply-To: <11826149894079-git-send-email-hskinnemoen@atmel.com>
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
To: "Antonino A. Daplas" <adaplas@gmail.com>, linux-fbdev-devel@lists.sourceforge.net
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>

From: Haavard Skinnemoen <hskinnemoen@atmel.com>

Set var->transp.offset and var->transp.length in 32bpp mode to
indicate that the 8 otherwise unused bits can be used for
transparency.

Signed-off-by: Haavard Skinnemoen <hskinnemoen@atmel.com>
Signed-off-by: Nicolas Ferre <nicolas.ferre@rfo.atmel.com>
---
  drivers/video/atmel_lcdfb.c |    5 ++++-
  1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/video/atmel_lcdfb.c b/drivers/video/atmel_lcdfb.c
index a05491f..bb361ab 100644
--- a/drivers/video/atmel_lcdfb.c
+++ b/drivers/video/atmel_lcdfb.c
@@ -221,8 +221,11 @@ static int atmel_lcdfb_check_var(struct 
fb_var_screeninfo *var,
  		var->blue.offset = 10;
  		var->red.length = var->green.length = var->blue.length = 5;
  		break;
-	case 24:
  	case 32:
+		var->transp.offset = 24;
+		var->transp.length = 8;
+		/* fall through */
+	case 24:
  		var->red.offset = 0;
  		var->green.offset = 8;
  		var->blue.offset = 16;



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
