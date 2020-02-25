From: Randy Dunlap <rdunlap@infradead.org>
Date: Tue, 25 Feb 2020 16:33:29 +0000
Subject: Re: [PATCH] Initialize ATA before graphics
Message-Id: <0da5bb70-2e55-0fa2-d950-3832f9ff7bcd@infradead.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <041f4abd-f894-b990-b320-bf0aab4242f2@molgen.mpg.de>
In-Reply-To: <041f4abd-f894-b990-b320-bf0aab4242f2@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Menzel <pmenzel@molgen.mpg.de>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Hans de Goede <hdegoede@redhat.com>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, LKML <linux-kernel@vger.kernel.org>
Cc: linux-ide@vger.kernel.org, linux-fbdev@vger.kernel.org, Arjan van de Ven <arjan@linux.intel.com>, linux-nvme@lists.infradead.org, dri-devel@lists.freedesktop.org

Hi Paul,
You should have also Cc-ed Arjan on this email. [done]


On 2/24/20 6:09 AM, Paul Menzel wrote:
> From: Arjan van de Ven <arjan@linux.intel.com>
> Date: Thu, 2 Jun 2016 23:36:32 -0500
> 
> ATA init is the long pole in the boot process, and its asynchronous.
> Move the graphics init after it, so that ATA and graphics initialize
> in parallel.
> 
> Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
> ---
> 
> 1.  Taken from Clear Linux: https://github.com/clearlinux-pkgs/linux/commits/master/0110-Initialize-ata-before-graphics.patch
> 2.  Arjan, can you please add your Signed-off-by line?
> 
>  drivers/Makefile | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/Makefile b/drivers/Makefile
> index aaef17c..d08f3a3 100644
> --- a/drivers/Makefile
> +++ b/drivers/Makefile
> @@ -58,15 +58,8 @@ obj-y                                += char/
>  # iommu/ comes before gpu as gpu are using iommu controllers
>  obj-y                          += iommu/
>  
> -# gpu/ comes after char for AGP vs DRM startup and after iommu
> -obj-y                          += gpu/
> -
>  obj-$(CONFIG_CONNECTOR)                += connector/
>  
> -# i810fb and intelfb depend on char/agp/
> -obj-$(CONFIG_FB_I810)           += video/fbdev/i810/
> -obj-$(CONFIG_FB_INTEL)          += video/fbdev/intelfb/
> -
>  obj-$(CONFIG_PARPORT)          += parport/
>  obj-$(CONFIG_NVM)              += lightnvm/
>  obj-y                          += base/ block/ misc/ mfd/ nfc/
> @@ -79,6 +72,14 @@ obj-$(CONFIG_IDE)            += ide/
>  obj-y                          += scsi/
>  obj-y                          += nvme/
>  obj-$(CONFIG_ATA)              += ata/
> +
> +# gpu/ comes after char for AGP vs DRM startup and after iommu
> +obj-y                          += gpu/
> +
> +# i810fb and intelfb depend on char/agp/
> +obj-$(CONFIG_FB_I810)           += video/fbdev/i810/
> +obj-$(CONFIG_FB_INTEL)          += video/fbdev/intelfb/
> +
>  obj-$(CONFIG_TARGET_CORE)      += target/
>  obj-$(CONFIG_MTD)              += mtd/
>  obj-$(CONFIG_SPI)              += spi/
> 


-- 
~Randy
Reported-by: Randy Dunlap <rdunlap@infradead.org>
