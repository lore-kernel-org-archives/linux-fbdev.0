From: Adam Borowski <kilobyte@angband.pl>
Date: Wed, 18 Jul 2018 03:03:25 +0000
Subject: [PATCH 4/6] vt: change 256-color palette to match all(?) modern terminals
Message-Id: <20180718030327.579-4-kilobyte@angband.pl>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180718030152.kdq53mwpdfusvwl5@angband.pl>
 <20180718030327.579-1-kilobyte@angband.pl>
In-Reply-To: <20180718030327.579-1-kilobyte@angband.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-console@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Adam Borowski <kilobyte@angband.pl>

Turns out that osso-xterm which I based upon uses something a lot different
from apparently any other terminal -- they all use identical shades, much
brighter than what I copied:

    Old: 00 2a 55 7f aa d4
    New: 00 5f 87 af d7 ff

This did hardly matter as we immediately shoehorn the colors into only 16
values, but recently 24-bit codes turned from an oddity to something
widespread, thus it's better to handle 256 vs 24-bit consistently.

Signed-off-by: Adam Borowski <kilobyte@angband.pl>
---
 drivers/tty/vt/vt.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 4096093c8cd2..8c61caafdf3c 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -1545,9 +1545,12 @@ static void rgb_from_256(int i, struct rgb *c)
 		c->g = i&2 ? 0xff : 0x55;
 		c->b = i&4 ? 0xff : 0x55;
 	} else if (i < 232) {   /* 6x6x6 colour cube. */
-		c->r = (i - 16) / 36 * 85 / 2;
-		c->g = (i - 16) / 6 % 6 * 85 / 2;
-		c->b = (i - 16) % 6 * 85 / 2;
+		int r = (i - 16) / 36;
+		int g = (i - 16) / 6 % 6;
+		int b = (i - 16) % 6;
+		c->r = r ? r * 0x28 + 0x37 : 0;
+		c->g = g ? g * 0x28 + 0x37 : 0;
+		c->b = b ? b * 0x28 + 0x37 : 0;
 	} else                  /* Grayscale ramp. */
 		c->r = c->g = c->b = i * 10 - 2312;
 }
-- 
2.18.0

