Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D29D27FB1B
	for <linux-fbdev@vger.kernel.org>; Tue,  6 Jan 2026 05:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767676079; cv=none; b=cq3YTmaDaMdreFYkDLQC7TnpfO555heUb5S8SR8xkqt7nNGPhKFDAenkhPD9bfhkLw+GPOeZeMmIurZvKisJGHdAb1yaSrQJMfLTGj2oUACNVysoTvFeHQX8UqTDk9JaRPR+65hDlx0ZJI7a4Jd/4ZIqamcQOk3iK10HQR1niq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767676079; c=relaxed/simple;
	bh=PvKsoC1yJDKXpvwc/Ywpgr06jgkkUxx9YT/NT7YJY4I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NIB7xtaypMl05NxAbma244KtGsi8gCwMe20YW1/s8Zzd1mLO6tjcsHl8oY/kDLjXwgoD0QdvOThY98KMXpPFX3qF5zpZlbfBfqzaFV6TEeUQc3/p9EO6AbZcwHRBa2OubGUYyNuVFOhWuBI1Tc0naXOfq8TDX7MZPIo9EVwNIes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dZwYEIHk; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dZwYEIHk"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7b852bb31d9so747981b3a.0
        for <linux-fbdev@vger.kernel.org>; Mon, 05 Jan 2026 21:07:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767676074; x=1768280874; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0gtGPUtnrtvwlzSCngVczC/q2RK/CQdmnl4xMzqGXCo=;
        b=dZwYEIHkOayOmYUN/scZL4w+LGYKtSWb4tlzh1I5U1dKaTGq0Fq8WAe3/CwDjP+t2E
         nQ8VEYumnw0hEwDq8UayVuuQog66HijgcCap4hmiHb7/8AGinH89vc9ioTjLRgcGc9Gl
         EvWxPfaHKebNl34GTnujf3zEvF7qHNIRbJDv5WPl8QnZ3UWX6JsCEapg0PXrEnpGLRbS
         cxUmuX57zjb4eZWhJctI7jL/AwOdg5p1YhLy0TEfQ2/KCHM7I+9haato5/78xcgKFo2z
         e+yOVFodcaw1DWd8feNCIqm7tAWOObMB4ynhTfv5nZxVjXb/oY1hOL89FbggKpthQCA+
         zrOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767676074; x=1768280874;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0gtGPUtnrtvwlzSCngVczC/q2RK/CQdmnl4xMzqGXCo=;
        b=sP1AI12x+LY2A+f7ZguEpTAKwlxTnN9N3RUjntWfG0COMvRgCZdC8ZQL5wW9XGMOfG
         Z4z8dhYNWoxO9zO1015lgd2fYuN+pgSxtJ2mHtJJYgc3DSPhpA6AyOXhpwh4EHXI2AZw
         oS9ldfrGj3JanB6U3RqtWsUwLzkUxDaVLF4wfJ056jTim/Jo7oD2TTKHqOYTxcYSOwQy
         lgFZNqlBXPhRbwq6Ba7hOU7McrNhllMu3scfGSV5w02f4KMfbsjEj7Dz6fo1896XAoVH
         zuI1I7G2LKQVawnG9+zrEHoMn5y3gVAJVJC7PlJL40XHpF6K4PmxGsrL7KSgAnSsGaZO
         4qoA==
X-Forwarded-Encrypted: i=1; AJvYcCXLcaID3omxIwkpjhTdVJ0x0nQYxgGx+ytIfaugfopWKMDTXl9Rf42eYI9iiiNKroagNrwolu71c6qiqA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8VuHFfp/kmw8Kjp0T6caI5kyrbN76sUv+zh7TcyO5edQSNhRD
	YlBp8lBMKuPh0ehzs0nvxgNw7MlxgIvRagoTDnZJfO9h63y/LQ1Nn/Ss
X-Gm-Gg: AY/fxX4GrfoCSME5udk4fzMKP0vZ0hJH6YBTAgWhc0RwoLp5wnfftYNitTCCZy7YnHH
	8boqKH2v6/acfn5XE4/K8Q5lSVZbxy1gVb/E/sf0205A8WiIf93rLckFgVHGJu9xzl5AtqrUnk9
	/pB8QWkVVBNzE0xLkyZ4gS45cXOd17FaFpnTt+VM9R2STqfpXXkRKl2+xoXmeuIqXi14JN1agwL
	hUFWcGG/9yBcvA4nmhbmr1zK6Oh7Jh3x6K4eOLhpE604aiCgUy9TXwseeBWwtaRW3We9GBJwK22
	Nt544LO0DARLJa+ktAqKpVXmoIFgkHUdXR2sEK6tE83PZ6H9Cs/5wMPeOJ6B28SY28ZZWIAvp3S
	o7ofMq0lL2Wse8ZYBD5QF7SaJCziq/xanMwD+UYbmy1oXIOh0w4Xzm/wUr//55B4OGVJ0OGeMfg
	k/1Twhz0isHmCk2gpNRelp3SplFN+iwd5+SxOvNjvcAle/q3oalGeknh8jn7TJ
