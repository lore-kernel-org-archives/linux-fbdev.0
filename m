From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 13 May 2020 15:03:35 +0000
Subject: Re: [PATCH] video: fbdev: ssd1307fb: Added support to Column offset
Message-Id: <CAHp75VfggycwYpsi024MWZYEgOpnst9NR3q-D5n30SDgmSB9Pw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1589370694-14327-1-git-send-email-alencar.fmce@imbel.gov.br>
In-Reply-To: <1589370694-14327-1-git-send-email-alencar.fmce@imbel.gov.br>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rodrigo Rolim Mendes de Alencar <455.rodrigo.alencar@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-fbdev@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, alencar.fmce@imbel.gov.br

On Wed, May 13, 2020 at 2:51 PM Rodrigo Rolim Mendes de Alencar
<455.rodrigo.alencar@gmail.com> wrote:
>
> This patch provides support for displays like VGM128064B0W10,
> which requires a column offset of 2, i.e., its segments starts
> in SEG2 and ends in SEG129.

You forgot
1) version of the patch (series) to be bumped
2) Cc to fbdev maintainer (I did here FYI)

> -       ret = ssd1307fb_write_cmd(par->client, 0x0);
> +       ret = ssd1307fb_write_cmd(par->client, par->col_offset);
>         if (ret < 0)
>                 return ret;
>
> -       ret = ssd1307fb_write_cmd(par->client, par->width - 1);
> +       ret = ssd1307fb_write_cmd(par->client, par->col_offset + par->width - 1);
>         if (ret < 0)
>                 return ret;
>
> @@ -626,6 +627,9 @@ static int ssd1307fb_probe(struct i2c_client *client)
>         if (device_property_read_u32(dev, "solomon,page-offset", &par->page_offset))
>                 par->page_offset = 1;
>
> +       if (of_property_read_u32(node, "solomon,col-offset", &par->col_offset))
> +               par->col_offset = 0;

This won't work on non-OF systems, but easy to fix: simple see around
and do in the same way.

>         if (device_property_read_u32(dev, "solomon,com-offset", &par->com_offset))
>                 par->com_offset = 0;

-- 
With Best Regards,
Andy Shevchenko
