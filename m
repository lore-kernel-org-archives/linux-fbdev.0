Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4D81B85F0;
	Fri, 15 Nov 2024 13:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731676355; cv=none; b=W7XF8shSh/PytvyxI/sy/bXA6NaknkjYNMMRb00zIJWtsMRWYL4b2wDnXzQ5+t2s9bBovr9Q+pOjVuqeX3eAKOgEvLPNQYNTNr75pzX+bp+XB8419LpiTb2WK7Tk6scyqPBkokTdknKt4MDlLX3UGcz7q92gfXs46b7+0nxnAdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731676355; c=relaxed/simple;
	bh=t32cxctacNgjHuwnZ8VnqC6ly1Bchl/QOwPC9P7ZlR4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CZXmyZeuP+XylyNE8Vf+T2EPs9xRuVH76FhJbTvUXQ9lYPZ0rL/WZTt/d81D6CmiBGREXTTqUhtobi1P0m08c18Q4q+2wrkNm6dZnFyB5pj6JiRjoxS4Z1DmFWX0Qb3y1O2VaDPWT+Ee0246Wtyi2NbUf7jCpZB0Vd/xC4W7UxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GU5guTR/; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GU5guTR/"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2e2fb304e7dso1540099a91.1;
        Fri, 15 Nov 2024 05:12:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731676353; x=1732281153; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LGEvwwkAr2aRQ6piezavR8P7IeH13bFGESYh7zT6n3Q=;
        b=GU5guTR/orVWp2D5Byx8IhOgSXON3QYVo/5koR5rjd6cfnIi/1YZX5J6cblIXRxQqq
         Q2rJ3lWTqL1CXZC+gzWqz2z5emuwL/L071ZQNIKheuFlUFTRabgcZhK8DRECqEkb+fnv
         pXgwhQl8RA4qkDRybQkd3Riem6kCS4rfbKspDmlNLTjBFII4GyLiaF+1UB2hOv7/yrJE
         0h/X8zXHF3Cx+V0EZn2k1ljKVOaV2tam85xhX4gYcuWBa8yhakNp6tI2fIn9k4PHYLv1
         UT5KIIfDCYeyio7MymHC+u0zpTeIIp44qLZg2cbR/kQvBxchzSmajNZGN+d0L5hdEtbI
         ZPnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731676353; x=1732281153;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LGEvwwkAr2aRQ6piezavR8P7IeH13bFGESYh7zT6n3Q=;
        b=PvNDkGUddVpi6tr5yasC916nqBaR00cXpYqgKzl1E/M9dzW2TdPo7v/1YaysJuvIJK
         JSCSdeCCUobgqGdBZMvKpETSOofeVg/YxF8H2qGZesT7DP/QActyLe9Y1WE3V2HGCab6
         kVOZnCDRQBXcseq+bHKvQnuJs521kFQs78/EPGOwI1uKXHTaKi6PxUbOihTADCNR2XrR
         8oOeh9OmiiFSCO8wJGR/xf/jxQlVvh3DcAdDY7CE7iGIpzPjWXyfVwNAzb21GcnFDrIl
         wQR+te2CN5n7vsxyxder2yxr+x5PCxBGUlMUcXsqBe8EWrDK76Wwt8rm9gmG9rcaQ/pI
         HUXQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2haUYJ1EhNuqOYPFj5oAab/1bthy4rOeRG1Bnlp3uGZyEw8vgbO8KhbrTO+Cvq+au9MPdr6SXBRIH3v4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxydyqVoHmvkLobqtimALmHu5MdmAOov0FcQLqIX05RBFJw6kO
	NkjhVHLGjis3A6hCoTGjE38dELF51Q0nAw/4ZgvgK1WdFtHSvO72
