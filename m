From: H Hartley Sweeten <hartleys@visionengravers.com>
Date: Thu, 03 May 2012 00:17:23 +0000
Subject: [PATCH] video: smscufx.c: local functions should not be exposed globally
Message-Id: <201205021717.23749.hartleys@visionengravers.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: linux-fbdev@vger.kernel.org, steve.glendinning@smsc.com, FlorianSchandinat@gmx.de

Functions not referenced outside of a source file should be marked
static to prevent them from being exposed globally.

Quiets the sparse warnings:

warning: symbol 'ufx_handle_damage' was not declared. Should it be static?

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Steve Glendinning <steve.glendinning@smsc.com>
Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>

---

diff --git a/drivers/video/smscufx.c b/drivers/video/smscufx.c
index 9985785..af3ef27 100644
--- a/drivers/video/smscufx.c
+++ b/drivers/video/smscufx.c
@@ -846,7 +846,7 @@ static void ufx_raw_rect(struct ufx_data *dev, u16 *cmd, int x, int y,
 	}
 }
 
-int ufx_handle_damage(struct ufx_data *dev, int x, int y,
+static int ufx_handle_damage(struct ufx_data *dev, int x, int y,
 	int width, int height)
 {
 	size_t packed_line_len = ALIGN((width * 2), 4);
