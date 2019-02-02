From: Yifeng Li <tomli@tomli.me>
Date: Sat, 02 Feb 2019 06:16:41 +0000
Subject: [PATCH 1/8] fbdev: sm712fb: update copyright headers.
Message-Id: <20190202061648.30374-2-tomli@tomli.me>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190202061648.30374-1-tomli@tomli.me>
In-Reply-To: <20190202061648.30374-1-tomli@tomli.me>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: Yifeng Li <tomli@tomli.me>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Teddy Wang <teddy.wang@siliconmotion.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

My implementation of 2D acceleration used the original buggy code
in the staging tree (which had been removed due to a critical bug
soon after its submission), also, OpenBSD's smfb.c driver written
by Miodrag Vallat was another important source of reference, a
hunk of hardware register definitions are taken verbatim.

This commit appends my name to the list of authors, and included
Miodrag Vallat's name and the ISC license of the original smfb.c
driver.

Signed-off-by: Yifeng Li <tomli@tomli.me>
---
 drivers/video/fbdev/sm712.h   | 20 ++++++++++++++++++++
 drivers/video/fbdev/sm712fb.c | 20 ++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/drivers/video/fbdev/sm712.h b/drivers/video/fbdev/sm712.h
index aad1cc4be34a..99077e91ae10 100644
--- a/drivers/video/fbdev/sm712.h
+++ b/drivers/video/fbdev/sm712.h
@@ -8,9 +8,29 @@
  * Copyright (C) 2009 Lemote, Inc.
  * Author: Wu Zhangjin, wuzhangjin@gmail.com
  *
+ * Copyright (C) 2014, 2019 Yifeng Li.
+ * Author:   Yifeng Li <tomli@tomli.me>
+ *
  *  This file is subject to the terms and conditions of the GNU General Public
  *  License. See the file COPYING in the main directory of this archive for
  *  more details.
+ *
+ *  This file incorporates work covered by the following copyright and
+ *  permission notice:
+ *
+ *    Copyright (c) 2009, 2010 Miodrag Vallat.
+ *
+ *    Permission to use, copy, modify, and distribute this software for any
+ *    purpose with or without fee is hereby granted, provided that the above
+ *    copyright notice and this permission notice appear in all copies.
+ *
+ *    THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
+ *    WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
+ *    MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
+ *    ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
+ *    WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
+ *    ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
+ *    OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
  */
 
 #define FB_ACCEL_SMI_LYNX 88
diff --git a/drivers/video/fbdev/sm712fb.c b/drivers/video/fbdev/sm712fb.c
index 502d0de2feec..8d63bbfef9ea 100644
--- a/drivers/video/fbdev/sm712fb.c
+++ b/drivers/video/fbdev/sm712fb.c
@@ -11,11 +11,31 @@
  * Copyright (C) 2011 Igalia, S.L.
  * Author:   Javier M. Mellid <jmunhoz@igalia.com>
  *
+ * Copyright (C) 2014, 2019 Yifeng Li.
+ * Author:   Yifeng Li <tomli@tomli.me>
+ *
  * This file is subject to the terms and conditions of the GNU General Public
  * License. See the file COPYING in the main directory of this archive for
  * more details.
  *
  * Framebuffer driver for Silicon Motion SM710, SM712, SM721 and SM722 chips
+ *
+ * This file incorporates work covered by the following copyright and
+ * permission notice:
+ *
+ *    Copyright (c) 2009, 2010 Miodrag Vallat.
+ *
+ *    Permission to use, copy, modify, and distribute this software for any
+ *    purpose with or without fee is hereby granted, provided that the above
+ *    copyright notice and this permission notice appear in all copies.
+ *
+ *    THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
+ *    WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
+ *    MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
+ *    ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
+ *    WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
+ *    ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
+ *    OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
  */
 
 #include <linux/io.h>
-- 
2.20.1
