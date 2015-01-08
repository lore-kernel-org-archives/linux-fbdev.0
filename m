From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Thu, 08 Jan 2015 08:17:57 +0000
Subject: [PATCH 0/2] fbdev: ssd1307fb: fixes
Message-Id: <1420705079-3741-1-git-send-email-prabhakar.csengg@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: LFBDEV <linux-fbdev@vger.kernel.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: LKML <linux-kernel@vger.kernel.org>, "Lad, Prabhakar" <prabhakar.csengg@gmail.com>

This patch series fixes trivial issues in ssd1307fb driver.

Lad, Prabhakar (2):
  fbdev: ssd1307fb: set default height if not found in DT node
  fbdev: ssd1307fb: check return value while setting offset

 drivers/video/fbdev/ssd1307fb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
1.9.1

