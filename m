From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: const fb_{fillrect,copyarea,image}?
Date: Tue, 7 Jan 2003 22:31:34 +0100 (MET)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0301072227110.21057-100000@vervain.sonytel.be>
References: <Pine.LNX.4.44.0301072119370.17129-100000@phoenix.infradead.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail2.sonytel.be ([195.0.45.172] helo=mail.sonytel.be)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18W1L3-0008Uj-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 07 Jan 2003 13:32:45 -0800
In-Reply-To: <Pine.LNX.4.44.0301072119370.17129-100000@phoenix.infradead.org>
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

On Tue, 7 Jan 2003, James Simmons wrote:
> > Wouldn't it make sense to make the fb_{fillrect,copyarea,image} parameters of
> > the fb_ops.fb_{fillrect,copyarea,image}() operations const? This would protect
> > us against side effects when reusing the fb_{fillrect,copyarea,image} structs
> > without reinitializing their contents (as is currently done by the logo drawing
> > code in fbcon_show_logo() on SMP).
> 
> Where is this exactly?

drivers/video/fbmem.c:fb_show_logo() initializes only image.dx in each loop
iteration:

| for (x = 0; x < num_online_cpus() * (LOGO_W + 8) &&
|      x < info->var.xres - (LOGO_W + 8); x += (LOGO_W + 8)) {
|         image.dx = x;
|         info->fbops->fb_imageblit(info, &image);
|         done = 1;
| }

> > Of course this means that we have to modify the clipping code, which currently
> > just modifies the passed structure.
> 
> :-( That is done to prevent someone from passing data that is larger than 
> the framebuffer.

You can still do clipping without modifying the passed structure, right?

BTW, is it possible that someone passes data that is larger (except for bugs)?
We have control over what happens in the kernel. Data passed from userspace is
a different issue, of course.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
