From: Tomasz Figa <tomasz.figa@gmail.com>
Date: Fri, 05 Jul 2013 23:12:05 +0000
Subject: Re: [PATCH V4 2/4] phy: Add driver for Exynos DP PHY
Message-Id: <1543218.1F6S8MDx2p@flatron>
List-Id: <linux-fbdev.vger.kernel.org>
References: <000b01ce76ff$cf9fd6a0$6edf83e0$@samsung.com>
In-Reply-To: <000b01ce76ff$cf9fd6a0$6edf83e0$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tuesday 02 of July 2013 17:40:31 Jingoo Han wrote:
> Add a PHY provider driver for the Samsung Exynos SoC DP PHY.
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
> Acked-by: Felipe Balbi <balbi@ti.com>
> ---
>  .../devicetree/bindings/phy/samsung-phy.txt        |    8 ++
>  drivers/phy/Kconfig                                |    6 ++
>  drivers/phy/Makefile                               |    1 +
>  drivers/phy/phy-exynos-dp-video.c                  |  111
> ++++++++++++++++++++ 4 files changed, 126 insertions(+)
>  create mode 100644 drivers/phy/phy-exynos-dp-video.c

Reviewed-by: Tomasz Figa <t.figa@samsung.com>

Best regards,
Tomasz

