Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9062E2222AC
	for <linux-fbdev@vger.kernel.org>; Wed, 10 Dec 2025 04:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765340805; cv=none; b=f5GS7CYIaef1sJTGspDrXkeUiek1LBy8w5jSIMDWXInvFd/rzdc2m+E5H418lmnXpkkqnJU77DmuFGcxCPWxl1DS4QCJRqHcYZe9T0y8BKR9OzmTSwAegvAUM9VNzSjoSwfRuAkG9IIov9rleoyEZFkCzjF+mz7skyINstWECf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765340805; c=relaxed/simple;
	bh=sj+TFlLPqZ+s1w+yvXLn+DhvC+eXwCs89D5IuNhjqs4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e1c4/Jwaxx7VF3ruuXblxvfWOjG0ymiIW9Z9bKv1wwKz8X+Pk//Y1aB5D+EgpMebabn2uqd4STDULTriWeleFpEQaeYqgSZrSStj1mlpqAUAMPTw7kkXAaiq+gJacYOkuqLy1+AMcX6i2isfj3kCTbQR4RocLaEp+WYfKFZkb6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K3yDQEYn; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K3yDQEYn"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-34a2acb736eso1940938a91.1
        for <linux-fbdev@vger.kernel.org>; Tue, 09 Dec 2025 20:26:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765340803; x=1765945603; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tk/No+Mm3I+u10bIGMU4QecHhYZtSqoq4vJuDZr7ifY=;
        b=K3yDQEYnu9nAEUfOoQ4xYesBmvWT7Gex4NgUgyG4vwMxJ7RiJi6qwyu8NMZ8Ri0H2s
         HDUpyEeLvGryDc2mQg6/CSAn9xJGAhcoqkm6dobD9/tWS++tMyo8DJ1XayEG094Bllel
         dJxxwO+U/qxhtNQlTGor7JKaYXspfqDAo4CZ1ppVn98om8DIaENX5Z78bbcGCTTIjq3H
         Mr7dD17pnnuyZba8i1fUFDICYl4tbX4oI9MXWPAOKR0b+I0K06Stw8vcwnJKxHMtTHFA
         SIMFZ4ub0wan1+dT+6i/keL9+MGReqAug1NC7T4O7ypZxGwS+asikd9rH+4q3c8WxruH
         Vnwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765340803; x=1765945603;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tk/No+Mm3I+u10bIGMU4QecHhYZtSqoq4vJuDZr7ifY=;
        b=N3VofrksyXVzQIE35OBBr4A7rRjPcFcK33D7qilh7bCzvq3AYRChoM2+psrwzUyUqD
         x1DgbjzBxSj6Azu7WjoX6Bi/SPTbqYXhncx8ycKj+03T/ZF3JOtxSW7pSynK066bivi0
         DkOq2u82xjdQ6OXnQp0y5sYu74cvw9KcXCUXSqKNy50B0QA0I+/Dz6/OXCZzpNl61BVO
         4MmS3PpbaXphI2QKyIcNF9o5lkDDu9TwWX1Ry7DbIhXIoRu7R6qXI70otZfZ9skfHBm8
         t5HHnWKxEYcndq5VW3/QYd00aqDsstcwn9L9rakIFLjHWJAkMTY/uxnCcviBNEU5HMCu
         O0oA==
X-Forwarded-Encrypted: i=1; AJvYcCUTK81NYsLzjc6mDgnJtQrru236zmA2LGiWt3LE33ZafJRPgHg2y/1xPQcTu1nexzbNdITjzylzkAynnw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8XIzTfNihMV+gZMv9WDK+87BDxNIQWXS6x1ecI3IBSeHEKo5O
	UfSnpTdKxlYBMcKbGDtgwiiDmCNEqZcYH4UaGCW879Yu+evgI3S2Tl5L
