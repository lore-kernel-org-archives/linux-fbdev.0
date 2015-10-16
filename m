From: Olof Johansson <olof@lixom.net>
Date: Fri, 16 Oct 2015 21:23:06 +0000
Subject: Re: [GIT PULL] On-demand device probing
Message-Id: <CAOesGMj44N3Xfv_D_iLEzXBrkN6LXBa-uh6m3fi_F2xDenDhMg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20151014092644.GO14956@sirena.org.uk>
	<1444909328-24761-1-git-send-email-tomeu.vizoso@collabora.com>
In-Reply-To: <1444909328-24761-1-git-send-email-tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Michael Turquette <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, =?UTF-8?Q?Terje_Bergstr=C3=B6m?= <tbergstrom-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie@kernel.o>

Hi,

I've bisected boot failures in next-20151016 down to patches in this branch:

On Thu, Oct 15, 2015 at 4:42 AM, Tomeu Vizoso
<tomeu.vizoso@collabora.com> wrote:
> Tomeu Vizoso (20):
>       driver core: handle -EPROBE_DEFER from bus_type.match()

The machine it happened on was OMAP5UEVM:

http://arm-soc.lixom.net/bootlogs/next/next-20151016/omap5uevm-arm-omap2plus_defconfig.html

But I've also seen it on tegra2, that one bisected down to:

>      regulator: core: Probe regulators on demand

http://arm-soc.lixom.net/bootlogs/next/next-20151016/seaboard-arm-multi_v7_defconfig.html



-Olof
