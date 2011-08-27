From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Sat, 27 Aug 2011 19:32:34 +0000
Subject: [PATCH] MAINTAINERS: change framebuffer maintainer
Message-Id: <1314473554-3317-1-git-send-email-FlorianSchandinat@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <4E4A1AB1.6040001@gmx.de>
In-Reply-To: <4E4A1AB1.6040001@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Paul Mundt <lethal@linux-sh.org>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>

As Paul has not much time for it I take over maintaining the
framebuffer subsystem.

Signed-off-by: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
---
 MAINTAINERS |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1d445f5..ac7e485 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2649,11 +2649,11 @@ F:	drivers/net/wan/dlci.c
 F:	drivers/net/wan/sdla.c
 
 FRAMEBUFFER LAYER
-M:	Paul Mundt <lethal@linux-sh.org>
+M:	Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
 L:	linux-fbdev@vger.kernel.org
 W:	http://linux-fbdev.sourceforge.net/
 Q:	http://patchwork.kernel.org/project/linux-fbdev/list/
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/lethal/fbdev-2.6.git
+T:	git git://github.com/schandinat/linux-2.6.git fbdev-next
 S:	Maintained
 F:	Documentation/fb/
 F:	Documentation/devicetree/bindings/fb/
-- 
1.6.3.2

