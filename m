Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1912632939C
	for <linux-fbdev@vger.kernel.org>; Tue, 28 Jul 2026 15:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785253560; cv=none; b=Gt27FxW8oik0hYGzI7ICg3uyrT+CbkulqoSCoVnIuteHwVV841tbthrmWsaH0VIQVDqqr7H8H1WK0A4DATS/h/Cj+tjUzcByQ34aFUXs/z4HBqjHIDfyq/xu/lQMEySnek6pm2yvVl+FZmfnwc04+pg8CqXGwUxwnqFB3j5B1hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785253560; c=relaxed/simple;
	bh=VDo4it9UlR4Ioy8LhcAXVYqM6+ETaNhl9l00CrRvZx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LodpB1nWSIeG+9cja1/wEVsYP1RKoWPII35GxsSZRx+UQpmyZyC9asLYGER7BlESfH7gtp07DUHZg1zQ1nEawA56We7GdNi7sMFAbvJv+hNBpaILK/g/0ynqvkqLD5rw0zyPddB15HGR01toh34SqkKv2ZfaiObhw/pvwNF4fVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mxJc9hF/; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mxJc9hF/"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-38759bcd877so2691781a91.2
        for <linux-fbdev@vger.kernel.org>; Tue, 28 Jul 2026 08:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785253558; x=1785858358; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MWiV0+CUdqlaiqVq42BuBLs9iZw1MGlogw86iDmjrO8=;
        b=mxJc9hF/zxbWGE1gS/oggdyOMS7wlw+pFNLjGvnVgvNO343noTPL824nJTMleJx+w6
         VSHzF+n1jCyzI72lbMkvwdPoIoYHEYr8XKQBypdjRTrp8zuOmNcwxqiwWeTouHkkLlKx
         kRwIHoSOQHBdZkKBSh5iuyK8V7lio6nL764IOr6y9SPuBVq+wa5CgdS7QV34mJU5nuPG
         hIxJwqPPeLaYkG9VZ5sX3jgSrr8COOmb7xMaWZ6uAqlMusQ3ca/NHr3ap2r5iVMT0w6+
         PX+zeeU+EcNGQf64EEgU6ET9LxUxyBbQXucAnBDuflXHYAQfRM1GcCn5ynSSLSmtIVso
         VlTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785253558; x=1785858358;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MWiV0+CUdqlaiqVq42BuBLs9iZw1MGlogw86iDmjrO8=;
        b=HGREPCLPU8u9eiEaTrPRjiLcOGbwJ5nC69c6Xqc60D54a70QOqPA7HpHZyv314f52o
         PYa+3e8a+aXxmGHxigOMqenq8jXuezeYT9miY2y93hgxdxg3CenbPvo+TBDQISBI+Y/v
         NTzPc+hp6JhVztYd5WverDCNlr1V/PHHDaxA1vCKfohJteBiCkQURAwX3MpwvVX7+HA0
         pWAZpKIOngMxIbWC/3PKOsmkVbwl1ebzYgYpiDD5sP3txk1Cfv/Ldgnb5MdfvYsx8L2e
         fMRHCBHS1O6Y85UFm+wBDvNQNOkXFkakiPp2Tx4GVGV1bK93+NJv72MLPSP2Rq1hhDjp
         Gg+w==
X-Forwarded-Encrypted: i=1; AHgh+RoM/0hsm2S2hkcNZEzUEpLD8GS2xzQcAkLJf8zF+gBNzaaH7CGh50gBmTNjBkwL1rNsg+EJ8CEAJE0bEw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxzHOp1r41jVRSD0x+Kt5vZ2dIDqcf6Tddk0eYrg2AgQJjgTXFX
	wfW3HaLyvN1F5WihFL5+iX67YkBJul2/BXgx7H8bi9DTvMlV2+KIUR7t
X-Gm-Gg: AR+sD10zr49UkXM9zfuNDXFrwIasgAv+F9QH/ynqS6MlzxSCHrKm30ZSEdQl0lx8dFy
	+3IMuxlmqRkIj9CexlxJIXunTFeIU4uwL0fXlx/WAlcWKN/aTBQ5D7oNtvUpmwMvDvQq9ESn1kw
	VS5RD+0cpJa3B5KNbfpkXNOtOvjApPpdpPwJKIV5maYbEPDY/XE9R5U68G6hg6Sk4ybynqPuqsi
	G+Sb7+lnmMOZlFw3syScx/OW2ENfarPL90vZIdLzvAPmY62/f0Ee1gSt7qGBOIv5Jjy0x1H69Jo
	2p1vr95dTbnYs8B5BnfLB2+E5uGgr3JMUN1RltI+qbWj21Y+2yBsrIJI2S/m+ijF1qOJ/zJu4P7
	K0IXE4CC3xJ/oXeMDRJYPPfcfyM/q7zIWCTXnacsnsR6qHVNu4sqxr59ZxQ96QpkCEa6SNqIW+H
	RdeE8cbAY=
