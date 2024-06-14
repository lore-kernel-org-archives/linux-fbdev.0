Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D872712F5A0
	for <linux-fbdev@vger.kernel.org>; Fri, 14 Jun 2024 09:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718358330; cv=none; b=BIAYosw/wF4Dudsw8ytKCHYal2vBTrBiXwwVuVdzbUA8YceumSnTIpbWDiL/d/g5U32TH1Kgdk744ykMSCWp0/dDndBvbITP3H7Gu5LpcnkuqJOtPMPBDZPj3FYAky7hbqCqds5NHw+0UdpcO3MOrnYOHWYVzz5wuIaAhRz1J1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718358330; c=relaxed/simple;
	bh=mBULaiJ7rhqMpeeFJBBm3V1JcggLzYeAf23TTXN6Iaw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=foquRhwJNToyz1KQE5JZJJk8hG7pFDXkfJv7oqbpZ/WsxgisAZ3wl55jTDGGZ4y+IvtP0gdimHGo7gjSH/GSjF0Jq3I2hZaY/1L0Bz1SRdR1UvYmBA9ysH3jP0swkQ6Sqaa+pifRptlVpMJ2Bl105AAHXNCVYu69t5xkiueyTKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KUaIwGXJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KUaIwGXJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718358327;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3zCQQ8p+hx0Gk9UH1f3YCfOSKKO0jNZPpOokLLsHO7k=;
	b=KUaIwGXJPkNswmP0VQWSyPoLk5oBKdk6ZAnNWIvmmRweMJ1+d4RDPuOTgw4/1Vln6mbeyS
	9zKMiP1chG/Btnsl3dCPqLxTGBnPiC9+CU6WaVd802EGXjUBUn6AEHlGm6OKRSXW7K05HZ
	q2E/3ktbXsrCW/qDIE5Hlek03j/Q5ZI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-470-fEonmYbDPVmvytp5fLArQA-1; Fri, 14 Jun 2024 05:45:20 -0400
X-MC-Unique: fEonmYbDPVmvytp5fLArQA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-421791c4eadso11614405e9.3
        for <linux-fbdev@vger.kernel.org>; Fri, 14 Jun 2024 02:45:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718358319; x=1718963119;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3zCQQ8p+hx0Gk9UH1f3YCfOSKKO0jNZPpOokLLsHO7k=;
        b=PeT3Sv0Z6exzUiaGH9D5+PRaqDQYYVYfpop6GYznuRixa3if4eBcLh9hgMMcALOQQf
         xgvd1KxVXU6H1tuvjNl7mq7zgy0Uv3Jrhq5HjEkW/0xkLkMXRLD4XKMyZ79ZRxMQL1CM
         2K/MmqjyySepygzRvMs5p2ct9OvSHBDu7NcXJZrUW26kT4LzvubXi0E/yGR85Z9jHRc1
         JxaqmG8FoNR/jfF9TnMxkdoIljrCDxFL4zVSyWWbJD53dhIscft2tAWbbOT4OmGeFkRn
         nKWpwtRx6/Zj6QQ0XEP7Gr9guy70fsGJpziniHuYSBclLBSS7oKGFt5FJ7FG3/HosMQB
         2Usg==
X-Forwarded-Encrypted: i=1; AJvYcCWbPaemCpuUsKNXdm/9a8gZEaF9TQeDWfaBy7vfHX+VFgJYh6lDHHpSylkmNVDCX6cWsnm/Ef0SQs/MMxxDoSQe/kGkAwDfn9XBu3M=
X-Gm-Message-State: AOJu0YyB3wBrOG8xK0wghLNTiFGzQYz+S23cerdDATphLzI3Sko6Ci39
	HQP60rFRQ1Ih31rzC6My5e8vxElgj8j4Z87bcD+Z0Whyb6cOQGbgEcdlJEbiyPrGCoKuWBJNCr5
	NgooYKaCb7llOVpHSWRKRfhCyLxxMF3u/JPp68GzCdGXT8AFXv27xOE8U3f0A
X-Received: by 2002:a05:600c:354e:b0:422:6755:17e3 with SMTP id 5b1f17b1804b1-42304848ad5mr18239295e9.29.1718358319395;
        Fri, 14 Jun 2024 02:45:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGq14KCC0bgeAFbxip4impHue7nA1V9MdeorCw9J2iMMisj4tdn99VzNb0cTThFgkm5mlMrXQ==
