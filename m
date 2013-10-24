From: Tomasz Stanislawski <t.stanislaws@samsung.com>
Date: Thu, 24 Oct 2013 15:13:55 +0000
Subject: Re: [PATCH 5/7] phy: Add driver for Exynos DP PHY
Message-Id: <52693933.8040809@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1381940896-9355-1-git-send-email-kishon@ti.com>
 <1381940896-9355-6-git-send-email-kishon@ti.com>
In-Reply-To: <1381940896-9355-6-git-send-email-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Kishon,
Recently, I posted 'simple-phy' driver.
It is a part of patchset for HDMI enabling on Exynos4 using Device Tree.

http://www.mail-archive.com/linux-samsung-soc@vger.kernel.org/msg23655.html

The simple-phy was dedicated for single register PHYs like HDMI or DP.
Using such a generic phy may help to avoid code duplication.

Regards,
Tomasz Stanislawski


On 10/16/2013 06:28 PM, Kishon Vijay Abraham I wrote:
> From: Jingoo Han <jg1.han@samsung.com>
> 
> Add a PHY provider driver for the Samsung Exynos SoC Display Port PHY.
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> Reviewed-by: Tomasz Figa <t.figa@samsung.com>
> Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
> Acked-by: Felipe Balbi <balbi@ti.com>
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  .../devicetree/bindings/phy/samsung-phy.txt        |    8 ++
>  drivers/phy/Kconfig                                |    7 ++
>  drivers/phy/Makefile                               |    1 +
>  drivers/phy/phy-exynos-dp-video.c                  |  111 ++++++++++++++++++++
>  4 files changed, 127 insertions(+)
>  create mode 100644 drivers/phy/phy-exynos-dp-video.c
> 

