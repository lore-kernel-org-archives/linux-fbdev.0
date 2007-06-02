From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 01/24] 68328fb: The pseudo_palette is
	only 16 elements long
Date: Sat, 02 Jun 2007 17:56:23 +0800
Message-ID: <46613EC7.9050902@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HuQi6-00008p-5c for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 02 Jun 2007 03:19:50 -0700
Received: from py-out-1112.google.com ([64.233.166.181])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HuQi4-00011W-S6
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 02 Jun 2007 03:19:50 -0700
Received: by py-out-1112.google.com with SMTP id u77so1508651pyb
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sat, 02 Jun 2007 03:19:48 -0700 (PDT)
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

The pseudo_palette is only 16 elements long.
    
Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/68328fb.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/68328fb.c b/drivers/video/68328fb.c
index 0dda73d..7f907fb 100644
--- a/drivers/video/68328fb.c
+++ b/drivers/video/68328fb.c
@@ -60,7 +60,7 @@ static u_long videomemory;
 static u_long videomemorysize;
 
 static struct fb_info fb_info;
-static u32 mc68x328fb_pseudo_palette[17];
+static u32 mc68x328fb_pseudo_palette[16];
 
 static struct fb_var_screeninfo mc68x328fb_default __initdata = {
 	.red =		{ 0, 8, 0 },




-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
