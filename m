From: Pavel Machek <pavel@ucw.cz>
Subject: Allow selecting MSM framebuffer in Kconfig
Date: Fri, 20 Nov 2009 12:39:15 +0100
Message-ID: <20091120113915.GA5154@elf.ucw.cz>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753030AbZKTLjS@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net, kernel list <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>, Arve Hj?nnev?g <arve@android.com>, linux-arm-kernel <linux-arm-ker>


Allow user to select MSM framebuffer support in Kconfig.

Signed-off-by: Pavel Machek <pavel@ucw.cz>

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 188e1ba..b3e05e4 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -2127,7 +2127,7 @@ config FB_PRE_INIT_FB
 	  the bootloader.
 
 config FB_MSM
-	tristate
+	tristate "MSM Framebuffer support"
 	depends on FB && ARCH_MSM
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
