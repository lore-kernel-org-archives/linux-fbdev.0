From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 3/10] savagefb: Make mode_option available when compiled as
 a module
Date: Fri, 02 Sep 2005 05:34:55 +0800
Message-ID: <431773FF.6060704@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EAx2T-0004ku-V8
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 01 Sep 2005 14:56:05 -0700
Received: from wproxy.gmail.com ([64.233.184.195])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EAx2R-0004MP-KL
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 01 Sep 2005 14:56:06 -0700
Received: by wproxy.gmail.com with SMTP id i21so261708wra
        for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 01 Sep 2005 14:55:57 -0700 (PDT)
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

    Make "mode_option" available when compiled as a module.
    
    Signed-off-by: Antonino Daplas <adaplas@pol.net>

---
 savagefb_driver.c |    3 +++
 1 files changed, 3 insertions(+)


diff --git a/drivers/video/savage/savagefb_driver.c b/drivers/video/savage/savagefb_driver.c
--- a/drivers/video/savage/savagefb_driver.c
+++ b/drivers/video/savage/savagefb_driver.c
@@ -2383,3 +2383,6 @@ static int __init savagefb_init(void)
 
 module_init(savagefb_init);
 module_exit(savage_done);
+
+module_param(mode_option, charp, 0);
+MODULE_PARM_DESC(mode_option, "Specify initial video mode");



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
