Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05EFC3B290
	for <linux-fbdev@vger.kernel.org>; Fri, 29 Mar 2024 04:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711685094; cv=none; b=gw1uTtzZ2Mo3Zf2Esk0vQBeaYRLVmesD+lP1WxReg9LZsCExVL+ROi6APo67QlVSofdjT3FJkZ+jgiOuZCkTK+JZC+h2UpT+dRKcnU7FYc7rp7etpTgJfM0AsIQ85WL1LDR30JV6c6vhmOxfYOqi8NFVYx0Sl+FdBPwXzGljQSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711685094; c=relaxed/simple;
	bh=fx75aDeb//DCFTHJW3dMQvi5gnKmJfUkKWLKThTPR94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VO+CP62wKq5twjwNDNQ/e1OJHP3X4sHkNcRSD2YgVoniIYGhAGsxdcd1HvqKZ1TDi42jhKjdMANshGROBu8OeHP6lZT72/PKOSoco+To68SnE1gjGM12PX6fjcBc20pFFfHNI2MnGZAGZXWwAuIOUer2p0LmGALo8jQ5iyETNyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ARKkytZx; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ARKkytZx"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-222b6a05bb1so1051164fac.3
        for <linux-fbdev@vger.kernel.org>; Thu, 28 Mar 2024 21:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711685091; x=1712289891; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=69VUW1JBrC64hXBRbspWF21+J8tNtsC9yt2uIqIg1HQ=;
        b=ARKkytZx7biCoF4FdX911rnJCexBt0iG+IlY+ojHC5xM8lHiSpUIq2CG8gJaeSlMWT
         nsPMe9VyQDwpIYZliclOQHQOr8os5bQJU+hkKiu5pDe0HCp7R83QzE1+NtEO/eFNqPUG
         JPNX8VuAh1HeKMTvaQyumwnHeGervw7jYlD3Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711685091; x=1712289891;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=69VUW1JBrC64hXBRbspWF21+J8tNtsC9yt2uIqIg1HQ=;
        b=l4EdelYGE4FGUbLnufu+84M3SvAV8tJrTs4xiF0VA4HSzmiRxFZxLf+n3s7pWFS14c
         HHwo/6vaHhNRyav8ZfGR3xpEQ/vOqQCYLogTn08CbXSurjbS/m8ULk72ctD3Mwi23D1g
         F6hwQwWA8FhNBuawoaoTpGEsM6cOVqv4dL9BJQhwKbHQZLF+r02a1RxHSjuwwlSv7ySK
         k81II/iAXwh77qeU+LixzTvjMvSthxQO0PjuM8Ofn4MhDPsQmYlru9eXPadSRw9GN4UV
         h6a2XQZr9amLaak+8nKkValiG9dlBsMGG43cyLoaRHh/Hrrt/EX/XHx2c7E/l86BxTQz
         QYEg==
X-Forwarded-Encrypted: i=1; AJvYcCWhr6ELK37SLNCTqAcHdi49x8rBGqZsGNW3ZGLHrWp02U4uBR91h9e/WaWJSoSoTWXmbl+ZIhY+SvMPWpdORb4z393ii/O73zpo9jg=
X-Gm-Message-State: AOJu0YzwmJ/XXQozIkSrsYNTZffbdk8Lxg+0+Mc5wkQ0r0yHih235vvb
	guGKBLNC5yXV5TfP69Wcy1suKLeu2Q+ZWDxwwoHDQUD/IBcsigBUkN6jPd6j4Q==
X-Google-Smtp-Source: AGHT+IFvNh8aPME+bk9MigIg8cgiL4SPF+c4/TssLm62fUGeJU6j/Ecq0WtTIJm48S6HEzmuuKfGsA==
X-Received: by 2002:a05:6870:c34f:b0:229:c1d4:83bf with SMTP id e15-20020a056870c34f00b00229c1d483bfmr1130237oak.8.1711685091224;
        Thu, 28 Mar 2024 21:04:51 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id q14-20020aa7982e000000b006e73508485bsm2159777pfl.100.2024.03.28.21.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 21:04:50 -0700 (PDT)
Date: Thu, 28 Mar 2024 21:04:50 -0700
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] video/hdmi: prefer length specifier in format over
 string copying
Message-ID: <202403282104.CC17451@keescook>
References: <20240320-strncpy-drivers-video-hdmi-c-v1-1-f9a08168cdaf@google.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240320-strncpy-drivers-video-hdmi-c-v1-1-f9a08168cdaf@google.com>

On Wed, Mar 20, 2024 at 11:22:02PM +0000, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> It looks like the main use of strncpy() here is to limit the amount of
> bytes printed from hdmi_log() by using a tmp buffer and limiting the
> number of bytes copied. Really, we should use the %.<len>s format
> qualifier to achieve this.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
