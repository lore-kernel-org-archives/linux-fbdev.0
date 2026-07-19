Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA51143F084;
	Sun, 19 Jul 2026 03:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784431925; cv=none; b=N0cfrjAPOi3z3GpWvEEcLaPv+L/oBMOBOUgjgfrHhcCcc54WzuCIN8w0b1w+xECB0D701vHwfiHcOrI9VaI1SCoOFVlbrwXS3fkEdmaqsclT6Ay42rttEe/0SZq7g/vQPbAt8kreA/OqRAj06Xtgofqnmt8WUsTOHsW/GoZloww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784431925; c=relaxed/simple;
	bh=q5w5X4NZWaApqAwCacls8/fv15P//ZF9wlA+e0rVim8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EnCF2gjfUoJ4xX8n8Isll91Xh1pljyY+XeqroaCvZVfbMgv2CTAhCJ9PAwBp3Xd6G74zFzkp3ftMCICB6pCCJGwoW70RWzSHs595JcUt7lzGdXPLTWtnAFkZycUl55j21iUCke7Fk7xUnCC7Gm/izz0Q3AuPwX2fMfQ52ayfCdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=FlEH7EpI; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FlEH7EpI"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=Rjc+gerhmCYCzaJXtcxnv4SN3FPtKy2qexZHFwrRceo=; b=FlEH7EpIwbSOZSMe23Qkbfs4TC
	SFUvXVlrMFg873exOk9drhpldlXq/jqZPSVj5NAioI7plec3AaE8IkQQndedtI3+XT9CUjvLnDkgU
	gLTANWBTwmR02A803BNCdCOIAKNCGjrwfsEzj6kNJVH23B9b7TsamzGBq+dVbxzhGikTxsubnVd5u
	yAEDJOdFmCtlohK7agc1yVws533s46PTBJ9s3lJiaq1MumVBdBMEQARYYpab/WKVPKiOV/iQPMo22
	67/BT4hlIkPiJ2O+HahupDgMqadFLvepH6zXQnlx1qJfcqEYBQdKJ4nABUXsXf2p1+SGuEu4QbY47
	CH1MDF2Q==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wlIFu-00000004iVh-2jcs;
	Sun, 19 Jul 2026 03:31:54 +0000
Message-ID: <ccb5e897-6974-4492-887f-62aea074c62e@infradead.org>
Date: Sat, 18 Jul 2026 20:31:54 -0700
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] backlight: ktd2801: fix unmet dependency on GPIOLIB
To: Julian Braha <julianbraha@gmail.com>, lee@kernel.org, danielt@kernel.org,
 jingoohan1@gmail.com, deller@gmx.de
Cc: duje@dujemihanovic.xyz, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, arnd@arndb.de
References: <20260719024902.151710-1-julianbraha@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260719024902.151710-1-julianbraha@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 7/18/26 7:49 PM, Julian Braha wrote:
> LEDS_EXPRESSWIRE depends on GPIOLIB, so its selector, BACKLIGHT_KTD2801
> also needs to ensure GPIOLIB is enabled. Otherwise:
> 
> WARNING: unmet direct dependencies detected for LEDS_EXPRESSWIRE
>   Depends on [n]: NEW_LEDS [=n] && GPIOLIB [=n]
>   Selected by [y]:
>   - BACKLIGHT_KTD2801 [=y] && HAS_IOMEM [=y] && BACKLIGHT_CLASS_DEVICE [=y]
> 
> This unmet dependency was found by kconfirm, a static analysis tool for
> Kconfig.

or it can be hand-crafted and the warning seen by 'make oldconfig' etc.


> Fixes: d95963e309bc ("backlight: ktd2801: Depend on GPIOLIB")
> Signed-off-by: Julian Braha <julianbraha@gmail.com>
> ---
>  drivers/video/backlight/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kconfig
> index 7c66b8840d88..dbf4ca23a9b6 100644
> --- a/drivers/video/backlight/Kconfig
> +++ b/drivers/video/backlight/Kconfig
> @@ -193,7 +193,7 @@ config BACKLIGHT_KTD253
>  
>  config BACKLIGHT_KTD2801
>  	tristate "Backlight Driver for Kinetic KTD2801"
> -	depends on GPIOLIB || COMPILE_TEST
> +	depends on GPIOLIB
>  	select LEDS_EXPRESSWIRE
>  	help
>  	  Say Y to enable the backlight driver for the Kinetic KTD2801 1-wire

Well, ktd2801.ko is being built for me with no warnings and I have:
COMPILE_TEST=y
GPIOLIB=n
BACKLIGHT_KTD2801=m

but we do want to eliminate the warning, so:

Tested-by: Randy Dunlap <rdunlap@infradead.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org>

thanks.
-- 
~Randy
