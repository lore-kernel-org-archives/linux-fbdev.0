From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 9/9] radeonfb_old: Fix broken link
Date: Sat, 20 Aug 2005 00:51:54 +0800
Message-ID: <43060E2A.6040906@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E6HLY-0002iL-LC
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 19 Aug 2005 17:36:28 -0700
Received: from wproxy.gmail.com ([64.233.184.202])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1E6HLW-00021V-Dg
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 19 Aug 2005 17:36:28 -0700
Received: by wproxy.gmail.com with SMTP id i3so656086wra
        for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 19 Aug 2005 17:36:19 -0700 (PDT)
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
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

    The link for ATI's product page in drivers/video/Kconfig for FB_RADEON is broken.
    Replace with a product comparison page.

    Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 Kconfig |    3 +--
 1 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -956,8 +956,7 @@ config FB_RADEON
 	  can be build either as modules or built-in.
 
 	  There is a product page at
-	  <http://www.ati.com/na/pages/products/pc/radeon32/index.html>.
-
+	  http://apps.ati.com/ATIcompare/
 config FB_RADEON_I2C
 	bool "DDC/I2C for ATI Radeon support"
 	depends on FB_RADEON



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
