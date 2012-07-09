From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 09 Jul 2012 07:34:04 +0000
Subject: Re: [PATCH v2 04/11] fbdev: export get_fb_info()/put_fb_info()
Message-Id: <CAMuHMdWsSqMjqDuE_qgNUjc1eCWZqLLo1GNxwLYZNih=YBFh0g@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1341784614-2797-1-git-send-email-dh.herrmann@googlemail.com>
	<1341784614-2797-5-git-send-email-dh.herrmann@googlemail.com>
In-Reply-To: <1341784614-2797-5-git-send-email-dh.herrmann@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, florianschandinat@gmx.de, linux-fbdev@vger.kernel.org, gregkh@linuxfoundation.org, alan@lxorguk.ukuu.org.uk, bonbons@linux-vserver.org

On Sun, Jul 8, 2012 at 11:56 PM, David Herrmann
<dh.herrmann@googlemail.com> wrote:
> --- a/drivers/video/fbmem.c
> +++ b/drivers/video/fbmem.c
> @@ -46,7 +46,7 @@ static DEFINE_MUTEX(registration_lock);
>  struct fb_info *registered_fb[FB_MAX] __read_mostly;
>  int num_registered_fb __read_mostly;
>
> -static struct fb_info *get_fb_info(unsigned int idx)
> +struct fb_info *get_fb_info(unsigned int idx)
>  {
>         struct fb_info *fb_info;
>
> @@ -61,14 +61,16 @@ static struct fb_info *get_fb_info(unsigned int idx)
>
>         return fb_info;
>  }
> +EXPORT_SYMBOL(get_fb_info);

EXPORT_SYMBOL_GPL?

> -static void put_fb_info(struct fb_info *fb_info)
> +void put_fb_info(struct fb_info *fb_info)
>  {
>         if (!atomic_dec_and_test(&fb_info->count))
>                 return;
>         if (fb_info->fbops->fb_destroy)
>                 fb_info->fbops->fb_destroy(fb_info);
>  }
> +EXPORT_SYMBOL(put_fb_info);

EXPORT_SYMBOL_GPL?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
