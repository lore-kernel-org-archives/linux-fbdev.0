Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0AF657CD
	for <linux-fbdev@vger.kernel.org>; Tue, 19 Mar 2024 15:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710861919; cv=none; b=P7iRcmNgGPzPJ3xcWyLBKwLZgDYo1vCOt5yPmtikMT4TA8phM/xXrz84OxmQEFmlFaeXerczrM2H5yC3a/+C+hHYwYsKVjvPY2BOOnduh/V7q/qs8zF2ekBhMjFziuTiJ5a+Hh8J8lFOVb/m7Vi/Hb9MKCqYJgH+xDgvnImJB4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710861919; c=relaxed/simple;
	bh=j/tOewZO+xITdwu8fyyevSlxd4rQDWIvMngL14Mt4g4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NJO7nkD2cKX4r4QjQq8OzWZqW1aFN+VRoo5IeHw++uOzGbUF88ezQ/ft19Vqkipg3WRDDo7+3WMrraJR0v8XBI0IzT+DtFtJMb9L26JBkRn4vlbIt1XFHlkaIvyngm87qWlXW8lJ/FTd4mXcXK+yygCcaXREbbE6HLFaCuF+Tio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VNu1wgl9; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VNu1wgl9"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-41412411622so15568135e9.2
        for <linux-fbdev@vger.kernel.org>; Tue, 19 Mar 2024 08:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710861916; x=1711466716; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j/tOewZO+xITdwu8fyyevSlxd4rQDWIvMngL14Mt4g4=;
        b=VNu1wgl9qj/XsgoFDbrMlSkjbmTDYIAYPPlXHfA5jBHDWx0419XlsUgMwVyY4V3eV8
         Kl+1TVO60EW9jLsNTgtsyRxH9CPdgyKW/HcoVeQJkN+x1F9nNwy0c5NYQeAIxU54kLCd
         7UrYCQUgLqMTvbwC2O82ksa1ge9HhRv7oL2miBFmQhoKFDm8A3huqUfpRhmHC9ut+u6O
         awyijI6eWclWiWtvGdSvaNoTtoh3zAx8zACweLnCbsaFIUC5qIxTOaYEmqWykqPTT8on
         ogTb5n1H9q+GrAo86yxNrE0D+NS/vtB9UZo20eZURicriyTI57ZiWbnkqshQAXc+RpiA
         Gpdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710861916; x=1711466716;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j/tOewZO+xITdwu8fyyevSlxd4rQDWIvMngL14Mt4g4=;
        b=CVn9+FKc6JxqHmGTMJ+0HMAPiaLwwZDobgjkXWX+OxZGeoJ5Bn75L5wiuKfVaQm9IK
         bZJvQS7Cts6mH587jSFl8BThqyCo9LIOnzF18bFJPY3JbnAAdgZtZ21/rdBq99Zzp7QC
         iGGFem7XVDBkho3LF5uOS/QSt7Bcy+q+4NK88NcNN7HZQWVIPmSS853EteHoqXuIQ3+t
         FShHksd4PGk9jEtYyZasOjPQke40EK3QfiwtvLH5GJ6gvsNZIxxUIdqQ4NgZz0YEBApZ
         zBGAJOpp5qATB4V18YrBbkUFpdr9XzIedxFJF6FSv/3PyFEDI1FnxqaSDckNQGKD8ao2
         Do8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXBOdfJfN+pdoI7Xd7GwW4mivcY4oVWGf5KPjMVTgvDkVtvrF+M4QKbX5CD2ozP14RFxQ8uKV/yQvnmfRWLDFJhKIsCdmGlIHb77Go=
X-Gm-Message-State: AOJu0YyWbGjGOyGuu8DrNjhk547KCTMx7yuhS6b/lw6jiKoPKMkx/2yB
	w7fikSxlaUxre1ekjcetLMnCoRvVFWDSTx1+fgnHVCAWmT93KfCpFU8Hq5inWiiWE6agX8I52sN
	87RQ=
X-Google-Smtp-Source: AGHT+IGuxUp4tJ3tduUZ1jDdJJOXB/6Dyq+c61cZG82qzzk9ozWfJDBWCF1r7b5Ii/MqZJEtyixx8Q==
X-Received: by 2002:a05:600c:4689:b0:413:f4b5:dcec with SMTP id p9-20020a05600c468900b00413f4b5dcecmr10850776wmo.40.1710861916490;
        Tue, 19 Mar 2024 08:25:16 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id k4-20020adfe3c4000000b0033e48db23bdsm12595322wrm.100.2024.03.19.08.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 08:25:15 -0700 (PDT)
Date: Tue, 19 Mar 2024 15:25:13 +0000
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: lee@kernel.org, jingoohan1@gmail.com, deller@gmx.de, andy@kernel.org,
	geert@linux-m68k.org, dan.carpenter@linaro.org, sam@ravnborg.org,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev
Subject: Re: [PATCH v2 3/6] backlight: omap1: Replace FB_BLANK_ states with
 simple on/off
Message-ID: <20240319152513.GA9963@aspen.lan>
References: <20240319093915.31778-1-tzimmermann@suse.de>
 <20240319093915.31778-4-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240319093915.31778-4-tzimmermann@suse.de>

On Tue, Mar 19, 2024 at 10:37:22AM +0100, Thomas Zimmermann wrote:
> The backlight is on for fb_blank eq FB_BLANK_UNBLANK, or off for
> any other value in fb_blank. But the field fb_blank in struct
> backlight_properties is deprecated and should not be used any
> longer.
>
> Replace the test for fb_blank in omap's backlight code with a
> simple boolean parameter and push the test into the update_status
> helper. Instead of reading fb_blank directly, decode the backlight
> device's status with backlight_is_blank().
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
