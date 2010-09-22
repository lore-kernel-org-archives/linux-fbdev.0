From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Wed, 22 Sep 2010 02:52:57 +0000
Subject: [PATCH] viafb: use proper register for colour when doing fill ops
Message-Id: <1285124599-5997-1-git-send-email-FlorianSchandinat@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <AANLkTin7ZD19NSec58gOCNrbYzeWq5XW4LNte50Nsm8M@mail.gmail.com>
In-Reply-To: <AANLkTin7ZD19NSec58gOCNrbYzeWq5XW4LNte50Nsm8M@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, Joseph Chan <JosephChan@via.com.tw>, Daniel Drake <dsd@laptop.org>, Jon Nettleton <jon.nettleton@gmail.com>

The colour was written to a wrong register for fillrect operations.
This sometimes caused empty console space (for example after 'clear')
to have a different colour than desired. Fix this by writing to the
correct register.
Many thanks to Daniel Drake and Jon Nettleton for pointing out this
issue and pointing me in the right direction for the fix.

Fixes http://dev.laptop.org/ticket/9323

Signed-off-by: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: Joseph Chan <JosephChan@via.com.tw>
Cc: Daniel Drake <dsd@laptop.org>
Cc: Jon Nettleton <jon.nettleton@gmail.com>
---
 drivers/video/via/accel.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/video/via/accel.c b/drivers/video/via/accel.c
index e44893e..c2f4e6e 100644
--- a/drivers/video/via/accel.c
+++ b/drivers/video/via/accel.c
@@ -283,11 +283,12 @@ static int hw_bitblt_2(void __iomem *engine, u8 op, u32 width, u32 height,
 		writel(tmp, engine + 0x1C);
 	}
 
-	if (op != VIA_BITBLT_COLOR)
+	if (op = VIA_BITBLT_FILL) {
+		writel(fg_color, engine + 0x58);
+	} else if (op = VIA_BITBLT_MONO) {
 		writel(fg_color, engine + 0x4C);
-
-	if (op = VIA_BITBLT_MONO)
 		writel(bg_color, engine + 0x50);
+	}
 
 	if (op = VIA_BITBLT_FILL)
 		ge_cmd |= fill_rop << 24 | 0x00002000 | 0x00000001;
-- 
1.6.3.2

