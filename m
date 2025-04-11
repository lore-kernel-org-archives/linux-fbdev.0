Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01F723E35D;
	Fri, 11 Apr 2025 21:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744405658; cv=none; b=S/R2Udv7JSXXDiLiJ/p0vQWW3dAsMbs//y5TtEe2ETYlhDMfrpuGZT1hZOaGv+D+zWzTZ2puXGi1T4IfEGxUGB+zIEytGgYewXbjy28TRMon7CT06RCDsW6y23Iy+FDR+Ahdx4Hdo0JgU+6w4R4Ksoi/eq2xeThl1XsjUXgasao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744405658; c=relaxed/simple;
	bh=j4W2OtgdLyFsgT7QtcMnu8DHrgkb4TesSKvi5TVw0SE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m3rJlpTF08dR9+zYBOEXNNuDOlUsc3v3pXRZHH3ADysxZKiu3ZalQDrCLIIkAJvRA3Vn8s7mb8ojWADro82WNbz8e9G4u3NbIh9PK3xNZY2K4zTrjhYju1HC9GDEW3xTLzpeTvfK4K2H66GO0XcpQ2Djn/eClOW16434bGH/nPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=oYxRtJfA; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oYxRtJfA"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=5ao/hAEK1tVECI3MffyX4CyT/zLaj3fsGpJIOrxlYbs=; b=oYxRtJfA8n7+wbug1XMpDb8jVb
	TAyW2sBXKhvwwhtvIXy9Xa/2mzgAFAL/Dh45l08V3+A/RH0zgv8juv+Pxeh6l+yFOLh5MXKizXYrw
	xjUdGn+vyp5Nao20+31I8V7IOBugD1sjk4qj6Ib303/jYS9p4QZuWkmPptsL+Bqgo1vY2xSUYVX2G
	C0uSMpJ4tbxI3OZFsX+PcnXzlZl5WRZ4jZbQblHoyQDPXP6j2cTdKE5i557zB6JqqQLdrRkp643oe
	9gnXFKsyo/RIqGbkV25z64iIM+B0NWfTljJajYzeUBrmjnYxhf0cGA7Mxx4TVD6xjRESgeexg53+8
	4jyyabWw==;
Received: from [50.39.124.201] (helo=[192.168.254.17])
	by desiato.infradead.org with esmtpsa (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u3Lau-000000095I7-2VSU;
	Fri, 11 Apr 2025 21:07:26 +0000
Message-ID: <dcc36d2f-8dad-47f9-b7c4-4e1f558545ff@infradead.org>
Date: Fri, 11 Apr 2025 14:07:20 -0700
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] backlight: ktd2801: depend on GPIOLIB
To: duje.mihanovic@skole.hr, Lee Jones <lee@kernel.org>,
 Daniel Thompson <danielt@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
 Helge Deller <deller@gmx.de>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250411-ktd-fix-v1-1-e7425d273268@skole.hr>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250411-ktd-fix-v1-1-e7425d273268@skole.hr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 4/11/25 10:22 AM, Duje Mihanović via B4 Relay wrote:
> From: Duje Mihanović <duje.mihanovic@skole.hr>
> 
> The ExpressWire library used by the driver depends on GPIOLIB, and by
> extension the driver does as well. This is not reflected in the driver's
> Kconfig entry, potentially causing Kconfig warnings. Fix this by adding
> the dependency.
> 
> Link: https://lore.kernel.org/all/5cf231e1-0bba-4595-9441-46acc5255512@infradead.org

s/Link:/Closes:/

> Signed-off-by: Duje Mihanović <duje.mihanovic@skole.hr>o

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  drivers/video/backlight/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kconfig
> index d9374d208ceebbf8b3c27976e9cb4d725939b942..37341474beb9982f7099711e5e2506081061df46 100644
> --- a/drivers/video/backlight/Kconfig
> +++ b/drivers/video/backlight/Kconfig
> @@ -185,6 +185,7 @@ config BACKLIGHT_KTD253
>  
>  config BACKLIGHT_KTD2801
>  	tristate "Backlight Driver for Kinetic KTD2801"
> +	depends on GPIOLIB || COMPILE_TEST
>  	select LEDS_EXPRESSWIRE
>  	help
>  	  Say Y to enable the backlight driver for the Kinetic KTD2801 1-wire
> 
> ---
> base-commit: 01c6df60d5d4ae00cd5c1648818744838bba7763
> change-id: 20250411-ktd-fix-7a5e5d8657b8
> 
> Best regards,

-- 
~Randy
