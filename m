From: Andrea Gelmini <andrea.gelmini@gelma.net>
Date: Sat, 21 May 2016 11:40:28 +0000
Subject: [PATCH 0036/1529] Fix typo
Message-Id: <20160521114028.772-1-andrea.gelmini@gelma.net>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 Documentation/fb/sstfb.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/fb/sstfb.txt b/Documentation/fb/sstfb.txt
index 13db107..a0a2dfb 100644
--- a/Documentation/fb/sstfb.txt
+++ b/Documentation/fb/sstfb.txt
@@ -60,7 +60,7 @@ Module Usage
 	  the device will be /dev/fb0. You can check this by doing a 
 	  cat /proc/fb. You can find a copy of con2fb in tools/ directory.
 	  if you don't have another fb device, this step is superfluous,
-	  as the console subsystem automagicaly binds ttys to the fb.
+	  as the console subsystem automagically binds ttys to the fb.
 	# switch to the virtual console you just mapped. "tadaaa" ...
 
 	Module removal:
-- 
2.8.2.534.g1f66975

