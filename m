Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8D92E2EEE
	for <linux-fbdev@vger.kernel.org>; Tue, 15 Jul 2025 13:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752585604; cv=none; b=AqRHyUpRheyP0AUFgA1XRE3glmaRDNTdH58nQBzbFH+C0h9B7elv69HZjxYny7k+8EIJpdTVSughCNpmx1ymcLPRRz1/G6a+8dvVfyttlutSHEAnnmEMMep3yKQLk/1vXqXsj/VpBksaOVYL2gQazb/QAHPBw85/d3adV0rmPUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752585604; c=relaxed/simple;
	bh=pw+cz07JtKjeBD7xSPONuGdwWJN1P3DPpVEUdiOZg4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dXsPZSYbt8DfrOCm9alNZnvXcxG7YiosbCOYNSw0DtPRfvrpeeM7uUUb3vUibEfHZiuwjr5PY8k4pG/iEItpVH3fxomWGI6AV8yt0jM8EoFmeZv81UDmb6pNGm/kTIYqccxNk8QEmZ5I7HC5SSe/P3UdlpkBWc/9Lk+Kz+FGzQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=SclGuTe/; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="SclGuTe/"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3a6f2c6715fso4285882f8f.1
        for <linux-fbdev@vger.kernel.org>; Tue, 15 Jul 2025 06:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1752585600; x=1753190400; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RZNdJdvnKf8QKxgnS87V8b+rsQrk+0DHovoGkwxahd4=;
        b=SclGuTe/FGfzERAKMU4ESMwyMAWD89N3JV+Ggbi7nNZFhAAVJGFUFDNGO0uEc7AAoS
         l7H0NRzPXl7IQhcp2jvQiUzpF6OT3PoO1CoeREdf20KTmuJbV1vOrvGYFGKLQkOLg5Z1
         EnCedlfM6KywSI1VNh1kYubC9vUcnP3Je7tsk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752585600; x=1753190400;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RZNdJdvnKf8QKxgnS87V8b+rsQrk+0DHovoGkwxahd4=;
        b=kdwhsfm1wOQrUlDAO3MyoQ7Mn7vDTX/9ml+XxRw64L5Bc5SA8HvoecIJBhwUz5Tq7i
         ZzYQf9AcwdsTVqPSz4NW4Oe4iF7hiyibWAN7RmTe3sWNQjzE9rcDHtjjQn9orXWcc93v
         MrZ2F1lMDMjzchVpfeuSz5eNt4NhtlX3kbBefvan7QDlz8GJvqiZk3eHgPdy7OTbdSIS
         Tql54j++fmKXo7vtMHmCgOChUmjW6piyyELQMngSh87SYJOoaRpoCDQ7et2ZFG1M7BmI
         kC2O4cDJEuHEOgiwuamy/EkTDqsxiaEGxSZYjyomgpB2d0k/1K2XTG8o6khMVk3pBa/A
         0LKg==
X-Forwarded-Encrypted: i=1; AJvYcCVEG2Hyl7mLO2eUeLcFQDX7p13PUE1IISxkHIlwQkF3ipAXFlPU+gtgWPiE6CHSxu1FW2eWe0a2ymkWxQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq46i32P8g9Mu5RuYSR1ApNxN1PZ9LDiQeLJ6u/nhxv3xcAiOG
	FLAMynS1NsqYStbS6c8YfWMYabNu2dBcKjClQmrnoUvK0eyP5EyPBQS1TfRz/tX3mNg=
X-Gm-Gg: ASbGncuFMNgjq7HwAG4rYuYOA3322pzvbUVMx6e0aZ5H9fmKKhSN9yGaRVy6ZQW+sRv
	HjktMYFR0udBRNx+/ldSZOkfM5Md/2PzTnlvShZW8LJqU6sSijdv/f2ksPneF7CHXc0Z2tVJlaP
	suepm3PzAop38DwJe0fkXyeEFarY25pVsHz9rBjIXUZCGMWdHYfQjUjso4JWp7dpvkOa17xZwC5
	RiXUwjZ/a5U+wSkx+NnaBNUarKFwF1eYtrpG5GsXWLRnYOsVsJVmbqYLuJ99hgiUc76ws7gvlMc
	Kn/nBCieyzXQiH3I39naO5KCmCNR8iCwGkSdXTbzXay4RdE7cXtXU28bPhpml0sj+81KuZtCuim
	IZjd8nmJQm99XP/21yKmBfigWvjRgQebf5A==
X-Google-Smtp-Source: AGHT+IGgOrGKdM3z4rYXREjB5K13TQWQc9hzSbnGlRYyUFMTZTPMvyOf/txGJ4PS42ny0/qCStlXJg==
X-Received: by 2002:a05:6000:290a:b0:3a4:f038:af74 with SMTP id ffacd0b85a97d-3b5f2e3ad53mr14816635f8f.51.1752585599669;
        Tue, 15 Jul 2025 06:19:59 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e0d70csm15389832f8f.62.2025.07.15.06.19.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 06:19:58 -0700 (PDT)
Date: Tue, 15 Jul 2025 15:19:56 +0200
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
Subject: Re: [PATCH v2 02/15] drm/panel: panel-samsung-s6e63m0: Include
 <linux/of.h>
Message-ID: <aHZVfD9Koa-fi5CQ@phenom.ffwll.local>
References: <20250715122643.137027-1-tzimmermann@suse.de>
 <20250715122643.137027-3-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715122643.137027-3-tzimmermann@suse.de>
X-Operating-System: Linux phenom 6.12.30-amd64 

On Tue, Jul 15, 2025 at 02:24:39PM +0200, Thomas Zimmermann wrote:
> Include <linux/of.h> to declare device_property_read_u32(). Avoids
> dependency on backlight header to include it.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Reviewed-by: Simona Vetter <simona.vetter@ffwll.ch>

> ---
>  drivers/gpu/drm/panel/panel-samsung-s6e63m0.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/panel/panel-samsung-s6e63m0.c b/drivers/gpu/drm/panel/panel-samsung-s6e63m0.c
> index ea241c89593b..930948cb615f 100644
> --- a/drivers/gpu/drm/panel/panel-samsung-s6e63m0.c
> +++ b/drivers/gpu/drm/panel/panel-samsung-s6e63m0.c
> @@ -16,6 +16,7 @@
>  #include <linux/export.h>
>  #include <linux/gpio/consumer.h>
>  #include <linux/module.h>
> +#include <linux/of.h>
>  #include <linux/property.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/media-bus-format.h>
> -- 
> 2.50.0
> 

-- 
Simona Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
