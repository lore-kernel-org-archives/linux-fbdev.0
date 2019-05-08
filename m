From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Wed, 08 May 2019 12:20:10 +0000
Subject: Re: [PATCH 09/16] mmc: sdhci-xenon: use new match_string() helper/macro
Message-Id: <20190508122010.GC21059@kadam>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190508112842.11654-1-alexandru.ardelean@analog.com>
 <20190508112842.11654-11-alexandru.ardelean@analog.com>
In-Reply-To: <20190508112842.11654-11-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc: linux-fbdev@vger.kernel.org, kvm@vger.kernel.org, linux-pci@vger.kernel.org, alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org, linux-ide@vger.kernel.org, linux-mtd@lists.infradead.org, linux-clk@vger.kernel.org, devel@driverdev.osuosl.org, andriy.shevchenko@linux.intel.com, linux-rockchip@lists.infradead.org, linux-mmc@vger.kernel.org, linux-pm@vger.kernel.org, intel-gfx@lists.freedesktop.org, linux-gpio@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, linux-tegra@vger.kernel.org, cgroups@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, netdev@vger.kernel.org, linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, gregkh@linuxfoundation.org, linux-integrity@vger.kernel.org, linuxppc-dev@lists.ozlabs.org

On Wed, May 08, 2019 at 02:28:35PM +0300, Alexandru Ardelean wrote:
> -static const char * const phy_types[] = {
> -	"emmc 5.0 phy",
> -	"emmc 5.1 phy"
> -};
> -
>  enum xenon_phy_type_enum {
>  	EMMC_5_0_PHY,
>  	EMMC_5_1_PHY,
>  	NR_PHY_TYPES

There is no need for NR_PHY_TYPES now so you could remove that as well.

regards,
dan carpenter
