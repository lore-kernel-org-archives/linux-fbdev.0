From: Pawel Moll <pawel.moll@arm.com>
Date: Tue, 17 Sep 2013 16:36:39 +0000
Subject: Re: [PATCH v3 1/2] video: ARM CLCD: Add DT support
Message-Id: <1379435799.9205.16.camel@hornet>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1379351934-25415-1-git-send-email-pawel.moll@arm.com>
 <52376180.1090001@wwwdotorg.org>
In-Reply-To: <52376180.1090001@wwwdotorg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

On Mon, 2013-09-16 at 20:52 +0100, Stephen Warren wrote:
> I think the binding should either always use names as the key, or use
> indices in interrupts as the key. Hence, I'd word that more like:
>=20
> - interrupt-names: either the single entry "combined" representing a
> 			combined interrupt output (CLCDINTR), or the
> 			four entries "mbe", "vcomp", "lnbu", "fuf"
> 			representing the individual CLCDMBEINTR,
> 			CLCDVCOMPINTR, CLCDLNBUINTR, CLCDFUFINTR
> 			interrupts.
> - interrupts: contains an interrupt specifier for each entry in
> 		 interrupt-names.

Cool, works for me.

> > +- arm,pl11x,panel-data-pads: array of 24 cells, each of them describing
> > +				a function of one of the CLD pads,
> > +				starting from 0 up to 23; each pad can
> > +				be described by one of the following values:
> > +	- 0: reserved (not connected)
> > +	- 0x100-0x107: color upper STN panel data 0 to 7
> ...
>=20
> I assume those are the raw values that go into the HW?
>=20
> > +				Example sets of values for standard
> > +				panel interfaces:
> > +	- PL110 single colour STN panel:
> > +			<0x107 0x106 0x105 0x104 0x103 0x102 0x101 0x100>,
> > +			<0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0>;
>=20
> The indentation of the introductory text seems a little odd.=20

It follows the first paragraph of this property description. But I may
re-format all this stuff. Really looking forward some the formal
syntax :-)

> Do we really need so many examples?

They cover all standard cases. If I was to write a tree for a new
platform not knowing anything about CLCD, I think I'd appreciate this
and don't believe this extra kB or two is a problem. Do you?

> > +Optional properties:
> > +
> > +- arm,pl11x,framebuffer-base: a pair of two values, address and size,
> > +				defining the framebuffer to be used;
> > +				to be used only if it is *not*
> > +				part of normal memory, as described
> > +				in /memory node
>=20
> If the framebuffer is part of /memory, what happens then? Is the address
> not fixed (so the HW isn't yet set up) and hence a driver should
> allocate it?

Yes, if it wants to display anything :-) And as this is a normal and
expected behaviour, I don't think it deserves a note in the
documentation. I'm open to any suggestions that would make the wording
above emphasize the "weirdness" of situations requiring the property.

Pawe=C5=82


