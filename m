From: Randy Dunlap <rdunlap@infradead.org>
Date: Tue, 07 Nov 2017 04:48:11 +0000
Subject: [PATCH] documentation: update list of available compiled-in fonts
Message-Id: <bf177e2d-d5a6-5889-e6b1-1c7a53e177ee@infradead.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: LKML <linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@linux-foundation.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>

From: Randy Dunlap <rdunlap@infradead.org>

Update list of available compiled-in fonts in lib/fonts/:
add 6x10 and drop RomanLarge (which was reverted 12 years ago).

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
---
 Documentation/fb/fbcon.txt |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- lnx-414-rc8.orig/Documentation/fb/fbcon.txt
+++ lnx-414-rc8/Documentation/fb/fbcon.txt
@@ -77,8 +77,8 @@ C. Boot options
 1. fbcon=font:<name>
 
         Select the initial font to use. The value 'name' can be any of the
-        compiled-in fonts: VGA8x16, 7x14, 10x18, VGA8x8, MINI4x6, RomanLarge,
-        SUN8x16, SUN12x22, ProFont6x11, Acorn8x8, PEARL8x8.
+        compiled-in fonts: VGA8x16, 7x14, 10x18, VGA8x8, MINI4x6,
+        SUN8x16, SUN12x22, 6x10, ProFont6x11, Acorn8x8, PEARL8x8.
 
 	Note, not all drivers can handle font with widths not divisible by 8,
         such as vga16fb.


