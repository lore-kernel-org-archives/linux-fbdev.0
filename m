Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC65A21254B
	for <linux-fbdev@vger.kernel.org>; Wed, 10 Dec 2025 04:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765340691; cv=none; b=TZnmKbL4k3Q9649ZaHFslLSS9Qe65qkrP9fWNczSr1E5QvYhT8m1lhIxx5M2kCS9V19D7Rj+btMfD6J7o3P4pDKQm7BYJWHUAYV+elBGHQGpoRHE06FfS9t49WBa+jHr0rPY5g9sra8a0Z89PjVSYQiiEsV3K6qT/uZ2nh9Tz6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765340691; c=relaxed/simple;
	bh=cbubf1NYJfCvFoWNQLYMFA2LJeNlUgm2HmggK2vgpLE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PhtV37BxJND0cPeEE8mFAK79CNH9v6McismptikruqH9BLuoXxYthdsTP5zd31Gnc61ftXmZT9FE5S5nBJdY5cNZkAjhBrS6nG2ewz80vWUiTQQp93mQXTBR64QTMyzW5nUCVdwP6IsYKEiDm4g2tjWlwRlBKLgbncKEscevl/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gfpgHscR; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gfpgHscR"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-295548467c7so81980285ad.2
        for <linux-fbdev@vger.kernel.org>; Tue, 09 Dec 2025 20:24:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765340689; x=1765945489; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZHURbWUQgIv6rDE4plYGzDdoLRCquvnAG2DekAVeb8k=;
        b=gfpgHscRzbg/3mIu1hfQjld+HqZgJG2nv4UTogQhqtGdoFjJsE6UxluafU0SWg+yah
         G/CnSdY16oCresSu+iSi88zBpMmIx7+GXsstPrJ59f2XCgsBYG4zkYUPXu0vBslOhhE/
         0+vAqvszq5PtC4JJjU/RfJ6jsQ+6E+KKAKWnpcPL7+iSM/zQWgbhPxS3SNhOl7xkjPLB
         6909K8Tojvfs1Gp3a0F2zflXUKPx4OPECCQj59LDjr7k2e65rrKgMdw7uuAjDRQZAFHZ
         aoklaDr6tTfk3o+MNy1ZISIQorvaNSY8FdtXG5rO1b/wfDJL7LKO+Z1CnH2M9VqFBfjC
         l3Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765340689; x=1765945489;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZHURbWUQgIv6rDE4plYGzDdoLRCquvnAG2DekAVeb8k=;
        b=CdPEAh+8WXqLBuijM0RL47iXRFXM9Wfuu5Bzp0eSgYG80KpyugKzI6CXPm4M/Sq+tj
         KMiX205JX4PGZJPWhVBVzbWXu7LDc/Jxq5Co51w+Y0EPhiJZoyOl6zLAZsdQMTsJ7+2G
         kHVwS4QOYSUOY4wyRImddRYM0szLEHthEZVJEGpGGFoZj1COB6+neQZfZZupRLD4JKIa
         VVGADAcNJ3dwtw9gF7jDoou0VSWkkDIuvauz/Lb4Wp+3nmedYeXg7AbEMrgKoc1j1Bhp
         vQ0Ud1VN8CtaOJZr23F3epFr4z/RRKzvi5TazN3ldRTr4BttQcGePrZysT60XQOnCdEt
         lANA==
X-Forwarded-Encrypted: i=1; AJvYcCXvwUXQQB8Fjapbff7sHHFikHHCtdN+GOncIWvOU6uYIXA7jrQ8z052UONeH9KQ/3cV0W5cJ9kgYf+QhQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyyjT7KPi+JCNMSuM6ooh2AD5SkhIs8EUyf5SmCOEG5x4PCFKOz
	p1HqLjapVCHV+uA9BgpyfWfG7qw28TAFxC81DIAPPD+pL1EeuGNtJDNJMQzAgXVY
