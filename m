From: John Zielinski <grim@undead.cc>
Subject: Framebuffer text mode style cursor
Date: Sat, 15 Nov 2003 23:35:07 -0500
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <3FB6FE7B.8070507@undead.cc>
Mime-Version: 1.0
Content-Type: multipart/alternative;
 boundary="------------060602010607000802090101"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1ALEdd-0005sd-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 15 Nov 2003 20:35:53 -0800
Received: from gw-undead3.tht.net ([216.126.84.18] helo=mail.undead.cc)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.24)
	id 1ALEcy-0002e1-QO
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 15 Nov 2003 20:35:12 -0800
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
To: linux-fbdev-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------060602010607000802090101
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

As I mentioned before, I found the default framebuffer cursor to be 
extremely distracting as it made the character it's on blink.  Here's a 
patch to make it act just the way it does in text mode.  I made it a 
configurable option.  So if the default cursor drives you nuts as well, 
give it a try.


diff -urN -X dontdiff fbdev-2.6/drivers/video/console/Kconfig fbdev/drivers/video/console/Kconfig
--- fbdev-2.6/drivers/video/console/Kconfig	2003-10-25 14:43:11.000000000 -0400
+++ fbdev/drivers/video/console/Kconfig	2003-11-15 23:13:02.000000000 -0500
@@ -104,6 +104,13 @@
 config FRAMEBUFFER_CONSOLE
 	tristate "Framebuffer Console support"
 	depends on FB
+	
+config FBCON_TEXT_CURSOR
+	bool "Framebuffer text mode style cursor"
+	depends on FRAMEBUFFER_CONSOLE
+	help
+	  Say Y here if you want the framebuffer cursor to behave like it
+	  does in text mode.
 
 config PCI_CONSOLE
 	bool
diff -urN -X dontdiff fbdev-2.6/drivers/video/console/fbcon.c fbdev/drivers/video/console/fbcon.c
--- fbdev-2.6/drivers/video/console/fbcon.c	2003-11-15 03:31:27.000000000 -0500
+++ fbdev/drivers/video/console/fbcon.c	2003-11-15 23:10:14.000000000 -0500
@@ -139,6 +139,11 @@
 
 static int vbl_cursor_cnt;
 
