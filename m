From: Sachin Kamat <sachin.kamat@linaro.org>
Date: Mon, 30 Dec 2013 06:34:13 +0000
Subject: [PATCH 4/4] video: pxa168fb: Cleanup pxa168fb.h file
Message-Id: <1388384533-20458-4-git-send-email-sachin.kamat@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Remove incorrect file reference in comments section.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Eric Miao <eric.y.miao@gmail.com>
---
 include/video/pxa168fb.h |    2 --
 1 file changed, 2 deletions(-)

diff --git a/include/video/pxa168fb.h b/include/video/pxa168fb.h
index 8c2f385a90ea..84cbb1f69ea6 100644
--- a/include/video/pxa168fb.h
+++ b/include/video/pxa168fb.h
@@ -1,6 +1,4 @@
 /*
- * linux/arch/arm/mach-mmp/include/mach/pxa168fb.h
- *
  *  Copyright (C) 2009 Marvell International Ltd.
  *
  * This program is free software; you can redistribute it and/or modify
-- 
1.7.9.5

