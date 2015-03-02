From: Rob Herring <robherring2@gmail.com>
Date: Mon, 02 Mar 2015 23:29:05 +0000
Subject: Re: [PATCH] video: ARM CLCD: Added support for FBIO_WAITFORVSYNC
Message-Id: <CAL_JsqJfA3Pxvdux-Um9nFoaZpRh30S9d1TQid_TchDH_qo7Ow@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1424898082-1522-1-git-send-email-arun.ramamurthy@broadcom.com> <1424898082-1522-3-git-send-email-arun.ramamurthy@broadcom.com>
In-Reply-To: <1424898082-1522-3-git-send-email-arun.ramamurthy-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arun Ramamurthy <arun.ramamurthy-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Jean-Christophe Plagniol-Villard <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Dmitry Torokhov <dtor-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Anatol Pomazau <anatol-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Jonathan Richardson <jonathar-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Scott Branden <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Ray Jui <rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org

On Wed, Feb 25, 2015 at 3:01 PM, Arun Ramamurthy
<arun.ramamurthy@broadcom.com> wrote:
> Added ioctl and interrupt handler functions to support FBIO_WAITFORVSYNC
> Also corrected documentation to make interrupts and interrupt-names
> optional as they are not required properties.
>
> Reviewed-by: Ray Jui <rjui@broadcom.com>
> Reviewed-by: Scott Branden <sbranden@broadcom.com>
> Signed-off-by: Arun Ramamurthy <arun.ramamurthy@broadcom.com>0
> ---
>  .../devicetree/bindings/video/arm,pl11x.txt        | 11 +--

Please split bindings to separate patches.

>  drivers/video/fbdev/amba-clcd.c                    | 82 ++++++++++++++++++++++
>  include/linux/amba/clcd.h                          |  4 ++
>  3 files changed, 89 insertions(+), 8 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/video/arm,pl11x.txt b/Documentation/devicetree/bindings/video/arm,pl11x.txt
> index 2262cdb..7d19024 100644
> --- a/Documentation/devicetree/bindings/video/arm,pl11x.txt
> +++ b/Documentation/devicetree/bindings/video/arm,pl11x.txt
> @@ -10,14 +10,6 @@ Required properties:
>
>  - reg: base address and size of the control registers block
>
> -- interrupt-names: either the single entry "combined" representing a
> -       combined interrupt output (CLCDINTR), or the four entries
> -       "mbe", "vcomp", "lnbu", "fuf" representing the individual
> -       CLCDMBEINTR, CLCDVCOMPINTR, CLCDLNBUINTR, CLCDFUFINTR interrupts
> -
> -- interrupts: contains an interrupt specifier for each entry in
> -       interrupt-names
> -
>  - clock-names: should contain "clcdclk" and "apb_pclk"
>
>  - clocks: contains phandle and clock specifier pairs for the entries
> @@ -54,6 +46,9 @@ Optional properties:
>         It can be used to configure a virtual y resolution. It
>         must be a value larger than the actual y resolution.
>
> +- interrupts: contains an interrupt specifier for the clcd vcomp interrupt
> +        This is required for the driver to handle FBIO_WAITFORVSYNC ioctls.
> +

What happened to interrupt-names?

Rob
