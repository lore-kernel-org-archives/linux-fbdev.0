From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 30 May 2014 14:28:55 +0000
Subject: Re: [PATCH] console: Add persistent scrollback buffers for all VGA consoles
Message-Id: <CAMuHMdVrDB7Q+oZi_WJk07a7OF_VOJiOHxpYwRABymTKsPuMoA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1401456425-15931-1-git-send-email-manuel.schoelling@gmx.de>
In-Reply-To: <1401456425-15931-1-git-send-email-manuel.schoelling@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: =?UTF-8?Q?Manuel_Sch=C3=B6lling?= <manuel.schoelling@gmx.de>
Cc: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Mark Brown <broonie@linaro.org>, Randy Dunlap <rdunlap@infradead.org>, David Herrmann <dh.herrmann@gmail.com>, Dave Airlie <airlied@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi Manuel,

On Fri, May 30, 2014 at 3:27 PM, Manuel Sch=C3=B6lling
<manuel.schoelling@gmx.de> wrote:
> Add a scrollback buffers for each VGA console. The benefit is that
> the scrollback history is not flushed when switching between consoles
> but is persistent.
> The buffers are allocated on demand when a new console is opened.

Thanks for your patch!

I see two issues with this feature:
  1. Before, the single (default 64 KiB) buffer was allocated at startup.
     Now you will allocate a buffer each time a new console is opened.
     Depending on memory fragmentation, this may fail.
  2. People with RAM-constrained systems may not like this.
     Can it be a config option?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
