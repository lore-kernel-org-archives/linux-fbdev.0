From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: [PATCH 2/2] viafb: use proper pci config API
Date: Tue, 19 May 2009 23:24:27 +0200
Message-ID: <20090519232427.ca64ac83.krzysztof.h1@poczta.fm>
References: <20090519083534.GI19746@prithivi.gnumonks.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <krzysztof.h1@poczta.fm>) id 1M6Whg-00057v-Cu
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 19 May 2009 21:18:28 +0000
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1M6Whb-0008FW-ML for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 19 May 2009 21:18:28 +0000
In-Reply-To: <20090519083534.GI19746@prithivi.gnumonks.org>
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
Cc: JosephChan@via.com.tw, ScottFang@viatech.com.cn, linux-fbdev-devel@lists.sourceforge.net

On Tue, 19 May 2009 16:35:34 +0800
Harald Welte <HaraldWelte@viatech.com> wrote:

> This patch alters viafb to use the proper Linux in-kernel API to access
> PCI configuration space, rather than poking at I/O ports by itself.
> 
> It also removes a minor inconsistency with naming of constants for the
> PCI device ID of the FUNCTION3 devices.
> 
> Signed-off-by: Harald Welte <HaraldWelte@viatech.com>
> ---
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

Can  you pass the pdev pointer from the probe function
here and skip the whole searching of the PCI device?

Regards,
Krzysztof

----------------------------------------------------------------------
Audi kilka tysiecy zlotych taniej? Przebieraj wsrod tysiecy ogloszen!
Sprawdz: http://link.interia.pl/f216f


------------------------------------------------------------------------------
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables 
unlimited royalty-free distribution of the report engine 
for externally facing server and web deployment. 
http://p.sf.net/sfu/businessobjects