X-Received: by 2002:a17:90b:33cb:b0:38d:c74d:29c5 with SMTP id 98e67ed59e1d1-38f6a37699emr3215736a91.19.1785253558298;
        Tue, 28 Jul 2026 08:45:58 -0700 (PDT)
Received: from localhost ([172.216.252.23])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f056202cesm4465321a91.0.2026.07.28.08.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 08:45:57 -0700 (PDT)
Date: Tue, 28 Jul 2026 18:45:51 +0300
From: Dan Carpenter <error27@gmail.com>
To: Muhammad Bilal <meatuni001@gmail.com>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3] staging: sm750fb: fix mono image source stride
 mismatch in lynxfb_ops_imageblit()
Message-ID: <amjOr0NiY8OMNaRf@stanley.mountain>
References: <20260728131050.37032-1-meatuni001@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260728131050.37032-1-meatuni001@gmail.com>

On Tue, Jul 28, 2026 at 06:10:50PM +0500, Muhammad Bilal wrote:
> sm750_hw_imageblit() advances its monochrome source pointer by
> src_delta per scanline, and computes the correct rounded-up stride
> internally as:
> 
>         bytes_per_scan = (width + start_bit + 7) / 8;
> 
> Its only caller, lynxfb_ops_imageblit(), instead passed src_delta as
> image->width >> 3. For widths not a multiple of 8 this under-counted
> the stride, so the source pointer fell further behind the real
> per-scanline layout on every line, corrupting the rendered image.
> 
> Rather than just fixing the caller's calculation, remove src_delta
> as a parameter entirely and have sm750_hw_imageblit() advance by the
> bytes_per_scan it already computes for itself. There has only ever
> been one caller, and that caller was passing an out-of-sync
> derivative of the same width/start_bit values sm750_hw_imageblit()
> already has, so keeping stride as a separate parameter served no
> purpose beyond letting the two calculations drift apart, which is
> exactly what happened here.
> 
> Rounding up, rather than down, is the direction consistent with the
> rest of the fbdev core: struct fb_image mono bitmap data (the same
> image->data this driver receives) is walked elsewhere with byte
> strides derived from a ceiling division of width by 8. The generic
> mono bit iterator in drivers/video/fbdev/core/fb_imageblit.h advances
> scanlines with "iter->data += BITS_TO_BYTES(iter->width)", and
> BITS_TO_BYTES() (include/linux/bitops.h) is a ceiling division.
> sm750_hw_imageblit()'s own "(width + start_bit + 7) / 8" is that same
> ceiling division with an added start_bit offset, so the caller's
> ">> 3" (floor) was the one calculation out of step with how this data
> layout is handled everywhere else.
> 
> Found by code review of sm750_hw_imageblit()'s internal stride
> calculation against what its only caller was passing in, and
> confirmed with a clean -Werror build. I do not have this hardware,
> so this has not been exercised at runtime on real sm750 silicon.
> 
> Fixes: 81dee67e215b2 ("staging: sm750fb: add sm750 to staging")
> Cc: stable@vger.kernel.org
> Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
> ---
> v3: Added the version notes below, which Dan pointed out were
>     missing from v2. Added Cc: stable@vger.kernel.org, flagged by
>     Greg's patch-bot since the Fixes: tag targets an old (2015)
>     commit. Added the rounding-direction justification Dan asked
>     about, citing fb_imageblit.h's BITS_TO_BYTES() as the existing
>     kernel-wide convention for this same struct fb_image layout.
>     Moved the "no hardware" disclosure from an email reply into the
>     commit message itself, per Dan's request.

Generally the no hardware disclosure would come here under the
--- cut off line.  But I'm not going to nit pick about that, it's
fine.

I see also that the "Pitch value (in bytes)" comment supports rounding
up so this looks good to me.

Reviewed-by: Dan Carpenter <error27@gmail.com>

regards,
dan carpenter


