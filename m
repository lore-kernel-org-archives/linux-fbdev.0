From: Pawel Moll <pawel.moll@arm.com>
Date: Thu, 12 Sep 2013 15:26:21 +0000
Subject: Re: [PATCH v2 1/2] video: ARM CLCD: Add DT support
Message-Id: <1378999581.13571.57.camel@hornet>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1378808726-32535-1-git-send-email-pawel.moll@arm.com>
 <522F57B9.5000001@wwwdotorg.org> <1378899931.4082.75.camel@hornet>
 <5230AAEB.2030607@wwwdotorg.org> <1378991033.13571.33.camel@hornet>
 <5231D5FA.4060508@wwwdotorg.org>
In-Reply-To: <5231D5FA.4060508@wwwdotorg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

On Thu, 2013-09-12 at 15:55 +0100, Stephen Warren wrote:
> > Ok, so I'll make it a arm,pl11x,specific property. Actually two
> > properties - one bit I missed was the dual STN panel case, where they
> > have separate frame buffers. Something along the lines of:
> >=20
> > Optional:
> >=20
> > - arm,pl11x,framebuffer-base: a pair of two values, address and size,
> > 				defining the framebuffer for the upper
> > 				(or the only one) panel
> > - arm,pl11x,lower-framebuffer-base: as above, for the lower STN panel,
> > 					when present
> >=20
> > Being very hardware-specific, it covers all possible quirky scenarios,
> > at the same time does not exclude the option of using the CMA region
> > phandles, if a particular system needed it.
>=20
> What do "upper" and "lower" mean in this context? I assume this somehow
> refers to placement of the displays on the board. If so, it sounds like
> there should be some better terminology; something that's specific to
> the CLCD controller itself,

It is very CLCD specific indeed and nothing to do with the board :-)

http://arminfo.emea.arm.com/help/topic/com.arm.doc.ddi0293c/I899134.html

"Upper and Lower Panel Frame Base Address Registers".

>  rather than the environment it's used in.
> Aalthough it does sound like this is in an FPGA and hence the controller
> is board-specific, but I don't see why it couldn't be re-used in some
> other FPGA-based board with different panel layout. Would "A" and "B" or
> "main" and "primary" or "first" and "second" work better?

Funnily enough I typed "secondary-framebuffer-base" first, but than
thought "no, let's match the spec" :-)

Pawe=C5=82


