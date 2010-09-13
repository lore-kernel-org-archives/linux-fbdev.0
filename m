From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 13 Sep 2010 18:14:52 +0000
Subject: Re: [PATCH 1/4] fbdev: fix section mismatches in q40fb.c
Message-Id: <AANLkTimHxWHfqh2hP8SPvTD7rcXwiC4Ar-adENM3phwu@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1282324404-3480-1-git-send-email-henne@nachtwindheim.de>
In-Reply-To: <1282324404-3480-1-git-send-email-henne@nachtwindheim.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Henrik Kretzschmar <henne@nachtwindheim.de>
Cc: linux-fbdev@vger.kernel.org, arnaud.patard@rtp-net.org, u.kleine-koenig@pengutronix.de, jayakumar.lkml@gmail.com, tj@kernel.org, linux-kernel@vger.kernel.org, linux-m68k@vger.kernel.org

On Fri, Aug 20, 2010 at 19:13, Henrik Kretzschmar
<henne@nachtwindheim.de> wrote:
> This patch moves the q40_fix and q40_var structures from .init.data
> to .devinit.data.
> This is where now the probe function resides, which only uses them.
>
> Signed-off-by: Henrik Kretzschmar <henne@nachtwindheim.de>

Applied

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
