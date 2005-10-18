From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 14/17] vesafb: Disable mtrr as the default
Date: Tue, 18 Oct 2005 17:21:51 +0800
Message-ID: <4354BEAF.5030901@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ERyJI-0000ea-Pi
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 18 Oct 2005 13:43:48 -0700
Received: from zproxy.gmail.com ([64.233.162.207])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1ERyJI-0000v6-Hn
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 18 Oct 2005 13:43:48 -0700
Received: by zproxy.gmail.com with SMTP id s18so1165348nze
        for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 18 Oct 2005 13:43:48 -0700 (PDT)
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

vesafb occassionally gets the size wrong when setting the mtrr.  When X or
DRI attempts to set the mtrr, it will fail due to range overlap significantly
affecting their performance. Disable mtrr and let the user explicitly enable
it with the mtrr:n option.

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---
 Documentation/fb/vesafb.txt |    4 ++--
 drivers/video/vesafb.c      |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)


diff --git a/Documentation/fb/vesafb.txt b/Documentation/fb/vesafb.txt
--- a/Documentation/fb/vesafb.txt
+++ b/Documentation/fb/vesafb.txt
@@ -146,10 +146,10 @@ pmipal	Use the protected mode interface 
 
 mtrr:n	setup memory type range registers for the vesafb framebuffer
 	where n:
-	      0 - disabled (equivalent to nomtrr)
+	      0 - disabled (equivalent to nomtrr) (default)
 	      1 - uncachable
 	      2 - write-back
-	      3 - write-combining (default)
+	      3 - write-combining
 	      4 - write-through
 
 	If you see the following in dmesg, choose the type that matches the
diff --git a/drivers/video/vesafb.c b/drivers/video/vesafb.c
--- a/drivers/video/vesafb.c
+++ b/drivers/video/vesafb.c
@@ -46,7 +46,7 @@ static struct fb_fix_screeninfo vesafb_f
 };
 
 static int             inverse   = 0;
-static int             mtrr      = 3; /* default to write-combining */
+static int             mtrr      = 0; /* disable mtrr */
 static int	       vram_remap __initdata = 0; /* Set amount of memory to be used */
 static int	       vram_total __initdata = 0; /* Set total amount of memory */
 static int             pmi_setpal = 0;	/* pmi for palette changes ??? */




-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
