Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE1C2E2EE9
	for <linux-fbdev@vger.kernel.org>; Tue, 15 Jul 2025 13:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752585760; cv=none; b=HkCtToWGqHAf/oHLR6D8XG1mDQAKnr0On6kEePMreOsFZ3eegMpPfnz75S1yddWH8nhtNDWk3fbI2hAX17392nJeMxJS1vprcazWc5ksGuPfqsecw2TM/UJgQVYcdn6B9miCpmJ0MkYLw7w+GBY8+K4uGlhY+3q4hA+/QvFbxq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752585760; c=relaxed/simple;
	bh=sgr6rQd/h9Lyy5OV9jWvIBZZU1Mi6s8Qpv85V1jfhy0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i1M75GdKQl9/LfMBFL1PdmGzng17ByiGOKJiHU6q/Z5mgbOvvFt2683U4uqj2J+ylwyIsfENSXvClTSAM227Zlq637W1cfvxTdbQ8BDl0CoQ1ItS+O9yFaKTC9m6V+14iqoYVZjqa9BEyTswz+tx7l8N3kc8BeGn2bngRXdgVww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=IpXs4VZU; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="IpXs4VZU"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4550709f2c1so27159435e9.3
        for <linux-fbdev@vger.kernel.org>; Tue, 15 Jul 2025 06:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1752585757; x=1753190557; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=61QFwRWr9Ndvk2ttgipTe3LJv9XUBOlZkiPA5AUFmfs=;
        b=IpXs4VZU+zbHikWwd6mYGhpnsyqWB3vBsVxWPsbl7TRcsibZ1XgDhOR4Skp+wIk3Jn
         jzU+CXj9y6QmMVKlSHlR3uYxEq9AY2n49cAZ7m3reLS00uuw/dbe4oj67mNwEPZYfh8j
         5IhFPTupd/eRD8ChWgBnIu+3T8mGfr0WXBOFc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752585757; x=1753190557;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=61QFwRWr9Ndvk2ttgipTe3LJv9XUBOlZkiPA5AUFmfs=;
        b=BGqVTd38PV81AK9Svr0OGjyzfygvQm12Pc6WTxorqCDqlWcMWof0ulJgZ3h4ZmW4m0
         CYaETNFgo/rogAXoh6x1JjOBELhm21pXNW9te4c6kdIOxex3Zll9SCR8Nj17++WiUcHD
         QCk7AiZPAcbC/lomf9zjCmuh9u6vbej1SXGrZwH9paCpIIIBouVGp+5G2ywOpMKi9vzr
         LaakcWXUnAWdP09ayeIqWwqBIBFR8M57m47+x0arTOv/qI/IQBE32aDOPW46NNv8gwJc
         NChn8RdkST2zlIvRrzW2LoVNUjIF7jNM5NtPCiDIP8+ipBH86/Tp0E0QPfIvgTKfvhUY
         QLAg==
X-Forwarded-Encrypted: i=1; AJvYcCXHzyAo6cXMwJfqjAORjvCFm6PG87brk4vh3rg+XpZEmv+ADiLo+091Vx0tArFmYnitl6k4fiF2yieYAw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz3fKuoI5E5Xlbx0WFn+gI38/tOmVjmv7MhuIWhn/FLYkm6bVy
	bBUs2V1KYimMWzRvYz9wUObxUQkq+Yt9pg7B3medk/foMhqIofMPfDcPH3Q8bV2fFzs=
X-Gm-Gg: ASbGncviS4CCY6cBBQwVAmhhSTCYo1lMzTOAGPbTIIQbf9A/AnB9EfJftqLOySGF2Rz
	LkuBnhWXgpb2HbRV+7dWHpqPYzoq+wwp7gkiZniGb3DFoDzQ6TzfOv5qWK7O1LCSMznJzKkZrKF
	hR3hfbdVqqjCdePRyiUOHEqRlCfzHM3TAvT6GZaPK7g33D+fPfopDbMPAQIXAyFcbmKDd8dYwGn
	sfQj2Jby5OjVljmm5H64e7f1hw262pioQYCav6TONu9DHJuhDR4s+GpWWMqd08be/rv4iwa/gmT
	uFFmL2hltjucIi7iwf4Wq7DwnhHUX1sq/YmGxZu9HzT7DAH+LrAtdI8kpfwWDsxEvcGf6TYFJ0G
	I3JPAnHXzaCgNlbVYTAfCIYWS95NfujN8+A==
X-Google-Smtp-Source: AGHT+IGd8c2xyf0Uxkux0OC1AuHlKA+muy38gHZuCpdnRoCjje75nBhjsGOEghV+rD/6jvj+dlKRcA==
X-Received: by 2002:a05:600c:1911:b0:456:1121:3ad8 with SMTP id 5b1f17b1804b1-45611213e56mr119039315e9.10.1752585757203;
        Tue, 15 Jul 2025 06:22:37 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45624651a09sm31053395e9.12.2025.07.15.06.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 06:22:36 -0700 (PDT)
Date: Tue, 15 Jul 2025 15:22:34 +0200
From: Simona Vetter <simona.vetter@ffwll.ch>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: lee@kernel.org, danielt@kernel.org, jingoohan1@gmail.com,
	neil.armstrong@linaro.org, jessica.zhang@oss.qualcomm.com,
	deller@gmx.de, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, airlied@gmail.com, simona@ffwll.ch,
	fnkl.kernel@gmail.com, j@jannau.net, hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com, sven@kernel.org,
	alyssa@rosenzweig.io, neal@gompa.dev,
	support.opensource@diasemi.com, duje.mihanovic@skole.hr,
	dri-devel@lists.freedesktop.org, asahi@lists.linux.dev,
	platform-driver-x86@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v2 15/15] backlight: Do not include <linux/fb.h> in
 header file
Message-ID: <aHZWGnJ9D72YFgNh@phenom.ffwll.local>
References: <20250715122643.137027-1-tzimmermann@suse.de>
 <20250715122643.137027-16-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715122643.137027-16-tzimmermann@suse.de>
X-Operating-System: Linux phenom 6.12.30-amd64 

On Tue, Jul 15, 2025 at 02:24:52PM +0200, Thomas Zimmermann wrote:
> The backlight interfaces don't require anything from <linux/fb.h>, so
> don't include it.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

I like this very much.

Reviewed-by: Simona Vetter <simona.vetter@ffwll.ch>

I guess also my Acked-by for merging the entire pile through the backlight
subsystem, that's probably the easiest path to land this all.

Cheers, Sima

> ---
>  include/linux/backlight.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/include/linux/backlight.h b/include/linux/backlight.h
> index 10e626db7eee..f29a9ef1052e 100644
> --- a/include/linux/backlight.h
> +++ b/include/linux/backlight.h
> @@ -10,7 +10,6 @@
>  #define _LINUX_BACKLIGHT_H
>  
>  #include <linux/device.h>
> -#include <linux/fb.h>
>  #include <linux/mutex.h>
>  #include <linux/types.h>
>  
> -- 
> 2.50.0
> 

-- 
Simona Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
