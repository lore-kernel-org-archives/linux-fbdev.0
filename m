From: Antonino Daplas <adaplas@pol.net>
Subject: Re: const fb_{fillrect,copyarea,image}?
Date: 10 Jan 2003 18:28:38 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1042181502.933.301.camel@localhost.localdomain>
References: <Pine.LNX.4.44.0301091814550.5660-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from willow.compass.com.ph ([202.70.96.38])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18WwZL-00006W-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 10 Jan 2003 02:39:19 -0800
In-Reply-To: <Pine.LNX.4.44.0301091814550.5660-100000@phoenix.infradead.org>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: James Simmons <jsimmons@infradead.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Fri, 2003-01-10 at 02:16, James Simmons wrote: 

>  
> > BTW, is it possible that someone passes data that is larger (except for bugs)?
> > We have control over what happens in the kernel. Data passed from userspace is
> > a different issue, of course.
> 
> Yes. Soon the standard ioctl for a cursor will be truly in place. This 
> means cfb_imageblit could be a issue from userland.
> 
If you are going to export the cursor API to userland, then soft_cursor
is useless, because it implies that we always have a copy of the screen
under the cursor (so we can restore it when we move the cursor) and it
also implies that fb_imageblit can support transparency (so the mask
bits will work).  For soft cursors, the userland has to take care of it.

For those with hardware cursors, this is exportable to user space. 

The structure fbcursor has one field that is console specific
fbcursor.dest which we basically use to invert the cursor image.  So the
structure that is passed via the cursor ioctl will be slightly
different, it should not have the 'dest' field.  So when it gets passed
to fb_cursor(), dest == NULL.  Then this is how drivers can respond: 

1. soft_cursor - if cursor->dest == NULL, always exit with an error. 

2. hardware cursors which cannot do invert - if cursor->dest == NULL and
rop == ROP_XOR, exit with an error, otherwise (ROP_COPY), proceed. 

3. hardware cursors with invert - cursor->dest will be ignored so it has
full support. 

The rivafb_cursor() and i810fb_cursor() already behaves like #2 already.

Anyway, inverting the cursor image is not commonly used in GUI apps.
Typically, they just need an opaque cursor + a transparency mask to
"shape" the cursor. 

Tony  





-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
