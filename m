From: Sumit Kumar <sumit686215@gmail.com>
Date: Tue, 08 May 2018 18:53:18 +0000
Subject: [PATCH] staging: sm750fb: add SPDX license identifier
Message-Id: <20180508185102.GA21793@ubuntu>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

SPDX licencse identifier is missing in header file. Add a SPDX license
identifier with correct format. Issue found by checkpatch.

Signed-off-by: Sumit Kumar <sumit686215@example.com>
---
 drivers/staging/sm750fb/ddk750.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/sm750fb/ddk750.h b/drivers/staging/sm750fb/ddk750.h
index 7340103..482c1c6 100644
--- a/drivers/staging/sm750fb/ddk750.h
+++ b/drivers/staging/sm750fb/ddk750.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  *         Copyright (c) 2007 by Silicon Motion, Inc. (SMI)
  *
-- 
2.7.4