X-Gm-Gg: AY/fxX49FQkGPJxIcjQqdLctUVkSovibMhtglrzPxIS0xYhqiYS/TgHoCYTiruAPwkX
	3dWsiJeThJAYyi/ppClV9ZEeuCkNouUneAJzS22db80cL5dIod8vU9JO7u+uWAlN1CMlxAQ1ZVb
	2bo9aiMO6B+I+Kh67xvqkHRurrlr1Tf0menMuqFnGNfZ2eteKu+UIctSbJi6xU9gYOJGTPe9rcM
	tlS5QiahxK7uJSutASu8y3VfqVYxu+ZnkxbTAr05tKrqwqNL/277vQHPafn0QJByB1YTW+YUjDu
	eWqVy4EWJu8RFyP5j3Qk/HK0zsOYjv5SXZxDuXFL5kooP615mDtW5WYCAeT69Ui2KYw2OVQuF1F
	w2f/9EYaMsXR+mz7ndHBK+lpQEho6ByRRDFy6y+RMNKTf3qgh9WNBndrk6FLllv5MGIXbK/+sp1
	k7lu/ltusc/NEho1CEiiKVJOSbs5Ao7vs52h3LOR1PC/urAUvwmplN1z7Ju5Z5
X-Google-Smtp-Source: AGHT+IFLjbHqKm1TeTHwPWHgM/dVq6lAyHbS/510gkTwuZ9bXQQa6783zsMnS6eOgTYVIMZq9D1MPA==
X-Received: by 2002:a17:903:198d:b0:298:1422:510d with SMTP id d9443c01a7336-29ec2d8b9f2mr11445495ad.48.1765340689155;
        Tue, 09 Dec 2025 20:24:49 -0800 (PST)
Received: from ?IPV6:2601:1c0:5780:9200:b90d:2938:bd7a:289f? ([2601:1c0:5780:9200:b90d:2938:bd7a:289f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29dae4cf97fsm167022355ad.25.2025.12.09.20.24.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Dec 2025 20:24:48 -0800 (PST)
Message-ID: <89b08d9a-9f96-40f0-9ae6-e54b16b65879@gmail.com>
Date: Tue, 9 Dec 2025 20:24:47 -0800
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] fbtft: Make sysfs and dev_*() logging conditional on
 FB_DEVICE
To: Thomas Zimmermann <tzimmermann@suse.de>, linux-fbdev@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-omap@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 andy@kernel.org, deller@gmx.de, gregkh@linuxfoundation.org
References: <20251209042744.7875-1-chintanlike@gmail.com>
 <20251209042744.7875-2-chintanlike@gmail.com>
 <329423e8-d778-4f30-904a-825b1be72ce2@suse.de>
Content-Language: en-US
From: Chintan Patel <chintanlike@gmail.com>
In-Reply-To: <329423e8-d778-4f30-904a-825b1be72ce2@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Thomas,

On 12/8/25 23:25, Thomas Zimmermann wrote:
> Hi
> 
> Am 09.12.25 um 05:27 schrieb Chintan Patel:
>> The fbtft core and sysfs implementation unconditionally dereference
>> fb_info->dev and register sysfs attributes. When FB_DEVICE=n, these
>> fields are unavailable, leading to build failures.
>>
>> This patch wraps all sysfs attribute creation/removal and dev_dbg/ 
>> dev_info
>> logging in #ifdef CONFIG_FB_DEVICE, with pr_*() fallbacks for the
>> non-FB_DEVICE case. This makes fbtft fully buildable when FB_DEVICE is
>> disabled.
>>
>> Signed-off-by: Chintan Patel <chintanlike@gmail.com>
>> ---
>>   drivers/staging/fbtft/fbtft-core.c  | 20 ++++++++++++++++++--
>>   drivers/staging/fbtft/fbtft-sysfs.c |  8 ++++++++
>>   2 files changed, 26 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/staging/fbtft/fbtft-core.c b/drivers/staging/ 
>> fbtft/fbtft-core.c
>> index 9e7b84071174..dc967bdeabe8 100644
>> --- a/drivers/staging/fbtft/fbtft-core.c
>> +++ b/drivers/staging/fbtft/fbtft-core.c
>> @@ -365,9 +365,14 @@ static int fbtft_fb_setcolreg(unsigned int regno, 
>> unsigned int red,
>>       unsigned int val;
>>       int ret = 1;
>> +#ifdef CONFIG_FB_DEVICE
>>       dev_dbg(info->dev,
> 
> Rather use fb_dbg() [1] and similar helpers for logging. They only need 
> the info pointer and do the correct output by themselves.
> 
> [1] https://elixir.bootlin.com/linux/v6.18/source/include/linux/fb.h#L895

Thank you for this pointer - I actually didnt now this existed. Will do v2.
