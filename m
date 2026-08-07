Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257A847CA8C
	for <linux-fbdev@vger.kernel.org>; Fri,  7 Aug 2026 13:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786108771; cv=none; b=sBoNDEjGXScXhSSXvkqn9T7EpROh0h8UXfKvxZphlTH4rJGhg4dyABFOhW0tNEqe1SI3zSoGW0263KyUDiaVatjz8dl46cUkFo9PjUe4LMkiDGezthbBJaIjoI0CrOlPElNOW3gahrIOqvawTFcT5epDa69MO+rqM4KaE60vKv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786108771; c=relaxed/simple;
	bh=drKag+Yi6J9cG0jE45K4+DzvsO2DUqWU8Uv2K1Ncz3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HX90oOkikeZvky3rOC1GvK6SUXgfnLgriaot/UXvBBMlMg1II7PYxFhmZTMZ7imXnyHfwZ968sXjyRLwRZO3NDooHSSepcFs2r8ljChZCzruxHmPLuBkq+x7aR8WIzXqEKisYKMaa5KuU1SSvlGHe0Hy/San1mRjy9Gojgd7m9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tFnBihFG; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tFnBihFG"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-495590dde14so38614275e9.0
        for <linux-fbdev@vger.kernel.org>; Fri, 07 Aug 2026 06:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786108764; x=1786713564; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZXS7YhwOsOt78ycthpj7rPL7k4j0Yf/nXb07Mye1llo=;
        b=tFnBihFGgJYpE/avZCwWoklnIJsfBlYOhrRE+ML/oFadzBO1DChT42nv7k/aiTnGIu
         7ZCAc7AU9jHtqwMW+npDnji+lKYEOKPdp27v8iYFDKWC07mV7KHRa0IgVGrh2ycDKlDq
         Z1hRoFrW+yUX8JQr7YkOfGq868MY3nVTWM5Z+l+SM8xGut8Fr27Kesq96qIcawpXmGmc
         2Pwk2XxA5arnimQDbQr60uOzKndW3xLnM6vjEBPdPo/yq+8rhoB+XhmApC+djuQoQ9L2
         CjPg3xUekvwP/kepokU3IH8gXA+yWXiILVPhp4OgxksVyatBo4e1eL5tEp0GCPo3BS0J
         mvkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786108764; x=1786713564;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZXS7YhwOsOt78ycthpj7rPL7k4j0Yf/nXb07Mye1llo=;
        b=fnKmp/PtiylYLE4DavURhj+xrcM4lE9xfu6Ws+2qE22zzW6GmRHlW6vlphyAay45/7
         kLfEZOfoyelXs2bpXHEWSioDe/espZSmW9bxJ9ik6I6qZvvnnHvRKnAYVbjENhcPi5LR
         HUWwo1tQmMkkKNUXksGvEwoy4Twu+BTabMmQIrFxo/AV3CppvTDIZ6OZyK5HvjeaSorx
         K2NFrd37al4i0U0sN65ZlQWK7LU0CRPvBTMl54J/V7VvUI3YHLuCma9b+Llxz/1KFFgc
         K3eoj4uUqqPX7gLQGoGQxrYw4ZYySZX0dN2EAxzC7PxOZQgw8pmJngK8YatSMCqBkKU5
         fUOg==
X-Forwarded-Encrypted: i=1; AHgh+RpRCSVCCjYn1YOISqZ0sZWzOSukTyeuRGUP9B3zzryUi+gxsNE6piHXFWWhg2ZjKN+ZeO62Id8o6isn5Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo1U8w3aCwWLUYHfi/OBqE/w0god01VSvRQMEQzPafUCSdn8uZ
	8O+k/av7+bfmQW0bXBmtmLzz2NhW0+JLKHYgUAoFORfQiw/S+g2vaKi3
X-Gm-Gg: AR+sD12fHnV9L1LM3WwhGr5lh9E3OoyZ5GbtyIEtJtviWzbwHX/rgOYwugPvAS1Yua2
	3EVjM9U2sTltV2M1uu1C6Gauf0fkZuEtuA+0UNWYFdQL4OTMss5OIMzqXoTTU2KgbXrU7NciFHz
	uqJQsSv78AXqph0niiQcBIFv9qXRh1X9+aEAzz2p410W+ZvvPJ2V5w3eZdEqciSrb5HN2MfhRtR
	Dp/EuquYjmef3PUufms0Vq//6AhtycoiLdXB2ijQ3IwlBfdgJIaOTAZxOk2D4GiIXxz60WgSRjX
	CwliUGf7o2VSUcUbbDVwRLH3IDSshzi4tTJOeTIE3pwkpSwBvAty7e718L2AqryICxiZGMMciLf
	iBI8ex7S6MzkZOVIHBHGZlb/YfjBtdOTeq9WuVQOGNOY1eXExNj000ITarOEiMVI7whwttyh6oD
	f2HgstoRapEUGwUM6/e83nGSNbSvE5LVfsDBOrxX+xBG05OesjuSqJPn74
X-Received: by 2002:a05:600c:310f:b0:492:45a0:dcef with SMTP id 5b1f17b1804b1-4994e73cc33mr221333245e9.5.1786108763889;
        Fri, 07 Aug 2026 06:19:23 -0700 (PDT)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-480021506cbsm6283482f8f.14.2026.08.07.06.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 06:19:22 -0700 (PDT)
Date: Fri, 7 Aug 2026 16:19:19 +0300
From: Dan Carpenter <error27@gmail.com>
To: Alexandros Xanthakis <xanthakis.alexandre@gmail.com>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: sm750fb: make g_fbmode array pointers
 const;prevent accidental modification of entries.
Message-ID: <anXbV19U41zYXOBS@stanley.mountain>
References: <20260806004325.3253-1-xanthakis.alexandre@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260806004325.3253-1-xanthakis.alexandre@gmail.com>

On Thu, Aug 06, 2026 at 03:43:25AM +0300, Alexandros Xanthakis wrote:
> Signed-off-by: Alexandros Xanthakis <xanthakis.alexandre@gmail.com>
> ---
>  drivers/staging/sm750fb/sm750.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
> index 89c811e0806c..8f533f3b1b42 100644
> --- a/drivers/staging/sm750fb/sm750.c
> +++ b/drivers/staging/sm750fb/sm750.c
> @@ -21,7 +21,7 @@
>  static int g_hwcursor = 1;
>  static int g_noaccel __ro_after_init;
>  static int g_nomtrr __ro_after_init;
> -static const char *g_fbmode[] = {NULL, NULL};

You're working against a wrong tree because this can't compile.

regards,
dan carpenter

> +static const char * const g_fbmode[] = {NULL, NULL};
>  static const char *g_def_fbmode = "1024x768-32@60";
>  static char *g_settings;
>  static int g_dualview __ro_after_init;
> -- 
> 2.55.0
> 
