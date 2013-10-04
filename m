From: Jingoo Han <jg1.han@samsung.com>
Date: Fri, 04 Oct 2013 00:13:46 +0000
Subject: [PATCH V2] MAINTAINERS: remove Richard Purdie as backlight maintainer
Message-Id: <003a01cec096$97c72040$c75560c0$%han@samsung.com>
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
 CREDITS     |    5 +++++
 MAINTAINERS |    1 -
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/CREDITS b/CREDITS
index 0640e16..dfe3cf8 100644
--- a/CREDITS
+++ b/CREDITS
@@ -2895,6 +2895,11 @@ S: Framewood Road
 S: Wexham SL3 6PJ
 S: United Kingdom
 
+N: Richard Purdie
+E: rpurdie@rpsys.net
+D: Backlight subsystem maintainer
+S: USA
+
 N: Daniel Quinlan
 E: quinlan@pathname.com
 W: http://www.pathname.com/~quinlan/
diff --git a/MAINTAINERS b/MAINTAINERS
index 5678de3..3a967c8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1651,7 +1651,6 @@ S:	Maintained
 F:	drivers/net/wireless/b43legacy/
 
 BACKLIGHT CLASS/SUBSYSTEM
-M:	Richard Purdie <rpurdie@rpsys.net>
 M:	Jingoo Han <jg1.han@samsung.com>
 S:	Maintained
 F:	drivers/video/backlight/
-- 
1.7.10.4


