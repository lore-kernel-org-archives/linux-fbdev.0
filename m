From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: [Linux-fbdev-users] RE: Crosstool for EBD9312..
Date: Wed, 9 Mar 2005 13:47:19 +0800
Message-ID: <200503091347.19442.adaplas@hotpop.com>
References: <4EE0CBA31942E547B99B3D4BFAB348113A4797@mail.esn.co.in>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
In-Reply-To: <4EE0CBA31942E547B99B3D4BFAB348113A4797@mail.esn.co.in>
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
To: linux-fbdev-users@lists.sourceforge.net, "Mukund JB." <mukundjb@esntechnologies.co.in>, linux-fbdev-devel@lists.sourceforge.net
Cc: geert@linux-m68k.org, Michael Burian <dynmail1@gassner-waagen.at>, komal_shah802003@yahoo.com

On Monday 07 March 2005 21:36, Mukund JB. wrote:
> Hi all,
>
> I also have a doubt regarding Accelarated Display driver.
> Would u define an Accelerated display driver?

An accelerated driver means that most of the drawing is done by
the GPU (the processor of the graphics card) while an unaccelerated driver
implies that drawing is done by the main CPU.

>
> Is it the driver to a Accelerated display card?

The driver is implementing the features of the card.

>
> 			Or
>
> Is it like accelerated display driver has a different meaning. I mean,
> it has the set features which will not be there on a normal driver for
> the same card?
>

The effect of software versus accelerated is the same.  The main difference
is that the GPU does the work if accelerated, the CPU if not.  And the CPU
version will be slower because it has to do other work besides drawing, and
the data that is processed by the CPU has to go to and from the bus.  The
GPU has no such constraints.

> How can I implement a accelerated driver?

You need to know the details of the particular chipset you are working on.

> Can I use the existing code of a framebuffer driver & do that? I heard

Yes, if the framebuffer driver implements console acceleration.

> in the groups saying framebuffer driver is not an accelerated driver.
>

Yes, the framebuffer driver only implements acceleration for the console.

> Please take the pain of explaining how a framebuffer driver is different
> form accelerated driver?

Essentially, a framebuffer driver only exposes the video memory to its
clients, period.  You can read from or write to this memory, but you have
to use the CPU to do this.  In order to implement acceleration, you need
to know how to talk to the GPU.

Tony




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
