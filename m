From: Kishon Vijay Abraham I <kishon@ti.com>
Date: Fri, 28 Jun 2013 09:43:27 +0000
Subject: Re: [PATCH 1/3] phy: Add driver for Exynos DP PHY
Message-Id: <51CD57EF.5010808@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <001501ce73bf$87c49c00$974dd400$@samsung.com>
In-Reply-To: <001501ce73bf$87c49c00$974dd400$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi,

On Friday 28 June 2013 10:52 AM, Jingoo Han wrote:
> Add a PHY provider driver for the Samsung Exynos SoC DP PHY.
>
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> ---
>   .../phy/samsung,exynos5250-dp-video-phy.txt        |    7 ++
>   drivers/phy/Kconfig                                |    8 ++
>   drivers/phy/Makefile                               |    3 +-
>   drivers/phy/phy-exynos-dp-video.c                  |  130 ++++++++++++++++++++
>   4 files changed, 147 insertions(+), 1 deletion(-)
>   create mode 100644 Documentation/devicetree/bindings/phy/samsung,exynos5250-dp-video-phy.txt
>   create mode 100644 drivers/phy/phy-exynos-dp-video.c
>
> diff --git a/Documentation/devicetree/bindings/phy/samsung,exynos5250-dp-video-phy.txt
> b/Documentation/devicetree/bindings/phy/samsung,exynos5250-dp-video-phy.txt
> new file mode 100644
> index 0000000..8b6fa79
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/samsung,exynos5250-dp-video-phy.txt

How about creating a single Documentation file for all samsung video phys? 
Sylwester?

Thanks
Kishon
