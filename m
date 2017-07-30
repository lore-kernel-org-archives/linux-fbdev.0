From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 30 Jul 2017 18:19:06 +0000
Subject: Re: [PATCH 2/6] drm/tinydrm: add helpers for ST7586 controllers
Message-Id: <CAHp75VdwMbe4g_xAtm3EgK4TiF3mubCWKykFA6Pn=iVk53XMRQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1501355870-13960-1-git-send-email-david@lechnology.com>
 <1501355870-13960-3-git-send-email-david@lechnology.com>
In-Reply-To: <1501355870-13960-3-git-send-email-david@lechnology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Lechner <david@lechnology.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree <devicetree@vger.kernel.org>, linux-fbdev@vger.kernel.org, Kevin Hilman <khilman@kernel.org>, Sekhar Nori <nsekhar@ti.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, dri-devel@lists.freedesktop.org, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>

On Sat, Jul 29, 2017 at 10:17 PM, David Lechner <david@lechnology.com> wrote:
> This adds helper functions and support for ST7586 controllers. These
> controllers have an unusual memory layout where 3 pixels are packed into
> 1 byte.
>
> +-------+-----------------+
> | bit   | 7 6 5 4 3 2 1 0 |
> +-------+-----------------+
> | pixel | 0 0 0 1 1 1 2 2 |
> +-------+-----------------+
>
> So, there are a nuber of places in the tinydrm pipline where this format

number

> needs to be taken into consideration.

> + * tinydrm_rgb565_to_st7586 - Convert RGB565 to ST7586 clip buffer

How this can be generic tinydrm helper?
Why driver can't handle it by its own and avoid spreading stuff into
generic header?

> +void tinydrm_rgb565_to_st7586(u8 *dst, void *vaddr,

> + * tinydrm_xrgb8888_to_st7586 - Convert XRGB8888 to ST7586 clip buffer

> +void tinydrm_xrgb8888_to_st7586(u8 *dst, void *vaddr,

Ditto.

> -       switch (fb->format->format) {
> -       case DRM_FORMAT_RGB565:
> -               if (swap)
> -                       tinydrm_swab16(dst, src, fb, clip);
> -               else
> -                       tinydrm_memcpy(dst, src, fb, clip);
> +       switch (pixel_fmt) {
> +       case MIPI_DCS_PIXEL_FMT_16BIT:
> +               switch (fb->format->format) {
> +               case DRM_FORMAT_RGB565:
> +                       if (swap)
> +                               tinydrm_swab16(dst, src, fb, clip);
> +                       else
> +                               tinydrm_memcpy(dst, src, fb, clip);
> +                       break;

Can't you use some other approach? Callbacks? Plugins?

> +       switch (mipi->pixel_fmt) {
> +       case MIPI_DCS_PIXEL_FMT_16BIT:
> +               len = width * height * sizeof(u16);
> +               break;
> +       case MIPI_DCS_PIXEL_FMT_ST7586_332:
> +               width = (width + 2) / 3;
> +               len = width * height;
> +               break;

Ditto.

> +       case MIPI_DCS_PIXEL_FMT_ST7586_332:
> +               /* 3 pixels per byte */
> +               bufsize = (mode->vdisplay + 2) / 3 * mode->hdisplay;
> +               break;

Ditto.

> -       if (cmd = MIPI_DCS_WRITE_MEMORY_START && !mipi->swap_bytes)
> +       if (cmd = MIPI_DCS_WRITE_MEMORY_START && !mipi->swap_bytes &&
> +           mipi->pixel_fmt != MIPI_DCS_PIXEL_FMT_ST7586_332)

Ditto.

If we allow this we end up to have 100500 LOCs in tinydrm-helpers.c
which will have nothing to do with the framework itself.



-- 
With Best Regards,
Andy Shevchenko
