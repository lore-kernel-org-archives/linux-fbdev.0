From: Alexandre Courbot <acourbot@nvidia.com>
Date: Sat, 17 Nov 2012 10:55:47 +0000
Subject: [PATCHv9 3/3] Take maintainership of power sequences
Message-Id: <1353149747-31871-4-git-send-email-acourbot@nvidia.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1353149747-31871-1-git-send-email-acourbot@nvidia.com>
In-Reply-To: <1353149747-31871-1-git-send-email-acourbot@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Add entry for power sequences into MAINTAINERS with all the needed
contact and SCM info.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
Acked-by: Stephen Warren <swarren@nvidia.com>
Acked-by: Thierry Reding <thierry.reding@avionic-design.de>
---
 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index bb0b27d..e9098f5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5745,6 +5745,16 @@ F:	fs/timerfd.c
 F:	include/linux/timer*
 F:	kernel/*timer*
 
+POWER SEQUENCES
+M:	Alexandre Courbot <acourbot@nvidia.com>
+S:	Supported
+W:	https://github.com/Gnurou/linux
+T:	git git://github.com/Gnurou/linux.git power-seq/for-next
+F:	Documentation/devicetree/bindings/power/power_seq.txt
+F:	Documentation/power/power_seq.txt
+F:	include/linux/power_seq.h
+F:	drivers/power/power_seq/
+
 POWER SUPPLY CLASS/SUBSYSTEM and DRIVERS
 M:	Anton Vorontsov <cbou@mail.ru>
 M:	David Woodhouse <dwmw2@infradead.org>
-- 
1.8.0

