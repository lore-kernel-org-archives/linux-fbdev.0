From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: new fbdev
Date: Sun, 22 Dec 2002 14:24:53 +0100 (MET)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0212221422300.11726-100000@vervain.sonytel.be>
References: <Pine.GSO.4.21.0212220944490.11631-100000@vervain.sonytel.be>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail2.sonytel.be ([195.0.45.172] helo=mail.sonytel.be)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18Q67C-0002nh-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 22 Dec 2002 05:25:58 -0800
In-Reply-To: <Pine.GSO.4.21.0212220944490.11631-100000@vervain.sonytel.be>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Sun, 22 Dec 2002, Geert Uytterhoeven wrote:
>   o drivers/video/console/font.h is needed by arch/m68k/kernel/m68k_defs.c
>     (for struct font_desc)

A bit more explanation: on Mac/m68k, head.S uses the fbdev fonts to print
status informtation.

This patch moves the definition of struct font_desc back to <video/font.h>, so
it can be used outside of drivers/video/console.

--- linux-2.5.52/include/video/font.h	Mon Mar 18 12:17:27 2002
+++ linux-m68k-2.5.52/include/video/font.h	Sun Dec 22 13:58:32 2002
@@ -0,0 +1,24 @@
+/*
+ *  font.h -- `Soft' font definitions
+ *
+ *  Created 1995 by Geert Uytterhoeven
+ *
+ *  This file is subject to the terms and conditions of the GNU General Public
+ *  License.  See the file COPYING in the main directory of this archive
+ *  for more details.
+ */
+
+#ifndef _VIDEO_FONT_H
+#define _VIDEO_FONT_H
+
+#include <linux/types.h>
+
+struct font_desc {
+    int idx;
+    char *name;
+    int width, height;
+    void *data;
+    int pref;
+};
+
+#endif /* _VIDEO_FONT_H */
--- linux-2.5.52/drivers/video/console/font.h	Tue Dec 10 13:41:40 2002
+++ linux-m68k-2.5.52/drivers/video/console/font.h	Sun Dec 22 13:58:32 2002
@@ -8,18 +8,10 @@
  *  for more details.
  */
 
-#ifndef _VIDEO_FONT_H
-#define _VIDEO_FONT_H
+#ifndef _VIDEO_CONSOLE_FONT_H
+#define _VIDEO_CONSOLE_FONT_H
 
-#include <linux/types.h>
-
-struct font_desc {
-    int idx;
-    char *name;
-    int width, height;
-    void *data;
-    int pref;
-};
+#include <video/font.h>		/* struct font_desc */
 
 #define VGA8x8_IDX	0
 #define VGA8x16_IDX	1
@@ -50,4 +42,4 @@
 /* Max. length for the name of a predefined font */
 #define MAX_FONT_NAME	32
 
-#endif /* _VIDEO_FONT_H */
+#endif /* _VIDEO_CONSOLE_FONT_H */

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
