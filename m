From: Nicolas Pitre <nicolas.pitre@linaro.org>
Date: Fri, 05 Jan 2018 21:42:58 +0000
Subject: [PATCH] console/dummy: leave .con_font_get set to NULL
Message-Id: <nycvar.YSQ.7.76.1801051636340.1528@knanqh.ubzr>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org


When this method is set, the caller expects struct console_font fields
to be properly initialized when it returns. Leave it unset otherwise
nonsensical (leaked kernel stack) values are returned to user space.

Signed-off-by: Nicolas Pitre <nico@linaro.org>
Cc: stable@kernel.org

diff --git a/drivers/video/console/dummycon.c b/drivers/video/console/dummycon.c
index 9269d56852..b90ef96e43 100644
--- a/drivers/video/console/dummycon.c
+++ b/drivers/video/console/dummycon.c
@@ -67,7 +67,6 @@ const struct consw dummy_con = {
     .con_switch =	DUMMY,
     .con_blank =	DUMMY,
     .con_font_set =	DUMMY,
-    .con_font_get =	DUMMY,
     .con_font_default =	DUMMY,
     .con_font_copy =	DUMMY,
 };
