Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153C42DBF4C;
	Wed, 18 Jun 2025 15:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750259081; cv=none; b=a5xMmqTZPf0mfPq73sdNLyhOQNx8VoBFH1eRj+n7lfC0gThb3EW48k26ws2ioCFsHs/WPZt7D91DoMjwYf0ifWhcjGgvldcK8/3lE6Nr5BahBftOadb6bdyjpjtNNpRQFam3n6vB00v/cTH4A9G8XDUJXkWEgSR539BqKtBwys4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750259081; c=relaxed/simple;
	bh=3EspRMCyRBl7yfzuy73byfYxphN1/E3jRSITGcFJFA8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F3o0WefkCRSDiQ3/9dbZwoEPh2/EZjDmdAGDlyBuQ/MlSSN1qtVyqRJlAPBVbUzQwlaWmDbzJLdZlTeaXC1ZefIxEPMp//sofelT5IbTXYB9TMbz1au7cX2J+JgjgWwo2Ma8dc4gsBoC8DBkb5x/9S9vGsiY3f3w4QAFnZ8jWmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HNvUhviq; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HNvUhviq"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-748d982e97cso1571639b3a.1;
        Wed, 18 Jun 2025 08:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750259079; x=1750863879; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7Hs2SUNklx2rXkCy6cYLf3Of+XZFsviDoNS0r49LYlo=;
        b=HNvUhviq2Hj7fxaqCytBzILIcQkL/1WWZnifV9ke2F2UF4qFZ4msO9YKqi+nkwgTvH
         yiPNUZFPcKDzYpg5WOB8jTBuoTc4PLgApFNZzk++T3QBENV0Lj+9jDq+bU0A5/XC1F5A
         jjmP7YhHwgGZXJ3BRXSDzFW4J7x1FETJtXKB1Y9bDhkv/8zv4SYHG6D/8kdroKfzs9rr
         EIcn1E7XZNiNBUzQK318tm6SYR0EnGCBIIY0r+wtr/BXlDKIwVnH4f8b0w/6ifxWjtgz
         GRc5M+5TNnZssO+tMSlPWJVhc3qWWan4Js50QZz2OgBGXPVw7rfOlTTL+MvIhCGg7enG
         hdNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750259079; x=1750863879;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7Hs2SUNklx2rXkCy6cYLf3Of+XZFsviDoNS0r49LYlo=;
        b=OjlWRuevNR0LhKOdkBg3kHN9MoaK+nFKjxTDOQnq3YF1+c8arIuXeRUb/eXflHAepW
         d5wwA34SloN6SdjlwkZlAvjED5JwdCUY8urNBlEhc7uiZsP4P8fRqQMRud9KwDJ7Zn4L
         fmcmSTsyTcBweXX6m7KOeO6P/yCizkC4qmA1tDSXVZlzgYrDBjsfX7zYY8odtgz7CKt+
         FaK/TGdxoceKDaVlp+aqyGww5PIFUVigm4yQI6+NRR0n6TuyunHqI3VmN8mhehc1ZzQL
         JKztcizmUXsTof8UOy/WDdN9SpegiO+bXMON5Ebj/TjDge4b9Y4rGToBWjax9A3J3MAi
         PGtQ==
X-Forwarded-Encrypted: i=1; AJvYcCWkXeoPze4GAfigMitM+AhhrJqA+/FWgfLARBrWw38BY296g9h6iaOmJiS/baORDGshfKt9wi1ySMbyJw==@vger.kernel.org, AJvYcCXM3Bfv4quisykcv26cvtdSyJhnLtKYGszAEua/CdxlcRFNO3C063/AO6Kllys8DfBu/n2zQul5LvhtX/HBn/e/mXOVVg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzEbILAg8rEbDLAKgBlKTnXfjWTVaMIKs2rtNhHjWGl07Se/t6i
	iZ3TzzFsSO6RPjm4xipWpDIONvLB9EXBdOZHSmTLhf5eDeQyehYrQ5gC
X-Gm-Gg: ASbGncvRsWOf/mCHXGC3wkn/phWs51X6u/1GsTCE7V57BOIyiGItUHtAQqB7Qx3G0X0
	gtLDQa3vopVfEMJzSwPw/akP22FVoFfzM74J4kXpQJebq4eFzNylfn9XBJngUbs5ScDvPksYeMA
	pLuQaDkFTXc8mKCEkuVEEYlTDNKd1kgQzF9HumFzljBQ0IZGkQCMvNHEVsRaq7N1KpBb4sb8Mza
	H7yWp3ZE6cZQxCat/mC+MyrQL5zVC6yIGXYfDIp/9lJ6Qg3QhQ8HxAwaPEnTkQHyTcbby1YYQwY
	QpDAC5xy3hpo7787RH7pjYuxwfXDjFcb5h2yPmH05LcC2SatwHvDa5IMfUglmn3gabjo3A==
X-Google-Smtp-Source: AGHT+IFbMcB+hSk5+yrphcoXGyxnzipWWHvp4gGJiBPM0m0zxo02a1BcE06EDvrBKZqeUdozbvm2Tw==
X-Received: by 2002:a05:6a00:1790:b0:736:3d7c:236c with SMTP id d2e1a72fcca58-7489d062437mr23210895b3a.14.1750259079025;
        Wed, 18 Jun 2025 08:04:39 -0700 (PDT)
Received: from [192.168.0.123] ([59.188.211.160])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7488ffecd1esm11106156b3a.25.2025.06.18.08.04.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jun 2025 08:04:38 -0700 (PDT)
Message-ID: <f5c7dcda-d67d-4da7-9b84-a9d5a760f452@gmail.com>
Date: Wed, 18 Jun 2025 23:04:33 +0800
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/12] backlight: ktd2801: Include
 <linux/mod_devicetable.h>
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
 <20250618122436.379013-11-tzimmermann@suse.de>
Content-Language: en-MW
From: Nick Chan <towinchenmi@gmail.com>
In-Reply-To: <20250618122436.379013-11-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 18/6/2025 20:16, Thomas Zimmermann wrote:
> Include <linux/mod_devicetable.h> to declare struct of_device_id.
> Avoids dependency on backlight header to include it.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>  drivers/video/backlight/ktd2801-backlight.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/video/backlight/ktd2801-backlight.c b/drivers/video/backlight/ktd2801-backlight.c
> index 0489b0615ceb..17eac1b3bce4 100644
> --- a/drivers/video/backlight/ktd2801-backlight.c
> +++ b/drivers/video/backlight/ktd2801-backlight.c
> @@ -6,6 +6,7 @@
>  #include <linux/backlight.h>
>  #include <linux/gpio/consumer.h>
>  #include <linux/leds-expresswire.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/platform_device.h>
>  #include <linux/property.h>
>  

Reviewed-by: Nick Chan <towinchenmi@gmail.com>

