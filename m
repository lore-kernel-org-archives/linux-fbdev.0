From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH RESEND 6/9] neofb: Fill
 transp->msb_right with the correct value
Date: Sun, 25 Feb 2007 18:19:25 +0800
Message-ID: <45E162AD.40307@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HLGb7-0006CG-Go for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 25 Feb 2007 02:27:17 -0800
Received: from py-out-1112.google.com ([64.233.166.177])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HLGb6-00021L-7e
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 25 Feb 2007 02:27:17 -0800
Received: by py-out-1112.google.com with SMTP id a29so536398pyi
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 25 Feb 2007 02:27:16 -0800 (PST)
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Fill transp->msb_right with the correct value.  fbcon ignores this, but user
apps may not.

Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/neofb.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/video/neofb.c b/drivers/video/neofb.c
index 395cced..bd30aba 100644
--- a/drivers/video/neofb.c
+++ b/drivers/video/neofb.c
@@ -665,6 +665,7 @@ neofb_check_var(struct fb_var_screeninfo
 	var->red.msb_right = 0;
 	var->green.msb_right = 0;
 	var->blue.msb_right = 0;
+	var->transp.msb_right = 0;
 
 	switch (var->bits_per_pixel) {
 	case 8:		/* PSEUDOCOLOUR, 256 */


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
