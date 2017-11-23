From: Daniel Thompson <daniel.thompson@linaro.org>
Date: Thu, 23 Nov 2017 12:11:16 +0000
Subject: Re: [PATCH V2 24/29] backlight: deprecate pci_get_bus_and_slot()
Message-Id: <337c09a3-08c9-8172-8430-3579aee20829@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1511390964-9979-1-git-send-email-okaya@codeaurora.org>
 <1511390964-9979-25-git-send-email-okaya@codeaurora.org>
In-Reply-To: <1511390964-9979-25-git-send-email-okaya@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org



On 22/11/17 22:49, Sinan Kaya wrote:
> pci_get_bus_and_slot() is restrictive such that it assumes domain=0 as
> where a PCI device is present. This restricts the device drivers to be
> reused for other domain numbers.
> 
> Getting ready to remove pci_get_bus_and_slot() function in favor of
> pci_get_domain_bus_and_slot().
> 
> Hard-coding the domain as 0.
> 
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>

I've no opinion on the wisdom or otherwise of removing the restrictive 
API but, providing the removal of that API from the header file collects 
the appropriate ack, then:

Acked-by: Daniel Thompson <daniel.thompson@linaro.org>


> ---
>   drivers/video/backlight/apple_bl.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/video/backlight/apple_bl.c b/drivers/video/backlight/apple_bl.c
> index d843296..6a34ab9 100644
> --- a/drivers/video/backlight/apple_bl.c
> +++ b/drivers/video/backlight/apple_bl.c
> @@ -143,7 +143,7 @@ static int apple_bl_add(struct acpi_device *dev)
>   	struct pci_dev *host;
>   	int intensity;
>   
> -	host = pci_get_bus_and_slot(0, 0);
> +	host = pci_get_domain_bus_and_slot(0, 0, 0);
>   
>   	if (!host) {
>   		pr_err("unable to find PCI host\n");
> 
