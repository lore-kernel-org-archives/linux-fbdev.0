Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D6D29B200
	for <linux-fbdev@vger.kernel.org>; Thu, 28 May 2026 14:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779977734; cv=none; b=PBWB3sJrXQiS94RLTpcUTQPHH7585tgOfJm0kTo7cQwdSGhVWoSejU/cnIUjEwe4d8qNzesz4/n9jp9GwH2w1SfOy3lX6Qj4F8TShA9uDNDZZGu8kNLJGSBidT7BnVg3jDgnlLOu8gb0JhNUJnu069aCuEqBf4B/uJ4B/evMumU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779977734; c=relaxed/simple;
	bh=6962Qk54f9gW1s6ogjP02dV69DIR4TKUycqJSi9UZ3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gvxFr2Xx+SrCM1MOWxxz9+jPu8CDijjCwyaaR2TPDwDCBoE9QMnIYcEdqirn66+D+oF0lNvVkm6pkF9oaRdkE1IZIicCYiNHnfu9quhFy2bzr2Lt3A59wKgzOdj+higVJT3ExKEdLo4hIPcnwQ/pHSYod++2PWyRB+kWWUrDKsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jp0cKFwQ; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jp0cKFwQ"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4896c22fcbaso110400415e9.0
        for <linux-fbdev@vger.kernel.org>; Thu, 28 May 2026 07:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779977731; x=1780582531; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=A8/kbdI5Q8i09zmSK+F/62AaBVf+xYaMTdSTospsePU=;
        b=jp0cKFwQI1mTEuNDSIH2Wvbwomti6sS0aBxYCmRyHXq/hJmXyRbT8S2ZEOHdZLrJ/6
         8oTkXYmxeHlFis9ibA4v2ccD6lYVSyBoqMM+fViIrMlD3cfUvj7gNeUR6AlYac9pZaJa
         bEI4XU9MH7rvTuHre3TmPRPo1kGv+fBOAEJUAzqBLt8SN1DVEGv1FBx9ApMn2bGiIDss
         Z7624JT3mBU0K3phLa6qtsx4FBK+/r3bi5NwhUHJiKf97qSqkzPjpRlJqA4Ddvl4sOoz
         FEoUYHCScNiwFN5akCjVXc2HhHs3qH/SK6JTIdARz0AioMinR5z/53QhppcB1gDXg8lJ
         mrJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779977731; x=1780582531;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A8/kbdI5Q8i09zmSK+F/62AaBVf+xYaMTdSTospsePU=;
        b=qYcHwI4yQP649nBqjYZM78WEH2ztL73akAm18UC6TO5aDRAvAfp5lBm0YLS47HpJ9R
         BR/cVEW1UB6zfTHYN5lOym8u5DdnK9CdD44Pq+IWt4u9us0u9I31cyL0pb84rLMARwLI
         KZKyGFlGxI3/XzdfUzyl7tfTXsHFO6sTuerD+1Jt3M0QA/eL3VbrkYtLvdtzgN3+Dh3T
         4codzuYhnxOFVPCvadQ8VcLxmNsz/9oVja9jjxpiTTuQQkkva6dIleXIQOKL4MSxPuLq
         ah19x3ID6UoERLo/me6NbgiyJF5cDPngaOc15tNH7pVswwAepusXrvFxA//AyvwwL2RG
         sJVg==
X-Forwarded-Encrypted: i=1; AFNElJ8+BHrbR/nRgfr82enJhnJ/QiluVJFnZ9UCn0JS39Y9fJEmIARvgAmfe/hkgJr73RDuRFD/1wm7dadYxw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8pan7dHUeWm2QpnDdl63hulnASq+X6mYElvcqlA/GPmykZaHA
	jtmu0Me2XZl+RBUwKJysRrMAR6BvZ1kMhDP1K8Q9coRRgPt8GiucaV9EQ5+agmXo
X-Gm-Gg: Acq92OEE8aIum4lb/ng7Pec86HzLcEPYt6qE0lteFJPJLskyL4xOOXyVGheD427H/KE
	BpmF+lPsu9Sd73a+wycHjDXm4ZREir2ibwU+vQxLaxtLcXOaunQhvx6OMZl+7H7WS8MBGmD970P
	KQzFp900+BHvVmLHwRoEB8cqTlEvjYKwO0S5uOWua99orYbbYfXX8zEUr1O3NqHu6EYQ4faQHyC
	URvXEe5b7U9y1uGrvn4AhM2/BC6XQq0zhMw8ujun39JYjywTxQzWn9ghwc6tyMJJDB0c7XFPAhT
	tR1W3uK2I1jj7k7q3WTwohtvqcyqhiBfw/j9pWutNu+Hfp2tlRCq6eimAlPT5UbpzopMLZW1TRO
	2JtvWBKAknn8kJEbrMK1axIXXy7gzboU4V88VTeIJN34EiIEhgLOqipxI9MV5ZqlzcoEcHNOj4U
	cJ0IE/5kpxLjfnr5/BJyryRDKrUhMDnyKiRA==
X-Received: by 2002:a05:600c:19cb:b0:490:507c:bdb1 with SMTP id 5b1f17b1804b1-490507cbed4mr410417065e9.15.1779977730628;
        Thu, 28 May 2026 07:15:30 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909294cafasm43958765e9.11.2026.05.28.07.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 07:15:29 -0700 (PDT)
Date: Thu, 28 May 2026 17:15:26 +0300
From: Dan Carpenter <error27@gmail.com>
To: Onish Sharma <neharora23587@gmail.com>
Cc: sudipm.mukherjee@gmail.com, gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev, linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] staging: sm750fb: rename pvReg to pv_reg
Message-ID: <ahhN_kiSb-yRWfiI@stanley.mountain>
References: <20260528133627.10850-1-neharora23587@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260528133627.10850-1-neharora23587@gmail.com>

On Thu, May 28, 2026 at 07:06:26PM +0530, Onish Sharma wrote:
> Rename pvReg to pv_reg to comply with kernel coding style (checkpatch.pl)
> and improve readability.
> 
> Signed-off-by: Onish Sharma <neharora23587@gmail.com>

pv stands for pointer void.  It's Hungarian notation and it's not
allowed.

regards,
dan carpenter

