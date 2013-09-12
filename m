From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Thu, 12 Sep 2013 15:56:09 +0000
Subject: Re: [PATCH v2 1/2] video: ARM CLCD: Add DT support
Message-Id: <20130912155609.GO12758@n2100.arm.linux.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1378808726-32535-1-git-send-email-pawel.moll@arm.com>
 <522F57B9.5000001@wwwdotorg.org> <1378899931.4082.75.camel@hornet>
 <5230AAEB.2030607@wwwdotorg.org> <1378991033.13571.33.camel@hornet>
 <5231D5FA.4060508@wwwdotorg.org>
In-Reply-To: <5231D5FA.4060508@wwwdotorg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, Sep 12, 2013 at 08:55:54AM -0600, Stephen Warren wrote:
> On 09/12/2013 07:03 AM, Pawel Moll wrote:
> > Ok, so I'll make it a arm,pl11x,specific property. Actually two
> > properties - one bit I missed was the dual STN panel case, where they
> > have separate frame buffers. Something along the lines of:
> > 
> > Optional:
> > 
> > - arm,pl11x,framebuffer-base: a pair of two values, address and size,
> > 				defining the framebuffer for the upper
> > 				(or the only one) panel
> > - arm,pl11x,lower-framebuffer-base: as above, for the lower STN panel,
> > 					when present
> > 
> > Being very hardware-specific, it covers all possible quirky scenarios,
> > at the same time does not exclude the option of using the CMA region
> > phandles, if a particular system needed it.
> 
> What do "upper" and "lower" mean in this context? I assume this somehow
> refers to placement of the displays on the board.

CLCD is only one controller - it can only produce one image from one
framebuffer.

What this refers to is a requirement for dual STN displays - rather
than starting at one corner and working logically to the opposite
corner, these start at one corner and half way through the display at
the same time.  So you scan out the upper half of the image at the
same time that you scan out the lower half of the image.

In order to give an image on the display where the conventional formula
works:

	address = start + y * bytes_per_line + x * bits_per_pixel / 8

this means that the "upper" and "lower" start addresses are related to
the parameters of the display - you want the lower half to start at
the address where y = panel_y_res / 2 and x = 0.

You may also wish to change the start address (if you have enough RAM)
to support page flipping - where you switch between two framebuffers -
one which is currently being displayed while the other is being updated
by the CPU.  You would use this to provide smooth video playback for
example.

So, DT has no business directly encoding this information - it should
be calculated from the information provided by the panel and the
timings required, and all that the CLCD driver should know is that
"we have this RAM which starts here, and extends for N bytes" - or
to use system memory instead.
