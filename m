From: Yifeng Li <tomli@tomli.me>
Date: Fri, 22 Mar 2019 05:17:59 +0000
Subject: [PATCH v2 7/7] MAINTAINERS: sm712fb: list myself as one maintainer.
Message-Id: <20190322051759.15007-8-tomli@tomli.me>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190322051759.15007-1-tomli@tomli.me>
In-Reply-To: <20190322051759.15007-1-tomli@tomli.me>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Teddy Wang <teddy.wang@siliconmotion.com>, linux-kernel@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Yifeng Li <tomli@tomli.me>

I have working on the sm712fb driver for a while and have some familiarity
with this hardware, I'll be helping working on and testing problems of this
driver, so add myself to the MAINTAINERS file.

Signed-off-by: Yifeng Li <tomli@tomli.me>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index dce5c099f43c..3f6686f0f020 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13871,6 +13871,7 @@ F:	drivers/input/touchscreen/silead.c
 F:	drivers/platform/x86/touchscreen_dmi.c
 
 SILICON MOTION SM712 FRAME BUFFER DRIVER
+M:	Tom Li <tomli@tomli.me>
 M:	Sudip Mukherjee <sudipm.mukherjee@gmail.com>
 M:	Teddy Wang <teddy.wang@siliconmotion.com>
 M:	Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
-- 
2.20.1
