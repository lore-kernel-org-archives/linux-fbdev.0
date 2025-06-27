Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527A02E11AE;
	Fri, 27 Jun 2025 16:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751041574; cv=none; b=R6ghAmND+r9xfRxzuhiqYWDq0hlSktde3GPjDPCnMDFts9yhpkBnSbIiyu8wtRJHZNV2UNOoZ8ov8iajR6xvH+bMgUUR0fKA7TSr79RfqbbqldPWUN4xBGZJBC+UlKsFtZXTm7ulCM7MPl/U7qk31TTiA4lvY0t20KQ+beUA2UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751041574; c=relaxed/simple;
	bh=iymRxdZHCbk6hr0LCFlebLISEqnGtGso2ocica07eUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UQFuOocdkuhk9g4RF1/xhsdQ0pNeYnLRv8Q6+K4nlN7Rp4pn7Bvca+93OjWKSTAVS5O4snZnlavidf4uwxqrujZf16Le8VwveEbPPEYRhDQY4sxF70QGqPlgWHaTOE7uU9P8K20fbbuLmz/3FzntXvjJtdEUiiNmtOnVwa5W0jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tb6YEAaM; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tb6YEAaM"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b26df8f44e6so16130a12.2;
        Fri, 27 Jun 2025 09:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751041572; x=1751646372; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iymRxdZHCbk6hr0LCFlebLISEqnGtGso2ocica07eUc=;
        b=Tb6YEAaMO5bkJZ3D1NCklDpR1Qna5H+NKm65xxJy+piBaa2U5yCqqnY5hXqTkGPIAV
         70Oy2QyBK3YnW24WtsLoXpE9zuiJM05bBKGBmOT8uh8p0JiGcUuy38e/v7tqJru0kwrE
         3uBBf+8ni99bWKO8FCYx5eaXLoN6I1+i26wz9/bymGoVGlvZkO4b97k/s/jhF+5uDZwd
         CAGSq8lI5pz1Z5c8v8fsxp/+pCXvvJXgzl/oUnvFcTOKiU0BQpVPhLEO74qOcpwZ/Y3I
         IqFB4l1jQAP4YxNLy9PxEAFSl4+dztHY/8/S3rMzulzs8prvjMoMnRKrIZkzAV/0mKw8
         rolw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751041572; x=1751646372;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iymRxdZHCbk6hr0LCFlebLISEqnGtGso2ocica07eUc=;
        b=mSEX1kpgWumYtNxiZPNuvvdmk+C+PvXWO7g/58qPNFh0ppYwukBBPduCuPprmv4lKr
         jDbJn5E2rsV8/xOsfQ2fU8R5cky0ZQWjPj3YEkWbiBTQ16lM/ImpyVgfEVWijeSHX1/1
         Ef2vxopie4Mfsu+44nYOUpoTpDwuNHPEAv194A88KNVq3dcwy1JYddob2Z3bndiPVwP/
         CltsE01+3Rw5NVoZBf7USMm9sJHUQA5UUnAzypw7mES6dgI70cBamnw/XajwLWum7JYo
         FwHFuD6BlAhYuP8vPuhzSycQt7l0vWKzMSoHqI4+oLfNQb/kxF5+UyPXYyLFUdFSOAgR
         eovQ==
X-Forwarded-Encrypted: i=1; AJvYcCUm9qRl6bRVnxGigK0PZAz5hs1SP11qjuj6MX86K4vkAAzLvMZhbULkEB76Wu3IlS2Kggi5ShdvgpPvFb2M@vger.kernel.org, AJvYcCWf7V32Ut40p6jxU2W717Ln7VtUpsj0NWwL3RCIHolmTDlv8aBIrIPMTq8JXTtIFmrScNJxV5yfGHNJ+g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzkQ9V4pwalekA1ZQGAkI1ctFc0UXe2Ub7q/bZaBF89/3IDhS4Q
	4jnrrdO7pjxhzCjqExJYUoA0E22tI5pzOH0aCDK6Cp2Gr1kjOQN2gDdQ
X-Gm-Gg: ASbGncs8u78ge+WntY3nW3GbTdcUq7QwQDudELbWiC0qtCsaTCp2TSGHWwaHRNZxEn4
	nscxmoCV62BJUkS4FZ6eHppemfRnIORcIJLjwRh5GthYk4VUHXdldRysBITy3wWxmrucIEnKBLr
	U1IDt7JUNONfufnt0Yw4FXZIkMZsicXYSXXbaw3gFhWv6uEYmxclOp2agwkvhdC2EkPhDJdv+hq
	nEHppZy3/82IubgTCeqt4d+9aKvPI687XwPbFbGy32bhaJUysHIuVEE8jhnjtzgHHP1YegJJJBC
	K8KzQftaFhQCQfMyLqLLwOkT7vHc6VJ22I3uknLHUGXZldYyC3zAQxo=
X-Google-Smtp-Source: AGHT+IFV96Rf4LjT7OKaIYJfb5G8fLhC9of+ZZxWEW59VC9buNUWyd7wTakUgyC5gxDtG2Rwj+b4Cw==
X-Received: by 2002:a17:90b:3c4a:b0:311:c1ec:7d11 with SMTP id 98e67ed59e1d1-318c92a2e8emr6033508a91.18.1751041572454;
        Fri, 27 Jun 2025 09:26:12 -0700 (PDT)
Received: from essd ([49.37.221.186])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-315f51d7913sm6875386a91.0.2025.06.27.09.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 09:26:12 -0700 (PDT)
Date: Fri, 27 Jun 2025 21:56:03 +0530
From: Abdun Nihaal <abdun.nihaal@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, 
	Dan Carpenter <dan.carpenter@linaro.org>, andy@kernel.org, gregkh@linuxfoundation.org, 
	lorenzo.stoakes@oracle.com, tzimmermann@suse.de, riyandhiman14@gmail.com, 
	willy@infradead.org, notro@tronnes.org, thomas.petazzoni@free-electrons.com, 
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: fbtft: fix potential memory leak in
 fbtft_framebuffer_alloc()
Message-ID: <gptas52msk2feixcrned7anmsozs5iyyku3h3am7fmv4jz46ty@lckiii7qhkq5>
References: <20250626172412.18355-1-abdun.nihaal@gmail.com>
 <aF2Ic8BP0zWS6R19@smile.fi.intel.com>
 <0327da98-8a7c-4db8-8bcd-4179b87a9486@suswa.mountain>
 <aF3CwnHyW5HHzDSG@surfacebook.localdomain>
 <aF57eMeNafg1w9Qw@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aF57eMeNafg1w9Qw@smile.fi.intel.com>

Thanks Andy and Dan for your detailed comments. I'll send a V2 with an
another clean up patch that fixes the order and removes devm for txbuf.

Regards,
Nihaal
