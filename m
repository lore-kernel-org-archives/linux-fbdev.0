From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Virtual Framebuffer on UM
Date: Sun, 11 Jul 2004 10:01:59 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.58.0407110953060.3013@waterleaf.sonytel.be>
References: <1089438322.3195.126.camel@localhost>
 <Pine.GSO.4.58.0407101646170.10242@waterleaf.sonytel.be>
 <1089517584.3234.38.camel@localhost>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BjZHe-0008GD-TR
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 11 Jul 2004 01:02:02 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1BjZHe-0006tP-6C
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 11 Jul 2004 01:02:02 -0700
In-Reply-To: <1089517584.3234.38.camel@localhost>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Clunis <orospakr@orospakr.is-a-geek.org>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Sat, 10 Jul 2004, Andrew Clunis wrote:
> On Sat, 2004-07-10 at 11:05, Geert Uytterhoeven wrote:
> > What does `fbset -i' say about the length of the frame buffer?
>
> root@darkstar:~# fbset -i
>
> mode "640x400-70"
>     # D: 25.176 MHz, H: 31.469 kHz, V: 69.932 Hz
>     geometry 640 400 640 400 8
>     timings 39721 40 24 39 9 96 2
>     rgba 8/0,8/0,8/0,0/0
> endmode
>
> Frame buffer device information:
>     Name        : Virtual FB
>     Address     : (nil)
>     Size        : 0
>     Type        : PACKED PIXELS
>     Visual      : PSEUDOCOLOR
>     XPanStep    : 1
>     YPanStep    : 1
>     YWrapStep   : 1
>     LineLength  : 0
>     Accelerator : No
>
> Hm. No address or size. That does not look right.  However, I performed
> a quick experiment to see if it was in fact UML and/or the caching hack
> that was causing this. I built a simple, standard x86 2.6.6 with vfb
> enabled and booted it on my laptop with the same boot arguments, and
> fbset -i returned almost exactly the same values! The *only* difference
> was Address was reported as '0' rather than '(nil)'.  I guess this was
> due to a slight difference in the fbset tool on my laptop and the one in

Different C library, I guess.

> the slackware filesystem I'm using with UML.  Either I am just making a
> mistake somewhere, or vfb is intended to behave this way.  Perhaps I'm
> missing a step and not initialising the framebuffer all the way? :S

Yep, smem_len is 0 on purpose, since accessing vfb from userspace definitely
doesn't work on real hardware due to the vmalloc()ed frame buffer.
On UML it may work, you can try changing smem_len.

> > I never finished it. I started using SKAS mode (in that case UML is dynamically
> > linked instead of statically, and libX11 doesn't need libpthread) and managed
> > to get something to work. IIRC at one moment of time even fbtest worked a bit.
>
> Interesting.  The -lpthread overriding weirdness will not jump across
> from a shared lib linked against pthread?

Apparently not.

> > However, when trying to get the logo and a real frame buffer console, I got
> > stuck in the conflicts between the standard virtual console subsystem and the
> > UML virtual consoles. With Gerd Knorr's recent patches for a special stderr
> > console, you can probably solve (a few of) these conflicts.
> >
> Could I just build UML without the stdio console support?  If the UML
> framebuffer works properly with fbcon, then we don't really need the stdio
> console anyway.  SDL can handle keyboard and mouse input as well, and I will
> eventually add input support to my driver. Maybe. A good excuse to learn the
> Linux input system, anyway. ;)

Yes, you can disable the stdio console. But then you couldn't see kernel
messages nor login, which is annoying for debugging :-(
Mileage may vary after Gerd's patches.

> > What I had in mind:
> >   - Split gdkfb in a kernel (gdkfb_kern) part that talks fbdev, and a user
> >     (gdkfb_user) part that takes care of X/GDK/GTK,
> >   - Use a ring buffer for transfering drawing commands (from fbcon) between the
> >     two parts [not yet implemented],

In a first version these commands would just be `update this region'.
Later we can add mode change (resize GTK window), etc...

> >   - Use a separate thread to periodically update the screen contents if the
> >     user has mmap()ed the virtual frame buffer [not yet implemented].
>
> argh! I had not thought of that... I wonder if there is some hack I
> could do to make it more efficient that just polling. yuck. Oh well. I
> think I am going to focus on getting a picture out of the thing first.
> ;)

Map the frame buffer read-only, and trap writes. But to make this efficient,
and not redraw on every single byte that's changed, you probably need something
like this in your trap handler:
  - make everything writeable
  - schedule refresh in x jiffies

and in the scheduled refresh:
  - refresh screen
  - make everything read-only again

> Oh, one last dumb question.  Are the acceleration imgblit, cpyrect, etc.
> functions in the drivers used by the fbcon system only and can't be
> leveraged by userspace things like an X11 fbdev driver?  Because if that
> is so I am probably just going to use the cfb* functions for now.

The acceleration routines can be used inside the kernel (i.e. fbcon) only. If
they would work from user space we wouldn't need the periodic thread or so.

Hmm, one more reason to add sending of those commands to the fbdev core using
writev(). Then the app (e.g. X) can keep a shadow buffer and send the
appropriate commands to update the screen. Would solve non-standard frame
buffer layouts as well, since the app doesn't need to care anymore (imgblit
always uses cfb).

> Are you going to OLS next week?  It would be awesome to meet you and perhaps pick
> your brain some more. ;)

Yes I will! CU!

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
