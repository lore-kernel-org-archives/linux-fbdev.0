From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: "remap_page_range" i810 compile time problem ..
Date: Fri, 11 Mar 2005 19:05:26 +0800
Message-ID: <200503111905.27355.adaplas@hotpop.com>
References: <4EE0CBA31942E547B99B3D4BFAB348113A49D2@mail.esn.co.in>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
In-Reply-To: <4EE0CBA31942E547B99B3D4BFAB348113A49D2@mail.esn.co.in>
Content-Disposition: inline
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
To: linux-fbdev-devel@lists.sourceforge.net, "Mukund JB." <mukundjb@esntechnologies.co.in>, adaplas@pol.net, linux-fbdev-users@lists.sourceforge.net

On Friday 11 March 2005 14:36, Mukund JB. wrote:
> Hi adaplas,
>
> Thankful to u for making things clear at every level.
>
> > > But when I try this without accel=1 rotation fails. Can u just
>
> narrate
>
> > > me what is accel accentually doing?
> >
> > Because if accel is on, the driver is using it's own version of
>
> drawing
>
> > functions which are flexible enough that additional features can be
>
> added,
>
> > such as screen rotation.
> >
> > If accel is off, the driver will use the generic functions which
>
> cannot do
>
> > screen rotation.  Of course, one can write a software version that can
>
> do
>
> > screen rotation.
>
> So, u mean the i810fb driver will process the command line parameters &
> if finds the accel is "1" in the list, it will use its own functions or
> else it will use the generic functions provided in the fbgen.c file.

Above is correct, except that i810fb, if accel is disabled will use the
functions in fbcon-cfb*.c, not fbgen.c.

>
> This is my understanding about fb driver architecture
>
> 			Application
> 			-----------
> 		  XFree86 / Directfb (Embedded)
> 			-----------
> 			 FB driver
> 			-----------
> 			 HARDWARE
>
> Are these files below a part of fb driver or do they come under a
> different level in fb driver architecture?

The above is correct, assuming that XFree86 uses the 'fbdev' driver.

>
> fbcon.c - low level framebuffer based console driver
> fbcon-cfb* - low level framebuffer based operations for 8 bpp packed
> pixels
> How do I differentiate between the above two?

fbcon.c is the glue between console and fbdev.  fbcon-cfb* contains
generic drawing functions for framebuffers with packed pixel format.

>
> fbcmap.c 	- It handles color mapping
> fbcon-plan2p*
>
> I find fbdevhw.a & I find groups referring to it.

fbdevhw, if I'm not mistaken, came from XFree86/Xorg.  It contains
helper functions used by XFree86 to talk to fbdev.

> I think it is a library. If so, give me some inputs where we can use it.
> Please do correct if I am going OFF-TRACK understanding FB drivers.
>
> Where exactly should I place the fbdevhw.a in the above shown
> architecture?

Probably between  XFree86 and fbdev.

Tony





-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