X-Google-Smtp-Source: AGHT+IHiKmEPUcAwcTE7fjNZOdCEXpjeKSD795z8uynKB32CMsSboNyZ64DeBwOHh2qCU3Qne8r25Q==
X-Received: by 2002:a17:90b:1e0d:b0:2e9:5004:2502 with SMTP id 98e67ed59e1d1-2ea154f7469mr2960960a91.13.1731676353255;
        Fri, 15 Nov 2024 05:12:33 -0800 (PST)
Received: from ?IPV6:2409:40c0:48:969e:e221:9e2d:e416:1b41? ([2409:40c0:48:969e:e221:9e2d:e416:1b41])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ea06ef6a7esm2734394a91.4.2024.11.15.05.12.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Nov 2024 05:12:32 -0800 (PST)
Message-ID: <333658df-a767-437f-9566-857e8ff5867f@gmail.com>
Date: Fri, 15 Nov 2024 18:42:27 +0530
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] video: fbdev: metronomefb: Fix buffer overflow in
 load_waveform()
To: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20241112202825.17322-1-surajsonawane0215@gmail.com>
 <7de29a8c-3325-4654-8afd-81f3f9a8d113@gmx.de>
Content-Language: en-US
From: Suraj Sonawane <surajsonawane0215@gmail.com>
In-Reply-To: <7de29a8c-3325-4654-8afd-81f3f9a8d113@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 14/11/24 20:13, Helge Deller wrote:
> On 11/12/24 21:28, Suraj Sonawane wrote:
>> Fix an error detected by the Smatch tool:
>>
>> drivers/video/fbdev/metronomefb.c:220 load_waveform() error:
>> buffer overflow 'wfm_hdr->stuff2a' 2 <= 4
>> drivers/video/fbdev/metronomefb.c:220 load_waveform() error:
>> buffer overflow 'wfm_hdr->stuff2a' 2 <= 4
>>
>> The access to wfm_hdr->stuff2a in the loop can lead to a buffer
>> overflow if stuff2a is not large enough. To fix this, a check was
>> added to ensure that stuff2a has sufficient space before accessing
>> it. This prevents the overflow and improves the safety of the code.
>>
>> Signed-off-by: Suraj Sonawane <surajsonawane0215@gmail.com>
>> ---
>>   drivers/video/fbdev/metronomefb.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/video/fbdev/metronomefb.c 
>> b/drivers/video/fbdev/metronomefb.c
>> index 6f0942c6e..9da55cef2 100644
>> --- a/drivers/video/fbdev/metronomefb.c
>> +++ b/drivers/video/fbdev/metronomefb.c
>> @@ -210,6 +210,12 @@ static int load_waveform(u8 *mem, size_t size, 
>> int m, int t,
>>       }
>>       wfm_hdr->mc += 1;
>>       wfm_hdr->trc += 1;
>> +
>> +    if (sizeof(wfm_hdr->stuff2a) < 5) {
>> +        dev_err(dev, "Error: insufficient space in stuff2a\n");
>> +        return -EINVAL;
>> +    }
>> +
>>       for (i = 0; i < 5; i++) {
>>           if (*(wfm_hdr->stuff2a + i) != 0) {
>>               dev_err(dev, "Error: unexpected value in padding\n");
> 
> That patch is completely wrong.
> There is
> /* the waveform structure that is coming from userspace firmware */
> struct waveform_hdr {
>          ....
>          u8 stuff2a[2];
>          u8 stuff2b[3];
> 
> So, I *believe* the for-next loop wants to walk acrosss stuff2a and 
> stuff2b,
> which have 5 entries together. So, basically the original code isn't nice
> but still correct.
> Your "sizeof()" check will always be false and is the wrong patch.
> 
> If at all, I think the stuff2a and stuff 2b arrays should be joined.
> Something like
>          u8 stuff2[5]; /* this is actually 2-entry stuff2a and 3-entry 
> stuff2b */
> But again, I don't know much about this driver.
> 
> Helge

Thank you for the brief feedback. I see your point regarding stuff2a and 
stuff2b. I’ll study this approach and revise the patch if I find it to 
be the correct solution.

Best regards,
Suraj Sonawane
