Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA29168B9
	for <linux-fbdev@vger.kernel.org>; Fri,  2 Feb 2024 17:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706896215; cv=none; b=Eoxgqq+8PFhgrpOHQ8KdXGk9fH690KMI/oJJtSyMZbfewrnQhGzJ2TQndAgs8i5s41aMlyaoGVSTAsisGd0USpa3VyDiGlQYnvCX2emVKSnslxWpVrBc2QD0TeckJIuHS2tkpZ9tewDcOrtEAyrHTFnLbBMiD2X7aaDX27VMbAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706896215; c=relaxed/simple;
	bh=17WxI6Z7MkY+zDf2Nd+Sr0hXcOCPhEbXf7SvxW61fO8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lxc4jVwlDzI+Svsdc/ynedip8qUeGp5bnAbceqcfCaR2H71ioo5yVKeBcOzdMP7ZeHKxliTb7FFF8tP4hDZtXQBIOKFL80R58iYt3QPHgWKSZ/Oi5GXOvCgpCD0wQ0obdzxR3hJML7AXwVerKrx3Qyalp2ZHv4zIoXIxHUm7z1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uRazlhx5; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uRazlhx5"
Message-ID: <2bbaab9a-3b4c-4c70-b1b2-09bc265d0476@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706896209;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=glz+Whkt9eR1IOU+DpFpEwRTsaEbA18tocKSIn5mkyQ=;
	b=uRazlhx5PRpyrK7j2RFoJmbPznTNczDUf8E2m8ARPEQ9tZRay7lAXwD/R0B7S766xt1Uub
	LlyfdqTgXjN8CPSUVg6b4zxAa2TseQT0OIHcZi86BDI0MpU2TSSRBRpqa4cu50MYwZ9Xsk
	W2PvXo1wQo4uXEPZn5zNvu1+y8g3r+g=
Date: Sat, 3 Feb 2024 01:50:01 +0800
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [v2,5/8] firmware/sysfb: Create firmware device only for enabled
 PCI devices
Content-Language: en-US
To: Thomas Zimmermann <tzimmermann@suse.de>, javierm@redhat.com,
 pjones@redhat.com, deller@gmx.de, ardb@kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
References: <20240202120140.3517-6-tzimmermann@suse.de>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sui Jingfeng <sui.jingfeng@linux.dev>
In-Reply-To: <20240202120140.3517-6-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

HI,


On 2024/2/2 19:58, Thomas Zimmermann wrote:
> Test if the firmware framebuffer's parent PCI device, if any, has
> been enabled. If not, the firmware framebuffer is most likely not
> working. Hence, do not create a device for the firmware framebuffer
> on disabled PCI devices.
>
> So far, efifb tracked the status of the PCI parent device internally
> and did not bind if it was disabled. This patch implements the
> functionality for all firmware framebuffers.


For *all* ?

I think the functionality this patch implemented is only target for the
PCIe device firmware framebuffers, the framebuffer consumed by the simplefb
driver (fbdev/simplefb.c) is also a kind of firmware framebuffer, but it is
target for the platform device only.

So, the correct description would be: "this patch implements the functionality
for the PCIe firmware framebuffers".

> v2:
> 	* rework sysfb_pci_dev_is_enabled() (Javier)
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
> ---
>   drivers/firmware/sysfb.c | 30 +++++++++++++++++++++++++++++-
>   1 file changed, 29 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/firmware/sysfb.c b/drivers/firmware/sysfb.c
> index d02945b0d8ea1..ab5cbc0326f6d 100644
> --- a/drivers/firmware/sysfb.c
> +++ b/drivers/firmware/sysfb.c
> @@ -70,13 +70,39 @@ void sysfb_disable(void)
>   }
>   EXPORT_SYMBOL_GPL(sysfb_disable);
>   
> +#if defined(CONFIG_PCI)
> +static __init bool sysfb_pci_dev_is_enabled(struct pci_dev *pdev)
> +{
> +	/*
> +	 * TODO: Try to integrate this code into the PCI subsystem
> +	 */
> +	int ret;
> +	u16 command;
> +
> +	ret = pci_read_config_word(pdev, PCI_COMMAND, &command);
> +	if (ret != PCIBIOS_SUCCESSFUL)
> +		return false;
> +	if (!(command & PCI_COMMAND_MEMORY))
> +		return false;
> +	return true;
> +}
> +#else
> +static __init bool sysfb_pci_dev_is_enabled(struct pci_dev *pdev)
> +{
> +	return false;
> +}
> +#endif
> +
>   static __init struct device *sysfb_parent_dev(const struct screen_info *si)
>   {
>   	struct pci_dev *pdev;
>   
>   	pdev = screen_info_pci_dev(si);
> -	if (pdev)
> +	if (pdev) {
> +		if (!sysfb_pci_dev_is_enabled(pdev))
> +			return ERR_PTR(-ENODEV);


Is it better to move the call of sysfb_pci_dev_is_enabled() out of sysfb_parent_dev() ?
Because then we don't need check the returned value by calling the IS_ERR() inthe sysfb_init() function.


>   		return &pdev->dev;
> +	}
>   
>   	return NULL;
>   }
> @@ -97,6 +123,8 @@ static __init int sysfb_init(void)
>   	sysfb_apply_efi_quirks();
>   
>   	parent = sysfb_parent_dev(si);
> +	if (IS_ERR(parent))
> +		goto unlock_mutex;

	if (!sysfb_pci_dev_is_enabled(parent))
		goto unlock_mutex;

>   
>   	/* try to create a simple-framebuffer device */
>   	compatible = sysfb_parse_mode(si, &mode);
