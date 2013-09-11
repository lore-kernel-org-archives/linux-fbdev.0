From: Pawel Moll <pawel.moll@arm.com>
Date: Wed, 11 Sep 2013 11:45:31 +0000
Subject: Re: [PATCH v2 1/2] video: ARM CLCD: Add DT support
Message-Id: <1378899931.4082.75.camel@hornet>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1378808726-32535-1-git-send-email-pawel.moll@arm.com>
 <522F57B9.5000001@wwwdotorg.org>
In-Reply-To: <522F57B9.5000001@wwwdotorg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

On Tue, 2013-09-10 at 18:32 +0100, Stephen Warren wrote:
> > +Optional properties:
> > +
> > +- video-ram: phandle to a node describing specialized video memory
> > +		(that is *not* described in the top level "memory" node)
> > +		that must be used as a framebuffer, eg. due to restrictions
> > +		of the system interconnect; the node must contain a
> > +		standard reg property describing the address and the size
> > +		of the memory area
>=20
> Should this use the "CMA bindings" that are being proposed at the moment?

I expected this bit to be the hardest to get through :-)

The memory in question is *not* a part of "normal" RAM, therefore CMA
doesn't even know about it. The situation I have to deal with is a
system when CLCD's AHB master can *not* access the normal RAM, so the
designers kindly ;-) provided some static RAM which it can address.

> Even if not, I'm not quite clear on what the referenced node is supposed
> to contain; is just a reg property enough, so you'd see the following at
> a completely arbitrary location in the DT:
>=20
> framebuffer-mem {
>     reg =3D <0x80000000 0x00100000>;
> };

The place wouldn't be random, no. Getting back to my scenario, the
"video" RAM, being close to CLCD, is (obviously) also addressable by the
core, as any other memory-mapped device. So its position is determined
by the platform memory map:

\ {
	#address-cell =3D <2>;
	#size-cell =3D <2>;
	static-memory-bus {
		#address-cell =3D <2>;
		#size-cell =3D <1>;
		ranges =3D <2 0 0 0x18000000 64M>;
		motherboard {
			ranges;=20
			video-ram {
				reg =3D <2 0 8MB>;
			};
		};
	};
};

From the core's perspective it's just a bit of extra memory, you could,
for example, put a MTD ram disk on it. It seems to deserve a
representation in the tree then.

> I'm not sure what the benefit of making this a standalone node is; why
> not just put the base/size directly into the video-ram property in the
> CLCD node?

This is certainly an option. I've considered this as well, but thought
that the above made more sense.

Having said that, there is actually a use case, although a very
non-probable one, for having a direct number there... The interconnect
that CLCD is connected to could have different mapping than the
processor's one. In other word, the memory seen by the core at X, could
be accessed by the CLCD at Y. Or, in even more quirky situation, the
core may not have access to the memory at all, with the graphics being
generated only by GPU (or any other third party). Then the value would
mean "the address you have to use when generating AMBA read transactions
to be get some meaningful data" and would have to be known explicitly.

I guess it won't be hard to convince me it's a better option ;-)

> > +- max-framebuffer-size: maximum size in bytes of the framebuffer the
> > +			system can handle, eg. in terms of available
> > +			memory bandwidth
>=20
> Size doesn't imply bandwidth, due to the potential for varying bpp,
> frame-rates, margin/porch sizes, etc. If this is a bandwidth limit,
> shouldn't we instead represent that value directly, perhaps along with
> some multiplier to convert theoretical bandwidth to practical bandwidth
> (to account for memory protocol and controller overheads)?

It's a *memory interface* bandwidth, so synchronization fields are
irrelevant here. And the bpp limit is actually being calculated from
this value, not the other way round. But I forgot about differing frame
rates, that's fact. So it probably should be:

- max-memory-bandwidth: maximum bandwidth in bytes per second that the
			cell's memory interface can handle

and can be then used to calculate maximum bpp depending on the selected
mode.

As to the multipliers... Although I hope that the SOC designer can
provide theoretical throughput data, the only practical way of getting
the value I was able to come up with was just trying different
combinations till cross the line, so there isn't much math to be done
further.

> ...
> > +- panel-type: (required) must be "tft" or "stn", defines panel type
> ...
> > +- panel-stn-4bit: (for monochrome "stn" panel) if present means
> > +			that the monochrome display is connected
> > +			via 4 bit-wide interface
>=20
> I just wanted to confirm that those are a complete/direct representation
> of all the HW options the module supports?

Yes. TFT or STN. There can be one or STN panels connected. STN(s) can be
color or mono. Mono STN(s) can be driven via 4 or 8 bit wide interfaces.
Disclaimer: I'm not trying to pretend an expert here. I'm just basing
the above on the cell's spec.

> > +- display-timings: standard display timings sub-node, see
> > +			Documentation/devicetree/bindings/video/display-timing.txt
>=20
> Should that be in a "Required sub-nodes" section (I assume required not
> optional) rather than "Optional Properties"?

Right, the whole "panel" section is kept separately in a hope that CDF
(or DRM or whatever ;-) generic display pipeline bindings will deprecate
it. So the display-timings is required when optional panel properties
are present. Maybe I should split them into a separate sub-node?
Something along these lines (including the bandwidth example):

clcd@1f0000 {
        compatible =3D "arm,pl111", "arm,primecell";
       =20
        max-memory-bandwidth =3D <36864000>; /* bps, 640x480@60 16bpp */
       =20
        panel {
                type =3D "tft";
                tft-interface =3D <8 8 8>;
                display-timings {
                        ...
                }      =20
        };     =20
};

Then the panel subnode would be optional, but type and display-timings
inside would be required.

Also, I will have another look at what the CDF is offering, to make it
as future-proof as possible.

Pawe=C5=82


