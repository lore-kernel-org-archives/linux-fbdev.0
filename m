From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 26 Aug 2013 17:51:04 +0000
Subject: Re: [patch] tgafb: potential NULL dereference in init
Message-Id: <CAMuHMdWJ7sXCfo-ZV6JFjkpm1KZRo+g0ULer+Ywt29aOsjquuw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20130826145610.GA12428@elgon.mountain>
In-Reply-To: <20130826145610.GA12428@elgon.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Mon, Aug 26, 2013 at 4:56 PM, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> --- a/drivers/video/tgafb.c
> +++ b/drivers/video/tgafb.c
> @@ -1475,7 +1475,7 @@ tgafb_init_fix(struct fb_info *info)
>         int tga_bus_pci = TGA_BUS_PCI(par->dev);
>         int tga_bus_tc = TGA_BUS_TC(par->dev);
>         u8 tga_type = par->tga_type;
> -       const char *tga_type_name = NULL;
> +       const char *tga_type_name;

Now the real compiler (at least some versions of gcc) will complain
about an uninitialized variable...

>         switch (tga_type) {
>         case TGA_TYPE_8PLANE:
> @@ -1496,10 +1496,9 @@ tgafb_init_fix(struct fb_info *info)
>                 if (tga_bus_tc)
>                         tga_type_name = "Digital ZLX-E3";
>                 break;
> -       default:
> -               tga_type_name = "Unknown";
> -               break;
>         }
> +       if (!tga_type_name)

It will only by NULL if the garbage on the stack was NULL...

> +               tga_type_name = "Unknown";
>
>         strlcpy(info->fix.id, tga_type_name, sizeof(info->fix.id));

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
