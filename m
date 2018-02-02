From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Date: Fri, 02 Feb 2018 05:21:21 +0000
Subject: Re: [PATCH] fbdev: simplefb: add support for 'memory-region' property on DT node
Message-Id: <20180202142121.CEB8.4A936039@socionext.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <2359956.Z9lQWSAgHb@amdc3058> <CAHp75VfTrEELX9kKjZ7zmM8V=ZxbfAPbEDozG1i0A4P6gUjnEA@mail.gmail.com>
In-Reply-To: <CAHp75VfTrEELX9kKjZ7zmM8V=ZxbfAPbEDozG1i0A4P6gUjnEA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Hi Andy,

On Thu, 1 Feb 2018 21:03:30 +0200 <andy.shevchenko@gmail.com> wrote:

> On Thu, Feb 1, 2018 at 5:56 PM, Bartlomiej Zolnierkiewicz
> <b.zolnierkie@samsung.com> wrote:
> > On Tuesday, January 23, 2018 08:34:56 PM Kunihiko Hayashi wrote:
> >> Enables 'memory-region' property referring to the memory description on
> >> the reserved-memory node in case of devicetree use.
> >> If there is no 'reg' property that specifies the address and size of
> >> the framebuffer, the address and size written in the memory description
> >> on the reserved-memory node can be used for the framebuffer.
> >>
> >> Furthermore, the reserved-memory node needs to have "no-map" attributes
> >> because simplefb driver maps the region by ioremap_wc().
> >>
> >> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> 
> >> +- memory-region: phandle to a node describing memory region as framebuffer
> >> +              memory instead of reg property. The node should include
> >> +              'no-map'.
> 
> >>       mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> >> +     if (!mem)
> >> +             mem = simplefb_parse_dt_reserved_mem(&pdev->dev);
> 
> I'm not sure I understood why you need this entire function?
> 
> Put your memory resource ('reg' property) as part of reserved memory
> with necessary flags.

Surely we prepare a memory resource as a part of reserved memory,
for example:

	reserved-memory {
		fb_area: memory@0xa0000000 {
			reg = <0xa0000000 0x400000>;
			no-map;
		};
	};

And we need to specify the address and size as a reg property in
the framebuffer node.

	framebuffer {
		compatible = "simple-framebuffer";
		reg = <0xa0000000 0x400000>;
	};

This function allows us to specify the area with phandle to
the reserved memory instead of same address and size.

	framebuffer {
		compatible = "simple-framebuffer";
		memory-region = <&fb_area>;
	};

If both reg and memory-region properties are specified
in the framebuffer node, the reg propery will be applied.

---
Best Regards,
Kunihiko Hayashi

