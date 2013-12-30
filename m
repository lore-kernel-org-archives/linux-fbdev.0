From: Sachin Kamat <sachin.kamat@linaro.org>
Date: Mon, 30 Dec 2013 06:34:11 +0000
Subject: [PATCH 2/4] video: msm: Cleanup video-msm_fb.h header
Message-Id: <1388384533-20458-2-git-send-email-sachin.kamat@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Commit 1ef21f6343ff ("ARM: msm: move platform_data definitions")
moved the file to the current location but forgot to remove the pointer
to its previous location. Clean it up.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 include/linux/platform_data/video-msm_fb.h |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/platform_data/video-msm_fb.h b/include/linux/platform_data/video-msm_fb.h
index 1f4fc81b3d8f..31449be3eadb 100644
--- a/include/linux/platform_data/video-msm_fb.h
+++ b/include/linux/platform_data/video-msm_fb.h
@@ -1,5 +1,4 @@
-/* arch/arm/mach-msm/include/mach/msm_fb.h
- *
+/*
  * Internal shared definitions for various MSM framebuffer parts.
  *
  * Copyright (C) 2007 Google Incorporated
-- 
1.7.9.5

