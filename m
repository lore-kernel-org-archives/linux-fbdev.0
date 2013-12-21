From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sat, 21 Dec 2013 19:09:10 +0000
Subject: Re: [RFC PATCH 1/5] gpu: ipu-v3: Move i.MX IPUv3 core driver out of staging
Message-Id: <CAMuHMdXTVnq0tt6=TYMbVgRRqeEd8uhA_5iKEXjGHP2S5XjP_g@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1387561966-31758-2-git-send-email-p.zabel@pengutronix.de>
In-Reply-To: <1387561966-31758-2-git-send-email-p.zabel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Fri, Dec 20, 2013 at 6:52 PM, Philipp Zabel <p.zabel@pengutronix.de> wrote:
> The i.MX Image Processing Unit (IPU) contains a number of image processing
> blocks that sit right in the middle between DRM and V4L2. Some of the modules,
> such as Display Controller, Processor, and Interface (DC, DP, DI) or CMOS
> Sensor Interface (CSI) and their FIFOs could be assigned to either framework,
> but others, such as the dma controller (IDMAC) and image converter (IC) can
> be used by both.
> The IPUv3 core driver provides an internal API to access the modules, to be
> used by both DRM and V4L2 IPUv3 drivers.
>
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> ---
>  drivers/gpu/Makefile                                          |  1 +
>  drivers/gpu/ipu-v3/Kconfig                                    |  7 +++++++
>  drivers/{staging/imx-drm => gpu}/ipu-v3/Makefile              |  2 +-
>  drivers/{staging/imx-drm => gpu}/ipu-v3/ipu-common.c          |  3 ++-
>  drivers/{staging/imx-drm => gpu}/ipu-v3/ipu-dc.c              |  3 +--
>  drivers/{staging/imx-drm => gpu}/ipu-v3/ipu-di.c              |  2 +-
>  drivers/{staging/imx-drm => gpu}/ipu-v3/ipu-dmfc.c            |  2 +-
>  drivers/{staging/imx-drm => gpu}/ipu-v3/ipu-dp.c              |  2 +-
>  drivers/{staging/imx-drm => gpu}/ipu-v3/ipu-prv.h             |  2 +-

The posted diff only shows the changes made during the move.

Has the actual code been reviewed here?
If not, please post it here (e.g. diff against /dev/null).
If yes, please ignore my comments.

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
