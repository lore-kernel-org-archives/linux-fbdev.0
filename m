Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B46F2EF283;
	Wed, 18 Jun 2025 15:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750259309; cv=none; b=Pa2R4yPj7l7dDzjZvj0xFCFbLOUsT6BA8FOLEoDg2vFg4JWiUbsuCvF1O3fGt+ye58k6BSm1+bAwbdaVVBfrb/K423D52qMWdjSOjjpMHfGPZAk1fSKyKhtAzuIHHkKb0k+gebNofhY9SmHuSrih3OanaHdHa9i6Kg0uQbXGROI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750259309; c=relaxed/simple;
	bh=L8Ij7WI1ztqVYmG775JBVUJdflNviiHPGOnb2Mh/ppk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n+nkwwtPOW+o/meTEn776Zq4Wq3OvFtW3oN8S+iVbWR1hWzeW3jrh36I1mtHJSr5x5RkgK/PzC9sOFM9nTFf9Im6u7emWZ0ZK5+vxDyELV3VvhcgeFlgev/h7ivCMboiGcbYi7m+ORU+yuI/MKtiF/5vZoZVOjNtX8kIdC86FQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H4DogCP4; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H4DogCP4"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-311da0bef4aso7719265a91.3;
        Wed, 18 Jun 2025 08:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750259307; x=1750864107; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NlXLcdl0xMjJ43b63DNA4aQ9Nj5CoTCVpP0YbONQKfs=;
        b=H4DogCP4PMxGSRhCsJJAduls7yJMMh8MdlnPUehDt5l6jrwLYGxgCDcZJFi5lrFEkK
         iLu+SLIzZMfXZ1VKosrVSInqpwzYYm6dI9vhIqRw/J+UiCNUf0avuknN0R1eetwbKlc6
         WX7TZRMzprURvnW0A88bBkVkJ1JCopWFhj3Qv8zNzdOhA6HZvhTkAMdilEFMMMeSOQgX
         IGB8z00vXO7GyLxmFgYn11fZ/xGngVQvQtdLP6SVUrb6prgcUsm46JL/onURsRv+GN55
         56szqtlRi9O1X19xDvSrbjopeXBYVl+ZFY3zVSlLrzPWAJYu05ndMbiHC0AHPkaUOr8n
         xtvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750259307; x=1750864107;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NlXLcdl0xMjJ43b63DNA4aQ9Nj5CoTCVpP0YbONQKfs=;
        b=MmCgiY2pwc/5dTHCXRFWWhIlWY7dQ9QEXHqRmJSn/9yatj1Cc9+hCoOtbPVXzZKA+p
         0B5lYGUoHxg+dYsrLh/KuXAosKKEqkOv1L/ExYHB3rOZzpGqXMEVzy40U0+uX3o8A/Sf
         b+5SGPsVjN66jivQqrLLQx/r192ZQOxAiGwYus+yblAsg59BSeW5FWgLn/sCVT79QDFZ
         gbR3p4I/NmNdv8shiQFZl9sWWL14LzNCHJwaRQ0gyJjemA9vysfzTy0hTZGRlatOu9jS
         OqCwaqhfDkORJCblSt8ZqgcL5tHhEdVkFWwimWVYL6jgI/QqoJbNTcsftbmBBdZAPZYW
         rkwg==
X-Forwarded-Encrypted: i=1; AJvYcCUUhbBDw8r1igQ8BQ79xvhJGgi3A0c6wx7MFp6rM3rVXZ7JTH/kWV13YztTH2ilojDHZ/HkF5kplpaqfQJFolTKSBwBdw==@vger.kernel.org, AJvYcCVjFSuAyIuVSJMwebVxaJoJyOTKxwcD5qAxl2DBafnSQ1oZEVAt/hUsMbKShQvi7LAteFE/G+EelpoTag==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg0p+aangkc9S9XK2sM2zYZx96LgbaNbmsDRohCQ/zDUUqeeFa
	jpEkg+Nk4Q986mqIZG0PB36AL3Hdi/3hZSutVfTo2I+Dk+5qLE1suqc7
