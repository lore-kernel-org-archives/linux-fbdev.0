Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7769734DCD9
	for <linux-fbdev@vger.kernel.org>; Thu, 12 Mar 2026 13:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773323825; cv=none; b=abBUNVMt2wzZ0WX3oJHP1O/jfIegOomU3SgCMQZNBTX62C1iRLZYH0cLxTHMOwXLnX8RaQwQrztxdL+oKSbLVTZlMsswT4egjrBqeaFGTYqKxLRghUbHzsPwDB40FTob9iLX7Ly+yvDcttMiaAz3UKdhG+xRRhJQFqzGekLc/tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773323825; c=relaxed/simple;
	bh=iN/UwKVJuP69SNyoLwLZ7RqGz0VPJ36dbcNR08CBkPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qqsMiF1ULIWzrlt5CAb6XmYY41kX+wKDmqw3tBXaA4Swix1WwgxWTtOmJ8ZgVsOv25XN6/A7iR9I3L9oIcuo7XT+F14+8oLoKwflBRCExIkN2wDmSHtoXmtX76c3A6aIx+XAK3jkG7w/pKJjt++78lbkqQMlGeukIDCqt0W1VWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QOf2p+ld; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QOf2p+ld"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-439c6fc2910so883787f8f.0
        for <linux-fbdev@vger.kernel.org>; Thu, 12 Mar 2026 06:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1773323822; x=1773928622; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ktVDN7qYq0WOHCD00szxOqNnI17BzE5korotOZpq77s=;
        b=QOf2p+ld/vl77vX4y5DBecVb45dOo6sNTLi0G0buf3g3pAl6byFv54sqoxuKwLmwXi
         PyTFr0aX7YKlqJRREf+Pe8RNQAb9ZYt0b7ODZLDq/m6vpMmcT3Uko10vr1nnGHwZQ7qz
         n1evQaITwa/wATVEO4O7Z0NAMIxFR2LXVrFlFFZ1WemlZ2heia5c9u+agCacL9pBZN76
         1C+EvMDZRNAU2tuUftBeTP+XE5uFrHFO1qucLqXVTAcoYakFIA2+N6ZjPYayon7ALwhN
         nakhGkEEaCTdkGSP3Di043wYSsaQEHDehRlqv8BENW5Ga37MZEIf3d/c1uCXr2KArbiJ
         0J7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773323822; x=1773928622;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ktVDN7qYq0WOHCD00szxOqNnI17BzE5korotOZpq77s=;
        b=wtWDGL3NcznHXX4Y3fb9ixd/UJgKfCUZK4k16FhfymHWeWwfdgOFgz9HR5z2DfHcNX
         1+mjceTTt7vr23cDIS3qsNz2usUY8ZLLbh/SWziVmb5cBIo98BXRv2ZoOAe0Sf0pGC4/
         qcolvbXqCpyz5vTjfuamn+FVdiEjY4bWuE0a8gzNZi9GJZps+CJ+CHxu6FyYiduZar+B
         oFJ5FOyMI3HZP2LFQoaKxvd2X1h7ADzgdw5is6nPmi9Nkt6Z6Q5v/eH8UHJAxDJVodMr
         gAk60LSLCscb2DEyDFVKrBRhgxuH8zC9sQUWA/v/02v0u+njkiIn0HesEE3MISgMC6u9
         YqLg==
X-Forwarded-Encrypted: i=1; AJvYcCXJPaK5+qCVq1Y3R23diZAMUKjKBBjQG6wRzW9G6xVo3UQYcw2noA/2QrhNm+OhT5otdyV6AuP1QxMdSQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxnd9nTvpwiYMDSXoj/KTBqGGLRXe502bdCHr1xFwcNBhuEMlb7
	MvAKSETa+0G03CWRhR9MXmmz3rHUrzYvPYXJA1VRqaiNDS82a/3EbD2hZmUTixPevGk=
X-Gm-Gg: ATEYQzwAQIqxO6NELjxNzIkmRqC1E+CqtsMA9XMjaljqmYSamXrkHmDTlv7k5RT8aFg
	3l3q0FStpEaIr5wRpi5v+ytG7Mb+ArIs/kc9TovPaZ9riQcWCa3gbiKlb1LcsNjOgqxaZkPIOyM
	2kAurIf8rNxyvd6ytENcRcCVQTuXmApLxdV45LlK9xHTZK4utMj5pyCA0z+M/zxtDEmVf9WFqGr
	IiufqMXQtm3vqRfNreC8Z5SAm4nAw/8PBIk2XRic9zPUEPv1ClXj0uFfm180pnHWG759vwPr+Tt
	MB/+LUH21F0seqyQxnr2fR4hW5/t7RU/bir9kWeI/zTZlGNilmuKZ/VfPy6yGUw3oDxTHmBCKSd
	oF1z6SNq4XUuifuJ8rxJdz0cb5bX6TsAQkCU4nyCXXEP00CTVq2mg4ojsroKmifiD/9lrQHGGZc
	WquzpVONRvGrcaaTGVQCp9RQv0lP+S
X-Received: by 2002:a05:600c:458e:b0:477:7ab8:aba with SMTP id 5b1f17b1804b1-4854b0ac93fmr97513165e9.1.1773323821702;
        Thu, 12 Mar 2026 06:57:01 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe226473sm7606686f8f.32.2026.03.12.06.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 06:57:01 -0700 (PDT)
Date: Thu, 12 Mar 2026 16:56:58 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Zile Xiong <xiongzile99@gmail.com>
Cc: andy@kernel.org, gregkh@linuxfoundation.org, deller@gmx.de,
	abdun.nihaal@gmail.com, chintanlike@gmail.com,
	niejianglei2021@163.com, dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: fbtft: avoid empty macro argument in
 define_fbtft_write_reg
Message-ID: <abLGKjvKMorbb3Vb@stanley.mountain>
References: <20260312111807.96789-1-xiongzile99@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260312111807.96789-1-xiongzile99@gmail.com>

On Thu, Mar 12, 2026 at 07:18:07PM +0800, Zile Xiong wrote:
> Replace the empty modifier argument with a simple identity macro.
> This fixes the error reported by scripts/checkpatch.pl while keeping
> the original semantics unchanged.
> 
> The generated code is equivalent and builds successfully.
> 
> Signed-off-by: Zile Xiong <xiongzile99@gmail.com>
> ---
>  drivers/staging/fbtft/fbtft-bus.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/fbtft/fbtft-bus.c b/drivers/staging/fbtft/fbtft-bus.c
> index 30e436ff19e4..380dd374a566 100644
> --- a/drivers/staging/fbtft/fbtft-bus.c
> +++ b/drivers/staging/fbtft/fbtft-bus.c
> @@ -61,10 +61,10 @@ out:									      \
>  	va_end(args);                                                         \
>  }                                                                             \
>  EXPORT_SYMBOL(func);
> -
> -define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8, )
> +#define fbtft_identity(x) (x)

Someone sent this exact same patch before.  Same name and everything.

https://lore.kernel.org/all/aYECoy7Apjwgzr9r@stanley.mountain/

A better sollution is to learn to just ignore checkpatch when it is
wrong.  My previous email was longer.

regards,
dan carpenter

