From: Rob Clark <robdclark@gmail.com>
Date: Wed, 17 Jan 2018 21:52:45 +0000
Subject: Re: [PATCH 2/2] drm/msm/adreno: fix nvmem related link error
Message-Id: <CAF6AEGsTe7-1FP5zrDDVyYuBw8ZVXH=TObzU+a1bNV7TH0n66w@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180115161431.803248-1-arnd@arndb.de> <20180115161431.803248-2-arnd@arndb.de>
In-Reply-To: <20180115161431.803248-2-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>
Cc: Jordan Crouse <jcrouse@codeaurora.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, dri-devel <dri-devel@lists.freedesktop.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, David Airlie <airlied@linux.ie>, Bjorn Andersson <bjorn.andersson@linaro.org>, Archit Taneja <architt@codeaurora.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, freedreno <freedreno@lists.freedesktop.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Mon, Jan 15, 2018 at 11:14 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> When NVMEM is configured as a loadable module, and adreno
> is built-in, we get a link failure:
>
> drivers/gpu/drm/msm/adreno/a5xx_gpu.o: In function `a5xx_gpu_init':
> a5xx_gpu.c:(.text+0x15cc): undefined reference to `nvmem_cell_get'
> a5xx_gpu.c:(.text+0x15da): undefined reference to `nvmem_cell_read'
> a5xx_gpu.c:(.text+0x15e4): undefined reference to `nvmem_cell_put'
>
> This adds a Kconfig dependency to enforce valid configurations,
> when NVMEM is a loadable module, adreno now has to also be one.
> The code seems to deal fine with nvmem being completely disabled,
> it will just not set the right speed bin then, so we don't need
> a hard dependency.
>
> Fixes: f56d9df656c4 ("drm/msm/adreno: Read the speed bins for a5xx targets")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Arnd, beyond randconfig, I guess there are probably two real-world
scenarios, both =m (distro) and both =y (android/oe/etc)..

Is there a kconfig way to say if nvmem=m then drm_msm must be =n or =m?

BR,
-R


> ---
>  drivers/gpu/drm/msm/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/msm/Kconfig b/drivers/gpu/drm/msm/Kconfig
> index 99d39b2aefa6..74fb1c816da9 100644
> --- a/drivers/gpu/drm/msm/Kconfig
> +++ b/drivers/gpu/drm/msm/Kconfig
> @@ -4,6 +4,7 @@ config DRM_MSM
>         depends on DRM
>         depends on ARCH_QCOM || (ARM && COMPILE_TEST)
>         depends on OF && COMMON_CLK
> +       depends on NVMEM || !NVMEM
>         depends on MMU
>         select QCOM_MDT_LOADER if ARCH_QCOM
>         select REGULATOR
> --
> 2.9.0
>
