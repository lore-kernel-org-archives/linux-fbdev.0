From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Thu, 12 Sep 2013 22:38:37 +0000
Subject: Re: [PATCH 1/2] video: ARM CLCD: Add DT support
Message-Id: <20130912223837.GS12758@n2100.arm.linux.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1378488201-21146-1-git-send-email-pawel.moll@arm.com>
 <522BAED9.4020301@gmail.com> <1378725559.4082.28.camel@hornet>
 <522F91F8.6010207@gmail.com> <1378907036.4082.105.camel@hornet>
 <5230DD1C.6060606@gmail.com> <1378999425.13571.54.camel@hornet>
 <1379009416.13571.68.camel@hornet> <52323E01.2070902@wwwdotorg.org>
In-Reply-To: <52323E01.2070902@wwwdotorg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, Sep 12, 2013 at 04:19:45PM -0600, Stephen Warren wrote:
> On 09/12/2013 12:10 PM, Pawel Moll wrote:
> > Such approach would also solve problem with bizarre cases like the
> > Versatile's (not Express ;-) muxer Russell mentioned (where there is a
> > de-facto custom wiring used). And no, I had a look at pinmux bindings
> > and I don't think they fit here at all...
> > 
> > Thoughts?
> 
> I think pinctrl would work just fine here. However, I suspect there's
> little need for pinctrl. pinctrl is required when one module may impose
> requirements on another module's muxable pins. I assume that the
> configuration for pins on CLCD is only relevant for CLCD itself, so
> there's no need to export an interface by which something else can
> configure the pins.

Well, the hardware is much like this:

CLCD ---> Mux ---> output

and the mux is controlled by a register, and will manipulate the output
from the CLCD controller such that the framebuffer contents can be
RGB565, BGR565, XRGB1555, XBGR1555 or RGB888.

(Actually, the Versatile mux can only support one of the 1555 formats,
but I forget which it is.)

I'm not sure that its worth describing all these in DT explicitly, but
maybe encoding it as a special "versatile" version of the CLCD primecell
instead - especially as the external mux takes care of the colour
component order rather than the CLCD controller (and that requires a
bit of board specific code to deal with.)
