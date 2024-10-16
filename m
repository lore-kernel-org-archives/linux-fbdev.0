Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE57487A5;
	Wed, 16 Oct 2024 04:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729051478; cv=none; b=VNcuhb+Nry3CGEVRNNMgMmouiGqCXH2SRCU28oVqZ6cHsMHL31VUPUG/jIeMKIWP2e9DfhqIxKxE8Rew3Svkju2heLuAy0yPCcwURNl5IGv1sNU2UZ+OvvHM4nhR+M1bdLThxx4njpEyczNUhcOaLd286OvawJKlOdUe3qsYvT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729051478; c=relaxed/simple;
	bh=ZX6XiKW0M/n8Lnvqlh1DSl+hNCpB4P3NallfsjdBN1Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O4EvXhdEvk8r7fG826opekD4lPpJoAfPD8Kr8c6V7oNgGFgLWrC9pyA40cU+ZJoCdXD8m3c92wIO8/GrQciY+/IMaKVdlglzQplCVl7dNl3hxuIgfjtZo5g0LRWxQuLPEOcOZ2/RcVmFPzHtdyASfObLGtyKbzp7v4Yd7FqNZac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XDd+GF+t; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XDd+GF+t"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7c3e1081804so3552077a12.3;
        Tue, 15 Oct 2024 21:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729051477; x=1729656277; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=59NZbVQOS9Li652Zznp470jAKXQhZQZy0L3fXqoVtrk=;
        b=XDd+GF+tOom+7p7CozxVlTaMQhWa8t7Q5Z/d3WgchVL/nAlU2zhjNXvf9XsnGZC3nO
         bylMjqciHbOm3gjLQQ9g2IQ59E8bQhqVG8WEaSCHbvclR0a7pp9dLh4Z1uYlsAmF1Tuk
         0Rd2VEGHTPrOunJ4oZ0oX6sFe4vCl5KQ60wdimzOTegkiOoLc0VFNqtjGcRIDnSOjGwt
         o//YoZVon5fZHOsGGhFscyrPLodHm0mIHWF1nEbupV3w43X0T9NP4T/38BUgEnxCgV/x
         8aebu8EChFi+mpEM0GUZ9NAOA6mg3NkCSfO9Q7SviMhC4wqX+m63kabRWEURT5DipTP9
         zVZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729051477; x=1729656277;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=59NZbVQOS9Li652Zznp470jAKXQhZQZy0L3fXqoVtrk=;
        b=nn1WTl4OIAmOGYwdJqHfPlLzMY7OK5oCZORGgEfsokDA03Bu/L1M20LB7tI9/2Qezp
         RDB19hCFenR59h3jdlzj29aMZ8QkdeXLxxPfH9yy2KH0vd/LEYQFdQsz7FwhoU760Qif
         eNtHTR9s3BjSX8n0nakkUHFMYJOe13gHYWzM8UoFkHoI/Cn94Dgef6qixSc/+TJQL9Ws
         g3XtMOSMitWxju0EG+Xvmaxz3685ybXqjKoprMlqbmsxT5wTHhK0jQhtNban8COVBuRp
         kiyb4xcpbcFrGBXA3Dtt0oX2zmXR4zBLUBqBTRSxJHVUlwJjIcvU5ZiJC7QyvnLSuDgs
         +wdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUocRKMHkihrVgiKe3af/Fi/I1kx+YrWHH/xqOOIOirStflT30okMslW7S2zZXRGhraZSWanFDXca8jjA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9d2Yl8mR/YjENT4UURaTc8jp65fpxdroQ5AWnpMXsrcNxAdAD
	aBN4cbtBiXf87zZqTXCr9MDl24/bzkeQL1RzYKwPoxvtVNRiL10O
X-Google-Smtp-Source: AGHT+IHPbt6ayP2jbww1xbmug0+xqouQX5CoAQQxJZQYaF5exueNlXpzBtj0KFTo0KFcMMRMoyLHiQ==
X-Received: by 2002:a05:6a21:4581:b0:1d8:f4d9:790f with SMTP id adf61e73a8af0-1d8f4d97fa1mr6194095637.22.1729051476605;
        Tue, 15 Oct 2024 21:04:36 -0700 (PDT)
Received: from ?IPV6:2409:40c0:11a6:bd6f:94e5:e911:e544:8911? ([2409:40c0:11a6:bd6f:94e5:e911:e544:8911])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e77370dfdsm2144367b3a.42.2024.10.15.21.04.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2024 21:04:36 -0700 (PDT)
Message-ID: <694e02fd-34b7-427c-9693-322afbafeb09@gmail.com>
Date: Wed, 16 Oct 2024 09:34:30 +0530
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] video: fix inconsistent indentation warning
To: Helge Deller <deller@gmx.de>, adaplas@gmail.com
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20241006071514.5577-1-surajsonawane0215@gmail.com>
 <fab752c8-0193-4d97-bbe5-40c426ede668@gmx.de>
Content-Language: en-US
From: Suraj Sonawane <surajsonawane0215@gmail.com>
In-Reply-To: <fab752c8-0193-4d97-bbe5-40c426ede668@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 15/10/24 02:02, Helge Deller wrote:
> On 10/6/24 09:15, SurajSonawane2415 wrote:
>> Fix the indentation to ensure consistent code style and improve
>> readability, and to fix this warning:
>> drivers/video/fbdev/nvidia/nv_hw.c:1512 NVLoadStateExt() warn:
>> inconsistent indenting
>>
>> Signed-off-by: SurajSonawane2415 <surajsonawane0215@gmail.com>
>> ---
>>   drivers/video/fbdev/nvidia/nv_hw.c | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> applied.
> 
> Thanks!
> Helge
Thank you for applying the patch!

Best regards,
Suraj Sonawane
