From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 08 Mar 2017 09:11:01 +0000
Subject: Re: About boot time Tux logo with -EPROBE_DEFER
Message-Id: <CAMuHMdV=EJnyv-YfrQYQBjdnq0Vz2XjTpeN3hDUgKzaGw+Jpmg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <redmine.issue-116282.20170227003040@dm.renesas.com>
 <redmine.journal-935021.20170228120819.2026321c0ca0beea@dm.renesas.com> <87shmp991p.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87shmp991p.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Laurent <laurent.pinchart@ideasonboard.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Fabian Frederick <fabf@skynet.be>, Andrew Morton <akpm@linux-foundation.org>, shimoda <yoshihiro.shimoda.uh@renesas.com>, Koji Matsuoka <koji.matsuoka.xm@renesas.com>, shiiba <naoya.shiiba.nx@renesas.com>, sakato <ryusuke.sakato.bx@renesas.com>, Hosoya <yoshifumi.hosoya.wj@renesas.com>, Fukawa <tomoharu.fukawa.eb@renesas.com>, Hien Dang <hien.dang.eb@renesas.com>, Khiem Nguyen <khiem.nguyen.xt@renesas.com>, Kouei Abe <kouei.abe.cp@renesas.com>, Harunobu Kurokawa <harunobu.kurokawa.dn@renesas.com>, Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>, Takeshi Kihara <takeshi.kihara.df@renesas.com>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi Morimoto-san,

On Tue, Mar 7, 2017 at 2:24 AM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
> I want to ask you about boot time Tux logo.
>
> For some reasons, current our video driver returns -EPROBE_DEFER when
> probe timing, but logo init function doesn't care it.
> Thus, our kernel can't have logo when boot time.
>
> I think this is not only our issue, but general issue ?
>
> Thus, I think logo init function should care about -EPROBE_DEFER
> or something. In our quick hack, this issue was solved by below patch,
> but I don't know this is OK.

The important part is that fb_logo_late_init() is called
  - as late as possible, to allow to draw the logo as late as possible,
  - but before free_initmem(), to avoid using freed memory.

kernel_init()
{
    kernel_init_freeable()
    {
        ...
        do_basic_setup()
        {
            ...
            do_initcalls();
            ...
        }
        ...
    }
    /* need to finish all async __init code before freeing the memory */
    async_synchronize_full();
    free_initmem();
    ...
}

According to the call graph above, the latest initcall() should be OK.

> So, how to solve this issue ? do you have nice idea ?
> or can maintainer accept below patch ?
>
> -------------------
> diff --git a/drivers/video/logo/logo.c b/drivers/video/logo/logo.c
> index b6bc4a0bda2a..4d50bfd13e7c 100644
> --- a/drivers/video/logo/logo.c
> +++ b/drivers/video/logo/logo.c
> @@ -34,7 +34,7 @@ static int __init fb_logo_late_init(void)
>      return 0;
>  }
>
> -late_initcall(fb_logo_late_init);
> +late_initcall_sync(fb_logo_late_init);
>
>  /* logo's are marked __initdata. Use __ref to tell
>   * modpost that it is intended that this function uses data

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
