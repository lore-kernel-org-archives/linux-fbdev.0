From: Peilin Ye <yepeilin.cs@gmail.com>
Date: Sun, 18 Oct 2020 18:14:10 +0000
Subject: [PATCH 2/2] docs: fb: Add font_6x8 to available built-in fonts
Message-Id: <717bb41dda8e2ed615f3faadfbc3e215de726d38.1603037079.git.yepeilin.cs@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <926453876c92caac34cba8545716a491754d04d5.1603037079.git.yepeilin.cs@gmail.com>
In-Reply-To: <926453876c92caac34cba8545716a491754d04d5.1603037079.git.yepeilin.cs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jonathan Corbet <corbet@lwn.net>
Cc: Daniel Vetter <daniel@ffwll.ch>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Sascha Hauer <s.hauer@pengutronix.de>, Sven Schneider <s.schneider@arkona-technologies.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, linux-doc@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Peilin Ye <yepeilin.cs@gmail.com>

Recently we added a new 6x8 font in commit e2028c8e6bf9 ("lib/fonts: add
font 6x8 for OLED display"). Add its name to the "compiled-in fonts"
list.

Signed-off-by: Peilin Ye <yepeilin.cs@gmail.com>
---
 Documentation/fb/fbcon.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/fb/fbcon.rst b/Documentation/fb/fbcon.rst
index 9aad964b767c..57f66de2f7e1 100644
--- a/Documentation/fb/fbcon.rst
+++ b/Documentation/fb/fbcon.rst
@@ -81,7 +81,7 @@ C. Boot options
 1. fbcon=font:<name>
 
 	Select the initial font to use. The value 'name' can be any of the
-	compiled-in fonts: 10x18, 6x10, 7x14, Acorn8x8, MINI4x6,
+	compiled-in fonts: 10x18, 6x10, 6x8, 7x14, Acorn8x8, MINI4x6,
 	PEARL8x8, ProFont6x11, SUN12x22, SUN8x16, TER16x32, VGA8x16, VGA8x8.
 
 	Note, not all drivers can handle font with widths not divisible by 8,
-- 
2.25.1
