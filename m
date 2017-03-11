From: Arushi Singhal <arushisinghal19971997@gmail.com>
Date: Sat, 11 Mar 2017 03:36:09 +0000
Subject: [PATCH 2/3] staging: sm750fb: fixes add blank line after function/struct/union/enum declarations
Message-Id: <20170311032410.8265-3-arushisinghal19971997@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170311032410.8265-1-arushisinghal19971997@gmail.com>
In-Reply-To: <20170311032410.8265-1-arushisinghal19971997@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: outreachy-kernel@googlegroups.com
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, Arushi Singhal <arushisinghal19971997@gmail.com>

This patch fixes the warnings reported by checkpatch.pl
for please use a blank line after function/struct/union/enum
declarations.

Signed-off-by: Arushi Singhal <arushisinghal19971997@gmail.com>
---
 drivers/staging/sm750fb/sm750_cursor.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/staging/sm750fb/sm750_cursor.c b/drivers/staging/sm750fb/sm750_cursor.c
index 612e9ab9d569..b64dc8a4a8fb 100644
--- a/drivers/staging/sm750fb/sm750_cursor.c
+++ b/drivers/staging/sm750fb/sm750_cursor.c
@@ -54,6 +54,7 @@ void sm750_hw_cursor_enable(struct lynx_cursor *cursor)
 	reg = (cursor->offset & HWC_ADDRESS_ADDRESS_MASK) | HWC_ADDRESS_ENABLE;
 	poke32(HWC_ADDRESS, reg);
 }
+
 void sm750_hw_cursor_disable(struct lynx_cursor *cursor)
 {
 	poke32(HWC_ADDRESS, 0);
@@ -65,6 +66,7 @@ void sm750_hw_cursor_setSize(struct lynx_cursor *cursor,
 	cursor->w = w;
 	cursor->h = h;
 }
+
 void sm750_hw_cursor_setPos(struct lynx_cursor *cursor,
 						int x, int y)
 {
@@ -74,6 +76,7 @@ void sm750_hw_cursor_setPos(struct lynx_cursor *cursor,
 	       (x & HWC_LOCATION_X_MASK);
 	poke32(HWC_LOCATION, reg);
 }
+
 void sm750_hw_cursor_setColor(struct lynx_cursor *cursor,
 						u32 fg, u32 bg)
 {
-- 
2.11.0

