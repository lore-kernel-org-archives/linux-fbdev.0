From: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 1/2] fbdev: S3 Savage Framebuffer Driver
Date: Mon, 25 Oct 2004 02:02:55 -0700
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20041025020255.01d0a126.akpm@osdl.org>
References: <200410230436.42009.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CM0mh-00071Y-61
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 25 Oct 2004 02:04:59 -0700
Received: from fw.osdl.org ([65.172.181.6] helo=mail.osdl.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CM0mf-0005Uj-MV
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 25 Oct 2004 02:04:59 -0700
In-Reply-To: <200410230436.42009.adaplas@hotpop.com>
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
To: adaplas@pol.net
Cc: adaplas@hotpop.com, linux-fbdev-devel@lists.sourceforge.net, dok@directfb.org, mpruikko@cc.hut.fi, neo@convergence.de

"Antonino A. Daplas" <adaplas@hotpop.com> wrote:
>
> S3 Savage Frambuffer Driver for the following chipsets: 

build fixes:


drivers/video/savage/savagefb.c:1368: macro `SavagePrintRegs' used without args
drivers/video/savage/savagefb.c:1926: macro `SavagePrintRegs' used without args
drivers/video/savage/savagefb.c:2141: macro `SavagePrintRegs' used without args

drivers/video/savage/savagefb.c: In function `savagefb_init':
drivers/video/savage/savagefb.c:2276: warning: implicit declaration of function `savagefb_setup'

Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/drivers/video/savage/savagefb.c |    5 ++---
 25-akpm/drivers/video/savage/savagefb.h |    2 +-
 2 files changed, 3 insertions(+), 4 deletions(-)

diff -puN drivers/video/savage/savagefb.h~savagefb-build-fix drivers/video/savage/savagefb.h
--- 25/drivers/video/savage/savagefb.h~savagefb-build-fix	2004-10-25 01:59:47.303620792 -0700
+++ 25-akpm/drivers/video/savage/savagefb.h	2004-10-25 01:59:51.100043648 -0700
@@ -21,7 +21,7 @@
 # define DBG(x)		printk (KERN_DEBUG "savagefb: %s\n", (x));
 #else
 # define DBG(x)
-# define SavagePrintRegs(x)
+# define SavagePrintRegs(...)
 #endif
 
 
diff -puN drivers/video/savage/savagefb.c~savagefb-build-fix drivers/video/savage/savagefb.c
--- 25/drivers/video/savage/savagefb.c~savagefb-build-fix	2004-10-25 02:00:18.228919432 -0700
+++ 25-akpm/drivers/video/savage/savagefb.c	2004-10-25 02:01:45.080715952 -0700
@@ -2248,9 +2248,9 @@ static void __exit savage_done (void)
 
 /* ************************* init in-kernel code ************************** */
 
-#ifndef MODULE
 int __init savagefb_setup(char *options)
 {
+#ifndef MODULE
 	char *this_opt;
 
 	if (!options || !*options)
@@ -2259,10 +2259,9 @@ int __init savagefb_setup(char *options)
 	while ((this_opt = strsep(&options, ",")) != NULL) {
 		mode_option = this_opt;
 	}
-
+#endif /* !MODULE */
 	return 0;
 }
-#endif /* !MODULE */
 
 int __init savagefb_init(void)
 {
_



-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
