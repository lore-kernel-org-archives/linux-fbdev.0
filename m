Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F4B28DF3A
	for <linux-fbdev@vger.kernel.org>; Mon, 30 Jun 2025 16:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751300641; cv=none; b=HpF9o3hwIuzXOviJnYl+/O1qwkHXhUjMXo22jc6suE/09QhF5PTELK13rUISRLaW8a22iDbAEzA+PrPy/hW5DO7s0rC82KIurDC4ybrpwxhh85DsvX/h2haEgmc7N7LB+gXG8T0jvhB356mxHl0RMAVL2XrbufRb2bzyoy6o6l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751300641; c=relaxed/simple;
	bh=5+OiCZTGghwKa74lu2VCudssFUMBCoc8IDFlvhmwSc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZZ46zjsldrbLKU9s4D567yCjzK/pn4iSGfdKYtFdNmlMEwQvhf35Qf5a/c4UrgOv8xJbSO4dKyKUvsaQmrp+y8dSetRwPJdLFQVMwEfCYgl6EjDXUNqMR356oEvXEo13r6VUK9LFmPh83vIWygXW38OgnpmE6Xzd3I3x1XcMyXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=X4lcGtgc; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X4lcGtgc"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-735ae68cc78so2825416a34.1
        for <linux-fbdev@vger.kernel.org>; Mon, 30 Jun 2025 09:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751300638; x=1751905438; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fA2hiy3pBisBqFxIA1WfhCNpsJVYMFCT5jmkfAR5MRI=;
        b=X4lcGtgcFC4FjrBVGlJtNIbmHEPy0nK+jBG+TPNJYk7M5Vj/MoXa+crBuk5AqLxzbB
         gpQGAMKwsy433OE2vNN+2rKmUfknG5WaVel0jP6nO1MzZBJfX2698w3xvz1C7xr2Zqsd
         D6UY7Jeb/08etcqf+up8ZqaIMhk/EfaVwR824WJj1rfuthPDrKa1wDbHYm3Dg3LRwudH
         jJV/pkeAUm5+v5zMMFH2KQmcFaW3OZxLvy1fooarr7n1H7qAU7clVpmgZAIh9scLZKZZ
         5NRsd390e3HUUhSziHc4Wo8v+wUV9IkR7ITd2ytEexWGRapqwy9sLXKWG2nj2zd/rix8
         eSHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751300638; x=1751905438;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fA2hiy3pBisBqFxIA1WfhCNpsJVYMFCT5jmkfAR5MRI=;
        b=AmTuv7U2BnlbcdpOavwpoYdjNk0Hx4B8lD+jsPwJFgvyOr6u4Xf2JvtIdDAM5T1Ugh
         SOTj59d0stcNGS0oAV5+IgRYuAD+lB01iYYE5ShGM/wR8L8XxXxsY73RRc9iPDWqrNsP
         sURnWUPmQa9V04S6Y7bDbnYI2lVn4m3/Aq/hLWs3rDKP0f88QXZQKjqiQhDWOVAVkXgS
         1pTK5sU0CPaU6ZieqrK7QYx7ygfQl8fL/sKepdGelyDp4urPBkpQRUnaCL5F2Q/y6G+B
         T03RUq3Gfk/YoM+xZYcKE1WNyo91aQ6N9ap1VchHIayuVyR9FR/F9hWFjmCYbSM/GZPG
         +0kA==
X-Forwarded-Encrypted: i=1; AJvYcCUiEGSD2KGLD5lI33qY8QSqO65r2mpGGmjJ/j5sGmOMSYSsOtNuTeSEh9C0DGC8h4rBuZoFDlGLlp7K9w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzaWMTLsbvHe3ed8lH7WiBH2W003Vlq34RLpt3p4tQTNDwR5vIC
	HFrcQfo+EhQRd4NZIrE61g3zkCP8MmN1tZWji6otQwLVXj8Q0A9qN3Nk9hmDKfD2Tn4guCRyVPd
	3GhsgwnQ=
X-Gm-Gg: ASbGncuthTmJHG1mqJxYdak3l8GQBKCrPOyWjePOnFlRQ3jrXiAXyI276VB06l3PpzB
	HippwC0urgmenytUMI4+vHIWjkbhMjT9sJUAAHIFP+g/CLVAsdRaHxRsrfKz6g84+QL0ZYco99q
	yU0mHAoP30Crsp0iRWbWG/TxopaUzjjdWsZdCz4oj6oU2NJJNSTf+7mjssG9lyAVFGWQ5QkOhYH
	ciKv02NIW684x3907XgfbuDcadGh6g8tlcLAsnFwPyei+/am0GA5y+rTDjGr+2tTd1SLmeY0EHt
	BsInCXAiDiSXa0LZgr5rydrRI9GRfec9Fxy4tPMxf3JzEE1qZ+Fvj/79OgYlIVOPPool
X-Google-Smtp-Source: AGHT+IHI8m9128kRd2fU4qN7fgHZ/eU48Raar7DmwpFo5FAW57ejeRpFPJvZQgadqdVBw4gRttl5dA==
X-Received: by 2002:a05:6830:61c2:b0:73a:8705:e9e6 with SMTP id 46e09a7af769-73afc43ba8amr8817314a34.4.1751300637997;
        Mon, 30 Jun 2025 09:23:57 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:fb67:363d:328:e253])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-73b2459ee91sm644765a34.51.2025.06.30.09.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 09:23:57 -0700 (PDT)
Date: Mon, 30 Jun 2025 19:23:54 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Abdun Nihaal <abdun.nihaal@gmail.com>
Cc: andy@kernel.org, gregkh@linuxfoundation.org, lorenzo.stoakes@oracle.com,
	tzimmermann@suse.de, riyandhiman14@gmail.com, willy@infradead.org,
	notro@tronnes.org, thomas.petazzoni@free-electrons.com,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] staging: fbtft: cleanup fbtft_framebuffer_alloc()
Message-ID: <e15bb200-f59a-45bb-8349-72816629abb9@suswa.mountain>
References: <cover.1751207100.git.abdun.nihaal@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1751207100.git.abdun.nihaal@gmail.com>

On Sun, Jun 29, 2025 at 08:10:09PM +0530, Abdun Nihaal wrote:
> Fix a potential memory leak and cleanup error handling in
> fbtft_framebuffer_alloc().
> 

Thanks!

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter

