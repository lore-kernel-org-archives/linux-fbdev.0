From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 08 Aug 2012 17:02:51 +0000
Subject: Re: [PATCH] video: move CNVT_TOHW to a common place
Message-Id: <CAMuHMdW11JpHg40QshVx5cG=CS2KG0RfAegv8K5eOco68asX4A@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1344426866-8789-1-git-send-email-prakash.pm@ti.com>
In-Reply-To: <1344426866-8789-1-git-send-email-prakash.pm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Wed, Aug 8, 2012 at 1:54 PM, Manjunathappa, Prakash
<prakash.pm@ti.com> wrote:
> --- a/include/linux/fb.h
> +++ b/include/linux/fb.h
> @@ -397,6 +397,11 @@ struct fb_cursor {
>         struct fb_image image;  /* Cursor image */
>  };
>
> +static inline __u32 CNVT_TOHW(__u32 val, __u32 width)

"__u32" is a bit misleading, as "val" is actually an unsigned 16-bit value.

> +{
> +       return ((val << width) + 0x7FFF - val) >> 16;
> +}

Also, if you move it to a public header, perhaps the function needs a more
descriptive name? What it does is remap a 16-bit value "val" onto a value with
"width" bits of resolution, where "width" must be smaller than 16.
"reduce_resolution()"?

Also, it can become more generic, not limiting to 16-bit input values.
The "0x7fff" part is "(1 << (width -1)) - 1". But I'm not sure it's
worth the effort
(are there places where this is needed?).

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
