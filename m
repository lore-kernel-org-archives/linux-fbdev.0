Received: from smtp16.bhosted.nl (smtp16.bhosted.nl [94.124.121.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ECC728DB3
	for <linux-fbdev@vger.kernel.org>; Mon, 18 Mar 2024 09:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.124.121.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710752867; cv=none; b=KhDW1vwP3I8hHOdD6Qm9JQsxUV7mlV3dzo4jhh1Xbw18/hXiLDTzbTj0+59EoRKeeQRnXIX0ZWF0GttDQCqNdmDT1eYRjM9gV8tLRodcpoqn8RFyqVa+1QI0I7RFfgGKeFwu1pqpquQ9cpYsJfvGfhz2zibWYbmqTkRSAOsZfUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710752867; c=relaxed/simple;
	bh=oDrMrlYSuxrgaoSfTWeaii5crOeguX/3uHvQtjSWjFo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SU20JVk3UatvA7VyCZZzTpJT7wkWXe85BjbbBJxbQY+wxJ/315fPS40ien55CL1XLW3XxVSJjEb+Otu2zgeKEnNwlGa8Y3OadQBaIRe5ieXeZZW2NjqLFdO4MieyMWwxmjN/jV+BB1bkyfgpe94QfJLXAs6FFxmNfFKBSwYmTeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=protonic.nl; spf=pass smtp.mailfrom=protonic.nl; dkim=pass (2048-bit key) header.d=protonic.nl header.i=@protonic.nl header.b=ewu7LAl9; arc=none smtp.client-ip=94.124.121.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=protonic.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonic.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonic.nl header.i=@protonic.nl header.b="ewu7LAl9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=protonic.nl; s=202111;
	h=content-transfer-encoding:content-type:mime-version:references:in-reply-to:
	 message-id:subject:cc:to:from:date:from;
	bh=FoIRlkqO1ctp4s2PeetRomEn5bkVsq7p5O2sYKCStY8=;
	b=ewu7LAl9hGfWHdB4/VRMy3TXUslfNg2HFaTeTI2PpqE4C6Vo6H1vDt6RgKLSk4gFkU50Aj2pHYtSy
	 hakOwv5p2GKUeqGCNHQbPc7vXUflHZcdfZPFxoqwMUlXuHZc3kwQAW2gk+7DrEI2C9wz945QAuB8eF
	 mPTCZdHoghSPfCPM6KQ0OpjaQJGiUVzhFJQxM/5MIA4XE8h60OTQAfsAzsDlDjRqRL5Yms7+xTOBgp
	 NJJWXq0D03AESW53VuSlkTSZgfe3442wnffO1Rm9d9RdBPAuIvDxKwC9l7axcI1i3bKgtnwXpgGGfz
	 td9ho0wYr2rrtHhv521NtOvbzXbiSpA==
X-MSG-ID: d02c6a3a-e506-11ee-844c-005056817704
Date: Mon, 18 Mar 2024 10:06:31 +0100
From: Robin van der Gracht <robin@protonic.nl>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: lee@kernel.org, daniel.thompson@linaro.org, jingoohan1@gmail.com,
 deller@gmx.de, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev, Miguel Ojeda
 <ojeda@kernel.org>
Subject: Re: [PATCH 1/6] auxdisplay/ht16k33: Replace use of fb_blank with
 backlight helper
Message-ID: <20240318100631.253b2d8e@erd007.prtnl>
In-Reply-To: <20240313154857.12949-2-tzimmermann@suse.de>
References: <20240313154857.12949-1-tzimmermann@suse.de>
	<20240313154857.12949-2-tzimmermann@suse.de>
Organization: Protonic Holland
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Thomas,

Thank you for submitting your patch, it looks fine to me.

Reviewed-by: Robin van der Gracht <robin@protonic.nl>

On Wed, 13 Mar 2024 16:45:00 +0100
Thomas Zimmermann <tzimmermann@suse.de> wrote:

> Replace the use of struct backlight_properties.fb_blank with a
> call to backlight_get_brightness(). The helper implement the same
> logic as the driver's function.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Robin van der Gracht <robin@protonic.nl>
> Cc: Miguel Ojeda <ojeda@kernel.org>
> ---
>  drivers/auxdisplay/ht16k33.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/drivers/auxdisplay/ht16k33.c
> b/drivers/auxdisplay/ht16k33.c index a90430b7d07ba..83db829b97a5e
> 100644 --- a/drivers/auxdisplay/ht16k33.c
> +++ b/drivers/auxdisplay/ht16k33.c
> @@ -314,14 +314,9 @@ static int ht16k33_initialize(struct
> ht16k33_priv *priv) 
>  static int ht16k33_bl_update_status(struct backlight_device *bl)
>  {
> -	int brightness = bl->props.brightness;
> +	int brightness = backlight_get_brightness(bl);
>  	struct ht16k33_priv *priv = bl_get_data(bl);
>  
> -	if (bl->props.power != FB_BLANK_UNBLANK ||
> -	    bl->props.fb_blank != FB_BLANK_UNBLANK ||
> -	    bl->props.state & BL_CORE_FBBLANK)
> -		brightness = 0;
> -
>  	return ht16k33_brightness_set(priv, brightness);
>  }
>  