X-Gm-Gg: ASbGnculcsxXm6sHj/5SPDXFRWkkvTylvB8H7nY5Ryxc/CAfn0OZOPiQA8w/6h7An22
	s+LC+U/diDppugExV7usdmkFTW/Nsf7tFsibgnN5/RzH9vrC8BE4QuZp8ekmVemvnFUDVBFWA/8
	6TU6Yw1754k8o1YeF0yyy9Na+D8meEQcTOP5zFwTnyX/83yYpvMYiTL10GtxN8YrZbW7p4OGVRN
	5TPQPMHLMTBvYmDVKzzPLdPIOFZAmqE8/UptOVjFPCE+zpSXR+CdDjqisr/s8kyIj2fAWXrHYda
	d3MhJhzpy0PeUpn4UjbJxIejIJyZN/8cq8foiaFXH3l/L0Wu2lgqL44uzmtu3r+yqhhlrQ==
X-Google-Smtp-Source: AGHT+IGMfD1en+jAPfFZnyKfP/6fLNvoxSDJknXoysVlOSdS/kFg5+qkb2avdYMr18aUztSudZuFfA==
X-Received: by 2002:a17:90b:528d:b0:314:2a2e:9da9 with SMTP id 98e67ed59e1d1-3142a2e9e1cmr8449811a91.25.1750259307379;
        Wed, 18 Jun 2025 08:08:27 -0700 (PDT)
Received: from [192.168.0.123] ([59.188.211.160])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3158a22418dsm16968a91.9.2025.06.18.08.08.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jun 2025 08:08:27 -0700 (PDT)
Message-ID: <c7ff4ca4-da9c-4b86-893b-1ffd9fb0fb4f@gmail.com>
Date: Wed, 18 Jun 2025 23:08:21 +0800
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/12] backlight: apple_dwi_bl: Include
 <linux/mod_devicetable.h>
Content-Language: en-MW
To: Thomas Zimmermann <tzimmermann@suse.de>, lee@kernel.org,
 danielt@kernel.org, jingoohan1@gmail.com, neil.armstrong@linaro.org,
 jessica.zhang@oss.qualcomm.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, airlied@gmail.com, simona@ffwll.ch,
 fnkl.kernel@gmail.com, j@jannau.net, hdegoede@redhat.com,
 ilpo.jarvinen@linux.intel.com, sven@kernel.org, alyssa@rosenzweig.io,
 neal@gompa.dev, deller@gmx.de, support.opensource@diasemi.com,
 duje.mihanovic@skole.hr
Cc: dri-devel@lists.freedesktop.org, asahi@lists.linux.dev,
 platform-driver-x86@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-fbdev@vger.kernel.org
References: <20250618122436.379013-1-tzimmermann@suse.de>
 <20250618122436.379013-8-tzimmermann@suse.de>
From: Nick Chan <towinchenmi@gmail.com>
In-Reply-To: <20250618122436.379013-8-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 18/6/2025 20:16, Thomas Zimmermann wrote:
> Include <linux/mod_devicetable.h> to declare struct of_device_id.
> Avoids dependency on backlight header to include it.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>  drivers/video/backlight/apple_dwi_bl.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/video/backlight/apple_dwi_bl.c b/drivers/video/backlight/apple_dwi_bl.c
> index 93bd744972d6..ed8bf13d3f51 100644
> --- a/drivers/video/backlight/apple_dwi_bl.c
> +++ b/drivers/video/backlight/apple_dwi_bl.c
> @@ -9,6 +9,7 @@
>  #include <linux/bitfield.h>
>  #include <linux/device.h>
>  #include <linux/io.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
>  

Reviewed-by: Nick Chan <towinchenmi@gmail.com>
