From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Tue, 20 Dec 2011 08:28:02 +0000
Subject: Re: [PATCH v3] video: support MIPI-DSI controller driver
Message-Id: <20111220082802.GR14542@n2100.arm.linux.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <4EF00557.2000201@samsung.com>
In-Reply-To: <4EF00557.2000201@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tue, Dec 20, 2011 at 12:47:35PM +0900, Donghwa Lee wrote:
> 
> Samsung S5PC210 and EXYNOS SoC platform has MIPI-DSI controller and MIPI-DSI
> based LCD Panel could be used with it. This patch supports MIPI-DSI driver
> based Samsung SoC chip.
> 
> LCD panel driver based MIPI-DSI should be registered to MIPI-DSI driver at
> machine code and LCD panel driver specific function registered to mipi_dsim_ddi
> structure at lcd panel init function called system init.
> In the MIPI-DSI driver, find lcd panel driver by using registered
> lcd panel name, and then initialize lcd panel driver.
> 
> Changes since v2:
> 	- support regulators control in the driver.
> 	- avoid type casting and use array to read easily in data write
> 	  function.
> 	- etc.
> 
> Signed-off-by: Donghwa Lee <dh09.lee@samsung.com>
> Signed-off-by: Inki Dae <inki.dae@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  drivers/video/Kconfig                 |    7 +
>  drivers/video/Makefile                |    2 +
>  drivers/video/s5p_mipi_dsi.c          |  619 ++++++++++++++++++++++
>  drivers/video/s5p_mipi_dsi_common.c   |  902 +++++++++++++++++++++++++++++++++
>  drivers/video/s5p_mipi_dsi_common.h   |   46 ++
>  drivers/video/s5p_mipi_dsi_lowlevel.c |  627 +++++++++++++++++++++++
>  drivers/video/s5p_mipi_dsi_lowlevel.h |  112 ++++
>  drivers/video/s5p_mipi_dsi_regs.h     |  156 ++++++
>  include/linux/mipi_dsim.h             |  361 +++++++++++++
>  9 files changed, 2832 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/video/s5p_mipi_dsi.c
>  create mode 100644 drivers/video/s5p_mipi_dsi_common.c
>  create mode 100644 drivers/video/s5p_mipi_dsi_common.h
>  create mode 100644 drivers/video/s5p_mipi_dsi_lowlevel.c
>  create mode 100644 drivers/video/s5p_mipi_dsi_lowlevel.h
>  create mode 100644 drivers/video/s5p_mipi_dsi_regs.h
>  create mode 100644 include/linux/mipi_dsim.h
> 
> diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
> index d83e967..879177b 100644
> --- a/drivers/video/Kconfig
> +++ b/drivers/video/Kconfig
> @@ -2082,6 +2082,13 @@ config FB_S3C2410_DEBUG
>  	  Turn on debugging messages. Note that you can set/unset at run time
>  	  through sysfs
>  
> +config S5P_MIPI_DSI
> +	tristate "Samsung SoC MIPI-DSI support."
> +	depends on FB_S3C && (ARCH_S5PV210 || ARCH_S5PV310 || ARCH_EXYNOS)
> +	default n

default n is the default default, so there's no point explicltly
specifying the default default default.
