From: "jonsmirl@gmail.com" <jonsmirl@gmail.com>
Date: Thu, 02 Oct 2014 13:49:53 +0000
Subject: Re: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
Message-Id: <CAKON4OyLsM-Q0EK3-gj-T_g3T=tTwNoOS8wHSqSuTT4mv9Uv_Q@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20140929101805.GB26008@ulmo> <20140929114643.GB4081@lukather>
 <20140929134708.GB30998@ulmo>
 <20140929155517.GR16977@sirena.org.uk>
 <20140930050923.GB29874@ulmo> <20140930173928.GH4273@sirena.org.uk>
 <20141001074139.GB18463@ulmo>
 <CABxcv=nKErHGPRLM5yer2YnOc2VJPWLmeKgwXbXEU3r_XvsCyg@mail.gmail.com>
 <20141001123250.GY4273@sirena.org.uk> <20141001124800.GA21733@ulmo>
 <20141001170517.GF4273@sirena.org.uk> <542C3934.3040409@redhat.com>
 <CAKON4OxzerMyuza-GSfmYiLMqA=Y3HOXko7a8rOcP_8PkHVF3w@mail.gmail.com>
 <542C4404.8040501@wwwdotorg.org> <542CF3C3.2050708@redhat.com>
 <CAKON4Oy8sZ-d6JzWLi7pUeNFE5ge0fr5Tgoc_PSpKcOoiN-0yQ@mail.gmail.com>
 <542D476D.50004@redhat.com>
 <CAKON4OwOFVFZjxN-SJpDJLcyCpNOT4_mjjr9OpgGXmTYvZwT+A@mail.gmail.com>
 <CAOMqctSnmN3YScH8+hCkmEVB076u=VsCAJVTz5=NEYzQJpYR6A@mail.gmail.com>
 <CAKON4Ow4WU8yhy+LKGgKfvS8E15MU=gfRoZXNW6AWGOBVPG8SQ@mail.gmail.com>
 <CAMuHMdXLf3iVFOxFa__xf17tFGD_tFFr0FLnEgJeQP4xz17YCA@mail.gmail.com>
In-Reply-To: <CAMuHMdXLf3iVFOxFa__xf17tFGD_tFFr0FLnEgJeQP4xz17YCA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, Oct 2, 2014 at 9:46 AM, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Thu, Oct 2, 2014 at 3:34 PM, jonsmirl@gmail.com <jonsmirl@gmail.com> wrote:
>> Does the clock and regulator cleanup happen before drivers can load
>> off from initrd? I didn't think it did but I might be wrong.
>
> Yes
>
> drivers/base/power/domain.c:late_initcall(genpd_poweroff_unused);
> drivers/clk/clk.c:late_initcall_sync(clk_disable_unused);
> drivers/regulator/core.c:late_initcall_sync(regulator_init_complete);

I think this is the basic problem, we need to open a window where
drivers can be loaded before the clock/regulator clean up happens.
That window needs to be fixed length (ie Ramdisk based loading).

This is a core problem in a multi-architecture kernel, we need to get
the device specific drivers loaded before this clean up happens.



>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds



-- 
Jon Smirl
jonsmirl@gmail.com
