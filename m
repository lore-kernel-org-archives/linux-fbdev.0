From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: clipping
Date: Sun, 29 Dec 2002 22:21:13 +0100 (MET)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0212292215130.17739-100000@vervain.sonytel.be>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail2.sonytel.be ([195.0.45.172] helo=mail.sonytel.be)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18Sksa-0005JZ-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 29 Dec 2002 13:21:52 -0800
Received: from vervain.sonytel.be (mail.sonytel.be [10.17.0.27])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id WAA29704
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 29 Dec 2002 22:21:13 +0100 (MET)
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


cfb_imageblit() takes care of clipping, but forgets to update fb_image.data if
fb_image.d[xy] was changed.

BTW, do we really need clipping in fb_ops.fb_{fillrect,copyarea,imageblit}()?

If these calls are accessible from user space through ioctl() (if anyone really
wants to do that?!?), I guess the answer is yes. For calls from kernel space,
I'd say it's not necessary since calling them with out-of-range parameters is a
bug anyway.
So we could move the clipping to the generic ioctl() handling in fbmem.c, if we
ever want to provide that functionality. Or is there a too high speed penalty
for graphics chips that do implement clipping in hardware?

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
