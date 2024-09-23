Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F0D82C60
	for <linux-fbdev@vger.kernel.org>; Mon, 23 Sep 2024 12:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727094874; cv=none; b=FaeeJV9B5g7h3BXj9SXJo1IyhCmpXfW1PEXHVj0htr+cUWTLlczSfhmk7/IhZUkfDbMTjvMPk+S5IoNbg6fQKBv6mLALfn/etIC1fO4fptgu7hdmD5o+GgJYDhEopqRFuJ4oxVnxkIMkB5xzhlfqlV0ESbARRDNIOt0oX11sQn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727094874; c=relaxed/simple;
	bh=2XIX5mz0RBmDA5euJxp8y+Wts9scQnp2U7ggIINJNfM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pBsvM5Fl5apipdncKWkR3JWmPxqw3bJ6b6oU0sSm3CqVmgWHC6X8uN5mqTkCi2J7r5JrQQvonZ+iLBt0uO4lYcXRYfw8kD37tPWucZv927r0SxbD8Sd4YlHuof5wwsX/6CEyHEtB8m/FR4CCrqFq428e/qz/S+5wlypzF67YalA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Qrbxk6xI; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qrbxk6xI"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5365a9574b6so5853748e87.1
        for <linux-fbdev@vger.kernel.org>; Mon, 23 Sep 2024 05:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727094871; x=1727699671; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=N49f57cTB1HFzUzgYfoooYdBFUEP0IAy2wA8kB5amCA=;
        b=Qrbxk6xIlmuXiAb5NeGL8tx3dGug+9UrmYImmGkd3HDu8wWZeyYncJksHxxP5wLUBx
         gT14Rg6vw/ytfkIhuyGtDTD08mheaf42txP++D5Htqt7MrXjARI28xsjEIsvy99faZJ0
         gBRevDSoCLaKUbJrVW7xeBBzPkykyAmBkiK+VLEkgwdXMg2yKgjDYPrXUQcCuUrDyvvl
         6S19c1oXqAq/yxsSPFub/i6XpET4RyZp3oFsowOkHU8CYtE3b1CV3Dlok5FmvIcaGDmT
         g3FaqlFUcUqX2v+/qjeSts4Ch/fZnOu5xzxE8J6HwGa7FuuIFEiwtpqW61+Ey08MADqq
         V9Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727094871; x=1727699671;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N49f57cTB1HFzUzgYfoooYdBFUEP0IAy2wA8kB5amCA=;
        b=VNQGOm849M/AIZzNzqXThlp1ikYTpusf6lVSJP2BpSTIXdvryNNUIrU4z9aZyiFIyF
         krCfL75LaVTiiDc1N6kBMJbunTbv65W5Td3QxCDA0AJoiXfo2AlHArPhFixNar4sMe3a
         UN6nfk2c7Cg0/hYgRw5YQgTaVRPw/EkanlJ6Ey2QMbnLNhY3/xW88D7ABLHRfb6ufuID
         0ngbwVnkcGLNDQEB5rmzX09S4GN2Qbw8rwe/n8XDZ/XU70pq8vufMAiF9eHKsMfLVMvg
         mm3FPoIejI3UxyPJrr0vS7fo9GuP+hPAj46csMV5fJo0VDNnMo9XylqglgUlixmIAJn4
         yO6w==
X-Forwarded-Encrypted: i=1; AJvYcCWsFQPV6CNSwP5D5kLeqzvbVArUYppnX+ELJh+UO0C6HmCjou1uTLb9w7YzoWFHAxkD1PEy0CFoW/3vIg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwB0QOGdjt2WI/MWW3dIDazAVlK9/Lpg4tIeQJyWk9rWbZI+woN
	DmBm2ONsy8Prs/sqgRCl6Brqoz+2OpYFCDK2KdnptRRl1fM7Ciu5VqWSerlQOt0=
X-Google-Smtp-Source: AGHT+IF/DFl2Yi5RkcdlR+iT6PwIVo32HuubtE9mc1DgRuA6fscZHZXvy947e5s+d+LPPRSSLjp9eQ==
X-Received: by 2002:a05:6512:3048:b0:533:4785:82ab with SMTP id 2adb3069b0e04-536ac2d6a6bmr6515979e87.1.1727094871107;
        Mon, 23 Sep 2024 05:34:31 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53687096914sm3251007e87.170.2024.09.23.05.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 05:34:29 -0700 (PDT)
Date: Mon, 23 Sep 2024 15:34:27 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Chen Ni <nichen@iscas.ac.cn>
Cc: deller@gmx.de, linux-fbdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fbdev: pxa3xx-gcu: Convert comma to semicolon
Message-ID: <rsegcr3fhm5hfb5vbe7zlmvmffwmctoxv77kohoonswpqlo45v@qkg4rfeforyc>
References: <20240902075724.3824567-1-nichen@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240902075724.3824567-1-nichen@iscas.ac.cn>

On Mon, Sep 02, 2024 at 03:57:24PM GMT, Chen Ni wrote:
> Replace a comma between expression statements by a semicolon.
> 
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
> ---
>  drivers/video/fbdev/pxa3xx-gcu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry
