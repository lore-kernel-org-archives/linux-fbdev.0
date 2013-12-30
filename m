From: Sachin Kamat <sachin.kamat@linaro.org>
Date: Mon, 30 Dec 2013 06:34:12 +0000
Subject: [PATCH 3/4] video: pxa: Cleanup video-pxafb.h header
Message-Id: <1388384533-20458-3-git-send-email-sachin.kamat@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Commit 293b2da1b611 ("ARM: pxa: move platform_data definitions")
moved the file to the current location but forgot to remove the pointer
to its previous location. Clean it up.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 include/linux/platform_data/video-pxafb.h |    2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/platform_data/video-pxafb.h b/include/linux/platform_data/video-pxafb.h
index 486b4c519ae2..07c6c1e153f8 100644
--- a/include/linux/platform_data/video-pxafb.h
+++ b/include/linux/platform_data/video-pxafb.h
@@ -1,6 +1,4 @@
 /*
- *  arch/arm/mach-pxa/include/mach/pxafb.h
- *
  *  Support for the xscale frame buffer.
  *
  *  Author:     Jean-Frederic Clere
-- 
1.7.9.5

