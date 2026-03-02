Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC82A34CFD4
	for <linux-fbdev@vger.kernel.org>; Mon,  2 Mar 2026 09:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772442590; cv=none; b=tWnK28mA8FSPN5D+30uZWv+RK9T0oHIzc8B8jhOAR1dk7kdyDczIja8s5bqEreAJ29p2rkjno7BXIcDqXpV1mwIO8POe3GJcfYobCNFyabPERbV0NRkH2kyvZBl4hq1jTDkqcBg+ulqaXMgbUGPy06ZI6kp9NjuQu7KshzX28vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772442590; c=relaxed/simple;
	bh=qjkP/1+k5cq3RnMIRwB1RFWNDwXgn5pOPZDVEw8Wa/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HJ6kxQfAManZyiUxKdPx4fApzkcRPSZjYC6eME9lgMdtC9IPBmcTEUcD8H1s2qmHMTjTrAUT6ZBpbEWrMTZ0mVhyer4hbZ6tqucKX0pnB9dYnNZVilfDSAvtYkXH3+bVfJMecpJg/uCHsdjTdS6+GSeRl6WNCxXp1YTW9l1kQac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Vi5Yxi4E; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vi5Yxi4E"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4806f3fc50bso45542825e9.0
        for <linux-fbdev@vger.kernel.org>; Mon, 02 Mar 2026 01:09:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1772442587; x=1773047387; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=H7hSkAEy5QMDiomw3PMMxDywDx0o6+q0SZ4BtDXuEqI=;
        b=Vi5Yxi4EZTypeu3vPjym2SbWqIf3NmzTxPUvnuyaXmODMDPVP9jm3nUraKNw7cSTUM
         nkhnKBdf/CJWwAC8gMX9/ZdHgLiJHmG3lHIrthsqA1uJgoLFVUi7UfHtWzyJHPMwF+qZ
         9DKpycYJgv75XSg+NbxS3Du33TipmnK/5MmUXPKeUgOZedy4zAlVsaOtPAEnkVay2kIm
         ygBdfP/GTJeo0vKZSUbcusl7Aox+fvyTr6/yfNxlN/CH3Y3oO0QANm5ZHGcQE6V99VF9
         Mqv9Ajvstlk1qhh7GEBM+zu3McZ6kScYtjTNg4HJciigRf9vFUhB6a/iIImasRmDRIyi
         i9NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772442587; x=1773047387;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H7hSkAEy5QMDiomw3PMMxDywDx0o6+q0SZ4BtDXuEqI=;
        b=sNYMfzZEnFn7zQVUrWbfTq2OGuboH6bgOB61Qo0xXSe/dEpN3xUIKnSoyWKWYrgTJW
         2h5cvcAVsJMmUF5Pg2fADH7z4WHKJNfLsU+QZGf8PMBSvI8vOGLI3BYbu2uX+kauPYvX
         /fVw0/Ef4yhBrncJa6I4Jh+k9PY4eRfB7ylPt4bbAGryJLqdMy3U6nTUmS6PGKPy8TZj
         0DVVD7OGf6YxyzP5xEeikUDZbWcibwwu8LlhF/xNVu9hxFjynXEM4RgtmWGUAn7WOkRj
         IlvMgsBJIseq7z9ipAnl75uX+DqkoJaf+RRN9E737VzGOAMd9dEpHxwBDMDlAVZ6oCEq
         SXNA==
X-Forwarded-Encrypted: i=1; AJvYcCVoQOZUy5vKNcOjv8pPCLGnWr2zzCIv6loywXQz5PA2wjBIt7f3lK4Eq84yeF5Ax9BOiZc7cwbEQfL4KA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyGK4CSxGV2j8zccRJAr9CTutlFOhwY79DZ8M+dlEi7V6nzP8mz
	qKb9bDXtwWv9RUMg6R62ebUWwojqEEY7mZsBMD6IQ4qR1Y226Na0Ol69MHmP0CCMoCTRtxvu2FV
	PxQcD
X-Gm-Gg: ATEYQzz5EDjI2R+WHIxL/p+lR6oW/ewMGrig2YirZVOYjNTxah9+J88QewQrMoenpm8
	SV1QM7YzX9plO2ikXI8kEjQAHMjVxx1jQkMyT0PGTu0/UGl0ydWKbzOXmS/ZLRvK6+dzrdqON47
	saEuutU2xZNyzMvFaL3qikjIslG7s8yD3N/hdamc7ANB9UBF5+oLpDLPSlneyEALsnG6tb3DrCU
	nTYLYlZeaCrkszKnGVlyKudRJmXV9AKNJTnMcKE+kETxEaame/SEw9PUYvmsclqV5j1cE1091oT
	w1hsk1BMfD6UZ57oP19/ChhLJQ6GI5wxlk0MWeGo1BIpjfhsr/ltopRZQT9j5BMrciLe/DRAJiX
	+znGZ7bviBf83raS4bPyzvkhtkkCRMOGCNrt/xeDUOwqcYF8wXPtbSBVDzUsRb3J0XMjTFXgsJX
	W0CPcBQzlzh43EihG30t2IB5Xp0ebOLu9MjK8eY+Y=
X-Received: by 2002:a05:600c:8106:b0:47a:975b:e3e6 with SMTP id 5b1f17b1804b1-483c9bbbdfamr201030975e9.18.1772442587203;
        Mon, 02 Mar 2026 01:09:47 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bfeca99asm123479625e9.31.2026.03.02.01.09.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 01:09:46 -0800 (PST)
Date: Mon, 2 Mar 2026 12:09:42 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Soham Kute <officialsohamkute@gmail.com>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: sm750fb: use proper error codes instead of -1
Message-ID: <aaVT1mSeKrSSlrha@stanley.mountain>
References: <20260301051434.28187-1-officialsohamkute@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260301051434.28187-1-officialsohamkute@gmail.com>

On Sun, Mar 01, 2026 at 10:44:34AM +0530, Soham Kute wrote:
> diff --git a/drivers/staging/sm750fb/ddk750_swi2c.c b/drivers/staging/sm750fb/ddk750_swi2c.c
> index 0ef8d4ff2ef9..d90a93ab8fdc 100644
> --- a/drivers/staging/sm750fb/ddk750_swi2c.c
> +++ b/drivers/staging/sm750fb/ddk750_swi2c.c
> @@ -294,7 +294,7 @@ static long sw_i2c_write_byte(unsigned char data)
>  	if (i < 0xff)
>  		return 0;
>  	else
> -		return -1;
> +		return -ETIMEDOUT;

The comment still says this returns -1.

Actually could you do this one function at a time, and in each commit
message please say "The callers propogate the error code back" or "
None of the callers check the error code" or "The callers treat all
non-zero error codes as failure and return -EINVAL" or whatever.


> @@ -264,7 +264,7 @@ int sm750_hw_copyarea(struct lynx_accel *accel,
>  		  (sPitch / Bpp & DE_WINDOW_WIDTH_SRC_MASK)); /* dpr3c */
>  
>  	if (accel->de_wait() != 0)

Did you consider propagating the error code from accel->de_wait()
instead?  That feels like a better solution but I haven't looked at
it at all.

regards,
dan carpenter