X-Gm-Gg: AY/fxX5Eu3whsVUE6NYLQGirw7sjgw6NO35rPpD397f1fvzPYJCH34KHjEhco/BAvdJ
	YhvVj/VhSlp4hcVX2KhZzpoQN5JysVxpJq1I5+90i4EAE1rAd1c9wQv6lkBobCgjpb0xwmvjID6
	VRw8ydAtQOF+xKwqUkLuUPR582fFJyWGZ0Cm7iCK+xB0k8BjY8HJkFUNOvBO0thAb/1LDlfiydC
	/8NddwWIeUkBSWuhUH+deSfdEQZb5O22ac7VlmO50GZUcDSKfTzm51JilAsOQdMzXCZ3pxq/zNX
	fAljabXtQruOLArSsKEI41x180Rx+O1V9AbbPORkynFhOJl1IMPzL+hYBqkMKy7UMnD2UvEBM6d
	d7wvCYijAF69ryT+okz/iLdrYKml6hCBSPzWQ+LSuPAyIgkllwfA/i0HfaC9DTvvFxpNPCKhmPN
	jygfc1TCAtQ4kIIAbfXoPqQ2cIneswAkhQvyVySeoJfJ6xSdYds6RvxOuGy7bU9iqQiZ+UjSQ=
X-Google-Smtp-Source: AGHT+IEkCPOkyg0imXvpe+yjarzV/1sk/8YYfqF82dhTlKcX5BeBSLcY5y7rsJgrq/q2KnhrIhD0uw==
X-Received: by 2002:a17:90b:5252:b0:343:684c:f8ad with SMTP id 98e67ed59e1d1-34a72808b72mr1162287a91.4.1765340802654;
        Tue, 09 Dec 2025 20:26:42 -0800 (PST)
Received: from ?IPV6:2601:1c0:5780:9200:b90d:2938:bd7a:289f? ([2601:1c0:5780:9200:b90d:2938:bd7a:289f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34a70926cd8sm971106a91.12.2025.12.09.20.26.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Dec 2025 20:26:42 -0800 (PST)
Message-ID: <d71e2795-f918-482b-af0e-18376f8ca835@gmail.com>
Date: Tue, 9 Dec 2025 20:26:41 -0800
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] fbdev: Guard sysfs interfaces under CONFIG_FB_DEVICE
To: Andy Shevchenko <andy.shevchenko@gmail.com>, Helge Deller <deller@gmx.de>
Cc: Thomas Zimmermann <tzimmermann@suse.de>, linux-fbdev@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-omap@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 andy@kernel.org, gregkh@linuxfoundation.org
References: <20251209042744.7875-1-chintanlike@gmail.com>
 <19e8a1b0-75e3-4c8d-911a-15fd70f60bea@suse.de>
 <f5d50007-5b48-47cb-8133-72fca274d562@gmx.de>
 <CAHp75Vds8GP+daMe9WcEbOaNT91kMHUjidzGUN-1_kVDuWBtLw@mail.gmail.com>
Content-Language: en-US
From: Chintan Patel <chintanlike@gmail.com>
In-Reply-To: <CAHp75Vds8GP+daMe9WcEbOaNT91kMHUjidzGUN-1_kVDuWBtLw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 12/9/25 06:25, Andy Shevchenko wrote:
> On Tue, Dec 9, 2025 at 10:23 AM Helge Deller <deller@gmx.de> wrote:
>> On 12/9/25 08:27, Thomas Zimmermann wrote:
> 
> ...
> 
>> This whole series adds a whole lot of ifdef'ery, which I think is the
>> worst approach. It makes the code less readable and leads to two code
>> paths, which may trigger different build errors depending on the config.
>>
>> I'm sure it must be possible to do the same without adding more #ifdefs,
>> e.g. by introducing a function like   dev_of_fbinfo(fbinfo)  which
>> simply returns NULL for the FB_DEVICE=n case.  Then, that value can be tested
>> like
>>          if (dev_of_fbinfo(fbinfo))
>>                  {...do-the-things...}
>> For the FB_DEVICE=n case this will then be optimized out by the compiler,
>> while you still have full compiler syntax checking.
>>
>> Thoughts?
> 
> I second you. I am also not a fan of ifdeffery when it can be avoided.
> 

Thank you for the review! Will do the change.
