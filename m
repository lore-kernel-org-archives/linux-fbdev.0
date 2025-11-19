Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40AB23594F
	for <linux-fbdev@vger.kernel.org>; Wed, 19 Nov 2025 13:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763560646; cv=none; b=gVfNJ5WyQw88FM4y8UVeC/1vEIFjCPlW5LTrso057+FCa9RpZ1jiWF97YX7SKvwd0rLVyk5NY78XrD1txg2vF4dTRTiDIZ1CAmPwrfyeGFdgc+QZe2crMe3iRSVktauBNH9tSmEQvECuD4ym1VRJxuBChujGWy0I1GypS0NRdV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763560646; c=relaxed/simple;
	bh=t95h38urR4hl2sxtnta6IJGy18VlxrnggA0cIH6J4oM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P744xwHPERGS7GkbN63EFbnMBLDdnO/hwpeMvl+aIWjS3EynbsB7Ldy1cyu8it4cgllgnt5wqcNxE8QiuslZ6Sflj9Gyvt4wthMW7X/vM6uxRXbOAX7446AcvwQd58/e/2iqLvEzn5B7+5pTnnyt0MKvmrq+6wjBwAOP0Zp3Be8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B4tuqFEF; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B4tuqFEF"
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-5dbe6be1ac5so2694950137.1
        for <linux-fbdev@vger.kernel.org>; Wed, 19 Nov 2025 05:57:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763560644; x=1764165444; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=de5iNSvcqaaOwtf/lxZWP8NugFiYs5OOT1HDIPeVtSo=;
        b=B4tuqFEFHnE1mhQwgZKhstQvJ9jV7vzNPczEOQ0HLynwoVm53wZhNd+sKrTPMIYC5t
         91ZEZbqhbjVRb0NNkkU1GknV2EHUdEwJ9fvqscHEg6YaiXA1BHEFn/srOvl8EYQkYiFn
         CF/A3hD9Wn/YCz5nxm6PHF/23FIDX30qds/DP0WQ6rRyFQByR7+Bt0qerwxRoMDu0WeR
         nKHliUkxljE0JnjM1Gqh4XyoaT1eN13IZ22YXeBrwHl1LXLpDWvITtHYoVzghbS2Oo1B
         PzWWav7RNYW8XWqzLBATfiNFGATCYFp7tq+Mu6E4r3/yGizvAbng2jwC88rLZWHVk2oY
         a1hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763560644; x=1764165444;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=de5iNSvcqaaOwtf/lxZWP8NugFiYs5OOT1HDIPeVtSo=;
        b=UvrTthpdkhD0Jj2XQgMuRR5rj8G1cfDSg7Cyn77rVHYonMc69HNLkocNVV9BE3vbFO
         hMnr9uysikSRtfJ1CeZLHiud7rM8RzZMtulVgduCggDvrWhwPwMmTa2NEoOhVKaR8AMJ
         uiFjf7DfwzE+oke1jZk1BRKj7xtX54X+u912UfdlEbeXLWkHOkcXOAXVWUpR03ySC8AG
         vxp7NSf54K7+fDXKfPKHCJ7/lIlcjGFOWX8jckZ7MkyiTfSxOAPBuh5ZMxHv0LkJG73a
         AZAId9wqBmuOM3FUkPOtlg/C1h9UxUvKYRHEyGBtCsQ0pJ3TQHjDxRhk7Z7FjJmFattQ
         n4kw==
X-Forwarded-Encrypted: i=1; AJvYcCV7MxhlmdZMqNox5Y9i/pBMGUnO6gtAbyGopubUe6z7ex7qDZwWLnjHmH8ldbdTt50nrFSaQAVYIy14gA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yza52GONpxp1Iuf/tbdEOWOaTSzDtEn6WsXbGpE8RymRMcSlyE9
	euSp4AeslTZNiuvd9U315Q0tcjCB1FtKmEt5rek/VxNQHmdQHM9EhXV+