X-Received: by 2002:a05:600c:354e:b0:422:6755:17e3 with SMTP id 5b1f17b1804b1-42304848ad5mr18239255e9.29.1718358319173;
        Fri, 14 Jun 2024 02:45:19 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:38da:a7d9:7cc9:db3e? ([2a01:e0a:c:37e0:38da:a7d9:7cc9:db3e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36075104b45sm3833550f8f.109.2024.06.14.02.45.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jun 2024 02:45:18 -0700 (PDT)
Message-ID: <31eb764b-27f2-4a99-b035-fab21de4ca7f@redhat.com>
Date: Fri, 14 Jun 2024 11:45:17 +0200
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/7] drm/panic: Rename logo to logo_ascii
To: Geert Uytterhoeven <geert+renesas@glider.be>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org
References: <cover.1718305355.git.geert+renesas@glider.be>
 <df77372c16153655c321a290b5a3191ee2dcbc6b.1718305355.git.geert+renesas@glider.be>
Content-Language: en-US, fr
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <df77372c16153655c321a290b5a3191ee2dcbc6b.1718305355.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 13/06/2024 21:18, Geert Uytterhoeven wrote:
> Rename variables related to the ASCII logo, to prepare for the advent of
> support for graphical logos.

Thanks, that looks good to me.

Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>

> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v2:
>    - Rebased.
> ---
>   drivers/gpu/drm/drm_panic.c | 11 ++++++-----
>   1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_panic.c b/drivers/gpu/drm/drm_panic.c
> index 5b0acf8c86e402a8..f7e22b69bb25d3be 100644
> --- a/drivers/gpu/drm/drm_panic.c
> +++ b/drivers/gpu/drm/drm_panic.c
> @@ -78,7 +78,7 @@ static struct drm_panic_line panic_msg[] = {
>   	PANIC_LINE("Please reboot your computer."),
>   };
>   
> -static const struct drm_panic_line logo[] = {
> +static const struct drm_panic_line logo_ascii[] = {
>   	PANIC_LINE("     .--.        _"),
>   	PANIC_LINE("    |o_o |      | |"),
>   	PANIC_LINE("    |:_/ |      | |"),
> @@ -447,7 +447,7 @@ static void draw_txt_rectangle(struct drm_scanout_buffer *sb,
>   static void draw_panic_static_user(struct drm_scanout_buffer *sb)
>   {
>   	size_t msg_lines = ARRAY_SIZE(panic_msg);
> -	size_t logo_lines = ARRAY_SIZE(logo);
> +	size_t logo_ascii_lines = ARRAY_SIZE(logo_ascii);
>   	u32 fg_color = convert_from_xrgb8888(CONFIG_DRM_PANIC_FOREGROUND_COLOR, sb->format->format);
>   	u32 bg_color = convert_from_xrgb8888(CONFIG_DRM_PANIC_BACKGROUND_COLOR, sb->format->format);
>   	const struct font_desc *font = get_default_font(sb->width, sb->height, NULL, NULL);
> @@ -459,8 +459,8 @@ static void draw_panic_static_user(struct drm_scanout_buffer *sb)
>   	r_screen = DRM_RECT_INIT(0, 0, sb->width, sb->height);
>   
>   	r_logo = DRM_RECT_INIT(0, 0,
> -			       get_max_line_len(logo, logo_lines) * font->width,
> -			       logo_lines * font->height);
> +			       get_max_line_len(logo_ascii, logo_ascii_lines) * font->width,
> +			       logo_ascii_lines * font->height);
>   	r_msg = DRM_RECT_INIT(0, 0,
>   			      min(get_max_line_len(panic_msg, msg_lines) * font->width, sb->width),
>   			      min(msg_lines * font->height, sb->height));
> @@ -473,7 +473,8 @@ static void draw_panic_static_user(struct drm_scanout_buffer *sb)
>   
>   	if ((r_msg.x1 >= drm_rect_width(&r_logo) || r_msg.y1 >= drm_rect_height(&r_logo)) &&
>   	    drm_rect_width(&r_logo) <= sb->width && drm_rect_height(&r_logo) <= sb->height) {
> -		draw_txt_rectangle(sb, font, logo, logo_lines, false, &r_logo, fg_color);
> +		draw_txt_rectangle(sb, font, logo_ascii, logo_ascii_lines, false, &r_logo,
> +				   fg_color);
>   	}
>   	draw_txt_rectangle(sb, font, panic_msg, msg_lines, true, &r_msg, fg_color);
>   }

