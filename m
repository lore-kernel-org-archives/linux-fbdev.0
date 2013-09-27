From: Jingoo Han <jg1.han@samsung.com>
Date: Fri, 27 Sep 2013 03:59:28 +0000
Subject: [PATCH] MAINTAINERS: remove Richard Purdie as backlight maintainer
Message-Id: <017f01cebb35$f6a82ac0$e3f88040$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: 'Andrew Morton' <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, 'Richard Purdie' <rpurdie@rpsys.net>, 'Jingoo Han' <jg1.han@samsung.com>, 'Thierry Reding' <thierry.reding@gmail.com>, 'Tomi Valkeinen' <tomi.valkeinen@ti.com>, 'Laurent Pinchart' <laurent.pinchart+renesas@ideasonboard.com>, 'Michael Hennerich' <michael.hennerich@analog.com>, 'Milo Kim' <milo.kim@ti.com>, 'Daniel Jeong' <gshark.jeong@gmail.com>

Remove Richard Purdie as backlight subsystem maintainer, since he
is not responding for a few years.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
Cc: Richard Purdie <rpurdie@rpsys.net>
---
 MAINTAINERS |    1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 146ade4..398819c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1645,7 +1645,6 @@ S:	Maintained
 F:	drivers/net/wireless/b43legacy/
 
 BACKLIGHT CLASS/SUBSYSTEM
-M:	Richard Purdie <rpurdie@rpsys.net>
 M:	Jingoo Han <jg1.han@samsung.com>
 S:	Maintained
 F:	drivers/video/backlight/
-- 
1.7.10.4


