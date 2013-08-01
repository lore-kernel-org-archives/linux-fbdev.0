From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 01 Aug 2013 09:31:07 +0000
Subject: Re: [patch -next] fb: fix recent breakage in correct_chipset()
Message-Id: <CAMuHMdXknqqtg5zpEEkBhcG7736GmowC4STSXS_hiLoTjkaUCw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20130702062821.GC24410@elgon.mountain>
In-Reply-To: <20130702062821.GC24410@elgon.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Tue, Jul 2, 2013 at 8:28 AM, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> The 6e36308a6f "fb: fix atyfb build warning" isn't right.  It makes all
> the indexes off by one.  This patch reverts it and casts the
> ARRAY_SIZE() to int to silence the build warning.
>
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>
> diff --git a/drivers/video/aty/atyfb_base.c b/drivers/video/aty/atyfb_base.c
> index a89c15d..9b0f12c 100644
> --- a/drivers/video/aty/atyfb_base.c
> +++ b/drivers/video/aty/atyfb_base.c
> @@ -435,8 +435,8 @@ static int correct_chipset(struct atyfb_par *par)
>         const char *name;
>         int i;
>
> -       for (i = ARRAY_SIZE(aty_chips); i > 0; i--)
> -               if (par->pci_id = aty_chips[i - 1].pci_id)
> +       for (i = (int)ARRAY_SIZE(aty_chips) - 1; i >= 0; i--)
> +               if (par->pci_id = aty_chips[i].pci_id)
>                         break;
>
>         if (i < 0)

Sorry for chiming in late, but can't we just revert the order of the loop
iteration and change i from int to size_t instead of adding a cast?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
