From: Adam Borowski <kilobyte@angband.pl>
Date: Wed, 18 Jul 2018 03:03:26 +0000
Subject: [PATCH 5/6] vt: compensate for brightening the 256-color palette
Message-Id: <20180718030327.579-5-kilobyte@angband.pl>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180718030152.kdq53mwpdfusvwl5@angband.pl>
 <20180718030327.579-1-kilobyte@angband.pl>
In-Reply-To: <20180718030327.579-1-kilobyte@angband.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-console@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Adam Borowski <kilobyte@angband.pl>

The algorithm for 256-to-16 conversion was designed with wrong input
palette but actually tuned on mainstream GUI terminals.  This resulted in
something that works well only for data we convert ourselves (ie, 256 not
24-bit).

As the change is non-linear, I did not bother replicating it exactly, thus
there are some differences, among others:
* values very close to black go to 0 (black) rather than 8 (dark grey)
* grayscale ramp is more even

A comparison of the old vs new vs FreeBSD's teken is at:
https://github.com/kilobyte/colorkernel

Signed-off-by: Adam Borowski <kilobyte@angband.pl>
---
 drivers/tty/vt/vt.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 8c61caafdf3c..c777f4c91df0 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -1559,17 +1559,17 @@ static void rgb_foreground(struct vc_data *vc, const struct rgb *c)
 {
 	u8 hue = 0, max = max3(c->r, c->g, c->b);
 
-	if (c->r > max / 2)
+	if (c->r > max / 2 + 32)
 		hue |= 4;
-	if (c->g > max / 2)
+	if (c->g > max / 2 + 32)
 		hue |= 2;
-	if (c->b > max / 2)
+	if (c->b > max / 2 + 32)
 		hue |= 1;
 
-	if (hue = 7 && max <= 0x55) {
+	if (hue = 7 && max <= 0x70) {
 		hue = 0;
 		vc->vc_intensity = 2;
-	} else if (max > 0xaa)
+	} else if (max > 0xc0)
 		vc->vc_intensity = 2;
 	else
 		vc->vc_intensity = 1;
-- 
2.18.0

