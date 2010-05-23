From: Andrea Gelmini <andrea.gelmini@gelma.net>
Date: Sun, 23 May 2010 19:56:04 +0000
Subject: [PATCH 036/199] Documentation/fb/internals.txt: Checkpatch cleanup
Message-Id: <1274644605-25181-8-git-send-email-andrea.gelmini@gelma.net>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Documentation/fb/internals.txt:73: ERROR: trailing whitespace

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 Documentation/fb/internals.txt |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/Documentation/fb/internals.txt b/Documentation/fb/internals.txt
index 9b2a2b2..de9d0db 100644
--- a/Documentation/fb/internals.txt
+++ b/Documentation/fb/internals.txt
@@ -1,4 +1,3 @@
-
 This is a first start for some documentation about frame buffer device
 internals.
 
@@ -70,7 +69,7 @@ The pixel value is broken up into red, green, and blue fields.
 
 Direct color (FB_VISUAL_DIRECTCOLOR)
 ------------------------------------
-The pixel value is broken up into red, green, and blue fields, each of which 
+The pixel value is broken up into red, green, and blue fields, each of which
 are looked up in separate red, green, and blue lookup tables.
 
 
-- 
1.7.1.251.gf80a2

