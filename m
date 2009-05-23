From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: [PATCH 07/15] viafb: use proper pci config
 API
Date: Sat, 23 May 2009 08:52:04 +0200
Message-ID: <20090523085204.ab138b47.krzysztof.h1@poczta.fm>
References: <1242851333-325-1-git-send-email-HaraldWelte@viatech.com>
	<1242851333-325-2-git-send-email-HaraldWelte@viatech.com>
	<1242851333-325-3-git-send-email-HaraldWelte@viatech.com>
	<1242851333-325-4-git-send-email-HaraldWelte@viatech.com>
	<1242851333-325-5-git-send-email-HaraldWelte@viatech.com>
	<1242851333-325-6-git-send-email-HaraldWelte@viatech.com>
	<1242851333-325-7-git-send-email-HaraldWelte@viatech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <krzysztof.h1@poczta.fm>) id 1M7kzT-0001B2-SB
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 23 May 2009 06:45:55 +0000
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1M7kzJ-0006jd-Je for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 23 May 2009 06:45:55 +0000
In-Reply-To: <1242851333-325-7-git-send-email-HaraldWelte@viatech.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Harald Welte <HaraldWelte@viatech.com>
Cc: linux-fbdev-devel@lists.sourceforge.net

On Thu, 21 May 2009 04:28:45 +0800
Harald Welte <HaraldWelte@viatech.com> wrote:

> From: Harald Welte <laforge@gnumonks.org>
> 
> This patch alters viafb to use the proper Linux in-kernel API to access
> PCI configuration space, rather than poking at I/O ports by itself.
> 
> Signed-off-by: Harald Welte <HaraldWelte@viatech.com>
> ---

Acked-by: Krzysztof Helt <krzysztof.h1@wp.pl>

>  drivers/video/via/hw.c |   64 +++++++++++++++++++++++++++++------------------
>  drivers/video/via/hw.h |    4 +-
>  2 files changed, 41 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/video/via/hw.c b/drivers/video/via/hw.c
> index 6306c88..40b7c0c 100644
> --- a/drivers/video/via/hw.c
> +++ b/drivers/video/via/hw.c
> @@ -2599,24 +2599,37 @@ static void disable_second_display_channel(void)
>  	viafb_write_reg_mask(CR6A, VIACR, BIT6, BIT6);
>  }
>  
> +static u_int16_t via_function3[] = {
> +	CLE266_FUNCTION3, KM400_FUNCTION3, CN400_FUNCTION3, CN700_FUNCTION3,
> +	CX700_FUNCTION3, KM800_FUNCTION3, KM890_FUNCTION3, P4M890_FUNCTION3,
> +	P4M900_FUNCTION3, VX800_FUNCTION3, VX855_FUNCTION3,
> +};
> +
> +/* Get the BIOS-configured framebuffer size from PCI configuration space
> + * of function 3 in the respective chipset */
>  int viafb_get_fb_size_from_pci(void)
>  {
> -	unsigned long configid, deviceid, FBSize = 0;
> -	int VideoMemSize;
> -	int DeviceFound = false;
> -
> -	for (configid = 0x80000000; configid < 0x80010800; configid += 0x100) {
> -		outl(configid, (unsigned long)0xCF8);
> -		deviceid = (inl((unsigned long)0xCFC) >> 16) & 0xffff;
> -
> -		switch (deviceid) {
> -		case CLE266:
> -		case KM400:
> -			outl(configid + 0xE0, (unsigned long)0xCF8);
> -			FBSize = inl((unsigned long)0xCFC);
> -			DeviceFound = true;	/* Found device id */
> -			break;
> +	int i;
> +	u_int8_t offset = 0;
> +	u_int32_t FBSize;
> +	u_int32_t VideoMemSize;
> +
> +	/* search for the "FUNCTION3" device in this chipset */
> +	for (i = 0; i < ARRAY_SIZE(via_function3); i++) {
> +		struct pci_dev *pdev;
> +
> +		pdev = pci_get_device(PCI_VENDOR_ID_VIA, via_function3[i],
> +				      NULL);
> +		if (!pdev)
> +			continue;
> +
> +		DEBUG_MSG(KERN_INFO "Device ID = %x\n", pdev->device);
>  
> +		switch (pdev->device) {
> +		case CLE266_FUNCTION3:
> +		case KM400_FUNCTION3:
> +			offset = 0xE0;
> +			break;
>  		case CN400_FUNCTION3:
>  		case CN700_FUNCTION3:
>  		case CX700_FUNCTION3:
> @@ -2626,21 +2639,22 @@ int viafb_get_fb_size_from_pci(void)
>  		case P4M900_FUNCTION3:
>  		case VX800_FUNCTION3:
>  		case VX855_FUNCTION3:
> -			/*case CN750_FUNCTION3: */
> -			outl(configid + 0xA0, (unsigned long)0xCF8);
> -			FBSize = inl((unsigned long)0xCFC);
> -			DeviceFound = true;	/* Found device id */
> -			break;
> -
> -		default:
> +		/*case CN750_FUNCTION3: */
> +			offset = 0xA0;
>  			break;
>  		}
> -
> -		if (DeviceFound)
> +		
> +		if (!offset)
>  			break;
> +
> +		pci_read_config_dword(pdev, offset, &FBSize);
> +		pci_dev_put(pdev);
>  	}
>  
> -	DEBUG_MSG(KERN_INFO "Device ID = %lx\n", deviceid);
> +	if (!offset) {
> +		printk(KERN_ERR "cannot determine framebuffer size\n");
> +		return -EIO;
> +	}
>  
>  	FBSize = FBSize & 0x00007000;
>  	DEBUG_MSG(KERN_INFO "FB Size = %x\n", FBSize);
> diff --git a/drivers/video/via/hw.h b/drivers/video/via/hw.h
> index 1cd0648..a69e907 100644
> --- a/drivers/video/via/hw.h
> +++ b/drivers/video/via/hw.h
> @@ -850,8 +850,8 @@ struct iga2_crtc_timing {
>  };
>  
>  /* device ID */
> -#define CLE266              0x3123
> -#define KM400               0x3205
> +#define CLE266_FUNCTION3    0x3123
> +#define KM400_FUNCTION3     0x3205
>  #define CN400_FUNCTION2     0x2259
>  #define CN400_FUNCTION3     0x3259
>  /* support VT3314 chipset */
> -- 
> 1.6.2.4
> 
> 
> ------------------------------------------------------------------------------
> Crystal Reports - New Free Runtime and 30 Day Trial
> Check out the new simplified licensing option that enables 
> unlimited royalty-free distribution of the report engine 
> for externally facing server and web deployment. 
> http://p.sf.net/sfu/businessobjects
> _______________________________________________
> Linux-fbdev-devel mailing list
> Linux-fbdev-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel
> 

----------------------------------------------------------------------
Chcesz miec nawigacje GPS ?
Zamow lub przedluz umowe na neostrade, a nawigacja bedzie Twoja.
Kliknij na link po szczegoly! http://link.interia.pl/f219a



------------------------------------------------------------------------------
Register Now for Creativity and Technology (CaT), June 3rd, NYC. CaT
is a gathering of tech-side developers & brand creativity professionals. Meet
the minds behind Google Creative Lab, Visual Complexity, Processing, & 
iPhoneDevCamp asthey present alongside digital heavyweights like Barbarian
Group, R/GA, & Big Spaceship. http://www.creativitycat.com 
