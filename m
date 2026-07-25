Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FAA63998BA
	for <linux-fbdev@vger.kernel.org>; Sat, 25 Jul 2026 08:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784969996; cv=none; b=Q+NwDMKZiPv0Ijqhr2QaH78ltdRgD64aJ4JpUJKM0z06IHm3ZQto9Y+D8EHzdcU4p7bfiWXupt5By4jB7iZXninwlyjTVufSeAQgcActSz5ok6GT5uMmpEaRLju1uHcq6yCHVYyp4UxtW93PItL1eWkq42yHs+6ZWokWFggd+bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784969996; c=relaxed/simple;
	bh=5MwmaoaW95tVUWMj8ol9Sr1didcpfiPdV9xHydvh54I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A3dE6GmgtpymocDSRH1oz2kYQcKkeCkPukBke51ctcFQjfbDNtvrVYjIOlNmV9HIr+er2zrJ3EKO8ChsSprknfKwFWmRLSakI6uXuKcaKKm+CgPws7MmsVX4LODuMNi/lD0tamWlZdzg8ZE0Mstp+TBAP16PNownU140Tc3E9ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a5kjR6HN; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a5kjR6HN"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8487b7b3fc8so1237091b3a.3
        for <linux-fbdev@vger.kernel.org>; Sat, 25 Jul 2026 01:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784969994; x=1785574794; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UbQYEEJpzV2V7mwGYT8rwyfPdNnK/gZ6YuB02J3vSqU=;
        b=a5kjR6HNCva01Sg8o1NWgYXcC3U5ZnMsQborA16GL628ypZEm3HdMMpkpp253QvN9E
         XOS1IqCIfYI3saId60jWlGbybllaqhCcO20X5Qq0Dh4Fygvf814o0yFdL9OLCchUnmwj
         C68fJBgReiFZEaGOH0z5xAOju0JR136U4PZifad03yLezsBkmlvEftAp5I3BKwvrwCSo
         78e1MnFe665tRf7TL9J2UZOtejx4E6CLUm7ewjQuiOkqAnuNMU+gsEWZn849aG1xm8aJ
         P5MzeuztOqRZecv3F4A8LwqqVYjYUFth8qCWliVxmyZFEDCgquZcGkCDkWABMgvf00v4
         yjFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784969994; x=1785574794;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UbQYEEJpzV2V7mwGYT8rwyfPdNnK/gZ6YuB02J3vSqU=;
        b=EQFNFRjYX7ZWytZUx85FiSGhpSl4OryUln1dWL8Ce6R+nw+7tvPb3Yix7W824cRfkG
         cHq28+VfbIjWYVYqecbCCHn3XYKH4qypHo/fNgz1DwgkcViER1Xy+DWM81kBdYmJiiNN
         dVebFwaxQ9j4tuKDDo5d4Z6fAMskN5t3qNezFdWvUlErzj6y3JUI2HpPXLc4qa48mzK+
         y1JV00nwWaIKylsvtzoEbPDD6ygXl+7zfExFIquwJIAey+1AVCVhLF3rhBArh06yVRhQ
         mqc07da+6E2zywZXgCAuGzF80ejnxgSrAqA1dNd7HMD9alYrryqE6v35LBScLZSY/S+Y
         dR1A==
X-Forwarded-Encrypted: i=1; AHgh+RpvLNZy4H0rTBWBxm6PpWCxRYWMxfaAInNQXStkBnngaZia4G9Bxp4ql67z23ZxqKkxsnBRPyb6wfvKHA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyQNRnnDvW/wBwmyctY9WAMLMvzYM5W0iHEPfth6JP4pMKt0tNX
	+ldo7SDn/3+bJG7eifmoAxQ/RuCf7rRb/sES2fV0vFswALvC04bRtZw3
X-Gm-Gg: AR+sD10xQPSaaodXa4ZKeBbKC1sQW2HogCrahF/WUXKy1Rcaf9IENjQyJhXjoh0Z77z
	wwYuXQQ/oW/ovLxf0vzlot4FEQ+FuBxT4b3fSPw1Ykfa59yxAn+ohYJ5hz3dyoPYJjN6KdAai/k
	UCPUGGj+F6eBtl1sTPPsU0+GKzyQTVSY/EeiIEORhnaxDASGvW0fclrIcH6+Np6jtN5qX4a+qns
	Pi+WmJwtnqdLw3oQRwD95fHS45STKLuvSZausCH64KzB/HHiiNL2NsMklnrqEy1PwftJjPq2vrb
	XZeIFgXDzUwE9qntblq1X5N27GJ856ysbCj39WhTBf2YSJl5mWyiRA+JOmy6lTXGVthKl3u0HBS
	NZ/xgP4ze5abl3kreiqZA9yh4YA6448u+8Kpw61m6JMp+vIKgEYoyEEe/vo2pwlDC4IaNAnK3
X-Received: by 2002:a05:6a00:180c:b0:847:99b4:d011 with SMTP id d2e1a72fcca58-84e59554766mr1191339b3a.39.1784969994409;
        Sat, 25 Jul 2026 01:59:54 -0700 (PDT)
Received: from localhost ([172.216.252.11])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e5325856dsm909382b3a.9.2026.07.25.01.59.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2026 01:59:52 -0700 (PDT)
Date: Sat, 25 Jul 2026 11:59:45 +0300
From: Dan Carpenter <error27@gmail.com>
To: Mohit Mishra <mishraloopmohit@gmail.com>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] staging: sm750fb: Remove unused function
 sm750_enable_dma
Message-ID: <amR7Afw8WeJcQBY1@stanley.mountain>
References: <20260725084649.106589-1-mishraloopmohit@gmail.com>
 <20260725084649.106589-2-mishraloopmohit@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260725084649.106589-2-mishraloopmohit@gmail.com>

On Sat, Jul 25, 2026 at 02:16:49PM +0530, Mohit Mishra wrote:
> diff --git a/drivers/staging/sm750fb/ddk750_power.c b/drivers/staging/sm750fb/ddk750_power.c
> index d617f554f58d..e4bea8da1827 100644
> --- a/drivers/staging/sm750fb/ddk750_power.c
> +++ b/drivers/staging/sm750fb/ddk750_power.c
> @@ -90,19 +90,6 @@ void sm750_enable_2d_engine(unsigned int enable)
>  	sm750_set_current_gate(gate);
>  }
>  
> -void sm750_enable_dma(unsigned int enable)
> -{
> -	u32 gate;
> -
> -	/* Enable DMA Gate */
> -	gate = peek32(CURRENT_GATE);
> -	if (enable)
> -		gate |= CURRENT_GATE_DMA;
> -	else
> -		gate &= ~CURRENT_GATE_DMA;
> -
> -	sm750_set_current_gate(gate);
> -}
>  

You need to delete the blank line afterwards as well otherwise there
are two blank lines in a row and checkpatch.pl -f will complain:

CHECK: Please don't use multiple blank lines
#93: FILE: drivers/staging/sm750fb/ddk750_power.c:93:
+
+

regards,
dan carpenter

