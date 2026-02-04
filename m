Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046693D413D
	for <linux-fbdev@vger.kernel.org>; Wed,  4 Feb 2026 11:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770203873; cv=none; b=s52aNexLWha9tp4cD4uM0hpb0dbAeS3rqtft1WyuPatcYZSfT1qhwC/Zn/BgjRFHDNRVYyBtZKZucg2w3ZIP53ixWWfqv8A8Q6NSLthPI/2FOjXp7S94nIeqjTKoVCMdUrL4NLTJIIPAFs10D9UVDJBlz7xa+fK8eQdfSuOeauQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770203873; c=relaxed/simple;
	bh=Zji1aowwvPlJLqP6BI0P+FkJJDk9vJBweSVoQnsBEb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VeqAAraeoG/jU2UMj5GWEj5ULnEc5YTRGhNERTUS3YCVgfx7HCQ7dSOm+dCDfXwSBg+5ATZFqPcChjtcFDKPRv57y4BOXZto2jh1tRvhiRgS4/5whj8ccnAqxMP/aaljsD73fOwMVUyeOa5sUuQtl15KKcB64WSrEZ9HaYAXdTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Lr7k6qpK; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Lr7k6qpK"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-4359a316d89so5061241f8f.0
        for <linux-fbdev@vger.kernel.org>; Wed, 04 Feb 2026 03:17:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770203871; x=1770808671; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WbXz44JPj7P+j9kt1fdw7OHDtXzyxP/if5Dyd2KDXL4=;
        b=Lr7k6qpKldXTh865rdWyf9i0ARMvgU4Kc788nrYidgulpZfJ6yKoj9zgjXwGphNT83
         h1aoAjc4+kkIAKpG23nSsg2U8P8MGGLkgdVS+sytatoEQpBjnvBTFO+Il3D2dbrKv9ET
         taNY64/vjs4Pq0d6/64Wpr296Tu1m6px6WlsxM3WN3ntxbp2nNW/TwKSzLk7EyjnnZmG
         lGAk9AMgzOnzhmBrJYBJLdLZbJ9QAGciNUudjAvifRb6hiV5mGWyNbMHw8UkMnpkkHMx
         23/tqhaGeG548eurr3xDb6AEqx3yWhh6R0tAeSkhFlsbCgx3uo6PtONuLAn1vBlPWyMm
         vsMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770203871; x=1770808671;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WbXz44JPj7P+j9kt1fdw7OHDtXzyxP/if5Dyd2KDXL4=;
        b=lXTukjnOedlifkSLjQRNDt6K4qVPsuqSixgv6byeA95mHGlLThNK93iecqIs8pud6J
         ubYHIRDobAMCif0TLLKURNoX1SAayHzUYPbkYfntSe9qUFmVfyiEsdSsP4K2WZ3+ER76
         k7C7pgF+KXLUIHU2GEKQ/7TDO3qBl7rySbe3Ixkblh42F961M0bEaM3Y0W5WO8uI7SG3
         gWNzsvR1M1+UlYeGw4XNI5B4R4RnZPG62eslIb/oBsplIWKKtbYpUfORDPd9DZm3yCB2
         9g4cAGBvWP7+zRQijGBJNzVnUy5bem5lsMUxdyow+U7ptaqX4n0s4kbjvDSqBBGX3MBl
         2aqQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSxQHs/uOnS+LilBhtuH5fufVtZ1ntdvhIDZfUYJ2IHuZNWOeu8oatjAgRq03qsPFioKo3jgdZIX3RBw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8Cak5Tsbaoamv9YTOw6NxotGdxrb6NPOAXGbX+FT7lHVStRXF
	SpImbrNAfwwsfYXkzc6E+MZyLSZFViqnEdmxeeAb0mv7ZUwy2uF94C8m9FxoYGeMOBo=
X-Gm-Gg: AZuq6aKkyhXlDDVRsS0Ow4T2TbDCl09wPdvhVdhsG1RlQmdyE9WlsI2WIN+sNBDc6Ko
	ylWR8KSEBhKNFJVHYLZaecPrOGD8zzVZj0ReVDCe7yA6U9grdgYawtxjURGN5Ann9+J1QM19saW
	zo/DCdTYsrknm20n2AY03l5KpPMUnlO2xLsEiZYZPt4N2u64UMYCMmj/w+5/Pl+8dVKIjcPUkSr
	QD2NxuhydvhVUFn+es6nZPnCLQ9wpnGwgyikblEjwO6EyhV9vBbTtBu/HhxmKZQqpgZGzstEkxZ
	BLpKXQNZPCSBKHesY0YU3AHxNoXZRrcto7ZKv2EdhYNjVyIOlpzJW2pdz7AejfIC3npQ9+cyIcU
	GuZRwIRrNpSRZvvHqIwfrsiD9b7CUIT3OaR1NF5kcl1oBqzOHe094dsf2pGARxuMcfBrq6Kb4mk
	MBFu5I2+j2HoT9fMJp
X-Received: by 2002:a05:6000:250c:b0:435:9ea8:8b83 with SMTP id ffacd0b85a97d-43617e41075mr3937187f8f.19.1770203871213;
        Wed, 04 Feb 2026 03:17:51 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43618057f9esm4855601f8f.28.2026.02.04.03.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 03:17:50 -0800 (PST)
Date: Wed, 4 Feb 2026 14:17:47 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Artem Lytkin <iprintercanon@gmail.com>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] staging: sm750fb: remove debug prints and convert
 logging in sm750.c
Message-ID: <aYMq2_W4IxRWhKgL@stanley.mountain>
References: <20260204101536.3311-1-iprintercanon@gmail.com>
 <20260204101536.3311-3-iprintercanon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260204101536.3311-3-iprintercanon@gmail.com>

On Wed, Feb 04, 2026 at 10:15:35AM +0000, Artem Lytkin wrote:
> Remove debug prints disguised as pr_info that dump internal variable
> values, pointer addresses, and structure contents. Convert remaining
> meaningful pr_err and pr_warn calls to dev_err and dev_warn where
> device context is available.

I feel like you should delete things as a separate step.  It makes it
slightly easier to think about.

It's really a no brainer to delete all the pr_info() stuff.  I don't
really have a problem deleting the debug code as well, but that's a
slightly more involved question because it doesn't really hurt anyone.
I guess no one will complain.  Greg tends to be a fan of deleting stuff
as well.

regards,
dan carpenter