X-Gm-Gg: ASbGncuQT6LR9DXbevkvHHb/mjqK6ZUctuWD1wbar9g7NiCOetbImQvj428OoRWNR9N
	AyMrf51RxBxUwYrTm8oAA25XsMUgMYCFjbGDpvCm44gsZo8NoTntrmKo6pG2j/s0qfhqghiUsmz
	c8boQezj469sKdsV4DcdMhpP6pGcG430irx8uc7NQFTFhwcA7/cfOnYPzTXaaqJiaZpizDbfmZ+
	kyV1c8di3NczhkxL+Ys6dznZ5WxjW3F3o5IuBhR4wZlIIcStSZxe4bZtbQkXMaO7oH6Cekkje/y
	uWnwV1odoVOLi4LgyegmjCEJ0R656fscSy9aIuxpXwxhBMImNBUrY5eQ2Op3HXOXM0HKgqyr1rc
	h/Iubs0rnctFBZ0HL1HrbI0Y7JXhDgKkaqQ//Mnle7+JQKV+nbdUINB1C/rVNeRGe2nk+vBArCU
	mJr8ycwH4bkfYX7aotx1DjF2LZ6ezPpoMf0OK09w==
X-Google-Smtp-Source: AGHT+IGa7rzG95o6W6cj6AePLxJr9+GNclEXHGzK7/ZUIMQGaEM6Y41RRqYBi1xyySb7CTzboZJPMg==
X-Received: by 2002:a05:6102:2906:b0:5d7:de08:dcd6 with SMTP id ada2fe7eead31-5dfc54eb53dmr6337612137.2.1763560644030;
        Wed, 19 Nov 2025 05:57:24 -0800 (PST)
Received: from [192.168.1.145] ([104.203.11.126])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5dfb726ff96sm6675438137.14.2025.11.19.05.57.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Nov 2025 05:57:23 -0800 (PST)
Message-ID: <4ec784a5-0f67-4fd3-9d51-d89a9fa9a385@gmail.com>
Date: Wed, 19 Nov 2025 08:57:21 -0500
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fbdev: q40fb: request memory region
To: Sukrut Heroorkar <hsukrut3@gmail.com>, Helge Deller <deller@gmx.de>,
 "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>,
 "open list:FRAMEBUFFER LAYER" <dri-devel@lists.freedesktop.org>,
 open list <linux-kernel@vger.kernel.org>
Cc: shuah@kernel.org, david.hunter.linux@gmail.com
References: <20251118095700.393474-1-hsukrut3@gmail.com>
Content-Language: en-US
From: David Hunter <david.hunter.linux@gmail.com>
In-Reply-To: <20251118095700.393474-1-hsukrut3@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/18/25 04:56, Sukrut Heroorkar wrote:
> The q40fb driver uses a fixed physical address but never reserves
> the corresponding I/O region. Reserve the range  as suggested in
> Documentation/gpu/todo.rst ("Request memory regions in all fbdev drivers").
> 
> No functional change beyond claming the resource. This change is compile
> tested only.

Reserving memory is a significant "functional" change, so you should not
put "No functional change...". I have noticed that in the mentorship
program, mentees might say this often times when they have not done
testing.

Thank you for describing that you did a compile test, but I believe that
more testing should be done before this patch is accepted.

As a result, if you are unable to test this device, I believe that an
RFT tag should be used. Also, the testing information goes below the
"---". This puts it in the change log and would make it so that if a
patch is accepted, everything below the change log is not put in the
commit message.

> 
> Signed-off-by: Sukrut Heroorkar <hsukrut3@gmail.com>
> ---
>  drivers/video/fbdev/q40fb.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/video/fbdev/q40fb.c b/drivers/video/fbdev/q40fb.c
> index 1ff8fa176124..935260326c6f 100644
> --- a/drivers/video/fbdev/q40fb.c
> +++ b/drivers/video/fbdev/q40fb.c
> @@ -101,6 +101,12 @@ static int q40fb_probe(struct platform_device *dev)
>  	info->par = NULL;
>  	info->screen_base = (char *) q40fb_fix.smem_start;
>  
> +	if (!request_mem_region(q40fb_fix.smem_start, q40fb_fix.smem_len,
> +				"q40fb")) {
> +		dev_err(&dev->dev, "cannot reserve video memory at 0x%lx\n",
> +			q40fb_fix.smem_start);
> +	}
> +

Is this correct? It seems to me that in the case of an error, all you
are doing is simply logging the error and proceeding. Would this cause
the device to continue to try to use space that it was not able to
reserve? I do not have experience with this device or the driver, but
that does not seem correct to me.

>  	if (fb_alloc_cmap(&info->cmap, 256, 0) < 0) {
>  		framebuffer_release(info);
>  		return -ENOMEM;
> @@ -144,6 +150,7 @@ static int __init q40fb_init(void)
>  		if (ret)
>  			platform_driver_unregister(&q40fb_driver);
>  	}
> +
>  	return ret;
>  }
>  

