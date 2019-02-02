From: Yifeng Li <tomli@tomli.me>
Date: Sat, 02 Feb 2019 06:16:48 +0000
Subject: [PATCH 8/8] MAINTAINERS: sm712fb: list myself as one maintainer.
Message-Id: <20190202061648.30374-9-tomli@tomli.me>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190202061648.30374-1-tomli@tomli.me>
In-Reply-To: <20190202061648.30374-1-tomli@tomli.me>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: Yifeng Li <tomli@tomli.me>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Teddy Wang <teddy.wang@siliconmotion.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, "David S. Miller" <davem@davemloft.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Nicolas Ferre <nicolas.ferre@microchip.com>, Arnd Bergmann <arnd@arndb.de>

I have working on the sm712fb driver for a while and have some familiarity
with this hardware, I'll be helping working on and testing problems of this
driver, so add myself to the MAINTAINERS file.

Signed-off-by: Yifeng Li <tomli@tomli.me>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 51029a425dbe..d62adb2caa87 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13838,6 +13838,7 @@ F:	drivers/input/touchscreen/silead.c
 F:	drivers/platform/x86/touchscreen_dmi.c
 
 SILICON MOTION SM712 FRAME BUFFER DRIVER
+M:	Tom Li <tomli@tomli.me>
 M:	Sudip Mukherjee <sudipm.mukherjee@gmail.com>
 M:	Teddy Wang <teddy.wang@siliconmotion.com>
 M:	Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
-- 
2.20.1
