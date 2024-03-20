Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B344AED1
	for <linux-fbdev@vger.kernel.org>; Wed, 20 Mar 2024 02:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710902650; cv=none; b=jV69u9ZM4uVbLLA/AWCaaqPN5VxjC475m6iJKKb50NTxyovfKoU54N5EQQv1CT4ZWIaQk3iRNdV+6U7E0Trpkh4uv7EkCUud/qF2KFQRpzpoQbpnY9WJsjCLtScRDGbIc7EnsU+RsCO3D2bFkafXikVm7J21NVmPCTqPPdu9AV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710902650; c=relaxed/simple;
	bh=PfIOWQapDLAw+W44Ln09xHd20/IykxP4ixCfdV5vP2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tx5/nNmeeSe/A7RXLEUlljRzumcafJfwPMbHAlOBNrCUzy7kw7Bjjcly9iBCKVlbdtrmHmpxOULfRfY1WNJokpJqE88WQmLyWe2Eh/KbkczrX0T1L+NE0lPGzu1QZVU7zs1WJs6ay8TvfNVZTsHDUmwnt6TtAj7RSE5S6bka8dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=S7sB6OwL; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="S7sB6OwL"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6e6bee809b8so5786099b3a.1
        for <linux-fbdev@vger.kernel.org>; Tue, 19 Mar 2024 19:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710902648; x=1711507448; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GfIBZvZR+X0639t+/0R7E3839UBAFzDwhD9FbKyVE5k=;
        b=S7sB6OwLK6P0pkurhfOGXCzFnM5ucGpaw+lrFgbTEk9kQexlgcNJATYaIJX0IJ12cr
         ACv6H81BiGUdn6B/4XPrEhf92KtL1zma4jAwnWc8RuPZuljuZxio3QPELQfmrN8YhunT
         CoQNd3vRTYjg9BcqSTJ053MjW2itNE0dnsy9w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710902648; x=1711507448;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GfIBZvZR+X0639t+/0R7E3839UBAFzDwhD9FbKyVE5k=;
        b=rhRMBORNOx8q/I1umx0/Sfx7RWnLXiTg8Ci9BxkdaVUZV3q8miVJaXFotF+gcjvdbq
         Qy1qb0OoXulEfGWvUrx4BcY6zYTij/ZF1ShU7qI64uf+pA6Sj41P/qPUddMmQwOU+6Qf
         DPx4crxM4Y2XaFyRmQ8jVrH0cHMitKSQp6tJYLEleszfvZvEG721kIrBK9TWfoAieC6j
         dvua7BRjKO0Nl6GFYTZeNHzPmRBJdGRI8SnUClx+yXFXyTJYeXMIPw5NmnYbveKTIdZw
         1wlKUIQ/oiSb4MTztg+aQ0R2qKypOTBF7oNDF/RoD+84h9kO/fYslS7vev8lRYalO83p
         keBA==
X-Forwarded-Encrypted: i=1; AJvYcCWsDEIKwlpPM4X53wQmJyn4Y7mpUR/mjOFOpwq+0M1GiZLfgzy5tSkNapItVgiMAonpFrpRjr9mQMaLqc0h5VMXGAazVoKHEnRnq3k=
X-Gm-Message-State: AOJu0Yz+xAx82lN6UmNYVKq4H/3dzgc2aJIt5XIq+7x7kAmtpCAOxpyn
	5aAbGou478V9xHUWigfRSAobqEa1YqmURJLq27RD0kiKPbaVzZAjZRE8JhuAqg==
X-Google-Smtp-Source: AGHT+IGknCDJeS90RO8ehnRZ7gHMFeBw03OZmeGDsZgVqTGTubjzVOjL99+92Uvx9d7Hh1AaJIztzQ==
X-Received: by 2002:a05:6a00:4609:b0:6e7:3254:a4fd with SMTP id ko9-20020a056a00460900b006e73254a4fdmr946741pfb.8.1710902648109;
        Tue, 19 Mar 2024 19:44:08 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id m24-20020a63f618000000b005e43cb66a7asm9830852pgh.87.2024.03.19.19.44.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 19:44:07 -0700 (PDT)
Date: Tue, 19 Mar 2024 19:44:06 -0700
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] video: fbdev: au1200fb: replace deprecated strncpy with
 strscpy
Message-ID: <202403191944.B66E4853@keescook>
References: <20240318-strncpy-drivers-video-fbdev-au1200fb-c-v1-1-680802a9f10a@google.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240318-strncpy-drivers-video-fbdev-au1200fb-c-v1-1-680802a9f10a@google.com>

On Mon, Mar 18, 2024 at 11:46:33PM +0000, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> Let's use the new 2-argument strscpy() which guarantees NUL-termination
> on the destination buffer while also simplifying the syntax. Note that
> strscpy() will not NUL-pad the destination buffer like strncpy() does.
> 
> However, the NUL-padding behavior of strncpy() is not required since
> fbdev is already NUL-allocated from au1200fb_drv_probe() ->
> frameuffer_alloc(), rendering any additional NUL-padding redundant.
> |	p = kzalloc(fb_info_size + size, GFP_KERNEL);
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Yup, looks correct.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
