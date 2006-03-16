From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: Framebuffer questions
Date: Thu, 16 Mar 2006 09:20:42 +0800
Message-ID: <4418BD6A.9080600@gmail.com>
References: <20060315211022.GA4474@localhost.localdomain>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FJhaP-0000BY-9Y
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 15 Mar 2006 17:47:33 -0800
Received: from pproxy.gmail.com ([64.233.166.183])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FJhaP-0004Fe-2O
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 15 Mar 2006 17:47:33 -0800
Received: by pproxy.gmail.com with SMTP id z59so265970pyg
        for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 15 Mar 2006 17:47:32 -0800 (PST)
In-Reply-To: <20060315211022.GA4474@localhost.localdomain>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: santiago@mail.cz

Ondrej Zajicek wrote:
> Hello
> 
> I have several questions about fbdev. I already read FB-FAQ, most docs
> in Documentation/fb/*, linux/fb.h and some messages in archive of this
> mailing list.
> 
> - I understood that if i want to change videomode then i should set
>   all items in struct fb_var_screeninfo, call ioctl FBIOPUT_VSCREENINFO,
>   driver considers wanted parameters and if exactly this mode or mode
>   with more bits_per_pixel or greater some bitfield.length is supported,
>   then mode is changed, otherwise change is rejected. If change is
>   successfull, then i should call ioctl FBIOGET_VSCREENINFO and
>   FBIOGET_FSCREENINFO to get information about real framebuffer
>   structure. Is this correct?

Yes but with exceptions.  For drivers with fixed modes, ie, vesafb, it
will always return the current fb_var_screeninfo whether the values
are greater/lesser than requested.

It is also possible that some of the fields are automatically set by the
driver, ie if requesting bits_per_pixel = 16, the rgba lengths and offsets
may automatically be set.

> 
> - Should i really set all fields? For example offset and msb_right
>   parts of red, green, blue and transp. I usually don't care of this
>   so i want to set some DONT_CARE value. Or are these items always
>   ignored so i needn't set anything?

Some of the fields are ignored, but you can never know which. To be on the
safe side, just get the current fb_var_screeninfo, use that as your
template, change the fields you want to change then pass it back to the
driver.

>   
> - If i have to supply complete mode timings for videomode change
>   why there is modedb.c and mode lines stored inside drivers?

Usually, these entries are used only on startup. Some drivers support
built-in internal mode tables, some use standard algo's (GTF, CVT) to
compute the mode timings. With these drivers, passing xres and yres is
usually enough. 

> 
> - I see there is FB_TYPE_TEXT mode (assume for standard text mode).
>   what should i set in struct fb_var_screeninfo to get this mode?
>   If i grep drivers/video for it, i get it occurs only in vga16fb.
>   Is there some deep reason for this or just programmers of other
>   fb drivers don't care about text mode?

This particular flag means that the driver is in text mode (ie, not
in graphics mode).  One driver, matroxfb in 2.4, has this functionality 
(by setting bits_per_pixel = 0), the driver goes to text mode (ie
vgacon like mode).

No driver implements this in 2.6 though, although we have the infra-
structure for this.

>   
> - Is there some possibility to get list of possible framebuffer
>   videomodes?

Hard to say with the display mode.  You can examine

/sys/class/graphics/fb[x]/modes

for a subset of modes supported.

>   Or just list of possible 'structural' framebuffer
>   configurations (type,visual,bpp,r/g/b)? (i hope that usually this is
>   ortogonal to resolution and timings setting - suppose have enough ram).
>   I know about FB_ACTIVATE_TEST but use iterative binary search to
>   find all video modes isn't sane idea :-)

No list.  But it shouldn't be too hard.  You only need get the  current
fb_var_screeninfo and only change bits_per_pixel most of the time to do
the search. Some drivers also examine green.length (ie if bits_per_pixel = 
16 and green.length is 5, RGB555, if 6, RGB565).

> 
> - Is there description of fb sysfs interface anywhere? 

None yet, it's still in a state of flux. Most of the entries
there though are counterparts of the fields in fb_var_sreeninfo and
a few are nonfunctional.

> 
> - Is there description of specific framebuffer formats for
>   various FB_TYPE_* and FB_AUX_*  anywhere?

None, except the comments in fb.h.  Most of the entries there
are for drivers that support nonlinear formats, and FB_AUX_ tells
you the type of interleaving for interleaved planes.  Only a few drivers
set these flags (amifb, atafb (broken in 2.6), vga16fb and matroxfb).

> 
> - I found that with vga16fb i can access just first plane.
>   Is it possible to switch planes from userspace and without
>   interaction with VGA registers?

I don't think so.  But you can set vga16fb for 8-bit linear format.

> 
> - What exactly is supposed to do FB_SYNC_BROADCAST ?
> 

Use standard TV timings.

> - In include/fb.h there is:
> 
> #define FB_VISUAL_PSEUDOCOLOR           3       /* Pseudo color (like atari) */
> 
>   Is there some deep sense in remark '(like atari)' or is this well-known
>   basic palette visual mode?
> 

No, it's not specific to atari, this is your basic indexed mode.

Tony


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
