From: Jingoo Han <jg1.han@samsung.com>
Date: Tue, 22 Jan 2013 04:17:47 +0000
Subject: Re: [PATCH 30/33] video: Convert to devm_ioremap_resource()
Message-Id: <000501cdf857$6f33c780$4d9b5680$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1358762966-20791-1-git-send-email-thierry.reding@avionic-design.de>
 <1358762966-20791-31-git-send-email-thierry.reding@avionic-design.de>
In-Reply-To: <1358762966-20791-31-git-send-email-thierry.reding@avionic-design.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: 'Thierry Reding' <thierry.reding@avionic-design.de>, linux-kernel@vger.kernel.org
Cc: 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>, 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>, 'Arnd Bergmann' <arnd@arndb.de>, 'Wolfram Sang' <w.sang@pengutronix.de>, 'Florian Tobias Schandinat' <FlorianSchandinat@gmx.de>, linux-fbdev@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>

On Monday, January 21, 2013 7:09 PM, Thierry wrote
> 
> Convert all uses of devm_request_and_ioremap() to the newly introduced
> devm_ioremap_resource() which provides more consistent error handling.
> 
> devm_ioremap_resource() provides its own error messages so all explicit
> error messages can be removed from the failure code paths.
> 
> Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
> Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
> Cc: linux-fbdev@vger.kernel.org
> ---
>  drivers/video/exynos/exynos_dp_core.c | 8 +++-----
>  drivers/video/jz4740_fb.c             | 6 +++---
>  drivers/video/omap2/dss/hdmi.c        | 8 +++-----
>  drivers/video/omap2/vrfb.c            | 9 ++++-----
>  drivers/video/s3c-fb.c                | 7 +++----
>  5 files changed, 16 insertions(+), 22 deletions(-)
> 

For drivers/video/s3c-fb.c, drivers/video/exynos/exynos_dp_core.c

Acked-by: Jingoo Han <jg1.han@samsung.com>


Best regards,
Jingoo Han


