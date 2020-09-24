From: Peilin Ye <yepeilin.cs@gmail.com>
Date: Thu, 24 Sep 2020 13:43:48 +0000
Subject: [PATCH 3/3] fbcon: Fix global-out-of-bounds read in fbcon_get_font()
Message-Id: <b34544687a1a09d6de630659eb7a773f4953238b.1600953813.git.yepeilin.cs@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1600953813.git.yepeilin.cs@gmail.com>
 <7fb8bc9b0abc676ada6b7ac0e0bd443499357267.1600953813.git.yepeilin.cs@gmail.com>
 <ef18af00c35fb3cc826048a5f70924ed6ddce95b.1600953813.git.yepeilin.cs@gmail.com>
In-Reply-To: <ef18af00c35fb3cc826048a5f70924ed6ddce95b.1600953813.git.yepeilin.cs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-fbdev@vger.kernel.org, Daniel Vetter <daniel.vetter@ffwll.ch>, syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Jiri Slaby <jirislaby@kernel.org>, Peilin Ye <yepeilin.cs@gmail.com>, linux-kernel-mentees@lists.linuxfoundation.org

fbcon_get_font() is reading out-of-bounds. A malicious user may resize
`vc->vc_font.height` to a large value, causing fbcon_get_font() to
read out of `fontdata`.

fbcon_get_font() handles both built-in and user-provided fonts.
Fortunately, recently we have added FONT_EXTRA_WORDS support for built-in
fonts, so fix it by adding range checks using FNTSIZE(). 

This patch depends on patch "fbdev, newport_con: Move FONT_EXTRA_WORDS
macros into linux/font.h", and patch "Fonts: Support FONT_EXTRA_WORDS
macros for built-in fonts".

Cc: stable@vger.kernel.org
Reported-and-tested-by: syzbot+29d4ed7f3bdedf2aa2fd@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?idb8be45afea11888776f897895aef9ad1c3ecfd
Signed-off-by: Peilin Ye <yepeilin.cs@gmail.com>
---
 drivers/video/fbdev/core/fbcon.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 66167830fefd..bda24c64e646 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -2492,6 +2492,9 @@ static int fbcon_get_font(struct vc_data *vc, struct console_font *font)
 
 	if (font->width <= 8) {
 		j = vc->vc_font.height;
+		if (font->charcount * j > FNTSIZE(fontdata))
+			return -EINVAL;
+
 		for (i = 0; i < font->charcount; i++) {
 			memcpy(data, fontdata, j);
 			memset(data + j, 0, 32 - j);
@@ -2500,6 +2503,9 @@ static int fbcon_get_font(struct vc_data *vc, struct console_font *font)
 		}
 	} else if (font->width <= 16) {
 		j = vc->vc_font.height * 2;
+		if (font->charcount * j > FNTSIZE(fontdata))
+			return -EINVAL;
+
 		for (i = 0; i < font->charcount; i++) {
 			memcpy(data, fontdata, j);
 			memset(data + j, 0, 64 - j);
@@ -2507,6 +2513,9 @@ static int fbcon_get_font(struct vc_data *vc, struct console_font *font)
 			fontdata += j;
 		}
 	} else if (font->width <= 24) {
+		if (font->charcount * (vc->vc_font.height * sizeof(u32)) > FNTSIZE(fontdata))
+			return -EINVAL;
+
 		for (i = 0; i < font->charcount; i++) {
 			for (j = 0; j < vc->vc_font.height; j++) {
 				*data++ = fontdata[0];
@@ -2519,6 +2528,9 @@ static int fbcon_get_font(struct vc_data *vc, struct console_font *font)
 		}
 	} else {
 		j = vc->vc_font.height * 4;
+		if (font->charcount * j > FNTSIZE(fontdata))
+			return -EINVAL;
+
 		for (i = 0; i < font->charcount; i++) {
 			memcpy(data, fontdata, j);
 			memset(data + j, 0, 128 - j);
-- 
2.25.1
