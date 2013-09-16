From: Stephen Warren <swarren@wwwdotorg.org>
Date: Mon, 16 Sep 2013 19:52:32 +0000
Subject: Re: [PATCH v3 1/2] video: ARM CLCD: Add DT support
Message-Id: <52376180.1090001@wwwdotorg.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1379351934-25415-1-git-send-email-pawel.moll@arm.com>
In-Reply-To: <1379351934-25415-1-git-send-email-pawel.moll@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 09/16/2013 11:18 AM, Pawel Moll wrote:
> This patch adds basic DT bindings for the PL11x CLCD controllers
> and make their fbdev driver use them (initially only TFT panels
> are supported).

> diff --git a/Documentation/devicetree/bindings/video/arm,pl11x.txt b/Documentation/devicetree/bindings/video/arm,pl11x.txt

> +- interrupts: either a single interrupt specifier representing the
> +		combined interrupt output (CLCDINTR) or an array of
> +		four interrupt specifiers for CLCDMBEINTR,
> +		CLCDVCOMPINTR, CLCDLNBUINTR, CLCDFUFINTR; in the
> +		latter case interrupt names must be specified
> +		(see below)
> +- interrupt-names: when four interrupts are specified, their names:
> +			"mbe", "vcomp", "lnbu", "fuf"
> +			must be specified in order respective to the
> +			interrupt specifiers

I think the binding should either always use names as the key, or use
indices in interrupts as the key. Hence, I'd word that more like:

- interrupt-names: either the single entry "combined" representing a
			combined interrupt output (CLCDINTR), or the
			four entries "mbe", "vcomp", "lnbu", "fuf"
			representing the individual CLCDMBEINTR,
			CLCDVCOMPINTR, CLCDLNBUINTR, CLCDFUFINTR
			interrupts.
- interrupts: contains an interrupt specifier for each entry in
		 interrupt-names.

> +- arm,pl11x,panel-data-pads: array of 24 cells, each of them describing
> +				a function of one of the CLD pads,
> +				starting from 0 up to 23; each pad can
> +				be described by one of the following values:
> +	- 0: reserved (not connected)
> +	- 0x100-0x107: color upper STN panel data 0 to 7
...

I assume those are the raw values that go into the HW?

> +				Example sets of values for standard
> +				panel interfaces:
> +	- PL110 single colour STN panel:
> +			<0x107 0x106 0x105 0x104 0x103 0x102 0x101 0x100>,
> +			<0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0>;

The indentation of the introductory text seems a little odd. Do we
really need so many examples?

> +Optional properties:
> +
> +- arm,pl11x,framebuffer-base: a pair of two values, address and size,
> +				defining the framebuffer to be used;
> +				to be used only if it is *not*
> +				part of normal memory, as described
> +				in /memory node

If the framebuffer is part of /memory, what happens then? Is the address
not fixed (so the HW isn't yet set up) and hence a driver should
allocate it?

