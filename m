From: Oliver Graute <oliver.graute@gmail.com>
Date: Thu, 09 Apr 2020 09:24:05 +0000
Subject: [PATCH v1] staging: fbtft: fb_st7789v: enabled inversion
Message-Id: <1586424250-25897-1-git-send-email-oliver.graute@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: gregkh@linuxfoundation.org
Cc: devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org, Oliver Graute <oliver.graute@kococonnector.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, oliver.graute@gmail.com

From: Oliver Graute <oliver.graute@kococonnector.com>

Enable inversion mode

Signed-off-by: Oliver Graute <oliver.graute@kococonnector.com>
---
 drivers/staging/fbtft/fb_st7789v.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/staging/fbtft/fb_st7789v.c b/drivers/staging/fbtft/fb_st7789v.c
index 3c3f387936e8..84c5af2dc9a0 100644
--- a/drivers/staging/fbtft/fb_st7789v.c
+++ b/drivers/staging/fbtft/fb_st7789v.c
@@ -120,6 +120,10 @@ static int init_display(struct fbtft_par *par)
 	write_reg(par, PWCTRL1, 0xA4, 0xA1);
 
 	write_reg(par, MIPI_DCS_SET_DISPLAY_ON);
+
+	/* enable inversion mode */
+	write_reg(par, 0x21);
+
 	return 0;
 }
 
-- 
2.17.1
