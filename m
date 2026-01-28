Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA352EC54D
	for <linux-fbdev@vger.kernel.org>; Wed, 28 Jan 2026 11:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769600816; cv=none; b=bGUtfr7g2nGwOwWqylL16d6jk1+XuxA8daDU0IlfkmnMXJUhcs3AQpT2OyF7vRmJfuep8RqJHPzZLk9a5ZUS3kGZMYKY1O/Vwlagtug90oToibSB5R8hhRPFShu/HTZaWpz16NRllLRItUdoTsG8e+alguC/bbPYLqa4eFWTbvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769600816; c=relaxed/simple;
	bh=/1B77Aa5R+WBSByqnqrIhirli+RecJNNuUsY+wsM0nE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YgJaM0XSC2JTFzQHsZ0q6BU0vQt6jd+c1Wh2TlVg5JkUu2WjM4cbEgzRFG+v13EawhjxOlef/LGBUIVhRSpcyNd+BHT47GQhU04rAYkrsB8+yX0EsB4t/Z3/mdvOpCFwdlT7z+F7z4Tsu0PEPBEj1x1zfX6Y8uAy36GMpBAeFlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xfGzbHSg; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xfGzbHSg"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4801bc32725so51809785e9.0
        for <linux-fbdev@vger.kernel.org>; Wed, 28 Jan 2026 03:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1769600813; x=1770205613; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=khJXybkcVVzB8mqgpRU1gLtvPugBIJAWbxW5cUcew3s=;
        b=xfGzbHSgobyP0+LMy0dj5oQO/eBvJciDqkXOzebpRDkuHTTlIGPZuD7NJtJUDGwr8t
         pp//Bp7PAEbArRR/xHzTPkxRNLhE28bwGfGddUlncWKFDbSR9froM+pRiDF3TW7coMga
         REAxRlYp0m8uBEI50SdVBr8gilCHN0GgIJQ0BA7ypNRmjbX3z5PGDVHro11ve33QhOqU
         qEQwg8Ve45T+UKdPZ/dK6uOcRrtQPDhus9T0uff88RJIJ9VqfadyBlnTnqW+bVw5+vFo
         kNro7WQ7FJss5/CunVnP7Q4GE0EZ4ANCa8sSGvfPGE18ZT+7cJEeQpZEpo/G1fjHlu46
         1FdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769600813; x=1770205613;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=khJXybkcVVzB8mqgpRU1gLtvPugBIJAWbxW5cUcew3s=;
        b=Ef8gA65HkILKNdoi7oFANjs0P/OCTitOfyzkx2IVm0o/K8C49w2qs/mSA9CReCO+Xt
         Vn+GMGx89gtBfGoC904sAgOSNaA7KJfC+ahLWv6WqHZLcwrH8jH7lTnTTU8viGEf6frF
         w/UKbhXQrOQ1Nak6k+e+uJWCpod/ytEkK22APnCdQbh1awGVJGyGMdtGn0ZF7qxTbsRW
         pR50zgIYzD5jVJm6Vmq5gB6VvEd6EUfsVUvvK68lCAtsgm7IhUHTnj+8ay7PzigrXSJW
         RNxiR0qtHqGzwTzxGgMSQ/TfTgRdeWdda0V01VupBl/I3C8OD6oU2sIql5bILjf85mO9
         xNRA==
X-Forwarded-Encrypted: i=1; AJvYcCWoR/50ItuCtuiSH7oGRITR1YFJTwhKTr9JRm/vcg4OPXC6TTerOstaLl91umr4C+zoaTZUkklAKX/7yA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxxLgvMWYEYwXi697mGMr1WF0Pt443iSBxHIHBHcqrxoKU9U4Mr
	ZwJqtnrAKkX+DxS6uHua6ns/lHrUaLp0h3L38BFbWzEZt38Fd2IRrbl4VlHTKmEvLys=
X-Gm-Gg: AZuq6aJ9SN0Naer4zQSQ40tMgfxjjM1n0u3vZPGA4WmSsmGWtcprAXxpZ7+dfrRkqWX
	R6EkoKd2E9MR4aGPNWuqFJdujSDspXtTbGEH/MnBC5iXKfNu9cXbHL8J+wr0RtQY08gbXGdn6ED
	SrhU7I3QVFH37BTi3wEqz/HmVXTdE3cXGj73H1JOnFz3ntzH3I+NrggesezAhoPl8HtfY8ZH1sB
	RwaKvZNeq3HYG6TPGBfyemqIGq6ccbuurR6fpID/JLSqmEkkmKnnJgces5R6O8yA73956DdCcfF
	WRXos6leY7LgzoBlHTxHyI6cszW+aofDSxvvemtJDtsL+dhenDWkpEF6XBo/bJwCEJ09IfLkd81
	pgNO+2jSra4fJKjONm2/5z/YxuJt9VLH00aPGrelIzmIHNDIgHCM3IaBaDzkg4kGjIUPpHuGLxP
	4Y2sDcxn1OkE7MJGBD
X-Received: by 2002:a05:600c:a08c:b0:477:63db:c718 with SMTP id 5b1f17b1804b1-48069c43e80mr67128725e9.16.1769600813044;
        Wed, 28 Jan 2026 03:46:53 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e1354205sm6549747f8f.41.2026.01.28.03.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 03:46:52 -0800 (PST)
Date: Wed, 28 Jan 2026 14:46:48 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Madhumitha Sundar <madhuananda18@gmail.com>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: sm750fb: replace magic number with defined
 constant
Message-ID: <aXn3KAIpVDr8la1o@stanley.mountain>
References: <20260127132758.49650-1-madhuananda18@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260127132758.49650-1-madhuananda18@gmail.com>

On Tue, Jan 27, 2026 at 01:27:58PM +0000, Madhumitha Sundar wrote:
> The hardware wait loop in hw_sm750_de_wait uses a hardcoded magic
> number (0x10000000) for the timeout counter.
> 
> Define a constant SM750_MAX_LOOP in sm750.h and use it to improve
> code readability and maintainability.

Timeout counters have no special meaning.  They aren't intended to be
re-used in multiple places.

There is a kind of bug where people think we exit with the counter set
to zero but actually we exit with it set the -1.  Normally, when I see
this sort of bug, I change the timer from cnt-- to --cnt which changes
loop from iterating 100 times to iterating 99 times.  It's fine.  No
one cares if about the exact number, just the approximate range.

The original was more clear.

regards,
dan carpenter

