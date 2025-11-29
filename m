Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B5C22B5A3
	for <linux-fbdev@vger.kernel.org>; Sat, 29 Nov 2025 10:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764412085; cv=none; b=uZ7a9OdkdQKbQpkYE+mvveS7oM4/HXDCcnWcjMbA+d2Nvc866VKZMN/w36UsGDOVkSZJxdnN4dEpCpSPQySvW7mPYA7Cpwqw3AsMqhD3UYwRX3EWDoAToV7PUyyJIPs2SQM77Td+d/Y6g+wpyHCMSEst3fbzQ5+P73cS2DsVYSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764412085; c=relaxed/simple;
	bh=OsIgH7jnRXE27PuYHQEZQVfVHYE3bIlsGn8LPRz+jDw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h3lBgtqolLi8leqRQPfuHzIjjWCxk81QOlhbZoBkePxeHi0UKfrpBD52tdCIytf/PvLlRyJnrcxjWUfF4cRjoyyCOkgwLYhJAP7bDH8DOtR1c10aD0SEgGTU4hspnRcPl+FrzMPmd1xla8gs8q2LiCzfuv1FA2DI1/JhQDvkpGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=FMyP9X19; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="FMyP9X19"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 197DB4E41971;
	Sat, 29 Nov 2025 10:28:00 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C6FE560706;
	Sat, 29 Nov 2025 10:27:59 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 79948102F274D;
	Sat, 29 Nov 2025 11:27:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1764412079; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=gzvuaBZkisdI8uhv3itEmVnMdXtPgcQ087X+dPKk1go=;
	b=FMyP9X19OZgcb2FZJK6VpKkGEV5sjwrm95J+AAY2pWsNYT13BY1gTV3X24Yu6Ovy1pY3Da
	4W1yR2qjK9cu0fDjuBmvBD7W+KKyh7o3ejf1IBPJ04IE18Ccz7xBITDFfkVXC88eCEBu7R
	d1S+frJebLBbCKU4tJWbeu7fTrisq821sxUpq4FmKGf+Zv6NWLUmK4V3XL923Dm/r6I+7s
	AZ+6tlO4grB0nK8aKMyCc9HHnyV0KU068YR6y0Aixh0zkkcMXKnaL8uAtiCouBsvqddUyQ
	8l1FwuFukDmOlxRf/+XgH9k4GVwxhJFukJZ/ccn98UOFB2Xc9MmDAnDIn727iQ==
Message-ID: <a4edce66-d08a-4b82-9472-b22f2fdb34eb@bootlin.com>
Date: Sat, 29 Nov 2025 11:27:56 +0100
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] backlight: Add Congatec Board Controller (CGBC)
 backlight support
To: petri.karhula@novatron.fi, Lee Jones <lee@kernel.org>,
 Daniel Thompson <danielt@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
 Helge Deller <deller@gmx.de>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org
References: <20251127-cgbc-backlight-v4-0-626523b7173d@novatron.fi>
 <20251127-cgbc-backlight-v4-1-626523b7173d@novatron.fi>
Content-Language: en-US
From: Thomas Richard <thomas.richard@bootlin.com>
In-Reply-To: <20251127-cgbc-backlight-v4-1-626523b7173d@novatron.fi>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 11/27/25 4:21 PM, Petri Karhula via B4 Relay wrote:
> From: Petri Karhula <petri.karhula@novatron.fi>
> 
> This driver provides backlight brightness control through the Linux
> backlight subsystem. It communicates with the board controller to
> adjust LCD backlight using PWM signals. Communication is done
> through Congatec Board Controller core driver.
> 

[...]

> +		bl_data->current_brightness = reply_buf[0] & BLT_PWM_DUTY_MASK;
> +
> +		/* Verify the setting was applied correctly */
> +		if (bl_data->current_brightness != brightness) {
> +			dev_err(bl_data->dev,
> +				"Brightness setting verification failed\n");
> +			return -EIO;
> +		}

I'm still not really convinced by other error messages, but okay let's
keep them. Maybe add current and requested brightnesses in this message,
it could be useful for debugging.

	"Brightness setting verification failed (X instead of Y)"

Otherwise looks good to me. I will test your series

Reviewed-by: Thomas Richard <thomas.richard@bootlin.com>

Best Regards,
Thomas
