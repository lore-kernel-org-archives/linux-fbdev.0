From: James Simmons <jsimmons@infradead.org>
Subject: Re: const fb_{fillrect,copyarea,image}?
Date: Thu, 9 Jan 2003 18:16:17 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0301091814550.5660-100000@phoenix.infradead.org>
References: <Pine.GSO.4.21.0301072227110.21057-100000@vervain.sonytel.be>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from carisma.slowglass.com ([195.224.96.167] helo=phoenix.infradead.org)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 18WhEb-0002Rl-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 09 Jan 2003 10:16:54 -0800
In-Reply-To: <Pine.GSO.4.21.0301072227110.21057-100000@vervain.sonytel.be>
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
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>


> drivers/video/fbmem.c:fb_show_logo() initializes only image.dx in each loop
> iteration:
> 
> | for (x = 0; x < num_online_cpus() * (LOGO_W + 8) &&
> |      x < info->var.xres - (LOGO_W + 8); x += (LOGO_W + 8)) {
> |         image.dx = x;
> |         info->fbops->fb_imageblit(info, &image);
> |         done = 1;
> | }

Oh.
 
> > > Of course this means that we have to modify the clipping code, which currently
> > > just modifies the passed structure.
> > 
> > :-( That is done to prevent someone from passing data that is larger than 
> > the framebuffer.
> 
> You can still do clipping without modifying the passed structure, right?

Probable it can be arranged this way.
 
> BTW, is it possible that someone passes data that is larger (except for bugs)?
> We have control over what happens in the kernel. Data passed from userspace is
> a different issue, of course.

Yes. Soon the standard ioctl for a cursor will be truly in place. This 
means cfb_imageblit could be a issue from userland.



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
