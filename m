From: Yegor Yefremov <yegorslists@googlemail.com>
Date: Tue, 09 Jul 2013 09:37:27 +0000
Subject: Re: [PATCH 1/1] OMAPDSS: Add sil9022 driver
Message-Id: <CAGm1_kuVLrTPS2TYw=TRWOppbY4HW0tpYUJzWqyv7MapJTL-_Q@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1373360825-25170-1-git-send-email-sathyap@ti.com>
In-Reply-To: <1373360825-25170-1-git-send-email-sathyap@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sathya Prakash M R <sathyap@ti.com>
Cc: "Valkeinen, Tomi" <tomi.valkeinen@ti.com>, archit@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Srinivas Pulukuru <srinivas.pulukuru@ti.com>

On Tue, Jul 9, 2013 at 11:07 AM, Sathya Prakash M R <sathyap@ti.com> wrote:
> From: Srinivas Pulukuru <srinivas.pulukuru@ti.com>
>
> Add driver for SIL9022 DPI-to-HDMI chip.
>
> Signed-off-by: Srinivas Pulukuru <srinivas.pulukuru@ti.com>
> [sathyap@ti.com: Ported the driver from 2.6.32 based internal
> kernel to v3.10 kernel]
> Signed-off-by: Sathya Prakash M R <sathyap@ti.com>
> ---
> This patch was tested using the legacy OMAP3630 based Zoom3 platform.
> There is no DT support for Zoom , hence board file changes
> made locally were used for validation purpose.
> Further, DT support will be added for a newer SOC which uses
> the sil9022 HDMI interface chip.
>
>  drivers/video/omap2/displays/Kconfig         |    8 +
>  drivers/video/omap2/displays/Makefile        |    1 +
>  drivers/video/omap2/displays/panel-sil9022.c | 1274 ++++++++++++++++++++++++++
>  drivers/video/omap2/displays/panel-sil9022.h |  527 +++++++++++
>  4 files changed, 1810 insertions(+)
>  create mode 100644 drivers/video/omap2/displays/panel-sil9022.c
>  create mode 100644 drivers/video/omap2/displays/panel-sil9022.h

What about making this driver more general. We've tested this HDMI
chip on am335x and there are also Freescal based devices using this
chip (http://www.genesi-tech.com/products/efika and kernel repo
http://github.com/genesi/linux-legacy).

Yegor
