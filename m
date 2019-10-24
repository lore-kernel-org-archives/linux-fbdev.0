From: Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
Date: Thu, 24 Oct 2019 16:38:22 +0000
Subject: [PATCH 3/3] staging: sm750fb: align arguments with open parenthesis in file sm750_cursor.h
Message-Id: <20191024163822.7157-4-gabrielabittencourt00@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20191024163822.7157-1-gabrielabittencourt00@gmail.com>
In-Reply-To: <20191024163822.7157-1-gabrielabittencourt00@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: outreachy-kernel@googlegroups.com, sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, lkcamp@lists.libreplanetbr.org, trivial@kernel.org
Cc: Gabriela Bittencourt <gabrielabittencourt00@gmail.com>

Cleans up checks of "Alignment should match open parenthesis"
in file sm750_cursor.h

Signed-off-by: Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
---
 drivers/staging/sm750fb/sm750_cursor.h | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750_cursor.h b/drivers/staging/sm750fb/sm750_cursor.h
index 16ac07eb58d6..b59643dd61ed 100644
--- a/drivers/staging/sm750fb/sm750_cursor.h
+++ b/drivers/staging/sm750fb/sm750_cursor.h
@@ -5,14 +5,11 @@
 /* hw_cursor_xxx works for voyager,718 and 750 */
 void sm750_hw_cursor_enable(struct lynx_cursor *cursor);
 void sm750_hw_cursor_disable(struct lynx_cursor *cursor);
-void sm750_hw_cursor_setSize(struct lynx_cursor *cursor,
-						int w, int h);
-void sm750_hw_cursor_setPos(struct lynx_cursor *cursor,
-						int x, int y);
-void sm750_hw_cursor_setColor(struct lynx_cursor *cursor,
-						u32 fg, u32 bg);
-void sm750_hw_cursor_setData(struct lynx_cursor *cursor,
-			u16 rop, const u8 *data, const u8 *mask);
-void sm750_hw_cursor_setData2(struct lynx_cursor *cursor,
-			u16 rop, const u8 *data, const u8 *mask);
+void sm750_hw_cursor_setSize(struct lynx_cursor *cursor, int w, int h);
+void sm750_hw_cursor_setPos(struct lynx_cursor *cursor, int x, int y);
+void sm750_hw_cursor_setColor(struct lynx_cursor *cursor, u32 fg, u32 bg);
+void sm750_hw_cursor_setData(struct lynx_cursor *cursor, u16 rop,
+			     const u8 *data, const u8 *mask);
+void sm750_hw_cursor_setData2(struct lynx_cursor *cursor, u16 rop,
+			      const u8 *data, const u8 *mask);
 #endif
-- 
2.20.1
