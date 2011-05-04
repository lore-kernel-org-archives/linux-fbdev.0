From: Steve Sakoman <steve@sakoman.com>
Date: Wed, 04 May 2011 12:44:48 +0000
Subject: Re: [PATCH 1/7] OMAP: OMAPFB: Remove unused lcd drivers
Message-Id: <BANLkTimuWoCFtq62mP2KF52VLytwqaWFzw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1304512059-10372-1-git-send-email-tomi.valkeinen@ti.com>
	<1304512059-10372-2-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1304512059-10372-2-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Arun C <arunedarath@mistralsolutions.com>, Koen Kooi <koen@openembedded.org>

On Wed, May 4, 2011 at 5:27 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> drivers/video/omap/ contains some lcd drivers which are not used by any
> board. They can be removed.
>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Cc: Arun C <arunedarath@mistralsolutions.com>
> Cc: Koen Kooi <koen@openembedded.org>
> Cc: Steve Sakoman <steve@sakoman.com>
> ---
>  drivers/video/omap/Makefile          |    4 -
>  drivers/video/omap/lcd_omap2evm.c    |  192 ---------------------------------
>  drivers/video/omap/lcd_omap3beagle.c |  130 -----------------------
>  drivers/video/omap/lcd_omap3evm.c    |  193 ----------------------------------
>  drivers/video/omap/lcd_overo.c       |  180 -------------------------------
>  5 files changed, 0 insertions(+), 699 deletions(-)
>  delete mode 100644 drivers/video/omap/lcd_omap2evm.c
>  delete mode 100644 drivers/video/omap/lcd_omap3beagle.c
>  delete mode 100644 drivers/video/omap/lcd_omap3evm.c
>  delete mode 100644 drivers/video/omap/lcd_overo.c

Acked-by: Steve Sakoman <steve@sakoman.com>

Steve
