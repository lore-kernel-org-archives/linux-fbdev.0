From: Kukjin Kim <kgene.kim@samsung.com>
Date: Fri, 09 Jul 2010 11:33:28 +0000
Subject: RE: [PATCH 01/19] s3c-fb: Change to depending on CONFIG_S3C_FB_DEV
Message-Id: <028801cb1f5a$8fe5c970$afb15c50$%kim@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1278665407-18002-1-git-send-email-p.osciak@samsung.com>
	<1278665407-18002-2-git-send-email-p.osciak@samsung.com>
In-Reply-To: <1278665407-18002-2-git-send-email-p.osciak@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Pawel Osciak wrote:
> 
> From: Ben Dooks <ben-linux@fluff.org>
> 
> As suggested by Marek Szyprowski, we should make the driver depend on
> the configuration currently being used to build the platform device
> into the kernel.
> 
> Signed-off-by: Ben Dooks <ben-linux@fluff.org>
> Signed-off-by: Pawel Osciak <p.osciak@samsung.com>

Actually, already submitted by Ben Dooks.
http://lists.infradead.org/pipermail/linux-arm-kernel/2010-May/015616.html

So...I'm not sure adding your signedoff and re-submitting are right.

In my opinion, it's enough to add comments which includes information about
that without re-submitting.

> ---
>  drivers/video/Kconfig |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
> index 3d94a14..858f1ca 100644
> --- a/drivers/video/Kconfig
> +++ b/drivers/video/Kconfig
> @@ -1930,7 +1930,7 @@ config FB_TMIO_ACCELL
> 
>  config FB_S3C
>  	tristate "Samsung S3C framebuffer support"
> -	depends on FB && ARCH_S3C64XX
> +	depends on FB && S3C_DEV_FB
>  	select FB_CFB_FILLRECT
>  	select FB_CFB_COPYAREA
>  	select FB_CFB_IMAGEBLIT
> --

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