+#ifdef CONFIG_FBCON_TEXT_CURSOR
+static u8 *cursor_data = NULL;
+static int cursor_data_size = 0;
+#endif
+
 #define divides(a, b)	((!(a) || (b)%(a)) ? 0 : 1)
 
 /*
@@ -966,18 +971,38 @@
 	}
 
 	if (mode != CM_ERASE) {
-		unsigned short charmask = vc->vc_hi_font_mask ? 0x1ff : 0xff;
 		int bgshift = (vc->vc_hi_font_mask) ? 13 : 12;
 		int fgshift = (vc->vc_hi_font_mask) ? 9 : 8;
 		int s_pitch = (vc->vc_font.width + 7) >> 3;
 		int size = s_pitch * vc->vc_font.height;
 		struct fb_cursor cursor;
-		int cur_height = 0, c, i;
-		u8 *dst;
+		int cur_height, c;
 		
 		memset(&cursor, 0, sizeof(struct fb_cursor));
 		cursor.enable = 1;
 
+		switch (vc->vc_cursor_type & 0x0f) {
+		case CUR_NONE:	
+			cur_height = 0;
+			break;
+		case CUR_UNDERLINE:
+			cur_height = (vc->vc_font.height < 10) ? 1 : 2;
+			break;
+		case CUR_LOWER_THIRD:
+			cur_height = vc->vc_font.height/3;
+			break;
+		case CUR_LOWER_HALF:
+			cur_height = vc->vc_font.height >> 1;
+			break;
+		case CUR_TWO_THIRDS:
+			cur_height = (vc->vc_font.height << 1)/3;
+			break;
+		case CUR_BLOCK:	
+		default:
+			cur_height = vc->vc_font.height;
+			break;
+		}
+		
  		c = scr_readw((u16 *) vc->vc_pos);
 
 		if (info->cursor.image.bg_color != attr_bgcol(bgshift, c) ||
@@ -988,6 +1013,12 @@
 			cursor.set |= FB_CUR_SETCMAP;
 		}
 		
+		if (info->cursor.hot.x || info->cursor.hot.y) {
+			cursor.hot.x = cursor.hot.y = 0;
+			cursor.set |= FB_CUR_SETHOT;
+		}
+	
+#ifndef CONFIG_FBCON_TEXT_CURSOR
 		if ((info->cursor.image.dx != (vc->vc_font.width * vc->vc_x)) ||
 		    (info->cursor.image.dy != (vc->vc_font.height * y))) {
 			cursor.image.dx = vc->vc_font.width * vc->vc_x;
@@ -1002,15 +1033,13 @@
 			cursor.set |= FB_CUR_SETSIZE;
 		}
 
-		if (info->cursor.hot.x || info->cursor.hot.y) {
-			cursor.hot.x = cursor.hot.y = 0;
-			cursor.set |= FB_CUR_SETHOT;
-		}
-	
 		if ((cursor.set & FB_CUR_SETSIZE) || (cursor.set & FB_CUR_SETPOS)) {
+			unsigned short charmask = vc->vc_hi_font_mask ? 0x1ff : 0xff;
 			int width = vc->vc_font.width >> 3;
 			u8 delta = vc->vc_font.width & 7;
-
+			u8 *dst;
+			int i;
+			
 			dst = kmalloc(size, GFP_ATOMIC);
 			if (!dst)
 				return;
@@ -1019,28 +1048,7 @@
 			if (info->cursor.image.data)
 				kfree(info->cursor.image.data);
 			info->cursor.image.data = dst;
-			
-			switch (vc->vc_cursor_type & 0x0f) {
-			case CUR_NONE:	
-				cur_height = 0;
-				break;
-			case CUR_UNDERLINE:
-				cur_height = (vc->vc_font.height < 10) ? 1 : 2;
-				break;
-			case CUR_LOWER_THIRD:
-				cur_height = vc->vc_font.height/3;
-				break;
-			case CUR_LOWER_HALF:
-				cur_height = vc->vc_font.height >> 1;
-				break;
-			case CUR_TWO_THIRDS:
-				cur_height = (vc->vc_font.height << 1)/3;
-				break;
-			case CUR_BLOCK:	
-			default:
-				cur_height = vc->vc_font.height;
-				break;
-			}
+
 			dst += (vc->vc_font.height - cur_height) * s_pitch;
 			for (i = 0; i < cur_height; i++) {
 				memset(dst, 0xff, width);
@@ -1048,9 +1056,7 @@
 					*(dst+width) = 0xf << delta;
 				dst += s_pitch;
 			}	
-		}
 
-		if ((cursor.set & FB_CUR_SETSIZE) || (cursor.set & FB_CUR_SETPOS)) {
 			char *src = vc->vc_font.data + ((c & charmask) * size);
 			
 			dst = kmalloc(size, GFP_ATOMIC);
@@ -1067,6 +1073,39 @@
 					*dst++ = 0xff ^ *src++;
 			}	
 		}
+#else
+		if ((info->cursor.image.dx != (vc->vc_font.width * vc->vc_x)) ||
+		    (info->cursor.image.dy != (vc->vc_font.height * y + vc->vc_font.height - cur_height))) {
+			cursor.image.dx = vc->vc_font.width * vc->vc_x;
+			cursor.image.dy = vc->vc_font.height * y + vc->vc_font.height - cur_height;
+			cursor.set |= FB_CUR_SETPOS;
+		}
+
+		if (info->cursor.image.height != cur_height ||
+		    info->cursor.image.width != vc->vc_font.width) {
+			cursor.image.height = cur_height;
+			cursor.image.width = vc->vc_font.width;
+			cursor.set |= FB_CUR_SETSIZE;
+		}
+		
+		if (cursor.set & FB_CUR_SETSIZE) {
+			if (size > cursor_data_size) {
+				if (cursor_data) {
+					kfree(cursor_data);
+					cursor_data_size = 0;
+				}
+				cursor_data = kmalloc(size, GFP_ATOMIC); 
+		    		if (!cursor_data)
+				        return;
+    		    		memset(cursor_data, 0xff, size);
+			        cursor_data_size = size;
+			}
+		
+			cursor.set |= FB_CUR_SETSHAPE;
+			info->cursor.image.data = cursor_data;
+			info->cursor.mask = cursor_data;
+		}
+#endif
 		info->fbops->fb_cursor(info, &cursor);
 		info->cursor.enable = 1;
 		atomic_dec(&info->sprite.count);



John




--------------060602010607000802090101
Content-Type: text/html; charset=us-ascii
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html;charset=ISO-8859-1">
  <title></title>
</head>
<body>
As I mentioned before, I found the default framebuffer cursor to be
extremely distracting as it made the character it's on blink.&nbsp; Here's a
patch to make it act just the way it does in text mode.&nbsp; I made it a
configurable option.&nbsp; So if the default cursor drives you nuts as well,
give it a try.<br>
<br>
<br>
<div class="moz-text-plain" wrap="true" graphical-quote="true"
 style="font-family: -moz-fixed; font-size: 16px;" lang="x-western">
<pre wrap="">diff -urN -X dontdiff fbdev-2.6/drivers/video/console/Kconfig fbdev/drivers/video/console/Kconfig
--- fbdev-2.6/drivers/video/console/Kconfig	2003-10-25 14:43:11.000000000 -0400
+++ fbdev/drivers/video/console/Kconfig	2003-11-15 23:13:02.000000000 -0500
@@ -104,6 +104,13 @@
 config FRAMEBUFFER_CONSOLE
 	tristate "Framebuffer Console support"
 	depends on FB
+	
+config FBCON_TEXT_CURSOR
+	bool "Framebuffer text mode style cursor"
+	depends on FRAMEBUFFER_CONSOLE
+	help
+	  Say Y here if you want the framebuffer cursor to behave like it
+	  does in text mode.
 
 config PCI_CONSOLE
 	bool
diff -urN -X dontdiff fbdev-2.6/drivers/video/console/fbcon.c fbdev/drivers/video/console/fbcon.c
--- fbdev-2.6/drivers/video/console/fbcon.c	2003-11-15 03:31:27.000000000 -0500
+++ fbdev/drivers/video/console/fbcon.c	2003-11-15 23:10:14.000000000 -0500
@@ -139,6 +139,11 @@
 
 static int vbl_cursor_cnt;
 
+#ifdef CONFIG_FBCON_TEXT_CURSOR
+static u8 *cursor_data = NULL;
+static int cursor_data_size = 0;
+#endif
+
 #define divides(a, b)	((!(a) || (b)%(a)) ? 0 : 1)
 
 /*
@@ -966,18 +971,38 @@
 	}
 
 	if (mode != CM_ERASE) {
-		unsigned short charmask = vc-&gt;vc_hi_font_mask ? 0x1ff : 0xff;
 		int bgshift = (vc-&gt;vc_hi_font_mask) ? 13 : 12;
 		int fgshift = (vc-&gt;vc_hi_font_mask) ? 9 : 8;
 		int s_pitch = (vc-&gt;vc_font.width + 7) &gt;&gt; 3;
 		int size = s_pitch * vc-&gt;vc_font.height;
 		struct fb_cursor cursor;
-		int cur_height = 0, c, i;
-		u8 *dst;
+		int cur_height, c;
 		
 		memset(&amp;cursor, 0, sizeof(struct fb_cursor));
 		cursor.enable = 1;
 
+		switch (vc-&gt;vc_cursor_type &amp; 0x0f) {
+		case CUR_NONE:	
+			cur_height = 0;
+			break;
+		case CUR_UNDERLINE:
+			cur_height = (vc-&gt;vc_font.height &lt; 10) ? 1 : 2;
+			break;
+		case CUR_LOWER_THIRD:
+			cur_height = vc-&gt;vc_font.height/3;
+			break;
+		case CUR_LOWER_HALF:
+			cur_height = vc-&gt;vc_font.height &gt;&gt; 1;
+			break;
+		case CUR_TWO_THIRDS:
+			cur_height = (vc-&gt;vc_font.height &lt;&lt; 1)/3;
+			break;
+		case CUR_BLOCK:	
+		default:
+			cur_height = vc-&gt;vc_font.height;
+			break;
+		}
+		
  		c = scr_readw((u16 *) vc-&gt;vc_pos);
 
 		if (info-&gt;cursor.image.bg_color != attr_bgcol(bgshift, c) ||
@@ -988,6 +1013,12 @@
 			cursor.set |= FB_CUR_SETCMAP;
 		}
 		
+		if (info-&gt;cursor.hot.x || info-&gt;cursor.hot.y) {
+			cursor.hot.x = cursor.hot.y = 0;
+			cursor.set |= FB_CUR_SETHOT;
+		}
+	
+#ifndef CONFIG_FBCON_TEXT_CURSOR
 		if ((info-&gt;cursor.image.dx != (vc-&gt;vc_font.width * vc-&gt;vc_x)) ||
 		    (info-&gt;cursor.image.dy != (vc-&gt;vc_font.height * y))) {
 			cursor.image.dx = vc-&gt;vc_font.width * vc-&gt;vc_x;
@@ -1002,15 +1033,13 @@
 			cursor.set |= FB_CUR_SETSIZE;
 		}
 
-		if (info-&gt;cursor.hot.x || info-&gt;cursor.hot.y) {
-			cursor.hot.x = cursor.hot.y = 0;
-			cursor.set |= FB_CUR_SETHOT;
-		}
-	
 		if ((cursor.set &amp; FB_CUR_SETSIZE) || (cursor.set &amp; FB_CUR_SETPOS)) {
+			unsigned short charmask = vc-&gt;vc_hi_font_mask ? 0x1ff : 0xff;
 			int width = vc-&gt;vc_font.width &gt;&gt; 3;
 			u8 delta = vc-&gt;vc_font.width &amp; 7;
-
+			u8 *dst;
+			int i;
+			
 			dst = kmalloc(size, GFP_ATOMIC);
 			if (!dst)
 				return;
@@ -1019,28 +1048,7 @@
 			if (info-&gt;cursor.image.data)
 				kfree(info-&gt;cursor.image.data);
 			info-&gt;cursor.image.data = dst;
-			
-			switch (vc-&gt;vc_cursor_type &amp; 0x0f) {
-			case CUR_NONE:	
-				cur_height = 0;
-				break;
-			case CUR_UNDERLINE:
-				cur_height = (vc-&gt;vc_font.height &lt; 10) ? 1 : 2;
-				break;
-			case CUR_LOWER_THIRD:
-				cur_height = vc-&gt;vc_font.height/3;
-				break;
-			case CUR_LOWER_HALF:
-				cur_height = vc-&gt;vc_font.height &gt;&gt; 1;
-				break;
-			case CUR_TWO_THIRDS:
-				cur_height = (vc-&gt;vc_font.height &lt;&lt; 1)/3;
-				break;
-			case CUR_BLOCK:	
-			default:
-				cur_height = vc-&gt;vc_font.height;
-				break;
-			}
+
 			dst += (vc-&gt;vc_font.height - cur_height) * s_pitch;
 			for (i = 0; i &lt; cur_height; i++) {
 				memset(dst, 0xff, width);
@@ -1048,9 +1056,7 @@
 					*(dst+width) = 0xf &lt;&lt; delta;
 				dst += s_pitch;
 			}	
-		}
 
-		if ((cursor.set &amp; FB_CUR_SETSIZE) || (cursor.set &amp; FB_CUR_SETPOS)) {
 			char *src = vc-&gt;vc_font.data + ((c &amp; charmask) * size);
 			
 			dst = kmalloc(size, GFP_ATOMIC);
@@ -1067,6 +1073,39 @@
 					*dst++ = 0xff ^ *src++;
 			}	
 		}
+#else
+		if ((info-&gt;cursor.image.dx != (vc-&gt;vc_font.width * vc-&gt;vc_x)) ||
+		    (info-&gt;cursor.image.dy != (vc-&gt;vc_font.height * y + vc-&gt;vc_font.height - cur_height))) {
+			cursor.image.dx = vc-&gt;vc_font.width * vc-&gt;vc_x;
+			cursor.image.dy = vc-&gt;vc_font.height * y + vc-&gt;vc_font.height - cur_height;
+			cursor.set |= FB_CUR_SETPOS;
+		}
+
+		if (info-&gt;cursor.image.height != cur_height ||
+		    info-&gt;cursor.image.width != vc-&gt;vc_font.width) {
+			cursor.image.height = cur_height;
+			cursor.image.width = vc-&gt;vc_font.width;
+			cursor.set |= FB_CUR_SETSIZE;
+		}
+		
+		if (cursor.set &amp; FB_CUR_SETSIZE) {
+			if (size &gt; cursor_data_size) {
+				if (cursor_data) {
+					kfree(cursor_data);
+					cursor_data_size = 0;
+				}
+				cursor_data = kmalloc(size, GFP_ATOMIC); 
+		    		if (!cursor_data)
+				        return;
+    		    		memset(cursor_data, 0xff, size);
+			        cursor_data_size = size;
+			}
+		
+			cursor.set |= FB_CUR_SETSHAPE;
+			info-&gt;cursor.image.data = cursor_data;
+			info-&gt;cursor.mask = cursor_data;
+		}
+#endif
 		info-&gt;fbops-&gt;fb_cursor(info, &amp;cursor);
 		info-&gt;cursor.enable = 1;
 		atomic_dec(&amp;info-&gt;sprite.count);


</pre>
John<br>
<br>
<pre wrap="">

</pre>
</div>
<br>
</body>
</html>

--------------060602010607000802090101--




-------------------------------------------------------
This SF. Net email is sponsored by: GoToMyPC
GoToMyPC is the fast, easy and secure way to access your computer from
any Web browser or wireless device. Click here to Try it Free!
https://www.gotomypc.com/tr/OSDN/AW/Q4_2003/t/g22lp?Target=mm/g22lp.tmpl
