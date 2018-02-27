From: Kees Cook <keescook@chromium.org>
Date: Tue, 27 Feb 2018 00:04:18 +0000
Subject: [PATCH 1/3] console: SisUSB2VGA: Drop dummy con_font_get()
Message-Id: <1519689860-7421-2-git-send-email-keescook@chromium.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1519689860-7421-1-git-send-email-keescook@chromium.org>
In-Reply-To: <1519689860-7421-1-git-send-email-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Kees Cook <keescook@chromium.org>, Thomas Winischhofer <thomas@winischhofer.net>, Sami Tolvanen <samitolvanen@google.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Nicolas Pitre <nicolas.pitre@linaro.org>, linux-usb@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

As done in commit:

  724ba8b30b04 ("console/dummy: leave .con_font_get set to NULL")

This drops the dummy .con_font_get(), as it could leave arguments
uninitialized.

Cc: Thomas Winischhofer <thomas@winischhofer.net>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/usb/misc/sisusbvga/sisusb_con.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/misc/sisusbvga/sisusb_con.c b/drivers/usb/misc/sisusbvga/sisusb_con.c
index 73f7bde78e11..998df891bdde 100644
--- a/drivers/usb/misc/sisusbvga/sisusb_con.c
+++ b/drivers/usb/misc/sisusbvga/sisusb_con.c
@@ -1358,7 +1358,6 @@ static const struct consw sisusb_dummy_con = {
 	.con_switch =		SISUSBCONDUMMY,
 	.con_blank =		SISUSBCONDUMMY,
 	.con_font_set =		SISUSBCONDUMMY,
-	.con_font_get =		SISUSBCONDUMMY,
 	.con_font_default =	SISUSBCONDUMMY,
 	.con_font_copy =	SISUSBCONDUMMY,
 };
-- 
2.7.4

