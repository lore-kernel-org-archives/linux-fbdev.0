Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6597057314
	for <linux-fbdev@vger.kernel.org>; Fri, 19 Jan 2024 21:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705698121; cv=none; b=n2eMFp0fRwrJjAB8zx+ocmrXtE15/CU3M0D9ziMFmS7yfD5h7uG+Dm2j6BTpqyrxKtGTbJA0MBKf6VN59uisc+GWOVNoWQQ60+kauRx9Q4cr2QZSprlYNas31T7r0ZSWem99ZsXSqDZvJAdf0FHvZcJamVvQiTaR9K0b4MlX3us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705698121; c=relaxed/simple;
	bh=4AWBUqGn52z//Z8+W5TPR4hHK4Fbb3QJg61PK0ynKPA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ifWrtii/e8Jamb1CRDIA1xdRHB31QjQboCd9PJ41w6S5DFS/fYEhIGKC9MIRONy9y+9tWFs4noyVeqL0CDRAlMwXZYjdM9jmbSZxr26VT2fNlsNJNMMUTpOw/W//onVvN6irgnuZUrgB4pbGevg3O9WwZRYjrRfksGt50+wmDSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=o2uPihq0; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="o2uPihq0"
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7bee9f626caso17504039f.0
        for <linux-fbdev@vger.kernel.org>; Fri, 19 Jan 2024 13:01:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1705698117; x=1706302917; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0jG9+AFkJLNvflocjNZF15QhqO4HCzitJO63mbz/u+8=;
        b=o2uPihq0oBuN2hWV3H+MhKYACJVs9WnxiZ3rwfuX9Y/FM3Na8Ocece/Q9dz58uHN/N
         1pwkzNnJiLGQWl9a+XQuAc2NxFmJnV6i1OzwOBpzzzqd0xbX86thE/K8V9F1JOJfxP1B
         GW6fsikGejF6gT2vitUMkvO8qMsIhtbDvvOzHiMAhkARtN2RNnIHEQJWqz53yheO7FGi
         bKS5upCGH+Znw9rF9rsgIFu+MeAHZ9GgRA/jBMhHZH8KPWnCA+ulzwrEYxJsPUpZUA0W
         JSTPiBqsLAFweH1ozff/6zBHVRuWCdNi1VdrlWJBO2lT7Qr10Jzj8MR8Dg4HxRdLzQaE
         1Bng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705698117; x=1706302917;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0jG9+AFkJLNvflocjNZF15QhqO4HCzitJO63mbz/u+8=;
        b=tk12okGGpjmtfy65x3LFaXtMZfAWdMAiJ62uD5f4kbrT4IwduTvg05wDP2fpzj3T7G
         zkmFdmbFwdJuJIUtC5TjqR0Knw2/T0OtVRFUqZ0/RevWbevGNLKo+k1Lel/mMVzWRi/f
         aPPo71tOquB+0So5q04aK6+hRE/ikhe+Lx+x6GCrj2JXQAQU4F6uNbiLtsG0zxCveWbz
         pwkhHQ2mmoP/QqWe/OIKDyGBoUgMuRGmM9ARFq14M2lR2hF0HY8XFNUrwWRZUPrbNPki
         FfDmycbfHGzh9tmQiPioprOxwMRN1i4GpqLJqJjkpmGMoe3+pywJX/SIjy8UNYzBi0wU
         yVHQ==
X-Gm-Message-State: AOJu0Yxk5OJA2zBeM5ovlTtqJG8ZNaWTQ01rGGOwGDF0E825RtmQRRBj
	ydKlmxl7iLMmvKplhTD84tLi7+ygmiz34kvKzv7v016HmrfGPjgc8EW/pGzazIo=
X-Google-Smtp-Source: AGHT+IGNR5BYN2HXGSPs+VQNSYhLsM/2O6+KOSvuCAHGwqfjFw0UVx1cafcplfBPWtjgF8KdjNjiqg==
X-Received: by 2002:a92:c549:0:b0:360:7937:6f7 with SMTP id a9-20020a92c549000000b00360793706f7mr952902ilj.3.1705698117134;
        Fri, 19 Jan 2024 13:01:57 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id j29-20020a056e02219d00b00361a1b951f7sm1023250ila.86.2024.01.19.13.01.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jan 2024 13:01:56 -0800 (PST)
Message-ID: <9e09464a-d58c-4f17-9318-26f0813a3023@kernel.dk>
Date: Fri, 19 Jan 2024 14:01:55 -0700
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: REGRESSION: no console on current -git
Content-Language: en-US
To: Helge Deller <deller@gmx.de>, LKML <linux-kernel@vger.kernel.org>,
 "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 Thomas Zimmermann <tzimmermann@suse.de>
Cc: avier Martinez Canillas <javierm@redhat.com>,
 Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
References: <05ea3233-20dd-4af7-86cc-de11ad2efe84@kernel.dk>
 <0293b14b-6188-4229-9fb6-29fbbdb8dc83@gmx.de>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <0293b14b-6188-4229-9fb6-29fbbdb8dc83@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/19/24 1:55 PM, Helge Deller wrote:
> Adding Mirsad Todorovac (who reported a similar issue).
> 
> On 1/19/24 19:39, Jens Axboe wrote:
>> My trusty R7525 test box is failing to show a console, or in fact anything,
>> on current -git. There's no output after:
>>
>> Loading Linux 6.7.0+ ...
>> Loading initial ramdisk ...
>>
>> and I don't get a console up. I went through the bisection pain and
>> found this was the culprit:
>>
>> commit df67699c9cb0ceb70f6cc60630ca938c06773eda
>> Author: Thomas Zimmermann <tzimmermann@suse.de>
>> Date:   Wed Jan 3 11:15:11 2024 +0100
>>
>>      firmware/sysfb: Clear screen_info state after consuming it
>>
>> Reverting this commit, and everything is fine. Looking at dmesg with a
>> buggy kernel, I get no frame or fb messages. On a good kernel, it looks
>> ilke this:
>>
>> [    1.416486] efifb: probing for efifb
>> [    1.416602] efifb: framebuffer at 0xde000000, using 3072k, total 3072k
>> [    1.416605] efifb: mode is 1024x768x32, linelength=4096, pages=1
>> [    1.416607] efifb: scrolling: redraw
>> [    1.416608] efifb: Truecolor: size=8:8:8:8, shift=24:16:8:0
>> [    1.449746] fb0: EFI VGA frame buffer device
>>
>> Happy to test a fix, or barring that, can someone just revert this
>> commit please?
> 
> I've temporarily added a revert patch into the fbdev for-next tree for now,
> so people should not face the issue in the for-next series:
> https://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git/commit/?h=for-next
> I'd like to wait for Thomas to return on monday to check the issue
> as there are some other upcoming patches in this area from him.

Given the issue (and that I'm not the only one reporting it), can we
please just get that pushed so it'll make -rc1? It can always get
re-introduced in a fixed fashion. I don't run -next here, I rely on
mainline working for my testing.

-- 
Jens Axboe

