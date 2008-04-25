From: Bryan Wu <cooloney@kernel.org>
Subject: [PATCH 2/2] BF54x Framebuffer Driver: BF542
	does not have EPPI0, so dont allow the LQ034 driver for now
Date: Fri, 25 Apr 2008 11:29:06 +0800
Message-ID: <1209094146-19872-3-git-send-email-cooloney@kernel.org>
References: <1209094146-19872-1-git-send-email-cooloney@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JpEcu-0007sv-Ct for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 24 Apr 2008 20:29:32 -0700
Received: from nwd2mail10.analog.com ([137.71.25.55])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JpEct-0002hY-2p
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 24 Apr 2008 20:29:32 -0700
In-Reply-To: <1209094146-19872-1-git-send-email-cooloney@kernel.org>
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
To: linux-fbdev-devel@lists.sourceforge.net, akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Cc: Bryan Wu <cooloney@kernel.org>, Mike Frysinger <vapier.adi@gmail.com>

From: Mike Frysinger <vapier.adi@gmail.com>

Signed-off-by: Mike Frysinger <vapier.adi@gmail.com>
Signed-off-by: Bryan Wu <cooloney@kernel.org>
---
 drivers/video/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 1bd5fb3..682eb61 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -546,7 +546,7 @@ config FB_VGA16
 
 config FB_BF54X_LQ043
 	tristate "SHARP LQ043 TFT LCD (BF548 EZKIT)"
-	depends on FB && (BF54x)
+	depends on FB && (BF54x) && !BF542
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-- 
1.5.5

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
