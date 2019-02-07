From: Richard Fearn <richardfearn@gmail.com>
Date: Thu, 07 Feb 2019 20:47:02 +0000
Subject: [PATCH] fbcon: add new font TER16x32 to boot options documentation
Message-Id: <990625e7-a0b1-81f9-3371-808159c31df9@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, linux-doc@vger.kernel.org

TER16x32 was added in ac8b6f148fc9.

Compare the list in fbcon.txt with the output of:

   $ fgrep -h .name lib/fonts/*.c | sort

Signed-off-by: Richard Fearn <richardfearn@gmail.com>
---
  Documentation/fb/fbcon.txt | 4 ++--
  1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/fb/fbcon.txt b/Documentation/fb/fbcon.txt
index 60a5ec04e8f0..97bf1d19dec2 100644
--- a/Documentation/fb/fbcon.txt
+++ b/Documentation/fb/fbcon.txt
@@ -78,8 +78,8 @@ C. Boot options
  1. fbcon=font:<name>

          Select the initial font to use. The value 'name' can be any of the
-        compiled-in fonts: 10x18, 6x10, 7x14, Acorn8x8, MINI4x6,
-        PEARL8x8, ProFont6x11, SUN12x22, SUN8x16, VGA8x16, VGA8x8.
+        compiled-in fonts: 10x18, 6x10, 7x14, Acorn8x8, MINI4x6, PEARL8x8,
+        ProFont6x11, SUN12x22, SUN8x16, TER16x32, VGA8x16, VGA8x8.

  	Note, not all drivers can handle font with widths not divisible by 8,
          such as vga16fb.
-- 
2.19.1
