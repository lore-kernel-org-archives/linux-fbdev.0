From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] interlaced packed pixels
Date: Fri, 4 Apr 2003 13:17:15 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0304041310440.1720-100000@vervain.sonytel.be>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail2.sonytel.be ([195.0.45.172] helo=mail.sonytel.be)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 191PCg-0008B4-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 04 Apr 2003 03:17:50 -0800
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
To: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>

	Hi,

I'd like to introduce a new frame buffer type to accommodate packed pixel frame
buffers that store the even and odd fields separately. This is typically used
in graphics hardware for TV output (e.g. set-top boxes).

--- linux-2.4.21-pre6/include/linux/fb.h.orig	Tue Apr 16 10:21:43 2002
+++ linux-2.4.21-pre6/include/fb.h	Fri Apr  4 13:14:19 2003
@@ -38,6 +38,7 @@
 #define FB_TYPE_INTERLEAVED_PLANES	2	/* Interleaved planes	*/
 #define FB_TYPE_TEXT			3	/* Text/attributes	*/
 #define FB_TYPE_VGA_PLANES		4	/* EGA/VGA planes	*/
+#define FB_TYPE_PACKED_PIXELS_LACED	5	/* Interlaced Packed Pixels */
 
 #define FB_AUX_TEXT_MDA		0	/* Monochrome text */
 #define FB_AUX_TEXT_CGA		1	/* CGA/EGA/VGA Color text */
@@ -115,6 +117,8 @@
 	__u32 smem_len;			/* Length of frame buffer mem */
 	__u32 type;			/* see FB_TYPE_*		*/
 	__u32 type_aux;			/* Interleave for interleaved Planes */
+					/* Offset to odd field for      */
+					/* interlaced packed pixels */
 	__u32 visual;			/* see FB_VISUAL_*		*/ 
 	__u16 xpanstep;			/* zero if no hardware panning  */
 	__u16 ypanstep;			/* zero if no hardware panning  */

The patch applies to both 2.4.x and 2.5.x.

Any comments?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds



-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
