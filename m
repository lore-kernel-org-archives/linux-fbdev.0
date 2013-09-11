From: Pawel Moll <pawel.moll@arm.com>
Date: Wed, 11 Sep 2013 13:43:56 +0000
Subject: Re: [PATCH 1/2] video: ARM CLCD: Add DT support
Message-Id: <1378907036.4082.105.camel@hornet>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1378488201-21146-1-git-send-email-pawel.moll@arm.com>
 <522BAED9.4020301@gmail.com> <1378725559.4082.28.camel@hornet>
 <522F91F8.6010207@gmail.com>
In-Reply-To: <522F91F8.6010207@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

On Tue, 2013-09-10 at 22:41 +0100, Sylwester Nawrocki wrote:
> On 09/09/2013 01:19 PM, Pawel Moll wrote:
> > On Sat, 2013-09-07 at 23:55 +0100, Sylwester Nawrocki wrote:
> >> H --- /dev/null
> >>> +++ b/Documentation/devicetree/bindings/video/arm,pl11x.txt
> >>> @@ -0,0 +1,87 @@
> >>> +* ARM PrimeCell Color LCD Controller (CLCD) PL110/PL111
> >>
> >> nit: Shouldn't the abbreviation be CLCDC ?
> >
> > The commonly used acronym for this cell is CLCD. For what its worth, I
> > can make the line read:
> >
> > ARM PrimeCell Color LCD (CLCD) Controller PL110/PL111
>=20
> OK, that's probably better. A meaningless detail, I've just seen mostly
> CLCDC used in the PL100/PL111 TRM and LCDC would presumably be more=20
> intuitive
> for this type of IP block.

I think I'll completely remove the acronym. No intuition will be
necessary then :-)

> >>> +- video-ram: phandle to a node describing specialized video memory
> >>> +		(that is *not* described in the top level "memory" node)
> >>> +                that must be used as a framebuffer, eg. due to restr=
ictions
> >>> +		of the system interconnect; the node must contain a
> >>> +		standard reg property describing the address and the size
> >>> +		of the memory area
> >>
> >> It seems the "specialized video memory" is described by some vendor sp=
ecific
> >> DT binding ? Is it documented ? It sounds like you are unnecessarily
> >> repeating the memory node details here.
> >
> > I appreciate this property being the hardest to swallow, but the problem
> > it is trying to solve is quite simple, really. System can be designed in
> > such a way that CLCD is *not* able to read data from the main memory. In
> > such case there will be a separate block of (usually static) memory
> > "next" to CLCD, which *must* be used for the framebuffer. And I've got
> > two choices here: to simply define an address and size, or to define a
> > phandle to a node with standard reg property. I'll be really grateful
> > for ideas how to describe the situation better.
>=20
> I though about reusing the binding only, the part defining reserved
> (carve out) memory regions.

Em, what exactly do you mean? Referring to the definition of "reserved
memory region" as an example how to use reg =3D <(address) (size)>?
(because, I don't think it can be  "linux,contiguous-memory-region",
"reserved-memory-region"). Can do, however I'm not sure if it won't
cause even more confusion, as I hope that the CMA bindings will be
useful here on their own, to allocate "normal" contiguous framebuffers.
Keep in mind those two use cases are very very different.

> >> Perhaps this binding/driver should use the common reserved memory bind=
ings,
> >> see thread http://www.spinics.net/lists/devicetree/msg02880.html
> >
> > No, not really - as I said, this is *not* the main RAM of the system.
> > CMA doesn't even know about its existence.
>=20
> I'm really not an expert in this area, I'll assume we don't list such
> separate memory chips in the 'memory' node.

ePAPR spec, regarding the memory node, states: "The client program may
access memory not covered by any memory reservations (see section 8.3)
using any storage attributes it chooses." (note that the reservations
mentioned are "the other" reservations, /memreserve/ ones ;-)

Now, I wouldn't want my "client program" (read: Linux kernel) to use the
"video memory" in question for general allocations, if only because of
its rather poor performance (resulting from the interconnect design, not
the memory chip characteristics), so I treat it more as a memory mapped
device which happens to have a lot of word-long registers...

> But if such memory could be used not only by this single IP block it would
> probably make sense to have it listed in memory/reserved-memory, so it=20
> could be used by other devices of which drivers possibly wouldn't have to
> contain all the detailed dt parsing/memory handling code.

The "video RAM" on my platform could be used for other purposes. If you
don't mind latencies :-) It's just that the CLCD itself can't use
anything else.

So, if the memory/reserved-memory described areas *not* to be used as
"normal RAM", yes - we could use it. I don't think it's the case now,
though.

Also, Steven mentioned the other option I talked about - just raw
address/size pair. See me deliberation there...

> >>> +- panel-dimensions: (optional) array of two numbers (width and heigh=
t)
> >>> +			describing physical dimension in mm of the panel
> >>> +- panel-type: (required) must be "tft" or "stn", defines panel type
> >>> +- panel-tft-interface: (for "tft" panel type) array of 3 numbers def=
ining
> >>> +			widths in bits of the R, G and B components
> >>> +- panel-tft-rb-swapped: (for "tft" panel type) if present means that
> >>> +			the R&   B components are swapped on the board
> >>> +- panel-stn-color: (for "stn" panel type) if present means that
> >>> +			the panel is a colour STN display, if missing
> >>> +			is a monochrome display
> >>> +- panel-stn-dual: (for "stn" panel type) if present means that there
> >>> +			are two STN displays connected
> >>> +- panel-stn-4bit: (for monochrome "stn" panel) if present means
> >>> +			that the monochrome display is connected
> >>> +			via 4 bit-wide interface
> >>
> >> Are this vendor specific or common properties ? Shouldn't those be pre=
fixed
> >> with the vendor name ?
> >
> > I have no answer to this question. My guts are telling me - nope. TFT is
> > TFT, STN is STN, nothing to do with "arm,". But I welcome other
> > opinions.
>=20
> I thought about documenting such a common properties in a common place.=20
>   It's
> not immediately clear from names of these properties that they apply to=20
> PL110/
> PL111 devices only.  If we let such generic names being redefined across =
DT
> bindings of different devices it is going to be pretty messy IMHO.  Same
> property in two different dts files would potentially have different=20
> meaning.
>=20
> So perhaps instead of panel-dimensions we could define common=20
> properties, e.g.
>=20
>   - display-phys-width: physical horizontal dimension of a display in=20
> millimetres
>                         (micrometres ?);
>   - display-phys-height: physical vertical dimension of a display in=20
> millimetres
>                         (micrometres ?);
>=20
> Instead of 'panel-stn-color' a boolean property 'monochrome-display',=20
> the default
> when this property was missing would be "colour display".
>=20
> I'd like to leave defining such common properties to someone having more =

> experience
> in the display area.  I don't think it would take much time come up with =

> generic
> names for that couple properties you need.  Then CDF implementation=20
> would simply use whatever gets agreed.

Ok, I see what you're saying. Yes, this could be done. No, I don't claim
to have enough expertise either (micrometers??? :-O ;-) The other thing
is that I don't really expect generic CDF bindings to cover such things.
They will (hopefully) only describe what's connected with what. And the
drivers should know how. Of course they may need the dimensions & alike
in the tree (of course having them standardised would help here), but
it's not a CDF job to provide those.

Anyway, if I decide to split the panel data into a separate sub-node,
I'll look into that.

Pawe=C5=82


