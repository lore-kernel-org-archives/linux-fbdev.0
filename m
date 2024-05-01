Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9988D12EBD4
	for <linux-fbdev@vger.kernel.org>; Wed,  1 May 2024 14:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714572110; cv=none; b=SIy6Ch+n1EUYCINiXYaPYEg3976EEtD7DdywZfhYtw7rwVlbhjdnsbJ3vU8+66xSJ/WQWYgN3UwHlWq62c256aLSvKE0X9vN+L4YFrcA19wmYoo82kOhkprJCkV6poT5+/DY0M2xy0CYEBMON2/u1vBTLoTE0txg89FDTtgmPAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714572110; c=relaxed/simple;
	bh=MRQauao233bl7PaCKp2AAgdkPImfXRP53eHl06LQeag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e47Wg1169z+ZCde43S3X5SCIykiYU/uQQJ2QGnwCT9TweWgEvhI+p0U8CIaeGlLfRnrjPCC39nE4oYnvUC8kti5GN74qjAnr/Uv6M+/La6asNKVAJ+NN0gb5I4XHxzm3pNmaQfIgWltMRjW+Kgc0ttR0lcVY675fFOLCwuIJqDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ovMJmXlz; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ovMJmXlz"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-349545c3eb8so4437413f8f.2
        for <linux-fbdev@vger.kernel.org>; Wed, 01 May 2024 07:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714572107; x=1715176907; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MRQauao233bl7PaCKp2AAgdkPImfXRP53eHl06LQeag=;
        b=ovMJmXlzrne8niuccMib5zu0vOZhemNly9cMl1Gcl1cLaiAAo7cTJoByh1MPYJdlGt
         aFoEWNAonoUS0qHDx/p/fgUQMFZf3KSPAQlYNQc0pZV5c91a+2D04agZs+mtScWKT0R8
         wnW9mfDzr/+Ejnz91KQs8zOnxo3vB17WhjiC3WuY8Kj/7mQZ9BKCFT7IFDeDfNuYbM3o
         /KeaY5TMJUivwVQ7L5vZW7x09S8ZX+E652aoJUF/F07YAP9wxw3Fr50a+zteaAq9K/k9
         HRyVTuoE8uSAqfIjYKTM4YZ9ftpEwftqGTWEqui2kTIBjYg6iuR75IiI3J2DLXGaudn1
         dfmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714572107; x=1715176907;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MRQauao233bl7PaCKp2AAgdkPImfXRP53eHl06LQeag=;
        b=NYyD1JF1IJEYD7MC8Xs6K2m2sivjJdXwALS4tr3fW+8SjoYrrf1eoINDVBCrCZAg/8
         94xkkJgXIpfnlDV3LnMCQWYJIummejtcXK/EkSTJiie2APijvbu55+/xlgXZDZETTr16
         8Tj6Mwwd9YI+EABa6GtU6RHV97Wx76wvSTu+HjGu0rYQKAE1MKq/zuCuQo2tp9TzqGoG
         JJvftz7ap7hsR2bhHK5nxJQYo+7oyJQ21wBsFSQxlO1f+0M/OBvcfaGhN063M93Wztxr
         Cq1BaBsgjFLVqet6yLH42PVaRoGwKUI5XdIJpgTc7W0XCB9etMInEgKjPI8KbKQ2RanO
         xMig==
X-Forwarded-Encrypted: i=1; AJvYcCVt4H/HkzckggkGg9bEJhgkrDtgr/AK68W5w8JJs+ESj3nJjLyIzrq6IcneKNTUhh+hgtv7TPAUuIphavk0gJdRufDa8rN1dBZ1Do0=
X-Gm-Message-State: AOJu0YwwOQYi8gziHwMVyeQcbucVxWCcI8B5xcBkro1tALw3Y1v8uiI5
	D8EFQHndqHe7UKosh6I8IKRsNYhk+vHiGAnbNuL+DypAyD4BxOLKZr2FRhR9uTo=
X-Google-Smtp-Source: AGHT+IF6AVQRyF6Dk1uSruwo7/L5zDwxkFGB+A6XFcz0Xm5YcaxaSXEkcGktSgGbTNPnxqHZOX+zUw==
X-Received: by 2002:a5d:4a05:0:b0:34c:a488:e6d0 with SMTP id m5-20020a5d4a05000000b0034ca488e6d0mr1782698wrq.36.1714572106928;
        Wed, 01 May 2024 07:01:46 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id n12-20020a5d4c4c000000b0034de40673easm1117019wrt.74.2024.05.01.07.01.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 07:01:46 -0700 (PDT)
Date: Wed, 1 May 2024 15:01:44 +0100
From: Daniel Thompson <daniel.thompson@linaro.org>
To: R Sundar <prosunofficial@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
	Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org, javier.carrasco.cruz@gmail.com,
	Julia Lawall <julia.lawall@inria.fr>,
	Shresth Prasad <shresthprasad7@gmail.com>
Subject: Re: [PATCH] backlight: sky81452-backlight: replace of_node_put with
 __free
Message-ID: <20240501140144.GA10180@aspen.lan>
References: <20240501125146.33648-1-prosunofficial@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240501125146.33648-1-prosunofficial@gmail.com>

On Wed, May 01, 2024 at 06:21:46PM +0530, R Sundar wrote:
> Use the new cleanup magic to replace of_node_put() with
> __free(device_node) marking to auto release when they get out of scope.
>
> Suggested-by: Julia Lawall <julia.lawall@inria.fr>
> Signed-off-by: R Sundar <prosunofficial@gmail.com>

Thanks for the patch but I think this one is a more appropriate
solution to this issue:
https://lore.kernel.org/all/20240421104916.312588-2-shresthprasad7@gmail.com/


Daniel.
