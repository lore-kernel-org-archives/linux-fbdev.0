From: James Simmons <jsimmons@infradead.org>
Subject: Re: [PATCH] PXA255 LCD Driver
Date: Sat, 20 Mar 2004 00:01:03 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0403192352580.14905-100000@phoenix.infradead.org>
References: <1079607908.2175.67.camel@icampbell-debian>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B4TvH-0003KK-PQ
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 19 Mar 2004 16:01:07 -0800
Received: from phoenix.infradead.org ([213.86.99.234])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1B4TvG-0002Ic-Pb
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 19 Mar 2004 16:01:07 -0800
In-Reply-To: <1079607908.2175.67.camel@icampbell-debian>
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
To: Ian Campbell <icampbell@arcom.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>



> I understand what you are saying (I think...), but I'm not sure how it
> applies to my situation -- my embedded LCD controller has no analogue
> for much of the stuff in fb_monspecs and has some extra stuff which are
> not present there.

What is it you need exactly? 

> Essentially the LCD controller<->panel interface has 16 data pins, an
> output enable, a pixel clock and (HV)sync. 

Is this the case for your setup or is this something true in general.
I like to add data fields that could be used by everyone.
 
> The settings which are of interest on a PXA255 are that aren't present
> in fb_monspecs, they specify the physical interface between the
> processor and the panel:
> 
>         active(==TFT) or passive(==STN), 
>                 These are two fundamentally different types of panel. It
>                 impacts when the pixclock ticks (all the time or just
>                 when data is present), and some other timing stuff.
>
>         output enable polarity
>                 panel is enabled on low or high
>         pixel clock polarity
>                 should the panel shift in data on a rising or a falling
>                 edge
> 	dual or single panel
>                 some STN panels are physically two panels stacked on top
>                 of each other, this impacts the way pixel data is packed
>                 onto the data lines
>         4pix or 8pix STN mono
>                 Monochrome STN panels take either 4 or 8 pixels at a
>                 time.
> 
> All of these differ from panel to panel, pretty much at the whim of the
> manufacturer...

Are these the fields you need in general?

> The other settings I think are already accounted for in the mode db:
>         resolution, bit depth, color/mono/grayscale, pixel clock, h and
>         vsync length, Left-Right-Upper-Lower margins.
> However -- all these are fixed in hardware for any given panel (although
> you could emulate different resolutions in s/w I guess).

... snip ...

> I also don't know how applicable all this is to other embedded LCD
> controllers --- the StrongArm hardware is very close to the PXA
> hardware, and I think all controllers which are as low level as them
> will share the same settings (since they are down to the hardware
> interface). I don't know for sure though.
> 
> My thinking prior to this discussion was to go for a database which maps
> LCD part # to all the settings above, where each LCD is selectable from
> Kconfig and a default can be specified (sort of like NLS now). People
> with a static panel would only build in the one database entry, people
> like me could build in a selection and choose from the command line etc
> (with overrides for all the above). 

I have thought about it. That is why I toke so long to reply. I think the 
best approach is that we create a database of struct fb_monspecs for LCD
panels. In struct fb_monspecs we have the following fields.

manufacturer[4]
monitor[14]
serial_no[14]
ascii[14]	For expansion.

We can have it so that we can pass in a monitor string that can be used to 
select the proper LCD panel in the database. How does that sound?












-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
