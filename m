From: Andrew Clunis <orospakr@orospakr.is-a-geek.org>
Subject: Re: Virtual Framebuffer on UM
Date: Sat, 10 Jul 2004 23:46:24 -0400
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1089517584.3234.38.camel@localhost>
References: <1089438322.3195.126.camel@localhost>
	 <Pine.GSO.4.58.0407101646170.10242@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BjVIS-0005nX-FK
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 10 Jul 2004 20:46:36 -0700
Received: from nasc-out-2.nasc.inter.net ([203.176.60.254] helo=app5.nasc.inter.net)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1BjVIR-0004hm-UX
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 10 Jul 2004 20:46:36 -0700
In-Reply-To: <Pine.GSO.4.58.0407101646170.10242@waterleaf.sonytel.be>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-fbdev-devel@lists.sourceforge.net

On Sat, 2004-07-10 at 11:05, Geert Uytterhoeven wrote: 

> What does `fbset -i' say about the length of the frame buffer?

root@darkstar:~# fbset -i

mode "640x400-70"
    # D: 25.176 MHz, H: 31.469 kHz, V: 69.932 Hz
    geometry 640 400 640 400 8
    timings 39721 40 24 39 9 96 2
    rgba 8/0,8/0,8/0,0/0
endmode

Frame buffer device information:
    Name        : Virtual FB
    Address     : (nil)
    Size        : 0
    Type        : PACKED PIXELS
    Visual      : PSEUDOCOLOR
    XPanStep    : 1
    YPanStep    : 1
    YWrapStep   : 1
    LineLength  : 0
    Accelerator : No

Hm. No address or size. That does not look right.  However, I performed
a quick experiment to see if it was in fact UML and/or the caching hack
that was causing this. I built a simple, standard x86 2.6.6 with vfb
enabled and booted it on my laptop with the same boot arguments, and
fbset -i returned almost exactly the same values! The *only* difference
was Address was reported as '0' rather than '(nil)'.  I guess this was
due to a slight difference in the fbset tool on my laptop and the one in
the slackware filesystem I'm using with UML.  Either I am just making a
mistake somewhere, or vfb is intended to behave this way.  Perhaps I'm
missing a step and not initialising the framebuffer all the way? :S

> > p.s. Geert, where can the source for your old GDK UM driver be found,
> > the one that had the -lpthread trouble?  I have a design that will
> > (hopefully) not have those issues, but I'm curious as to how you tackled
> > the rest of it.  (SDL itself has a -lpthread dependency, but I can get
> > around this. The graphical component of SDL does not require pthreads,
> > so as long as I don't init the audio or threading components, I should
> > be OK)
I should have been more clear here.  SDL is an simple but awesome multimedia
library.  It's at http://www.libsdl.org/.  Not only does it support 2D accel., but
it works with a plethora of platforms (it even uses DirectDraw when you use it
on win32!).  Only problem with it is it indeed uses -lpthread, but I have a number
of tricks that could be used to get around that (I list them below).
> 
> I never finished it. I started using SKAS mode (in that case UML is dynamically
> linked instead of statically, and libX11 doesn't need libpthread) and managed
> to get something to work. IIRC at one moment of time even fbtest worked a bit.

Interesting.  The -lpthread overriding weirdness will not jump across
from a shared lib linked against pthread? 

I have actually been through a couple of attempts at this project over
the last few months I am glad I have not been totally barking up the
wrong tree. ;).  I have tried a number of tricks such as adding pthread
stubs to the kernel, POSIX shared memory, and writing a shared library
as an intermediary.

This time around I'm just been starting from the basics again, which is
why I'm bothering to make sure basic fb subsystem and vfb are working
properly before I attack anything else again. :P

> However, when trying to get the logo and a real frame buffer console, I got
> stuck in the conflicts between the standard virtual console subsystem and the
> UML virtual consoles. With Gerd Knorr's recent patches for a special stderr
> console, you can probably solve (a few of) these conflicts.
> 
Could I just build UML without the stdio console support?  If the UML
framebuffer works properly with fbcon, then we don't really need the stdio
console anyway.  SDL can handle keyboard and mouse input as well, and I will
eventually add input support to my driver. Maybe. A good excuse to learn the
Linux input system, anyway. ;)
> 
> What I had in mind:
>   - Split gdkfb in a kernel (gdkfb_kern) part that talks fbdev, and a user
>     (gdkfb_user) part that takes care of X/GDK/GTK,
>   - Use a ring buffer for transfering drawing commands (from fbcon) between the
>     two parts [not yet implemented],
>   - Use a separate thread to periodically update the screen contents if the
>     user has mmap()ed the virtual frame buffer [not yet implemented].

argh! I had not thought of that... I wonder if there is some hack I
could do to make it more efficient that just polling. yuck. Oh well. I
think I am going to focus on getting a picture out of the thing first.
;)

Oh, one last dumb question.  Are the acceleration imgblit, cpyrect, etc.
functions in the drivers used by the fbcon system only and can't be
leveraged by userspace things like an X11 fbdev driver?  Because if that
is so I am probably just going to use the cfb* functions for now.

> Anyway, here's the patch for my current work. Note that it includes 2 versions
> of gdkfb and that you have to append `gdkfb' or `gdkfb2' to the kernel command
> line to make it initialize gdkfb or gdkfb2.
> 
> Good luck!
Thanks again! :D 

Are you going to OLS next week?  It would be awesome to meet you and perhaps pick
your brain some more. ;)

> 
> Gr{oetje,eeting}s,
> 
> 						Geert


-- 
Regards,
Andrew Clunis

http://orospakr.is-a-geek.org/



-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
