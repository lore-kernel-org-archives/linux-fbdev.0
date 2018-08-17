From: Randy Dunlap <rdunlap@infradead.org>
Date: Fri, 17 Aug 2018 04:12:07 +0000
Subject: [PATCH] Documentation/fb/vesafb.txt: "inverse" option corrections
Message-Id: <b77dcfee-2cc2-adb0-645e-369fc032abd1@infradead.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux Fbdev development list <linux-fbdev@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

From: Randy Dunlap <rdunlap@infradead.org>

Spell the vesafb "inverse" option correctly and tell what it does.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-fbdev@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: Antonino A. Daplas <adaplas@gmail.com>
---
 Documentation/fb/vesafb.txt |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- lnx-418.orig/Documentation/fb/vesafb.txt
+++ lnx-418/Documentation/fb/vesafb.txt
@@ -114,11 +114,11 @@ to turn it on.
 
 You can pass options to vesafb using "video=vesafb:option" on
 the kernel command line.  Multiple options should be separated
-by comma, like this: "video=vesafb:ypan,invers"
+by comma, like this: "video=vesafb:ypan,inverse"
 
 Accepted options:
 
-invers	no comment...
+inverse	use inverse color map
 
 ypan	enable display panning using the VESA protected mode 
 	interface.  The visible screen is just a window of the
