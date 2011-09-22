From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 22 Sep 2011 19:40:17 +0000
Subject: Re: [PATCH] gma500: gtt based hardware scrolling console
Message-Id: <CAMuHMdWBz9+TCBUbaOY3HRv=khiDHkRCKdx5e53HCen54RUBVw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20110922184316.25068.54702.stgit@localhost.localdomain>
In-Reply-To: <20110922184316.25068.54702.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: greg@kroah.com, linux-kernel@vger.kernel.org, Linux Fbdev development list <linux-fbdev@vger.kernel.org>

Hi Alan,

On Thu, Sep 22, 2011 at 20:43, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
diff --git a/drivers/staging/gma500/framebuffer.c
b/drivers/staging/gma500/framebuffer.c
index 7748331..3f39a37 100644
--- a/drivers/staging/gma500/framebuffer.c
+++ b/drivers/staging/gma500/framebuffer.c

> @@ -416,6 +473,8 @@ static int psbfb_create(struct psb_fbdev *fbdev,
>
>        info->fix.smem_start = dev->mode_config.fb_base;
>        info->fix.smem_len = size;
> +       info->fix.ywrapstep = gtt_roll;

Do you really want to set this? I didn't see any other wrapping
support in your patch.
However, I guess you can implement wrapping support using the same
mapping trick?

> +       info->fix.ypanstep = gtt_roll;
>
>        if (backing->stolen) {
>                /* Accessed stolen memory directly */

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
