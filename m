Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6B551021
	for <linux-fbdev@vger.kernel.org>; Wed, 13 Mar 2024 17:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710351197; cv=none; b=pdpZ03H8Bu+t/ykrich3AoijWQlRoW4MpGR8ooIP4Gr//+fg2nkF1Eio9WHC7eLoPEzk4tffoUUK5vGcS1rM0z9ZYmiB9E8L3wZhfpZSPJ2GIFfewV/xi+A1fK3DlUMsZfY9yDvlw0jlYJf27zsfCD3jDfsOTBfUF5gaZT+ZY18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710351197; c=relaxed/simple;
	bh=CubIZf+/omKUsb3lOARefyB/2NtkoeTUL3xuMU6Y8/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V00akfbO+ZEp5lJQxEnen8/w6HXi8Uxhwtex7fOxA8SGzr57/CeWUoQJJU9U57axsaLOAeuj7ofx02wQJ2kfd2YOEly6WhUNK+HjY9sx+EcYIhfE+EudMuzRvJElekih67yDKpVDJu5vNyiKSDfYk+1LdBlXB8cBMBK+prbj218=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GsvCsZDw; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GsvCsZDw"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a45c006ab82so9595666b.3
        for <linux-fbdev@vger.kernel.org>; Wed, 13 Mar 2024 10:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710351194; x=1710955994; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9xJXU/djE+6AamWsghHa5QQd0IYVhNMehUxy5z/IImY=;
        b=GsvCsZDwXNfFbs5w0i/jkdfqpwCROghchOWdsMcQDLmnnp5nAl3KVePcRnLtC3yTFc
         ovpXMA6MRcb77KxtDEiGWBOXEY+mQFGoPeqt0lSuMQK5k7S+dSbkY+33vsvEJRCozRC5
         7shh///uREW3L0UoSOpWrahWnUJRH3YDKP7KJJNSAZL9GXzAm0WqT+mGEHSby/OxjrPy
         dmoahCWJurCpSJgvc7va+ofZ6OVT0Ewut8J8J9bvqTKwURsrr7NEosktVyp6rpziS0/2
         OK31aW77dPpAmPDFokzPDXIgr03ivQ4p/cd7xWqIf6vQVAD8Q1h4bibM7eygDAKna+et
         oGcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710351194; x=1710955994;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9xJXU/djE+6AamWsghHa5QQd0IYVhNMehUxy5z/IImY=;
        b=tWdSXQKvILWrOS6iSRQ0FtnfEZ7/CqPBLQnfaVfRY2MfwHBMkOsDtFlH7vUqQNn+Gg
         3KSK9qsWRLin/m6SqjCnuO88c8C3WyV2LjCSTE4Pk2hU5mm/7JkkLeu/XAgQ9s7z6qOa
         VHyYuTigZDL9ecFkNQwqhhR5lsIWj4o/W6cUqULKHiZ/UWwD2o4GXjRUD56A34WqJwQW
         3PKQxnkVl5tAkzSWcduVeIBgQbsGvypk0ZNAgtmH0iOGlUf+NIXAQD3yrsPHaSAUc/Q9
         YSBHo9CS87p1QIs1G98D0GdYWH02GG8MSZ9YDz9heNpUGl3p01URlQKDg4LzvqYIKhSs
         zhZg==
X-Forwarded-Encrypted: i=1; AJvYcCUw41RyKBgKcipRKOZ22nfDlfkM3POgaVKqAaG3t2KfrORZWmOX98rV/Sh9lv/maCtA6y5HUBM+ytU5zMelJzy15Oro9iUVnvV2GL8=
X-Gm-Message-State: AOJu0YxglVdsozhTZtEmHVkW+bP/nJeWXgXa1d/zYzp8obaGqjW0c+Mt
	kystmOpP9J67/P3d8cmlMMaU1AKKFQAOTETr3AGUgxKrM0zsfxLMtjBGYTzRHHg=
X-Google-Smtp-Source: AGHT+IGWVrwxwMFG8QtjiHohVmMptNb7CchWBc6WHbIGEiRSXUj1DaCqpwulZHiaYzSMSsRwqF5bPw==
X-Received: by 2002:a17:906:2e86:b0:a45:4416:1fbd with SMTP id o6-20020a1709062e8600b00a4544161fbdmr4184614eji.39.1710351194341;
        Wed, 13 Mar 2024 10:33:14 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id qx26-20020a170906fcda00b00a45a687b52asm5011259ejb.213.2024.03.13.10.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 10:33:13 -0700 (PDT)
Date: Wed, 13 Mar 2024 20:33:08 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: lee@kernel.org, daniel.thompson@linaro.org, jingoohan1@gmail.com,
	deller@gmx.de, dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH 5/6] staging/fbtft: Remove reference to fb_blank
Message-ID: <a30fe590-23c0-4fc8-ac2a-577a2fa15e97@moroto.mountain>
References: <20240313154857.12949-1-tzimmermann@suse.de>
 <20240313154857.12949-6-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240313154857.12949-6-tzimmermann@suse.de>

On Wed, Mar 13, 2024 at 04:45:04PM +0100, Thomas Zimmermann wrote:
> The field fb_blank in struct backlight_properties is deprecated and
> should not be used. Don't output its value in the driver's debug print.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>  drivers/staging/fbtft/fb_ssd1351.c | 4 +---
>  drivers/staging/fbtft/fbtft-core.c | 5 ++---

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter

