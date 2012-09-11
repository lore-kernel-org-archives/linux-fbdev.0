From: Jingoo Han <jg1.han@samsung.com>
Date: Tue, 11 Sep 2012 02:31:23 +0000
Subject: Re: [PATCH v2] fbdev: Add Renesas vdc4 framebuffer driver
Message-Id: <000801cd8fc5$8931bd40$9b9537c0$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1347267372-22949-1-git-send-email-phil.edworthy@renesas.com>
In-Reply-To: <1347267372-22949-1-git-send-email-phil.edworthy@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Monday, September 10, 2012 5:56 PM Phil Edworthy wrote
> 
> The vdc4 display hardware is found on the sh7269 device.
> 
> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>


Reviewed-by: Jingoo Han <jg1.han@samsung.com>

Best regards,
Jingoo Han


> ---
> v2:
>  * Use devm_ variants of clk_get, ioremap_nocache, request_irq.
>  * Replace spaces with tabs.
>  * Check ren_vdc4_start return value.
>  * Fix headers used.
> 
>  drivers/video/Kconfig      |   10 +
>  drivers/video/Makefile     |    1 +
>  drivers/video/ren_vdc4fb.c |  641 ++++++++++++++++++++++++++++++++++++++++++++
>  include/video/ren_vdc4fb.h |   19 ++
>  4 files changed, 671 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/video/ren_vdc4fb.c
>  create mode 100644 include/video/ren_vdc4fb.h


