From: Pawel Moll <pawel.moll@arm.com>
Date: Thu, 12 Sep 2013 13:03:53 +0000
Subject: Re: [PATCH v2 1/2] video: ARM CLCD: Add DT support
Message-Id: <1378991033.13571.33.camel@hornet>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1378808726-32535-1-git-send-email-pawel.moll@arm.com>
 <522F57B9.5000001@wwwdotorg.org> <1378899931.4082.75.camel@hornet>
 <5230AAEB.2030607@wwwdotorg.org>
In-Reply-To: <5230AAEB.2030607@wwwdotorg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org


On Wed, 2013-09-11 at 18:39 +0100, Stephen Warren wrote:
> > From the core's perspective it's just a bit of extra memory, you could,
> > for example, put a MTD ram disk on it. It seems to deserve a
> > representation in the tree then.
>=20
> Yes, that's a good point. Perhaps it is reasonable to represent the
> memory somewhere then.
>=20
> I don't see why this memory couldn't exist in the regular /memory node;
> it is after all (admittedly slow) RAM. Obviously you'd want to cover the
> region with a /memreserve/ to avoid it being used just like any other
> RAM.=20

This would be pretty tricky in my particular case... The sram chip lives
on a motherboard, which lives behind a static memory interface (Chip
Select + offset). And the memreserve can only take "top level" address,
which can be different depending on the test chip (SoC) or FPGA SMM
being used.

> Perhaps the CLCD could reference the memreserve then?

How do you mean reference the memreserve? It's not a node, I don't think yo=
u can get
a phandle to it...

> Alternatively, if you want to represent the region as a regular node
> rather than a /memory entry, I'd expect there to be a binding defining
> what that node was, and the node to at least have a compatible value as
> well. I'm not sure how you would indicate that the node should be MTD
> vs. a resource for CLCD though; perhaps you'd use a different compatible
> value depending on the intended use of the memory?

Yes, that's exactly what I have now:

                psram@1,00000000 {=20
                        compatible =3D "arm,vexpress-psram", "mtd-ram";
                        reg =3D <1 0x00000000 0x02000000>;
                        bank-width =3D <4>;
                };
               =20
                vram@2,00000000 {
                        compatible =3D "arm,vexpress-vram";
                        reg =3D <2 0x00000000 0x00800000>;
                };

which allows mtd to use the psram.

> >> I'm not sure what the benefit of making this a standalone node is; why
> >> not just put the base/size directly into the video-ram property in the
> >> CLCD node?
> >=20
> > This is certainly an option. I've considered this as well, but thought
> > that the above made more sense.
> >=20
> > Having said that, there is actually a use case, although a very
> > non-probable one, for having a direct number there... The interconnect
> > that CLCD is connected to could have different mapping than the
> > processor's one. In other word, the memory seen by the core at X, could
> > be accessed by the CLCD at Y. Or, in even more quirky situation, the
> > core may not have access to the memory at all, with the graphics being
> > generated only by GPU (or any other third party). Then the value would
> > mean "the address you have to use when generating AMBA read transactions
> > to be get some meaningful data" and would have to be known explicitly.
> >=20
> > I guess it won't be hard to convince me it's a better option ;-)
>=20
> That's true. Everything in DT is currently set up to describe the CPU's
> memory map. Either we need to add some more properties to describe the
> potentially different memory map for other bus masters, and/or we should
> represent the various buses in DT, and any driver doing DMA should ask
> each bus's driver in turn to translate the core-visible address to a bus
> address so we can eventually end up with the address needed by the bus
> masters.
>=20
> That is indeed complex, and could at least in many situations simple be
> short-circuited by putting the relevant base address in each other bus
> master's own node/property. Hopefully we wouldn't get bitten by how
> non-general that could be.

Ok, so I'll make it a arm,pl11x,specific property. Actually two
properties - one bit I missed was the dual STN panel case, where they
have separate frame buffers. Something along the lines of:

Optional:

- arm,pl11x,framebuffer-base: a pair of two values, address and size,
				defining the framebuffer for the upper
				(or the only one) panel
- arm,pl11x,lower-framebuffer-base: as above, for the lower STN panel,
					when present

Being very hardware-specific, it covers all possible quirky scenarios,
at the same time does not exclude the option of using the CMA region
phandles, if a particular system needed it.

> > - max-memory-bandwidth: maximum bandwidth in bytes per second that the
> > 			cell's memory interface can handle
> >=20
> > and can be then used to calculate maximum bpp depending on the selected
> > mode.
>=20
> Yes, that's a better property definition.

Ok, I'll go that way then. Whether derived from the system design
characteristics or by "hands on experiments", seems hardware-y enough.

> >>> +- display-timings: standard display timings sub-node, see
> >>> +			Documentation/devicetree/bindings/video/display-timing.txt
> >>
> >> Should that be in a "Required sub-nodes" section (I assume required not
> >> optional) rather than "Optional Properties"?
> >=20
> > Right, the whole "panel" section is kept separately in a hope that CDF
> > (or DRM or whatever ;-) generic display pipeline bindings will deprecate
> > it. So the display-timings is required when optional panel properties
> > are present. Maybe I should split them into a separate sub-node?
> > Something along these lines (including the bandwidth example):
>=20
> I would assume that TFT-vs-STN is a pretty direct representation of the
> HW (IO bus to panel in particular), and hence wouldn't be replaced by
> CDF? I would expect CDF to represent the more generic properties. But, I
> haven't been following CDF too closely, so perhaps that's not true.

I'm not expecting CDF *bindings* to carry this information, no. I'm
expecting CDF core to provide me with this data in runtime (here's the
panel; what kind of panel are you? what modes do you provide? etc.) and
this is what my initial experiments used. The CLCD node only had the
video-ram and bandwidth-like properties plus a phandle to the display.=20

> If you're expecting this binding to change if/when CDF appears, perhaps
> it'd be better to wait for CDF, or plan for a new compatible property at
> that time, or add some property indicating old-style configuration vs
> new-style configuration once CDF is supported?

I'm expecting the panel description inside the CLCD node to be
deprecated, not changed, by the mythical CDF. As to waiting for it...
well. It's been over a year since first proposal ("generic panel
framework" as was it called then ;-). And over 2 years since VE gained
"DT support except for CLCD, which should be ready soon" ;-) And than 2
or 3 new platforms had to keep auxdata only for CLCD's sake. So, sure -
we can wait :-)

Pawe=C5=82


