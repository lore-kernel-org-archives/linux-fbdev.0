From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH] savagefb: Fix resume
Date: Sun, 23 Apr 2006 08:27:04 +0800
Message-ID: <444AC9D8.4060008@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FXSRn-0000NG-Lh
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 22 Apr 2006 17:27:31 -0700
Received: from pproxy.gmail.com ([64.233.166.178])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FXSRm-0005HS-85
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 22 Apr 2006 17:27:31 -0700
Received: by pproxy.gmail.com with SMTP id i49so804684pye
        for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 22 Apr 2006 17:27:28 -0700 (PDT)
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

One line which is critical for resume from standby/suspend was accidentally
removed. Bring it back.

BTW, resuming savagefb properly from S3 may require acpi_sleep=s3_bios. 

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---


 drivers/video/savage/savagefb_driver.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/video/savage/savagefb_driver.c b/drivers/video/savage/savagefb_driver.c
index 0a6f244..ee49711 100644
--- a/drivers/video/savage/savagefb_driver.c
+++ b/drivers/video/savage/savagefb_driver.c
@@ -2391,6 +2391,7 @@ static int savagefb_resume (struct pci_d
 	pci_set_master(dev);
 	savage_enable_mmio(par);
 	savage_init_hw(par);
+	savagefb_set_par(info);
 	fb_set_suspend (info, 0);
 	savagefb_blank(FB_BLANK_UNBLANK, info);
 	release_console_sem();


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
