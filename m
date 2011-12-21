From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Wed, 21 Dec 2011 21:42:06 +0000
Subject: Re: [PATCH] MAINTAINERS: add a maintainer for Samsung Framebuffer
Message-Id: <4EF252AE.70003@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <003c01ccbdf3$41843df0$c48cb9d0$%han@samsung.com>
In-Reply-To: <003c01ccbdf3$41843df0$c48cb9d0$%han@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On 12/19/2011 02:09 AM, Jingoo Han wrote:
> Add a maintainer for Samsung Framebuffer driver.
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> Cc: Ben Dooks <ben-linux@fluff.org>

Applied.


Thanks,

Florian Tobias Schandinat

> ---
>  MAINTAINERS |    6 ++++++
>  1 files changed, 6 insertions(+), 0 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 855afd4..a03e288 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5667,6 +5667,12 @@ L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
>  S:	Supported
>  F:	sound/soc/samsung
>  
> +SAMSUNG FRAMEBUFFER DRIVER
> +M:	Jingoo Han <jg1.han@samsung.com>
> +L:	linux-fbdev@vger.kernel.org
> +S:	Maintained
> +F:	drivers/video/s3c-fb.c
> +
>  SERIAL DRIVERS
>  M:	Alan Cox <alan@linux.intel.com>
>  L:	linux-serial@vger.kernel.org

