From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: drawings ops structures
Date: Mon, 19 Aug 2002 21:24:49 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0208192118010.8385-100000@vervain.sonytel.be>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail2.sonytel.be ([195.0.45.172] helo=mail.sonytel.be)
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17gs9A-00028d-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 19 Aug 2002 12:25:04 -0700
Received: from vervain.sonytel.be (mail.sonytel.be [10.17.0.27])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id VAA24356
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 19 Aug 2002 21:24:50 +0200 (MET DST)
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>


If I look at these definitions in <linux/fb.h>:

| struct fb_copyarea {
|         __u32 sx;       /* screen-relative */
|         __u32 sy;
|         __u32 width;
|         __u32 height;
|         __u32 dx;
|         __u32 dy;
| };
| 
| struct fb_fillrect {
|         __u32 dx;       /* screen-relative */
|         __u32 dy;
|         __u32 width;
|         __u32 height;
|         __u32 color;
|         __u32 rop;
| };
| 
| struct fb_image {
|         __u32 width;    /* Size of image */
|         __u32 height;
|         __u16 dx;       /* Where to place image */
|         __u16 dy;
|         __u32 fg_color; /* Only used when a mono bitmap */
|         __u32 bg_color;
|         __u8  depth;    /* Dpeth of the image */
|         char  *data;    /* Pointer to image data */
| };

Then I start to wonder ...
  - why are dx and dy in struct fb_image of type __u16, while they are of type
   __u32 in struct fb_copyarea and struct fb_fillrect?
  - why is the order of the fields different for each structure?
    Wouldn't it be better to always use the same order for the common fields,
    e.g.

	__u32 dx;
	__u32 dy;
	__u32 width;
	__u32 height;

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds



-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