X-Google-Smtp-Source: AGHT+IELk3bSN8b6/uvhBy79lAtP4nFKRyXfqVo09Vl9Sea1jJstOayAx+4sJKgZc+BInTNtDc92kA==
X-Received: by 2002:a05:6a00:f8e:b0:7f6:2b06:7129 with SMTP id d2e1a72fcca58-8187f4a1122mr1578438b3a.43.1767676074134;
        Mon, 05 Jan 2026 21:07:54 -0800 (PST)
Received: from ?IPV6:2601:1c0:5780:9200:980d:1373:5653:99ac? ([2601:1c0:5780:9200:980d:1373:5653:99ac])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-819c52f8ff7sm752055b3a.37.2026.01.05.21.07.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jan 2026 21:07:53 -0800 (PST)
Message-ID: <af800a37-150b-4b7f-ad83-4db6e7e72df9@gmail.com>
Date: Mon, 5 Jan 2026 21:07:52 -0800
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] fbdev: sh_mobile_lcdc: Make FB_DEVICE dependency
 optional
To: Andy Shevchenko <andriy.shevchenko@intel.com>,
 Helge Deller <deller@gmx.de>
Cc: Helge Deller <deller@kernel.org>, andy <andy@kernel.org>,
 linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20251230052827.4676-1-chintanlike@gmail.com>
 <20251230052827.4676-5-chintanlike@gmail.com> <aVOJovo-k6-0KnVg@carbonx1>
 <aa2b08f8-e6c3-4768-bce9-e36ad9d1e74b@gmail.com>
 <73007a0a-dd96-43eb-be2e-ccbf8b19cd79@gmx.de>
 <aVkWigAQWC1dZBAv@smile.fi.intel.com>
Content-Language: en-US
From: Chintan Patel <chintanlike@gmail.com>
In-Reply-To: <aVkWigAQWC1dZBAv@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 1/3/26 05:15, Andy Shevchenko wrote:
> On Sat, Jan 03, 2026 at 10:59:44AM +0100, Helge Deller wrote:
>> On 12/30/25 19:25, Chintan Patel wrote:
>>> On 12/30/25 00:13, Helge Deller wrote:
> 
> ...
> 
>>>>> -ATTRIBUTE_GROUPS(overlay_sysfs);
>>>>
>>>> Instead of replacing the ^ ATTRIBUTE_GROUPS() by the code below,
>>>> isn't it possible to just mark the overlay_sysfs_attrs[] array
>>>> _maybe_unused, and just do:
>>>> + #ifdef CONFIG_FB_DEVICE
>>>> + ATTRIBUTE_GROUPS(overlay_sysfs);
>>>> + #endif
>>>>
>>>> ?
>>>
>>> Yes, the __maybe_unused + #ifdef ATTRIBUTE_GROUPS() approach would work.
>>>
>>> I went with the PTR_IF(IS_ENABLED()) pattern because Andy suggested
>>> using PTR_IF() to conditionally include overlay_sysfs_group in
>>> overlay_sysfs_groups, and to keep .dev_groups always populated while
>>> letting the device core skip NULL groups. This avoids conditional
>>> wiring via #ifdef and keeps the code type-checked without
>>> CONFIG_FB_DEVICE.
>>> If you still prefer the simpler #ifdef ATTRIBUTE_GROUPS() approach
>>> for this driver, I can switch to that, but I wanted to follow Andy’s
>>> guidance here.
>>
>> I assume Andy will agree to my suggested approach, as it's cleaner
>> and avoids code bloat/duplication. Maybe you send out a v4 with my
>> suggested approach, then it's easier to judge... ?
> 
> I'm also fine with original code. But a suggested approach would work as well
> (at least like it sounds from the above description). Ideally would be nice to
> get rid of ifdeffery completely (that's why we have PTR_IF() for), although
> it might be not so readable. TL;DR: the most readable solution is the winner.
> 
Thank you both! I will send v4 with Helge's suggestion and take it from 
there.

