From: Jingoo Han <jg1.han@samsung.com>
Date: Thu, 28 Nov 2013 04:39:04 +0000
Subject: Re: [PATCH 01/28] video: arkfb: use DEFINE_PCI_DEVICE_TABLE macro
Message-Id: <005601ceebf3$c43808f0$4ca81ad0$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <002901ceebe7$c3eec160$4bcc4420$%han@samsung.com>
In-Reply-To: <002901ceebe7$c3eec160$4bcc4420$%han@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Thursday, November 28, 2013 12:13 PM, Jingoo Han
> 
> This macro is used to create a struct pci_device_id array.
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>

Please, ignore these patches.
According to the Greg Kroah-Hartman, 

"Yeah, and it's a horrid macro that deserves to be removed, please don't
use it in more places.

Actually, if you could just remove it, that would be best, sorry, I'm
not going to take these patches."

So, I will send the patch to remove 'DEFINE_PCI_DEVICE_TABLE' instead.
Sorry for annoying. :-)

Best regards,
Jingoo Han

> ---
>  drivers/video/arkfb.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/video/arkfb.c b/drivers/video/arkfb.c
> index a6b29bd..cc9f8a2 100644
> --- a/drivers/video/arkfb.c
> +++ b/drivers/video/arkfb.c
> @@ -1183,7 +1183,7 @@ fail:
> 
>  /* List of boards that we are trying to support */
> 
> -static struct pci_device_id ark_devices[] = {
> +static DEFINE_PCI_DEVICE_TABLE(ark_devices) = {
>  	{PCI_DEVICE(0xEDD8, 0xA099)},
>  	{0, 0, 0, 0, 0, 0, 0}
>  };
> --
> 1.7.10.4


