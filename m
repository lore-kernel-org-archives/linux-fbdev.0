From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: fb_imageblit()
Date: Sun, 5 Jan 2003 17:38:35 +0100 (MET)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0301051723310.10559-100000@vervain.sonytel.be>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail2.sonytel.be ([195.0.45.172] helo=mail.sonytel.be)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18VDnx-0007xL-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 05 Jan 2003 08:39:17 -0800
Received: from vervain.sonytel.be (mail.sonytel.be [10.17.0.27])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id RAA06981
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 5 Jan 2003 17:38:35 +0100 (MET)
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


I have a few questions and comments related to fb_imageblit().

 1. Why is the logo data in fb_image.data stored in an `unpacked' way? I.e.
    each byte of the logo data corresponds to one pixel of the image,
    irrespective of the depth of the image.

    However, I do see one good reason: it makes life easier for planar
    displays, since a fast c2p (chunky-to-planar) convertor doesn't have to
    care about the image depth, the source data is always 1 byte per pixel.

 2. If fb_image.depth == 1, how can fb_imageblit() distinguish between drawing
    a monochrome image (e.g. penguin logo) and color expanding a monochrome
    image (e.g. drawing text)? It's not possible to handle them the same, since
    image data for color expansion is packed, while image data for monochrome
    image drawing is not.
    
    If monochrome image data would be packed as well, it could be handled by
    setting fb_image.fg_color = 1 and fb_image.bg_color = 0 (or vice versa for
    mono10), and fb_set_logo() becomes simpler as well.

    If we retain the unpacked data for images, we need some other flag to
    indicate color expansion. Perhaps setting fb_image.depth to 0?

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
