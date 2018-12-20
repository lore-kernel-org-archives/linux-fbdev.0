From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Thu, 20 Dec 2018 18:06:24 +0000
Subject: Re: [PATCH v5] fbdev: Remove depends on HAS_DMA in case of platform dependency
Message-Id: <17d121db-7afc-faca-10a8-ec55b5429171@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20181203122549epcas4p41d426a4a89a2a4fd74a16924319fa1f9@epcas4p4.samsung.com>
        <20181203122459.12558-1-geert@linux-m68k.org>
In-Reply-To: <20181203122459.12558-1-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org


On 12/03/2018 01:24 PM, Geert Uytterhoeven wrote:
> Remove dependencies on HAS_DMA where a Kconfig symbol depends on another
> symbol that implies HAS_DMA, and, optionally, on "|| COMPILE_TEST".
> In most cases this other symbol is an architecture or platform specific
> symbol, or PCI.
> 
> Generic symbols and drivers without platform dependencies keep their
> dependencies on HAS_DMA, to prevent compiling subsystems or drivers that
> cannot work anyway.
> 
> This simplifies the dependencies, and allows to improve compile-testing.
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Reviewed-by: Mark Brown <broonie@kernel.org>
> Acked-by: Robin Murphy <robin.murphy@arm.com>
> Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Patch queued for 4.21, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
