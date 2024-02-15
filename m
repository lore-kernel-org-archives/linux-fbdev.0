Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C0C12BEA1
	for <linux-fbdev@vger.kernel.org>; Thu, 15 Feb 2024 12:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707998823; cv=none; b=NfUEOOvFP/ia3/25jc4gHbv/KDlF5BiuCq88aqOAvChVO8oCSf9CvZF3hu1gILr+QVxK31thcAmiitasXLMilMtgSVHbJw5jN6XtAphi1uMbRCz7+G7t/ClUqvK1jxxrkHextkj5DMIBNiUAXDQe/Bgit4MzmSV5HDSmlnlpp+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707998823; c=relaxed/simple;
	bh=6HsBMbgzYfxwG4TUH3pKnkkz/36cZRYAsjlWFRO45NM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ASvcUiQGdRjW2VBp0Hn2b9AkZxPoqR1ukCaQF/QzC0Z/mmqLzR33DYhdJtN/SeinGP/7xTtsmtYK0igkOPr/cgES0rotcuHSxOSZ9yDCFDt16btZX9ul+FCZi+JqWD5TIazJYPawh/kGzvwZIGFaROp15Cc1gJIJcJnFTIyVIY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sx1FDUZs; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sx1FDUZs"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-511acd26c2bso1047483e87.2
        for <linux-fbdev@vger.kernel.org>; Thu, 15 Feb 2024 04:07:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707998819; x=1708603619; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6HsBMbgzYfxwG4TUH3pKnkkz/36cZRYAsjlWFRO45NM=;
        b=sx1FDUZsIAYbIqa8fcta1xmjkAnPpCzNRLAif8KNIL9LpPbZCNglyD0nrdzXavxJJE
         UQxeZ7sdJLhmmOQ7ztbqdvcgUWB3w7i6Li3us+vxbMz9brfywL6skjBrJ0HqWVuBSike
         kAThfOZOlAJUnI66Act5tjcCLsDpkZk921ODv68Zjt5aO25lIu36yCV+iQqhoqOBrC5X
         ehM+0tbyMGawhRE+TB74vXRWb/BAl4XSfWsNysEPZUur774fc+3IvoFpK94p2GEhgQ82
         ng7tke+3xVmQb7GMTLjHoFCX08nl2zClOsBOeMO7OmkXUU4AFdGj93tI7fMwvzWOJIaZ
         CaOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707998819; x=1708603619;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6HsBMbgzYfxwG4TUH3pKnkkz/36cZRYAsjlWFRO45NM=;
        b=xMN8Oag6Kju4jadXHxeYgPMmaGF2VtKiZFk7Vxk5JkTMmKFaOWPyLuqJC7+FvpJIjm
         RCK636Zvza6FULLEGNCLal/oE1ZazB1ssscu8Ve1G5gIIYybIBNNByzklNbKXe35Bi7y
         Wk36LmT+lnhmG7Ct/ztdlSpOL1a1DEWD9cqqiLrs6bKWgxgI0duvLl7aFZZeQ7O4JIDR
         q8mQpAKAa09sUsqr/hCOWVxsXkerPZ1EmvPT2F9URpI4otjKOkqbcwmRqQQB5UPQ3P3u
         238doBX74C8mrOngrTVdTrrYS8hX5g0ddD8vngzKW4nHckSg0laQ5jeRQ44060eWPumK
         B8aA==
X-Forwarded-Encrypted: i=1; AJvYcCUO5t/GmP+bUlI3W9GFy8J+X3PTlbzE6c/y5Nh/08JE8XTmAiHVBkhiNofdkTLTbkcLryXxB2yVqTa7qhXr4uulqWQraF9J327L53k=
X-Gm-Message-State: AOJu0YycgwEd2mCFliCeeu9/z4pPxU/83XCD80WJXX4GWM7hY9RJ9Wfv
	leldZQqlx9E7TL579txZLKsbPregrQddHlk+gIojNikzigwtJo+4D5Uw+3/eGac=
X-Google-Smtp-Source: AGHT+IEvCAE2Hh2zJZuwx6DONXdXfWx3DTN1g6LukJQSKZzMSvJwK0E8L2N9izM+RVK89lmD04+0vg==
X-Received: by 2002:a05:6512:3130:b0:511:82b7:9fb7 with SMTP id p16-20020a056512313000b0051182b79fb7mr1408077lfd.13.1707998819594;
        Thu, 15 Feb 2024 04:06:59 -0800 (PST)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id t10-20020a05600c450a00b004122cfb5c5asm171291wmo.12.2024.02.15.04.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 04:06:59 -0800 (PST)
Date: Thu, 15 Feb 2024 12:06:57 +0000
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: lee@kernel.org, jingoohan1@gmail.com, deller@gmx.de, javierm@redhat.com,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-input@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH 05/10] backlight/aat2870-backlight: Remove struct
 backlight.check_fb
Message-ID: <20240215120657.GI9758@aspen.lan>
References: <20240212162645.5661-1-tzimmermann@suse.de>
 <20240212162645.5661-6-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240212162645.5661-6-tzimmermann@suse.de>

On Mon, Feb 12, 2024 at 05:16:38PM +0100, Thomas Zimmermann wrote:
> The driver's implementation of check_fb always returns true, which
> is the default if no implementation has been set. So remove the code
> from the driver.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
