From: Xinliang Liu <xinliang.liu@linaro.org>
Date: Mon, 30 May 2016 02:31:53 +0000
Subject: Re: [path v2 7/7] drm/hisilicon/hibmc: Add maintainer for Hibmc DRM
Message-Id: <CAGd==07sV0qaDES5D5ozvkC1FDQXZ-Z9_UCNX8vO09HKBktq3w@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1464514855-108050-1-git-send-email-zourongrong@gmail.com>
 <1464514855-108050-8-git-send-email-zourongrong@gmail.com>
In-Reply-To: <1464514855-108050-8-git-send-email-zourongrong@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rongrong Zou <zourongrong@gmail.com>
Cc: linux-fbdev@vger.kernel.org, Emil Velikov <emil.l.velikov@gmail.com>, Linuxarm <linuxarm@huawei.com>, dri-devel <dri-devel@lists.freedesktop.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, LAKML <linux-arm-kernel@lists.infradead.org>, Hanjun Guo <guohanjun@huawei.com>, Rongrong Zou <zourongrong@huawei.com>, majun258@huawei.com

On 29 May 2016 at 17:40, Rongrong Zou <zourongrong@gmail.com> wrote:
> Signed-off-by: Rongrong Zou <zourongrong@gmail.com>
> Signed-off-by: Jianhua Li <lijianhua@huawei.com>
> ---
>  MAINTAINERS | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f466673..a8a62e0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3957,6 +3957,13 @@ T:       git git://github.com/patjak/drm-gma500
>  S:     Maintained
>  F:     drivers/gpu/drm/gma500/
>
> +DRM DRIVERS FOR HIBMC
> +M:     lijianhua <lijianhua@huawei.com>
> +M:     Rongrong Zou <zourongrong@gmail.com>
> +L:     dri-devel@lists.freedesktop.org
> +S:     Maintained
> +F:     drivers/gpu/drm/hisilicon/hibmc

Please add a "/" ad the end of this line.
And move this part into DRM DRIVERS FOR HISILICON

Thanks,
-xinliang

> +
>  DRM DRIVERS FOR HISILICON
>  M:     Xinliang Liu <z.liuxinliang@hisilicon.com>
>  R:     Xinwei Kong <kong.kongxinwei@hisilicon.com>
> --
> 1.9.1
>
