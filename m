From: Tomasz Figa <tomasz.figa@gmail.com>
Date: Fri, 05 Jul 2013 23:11:02 +0000
Subject: Re: [PATCH V4 3/4] video: exynos_dp: remove non-DT support for Exynos Display Port
Message-Id: <2149220.dCp7esoXHa@flatron>
List-Id: <linux-fbdev.vger.kernel.org>
References: <000c01ce76ff$fffa39d0$ffeead70$@samsung.com>
In-Reply-To: <000c01ce76ff$fffa39d0$ffeead70$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Jingoo,

On Tuesday 02 of July 2013 17:41:52 Jingoo Han wrote:
> Exynos Display Port can be used only for Exynos SoCs. In addition,
> non-DT for EXYNOS SoCs is be supported from v3.11; thus, there is
> no need to support non-DT for Exynos Display Port.
> 
> The 'include/video/exynos_dp.h' file has been used for non-DT
> support and the content of file include/video/exynos_dp.h is moved
> to drivers/video/exynos/exynos_dp_core.h. Thus, the 'exynos_dp.h'
> file is removed. Also, 'struct exynos_dp_platdata' is removed,
> because it is not used any more.
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> ---
>  drivers/video/exynos/Kconfig          |    2 +-
>  drivers/video/exynos/exynos_dp_core.c |  116
> +++++++---------------------- drivers/video/exynos/exynos_dp_core.h | 
> 109 +++++++++++++++++++++++++++ drivers/video/exynos/exynos_dp_reg.c  |
>    2 -
>  include/video/exynos_dp.h             |  131
> --------------------------------- 5 files changed, 135 insertions(+),
> 225 deletions(-)
>  delete mode 100644 include/video/exynos_dp.h

Reviewed-by: Tomasz Figa <t.figa@samsung.com>

Best regards,
Tomasz

