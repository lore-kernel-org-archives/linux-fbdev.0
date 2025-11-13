Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B26DDD2
	for <linux-fbdev@vger.kernel.org>; Thu, 13 Nov 2025 08:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763022076; cv=none; b=a1dI7r9wSY02ztaLSIS43cfp6ML5QnklcnakxrU3DQc0nTynaI/hOCu4fwf/e3lCS7ct3ON7L1AynzqFIBd/MBZWFL2DOO9yUsfljqPP0XQeEOxujZn3NdOmBd0HZ8rwHTrOQ+3N7FVOtzKOnFnKNsibNnU8MW7HI8CRxm4MVhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763022076; c=relaxed/simple;
	bh=L7rrq4WiKIi6GSN+aCQUJaSUVAJ38fs+p26mjrNBcqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u9h2mfG9MiRp5l/nsqNgbkFg/9h9gyiKQgEKnfu1jbu2DlxhbmJt/SkqfmldfGHyE42TMONpzZByqoHe6Q5gOF3IUcsjx6Ek1ihSPBgk3Ft/HIeJAgMCDR/IA7lwrABLl7nYX4OX4/h12yP9OakjGwoTQKS1UruTuRrXBbni7J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lz5pVcjH; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lz5pVcjH"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7aad4823079so498459b3a.0
        for <linux-fbdev@vger.kernel.org>; Thu, 13 Nov 2025 00:21:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763022074; x=1763626874; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L7rrq4WiKIi6GSN+aCQUJaSUVAJ38fs+p26mjrNBcqA=;
        b=Lz5pVcjHLjyVs428Y0hpKPDn/LaATzeAbxLcZITOxrCMrcUgAQuy2dpyeXU+USKPOP
         ooRBeJ+DrWQc1f1X81sqAfPUx49KjNKZlHXh8eYLBtaPOZkHr0+MeOPFyDEQvr7ujiAl
         hIBC8IGPnYzxdc+YA5y0ufFHJmn5zNc/eXqFHc60Pv07FRurUlSCFCZ9p6qObG1oS69P
         tkxjq4h6ufTe8wjX3tQp00fNS6eBbAv+q7KhKJP7I78VF1gOt6V3QJNOX9lSI425eVLu
         kO/B+SaWbPQC7/d8GDLQZ8zt7KrRDJcdaUKxtQn3/77/hHKl3FKk+/Ibv8gPxwMqfN+B
         dEYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763022074; x=1763626874;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L7rrq4WiKIi6GSN+aCQUJaSUVAJ38fs+p26mjrNBcqA=;
        b=vLZ6gNJeJWvptC6tmLUu9lrHGV8UUCPypqKklrbqsgDHfKNnJUiFUvLPSkfOe2e/sI
         h2jcIS0x1V3G/NK7c3lPi3s5FMKo27Oya6NeLBLwKZhyvbFO7hcWMNQK2M4HkKP9FosG
         d4/vKxzIESFcQo8L3qvsIbPmslQP2v6nb+6Zl497WapdwZBh3D6EhlZcYukui/lN82NK
         +ZZLt0ol4rWy8z92jpubEu1iemtvz8yvCiF37AFiWV80woSEp2A5Gev6LpI956NZqF27
         G3r+fr2s2S0XY9zoXt4nfCcsD643PthUbcZdCOUAev3Vh5t92gCPqGsFo0PrOtMLt/WB
         gMPw==
X-Forwarded-Encrypted: i=1; AJvYcCUKy7fjk6Ze2cfaDxCLikMiGLHmJBGPgXZRv/EXKuxOD9HMp249jv/OKVgB914N/eHapfYkZ/lk4h2g6A==@vger.kernel.org
X-Gm-Message-State: AOJu0YyfeUYRndNJNvzinzPJ8n+/K58ZJMTzG+C+L+HPxs0x343Nrnx+
	f8D9asWZfVD+KGeXdRC9AcQKnFb4GTNP+JXIbRmTQBxRlQKAIy8hyrJb
X-Gm-Gg: ASbGnctDPxBd4ikMay20bZOWGm/+/lhsRG9V32UUm9SGAAoy1Xip/weSBASaEE3PLVU
	0dSHr1K8NNeDU2QB5DYqISCOBmbt1/AvTDDliTFbiRU54Mzre3DgdDlVCkZUH+PGp2mLJMUfFhg
	YQi2BM1VhqGhR8af+034m+yBhjRFRHMcXhcVsfg51Cm/KNUKPufaz0abnx3DaTS+PaBUHB0auaM
	LtqMUn3328wfcjnC+vduB8hhDoN1k0QVf1CdRqkSdvnW2E6YnO5bfVHhbUi6M97nBOfTiCg52zK
	KVnujfuTxEC6NDhtJWfNppohE691DHIA5xP9jrEg2NSisKxIzM8+QA9gchoPgG+aza2zJposOCx
	pPEN8h8CvirJu2LCI1C2BwmvP820VI6RimuMM5KSNX5+eCX3RGNqkL24VTRLv+zuqMNwxwMr8Gp
	baIZc=
X-Google-Smtp-Source: AGHT+IFysTHUjNEuPh00MCrJEYLnKEdmVnsQMMpHldxJQNuHD1tNj4Av6uMadzQrVRooBE7mHyl74w==
X-Received: by 2002:a05:6a00:4d03:b0:7b9:a27:3516 with SMTP id d2e1a72fcca58-7b90a2738a5mr1716653b3a.21.1763022073646;
        Thu, 13 Nov 2025 00:21:13 -0800 (PST)
Received: from essd ([103.158.43.16])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b927c230aesm1431467b3a.68.2025.11.13.00.21.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 00:21:13 -0800 (PST)
Date: Thu, 13 Nov 2025 13:51:07 +0530
From: Abdun Nihaal <abdun.nihaal@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org, Andy Shevchenko <andy@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jianglei Nie <niejianglei2021@163.com>
Subject: Re: [PATCH v2 1/1] staging: fbtft: core: fix potential memory leak
 in fbtft_probe_common()
Message-ID: <zvkfqrnqwksg5otoy2wzfx2xtmcyyk2fgottnqkkwm6q2uxdam@2fthfckoffov>
References: <20251112192235.2088654-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251112192235.2088654-1-andriy.shevchenko@linux.intel.com>

Looks good to me.
Acked-by: Abdun Nihaal <abdun.nihaal@gmail.com>
