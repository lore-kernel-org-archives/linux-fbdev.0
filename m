From: Antonino Daplas <adaplas@pol.net>
Subject: Re: Mirrored Display?
Date: 16 Dec 2002 01:57:52 +0500
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1039985803.1080.119.camel@localhost.localdomain>
References: <200212131733.42340.kaufmann@sohard.de>
	<1039911076.1000.39.camel@localhost.localdomain> 
	<200212151603.30592.kaufmann@sohard.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from willow.compass.com.ph ([202.70.96.38])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18Nd71-0005J6-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 15 Dec 2002 10:03:35 -0800
In-Reply-To: <200212151603.30592.kaufmann@sohard.de>
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
To: Michael Kaufmann <kaufmann@sohard.de>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Sun, 2002-12-15 at 22:03, Michael Kaufmann wrote:
> On Saturday 14 December 2002 23:29, you wrote:
> > On Fri, 2002-12-13 at 23:33, Michael Kaufmann wrote:
> > > Hello,
> > >
> > > i would like to use a mono LCD with a framebuffer driver.
> > >
> > > I've modified existing drivers, and after a lot of work i now have a
> > > clear picture on my display. Unfortunately, the complete picture is
> > > mirrored. The Bootlogo is top/right instead of top/left and the ascii
> > > output starts from right to left.
> > >
> > > Where is the right place to modify this behaviour?
> > > I'm also looking for a possibility to rotate the picture.
> > > Because my videocontroller can emulate 15 grayscales, i'm useing 4bpp.
> > >
> > > It would be very nice, if someone can guide me in the right direction.
> >
> > Are you using fbcon-cfb4.c to draw the characters?  Is the whole display
> > mirrored, including individual characters?  If you run an fb-based app
> > (like fbtest for instance), is the display also mirrored?
> 
> Yes,  i'm using fbon-cfb4.c. The console is on my display, i see the boot logo 
> and the kernel messages in the display mirrored. I never used fbtest. By the 
> way, where can i find fbtest? But i already startet nanox/microwindows on top 
Check one of the links in www.linux-fbdev.org.

> of the fb, and the picture is also mirrored.  
> 
Ouch, your user apps are also mirrored :-(

> > If it's the whole display, maybe your hardware supports mirroring (some
> > hardware with video overlay need this to support YUV formats that are
> > either vertically or horizontally mirrored).  Maybe it has something
> > like that.  Otherwise, it will be difficult to correct this without
> > rewriting practically everything.
> 
> No, i don't think so. It is a simple video controller. Nevertheless, i have 
> just looked in the datasheet, and do not found such a feature. 
> 
> I don't think that this is a bug or something like this in the framebuffer. 
> Because everthing works like i exect it, but i have to mirror the picture.
No, I never said this was a bug.  Mirroring is a hardware feature
occasionally useful such as for mirrored mpegs.  

> I have also measured with a scope all signals to the display, and the 
> generated output looks like i expect it. The datastream starts with the first 
> pixel (in the picture top/left) and continues with the second pixel (on the 
> right of the first pixel) and so on.
> But my display is mapping this datastream from the right to the left.
This is the problem.  You are writing each byte in the correct location
in the framebuffer, but somehow it gets shown in the "mirrored" location
of your display.

> Please take a look on the attached picture, i think it explains the behaviour.
> I can reproduce it without Linux with a simple monitor programm
> 
> At the moment i have two explanations:
> 1) I have a display witch must be accessed unusual, and the LINUX FB doesn't
>     support this kind of access (not yet).
> 2) There is a hardware problem with the signals to the display (changed 
>    signals like frame-pulse, and line-pulse, or something like this.
> 
> I don't think that it is a hardware problem, but i will check the connection 
> again. Is there really no way in the framebuffer to mirror and/or rotate the 
> picture data?
> When i have to fix it in software, what kind of code do i have to rewrite? 

Fixing the console is feasible enough though it entails a lot of work.
You have to rewrite all the functions in fbcon-cfb4.c so you go
"right->left" instead of "left->right".  Do the same thing to
fbcon_show_logo() in fbcon.c, and fb_read/fb_write in fbmem.c.

Fixing user apps, that's the tough part. The framebuffer API is not
something like XAA which has specific hooks for filling, copying,
expanding, etc an area of pixels to the framebuffer.  All the
framebuffer API provides are two ways to access the graphics memory
(similar to a watered-down version of X's DGA):

1. The standard file read/file write which will be intercepted by
fb_read and fb_write; and

2. mmap 

Of the 2, mmap is usually chosen by user apps because it's simple and
fast.  The disadvantage is that your driver has no control on what will
get displayed, and there is no feasible solution to this, except to
disable mmap by setting fb_fix_screeninfo.smem_len to zero. Hopefully,
if mmap is not possible, they will fall back to using file read and file
write.

User apps will always assume that the first pixel written to the
framebuffer will appear as the first pixel of the first scanline of your
display.  Meaning, for apps that will always use mmap, you have to
rewrite them so they raster "right->left" instead of "left->right".

If you think about it, a hardware solution seems to be more feasible.

Tony




-------------------------------------------------------
This sf.net email is sponsored by:
With Great Power, Comes Great Responsibility 
Learn to use your power at OSDN's High Performance Computing Channel
http://hpc.devchannel.org/
