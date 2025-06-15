Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E8A2AE74;
	Sun, 15 Jun 2025 08:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749976209; cv=none; b=FKriEFZo0K0VO5z4ZfkUY+y/gqE785x6btlqZQoRijJlJP92LOcryQKVZcqDvrZv0r+iGuKtjBOiD6u+c/2/Bw7A5oGwniYLHSiehX/BNR4s2ljJDNyOgofgk6681IVOTH8WdN3aVv1xPVNfen6n7R/hrtBXR/EZ9aDeWY/RlE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749976209; c=relaxed/simple;
	bh=ENhrq/o1alYob1LMyOVxJtGIF2Y/J291I4h8cvjkwoM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L5oxL7fPrsdlmzL1ZYmcVdE/9f09B+ZBeym+QuKRMNpBvkt0OlbbDz+q3AScV3kFAP5pYEZ9ycOosP5zVN5gDvICPRTnCknysFso/pdbJHXhPtQwoFCJe/aPZnIO1VZVpeRPQwI90MK51L8OYFaBBHG6CIAm2ZHWnAY2mBXO4iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L2ep9IDP; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L2ep9IDP"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4530921461aso28738085e9.0;
        Sun, 15 Jun 2025 01:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749976205; x=1750581005; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KuGogJWPapQAin3rE54hpggnDxcNPZWyx9aIMxHutdg=;
        b=L2ep9IDPjB3LTZvPOcrvw1LVx1e1/ROUHOP2PoKeYad2h8jnW15aNiU2Yyau07zCYQ
         MckTRdVR2apJ/SekdTakc4BRkKGtQvHw7fpOUfPVjZ3/jWRkgLHoc0T+ebNIerO/p/Qa
         tRFMtfqrWZ38Y+vD9xN2rPseyVx/DeYDTVv9YCt6igorqEnEaY1IQMBMedS8XAlzU+3m
         1UaBUw/OnOEa2myfsTIens8I32vEOTs/fd4gy5dG9Eg4whqgLuOCjFiNCApWHmyPLpKQ
         Aq1gEA337jED3uLsWNgioaWarDlxf7O1P+lGcG6EAJueSmdNQSWzbB8kfvpfZ9T5Oytn
         QEww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749976205; x=1750581005;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KuGogJWPapQAin3rE54hpggnDxcNPZWyx9aIMxHutdg=;
        b=BGWsbd+hFsfaqrJXx4olsdlh9e1L7AALvscAIeJqr7iQ1Ee0lsto+txv8X1o3wTYUz
         jySKYMCT00xaPwYka4ZYg7tGp+xhlTLiSVe1l1qkVIhXy7EiYfMf/fQIzNvkgo2iYrfY
         oV0LosdTC7Xq03ZCxguhQlLDdP0CdWVz6bMMTOfnuUAkbX2GK7QUlKz9xEVVGI3Je8qX
         Bxa6qtTVTYZsvHSbABrUKJ3tr8Nr71kL9w2/eMPHPn03oQxK7D0fBC4Rx9UQda76I/15
         rNxvAMHUehUpNMdNDUxevttmzID8kWPOE4Ge2murFYSGme9Oo5mgzzrcl4ET2auJ5Zxp
         P3yQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNYTR7uTcWgt9B3m2TC57coW7j8VcvpTQQ736vbY0NmUwlTRfrHvVVqCz1BTZRRPZCm/yu3YurQ4w3RqwN@vger.kernel.org, AJvYcCXnkovBZwY7KAGFft7C662fAq2WW5stWUVOvWfIZ6Paf40Nz0YWwnUm9+PeqB4gLQFIvGhUQKLVBeDChw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxFEh8hDrAqgfNVZ7vDQMo+4Wg24sOexgAqL9f2jSJjgOa+6tQj
	Vam5EQy4V5j6xzXSDDYOtzVMzzKfEUWGM2z441e5aiuKOrfMVoK1dWpe
X-Gm-Gg: ASbGncuO71zjfK6OkTwImV0bG8LrpvqVV7Zq8EqO6CvbWR3EqF/VO0BIsXmdN82hlyY
	H0rv/G9qiqjlakR06VgM69B80AVaw2U8L7bC3T/Gz1vvhezsJSTwDB93DKLZa3b1djb6qwI/THn
	e4ODq6mLWSjqIG3rZ+wGLt3f6rTL7BIjfI27qrzi73VUAGQy5D38UAzXp+Euv3WCIY0kzsuBcVL
	vqBLH85lcPKXOHpI+78kGWVUs5+4xU7b7Vc2XO5SeRVUjtB/BALbaIUzMqk+xojzDXc4OaSllWB
	lI8or6QiUzQMBzOPQQUTV3uwgm/+Ve8TGahI+mfHHFGi5I9hyoNReIYWWHYWwg4g//qTwEhC3d6
	jh0Um/bSj5IVR79RDl5Zm5izRTyGbJpDj/Uo=
X-Google-Smtp-Source: AGHT+IF9OW8znz+iOjoEakb1HbIdI1Ooss/XHYANejVTvB7P2jZm+Zdxdus6R8/hV1XuZzKcerkp/w==
X-Received: by 2002:a05:600c:6989:b0:453:9b3:5b65 with SMTP id 5b1f17b1804b1-4533ca502ecmr51592035e9.8.1749976205278;
        Sun, 15 Jun 2025 01:30:05 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4534172d2b0sm32503735e9.35.2025.06.15.01.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Jun 2025 01:30:05 -0700 (PDT)
Date: Sun, 15 Jun 2025 09:30:03 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Alex Guo <alexguo1023@gmail.com>
Cc: deller@gmx.de, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fbdev: i740: Fix potential divide by zero
Message-ID: <20250615093003.6e524fa9@pumpkin>
In-Reply-To: <20250614051837.3544959-1-alexguo1023@gmail.com>
References: <20250614051837.3544959-1-alexguo1023@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 14 Jun 2025 01:18:37 -0400
Alex Guo <alexguo1023@gmail.com> wrote:

> Variable var->pixclock can be set by user. In case it equals to
> zero, divide by zero would occur in 4 switch branches in
> i740fb_decode_var.
> Similar crashes have happened in other fbdev drivers. We fix this
> by checking whether 'pixclock' is zero.

Doesn't it already hit the 'default' clause of the switch statement?

	David

> 
> Similar commit: commit 16844e58704 ("video: fbdev: tridentfb:
> Error out if 'pixclock' equals zero")
> 
> Signed-off-by: Alex Guo <alexguo1023@gmail.com>
> ---
>  drivers/video/fbdev/i740fb.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/video/fbdev/i740fb.c b/drivers/video/fbdev/i740fb.c
> index 9b74dae71472..861e9e397b4e 100644
> --- a/drivers/video/fbdev/i740fb.c
> +++ b/drivers/video/fbdev/i740fb.c
> @@ -419,6 +419,10 @@ static int i740fb_decode_var(const struct fb_var_screeninfo *var,
>  
>  
>  	bpp = var->bits_per_pixel;
> +	if (!var->pixclock){
> +		dev_err(info->device, "pixclock must not be zero\n");
> +		return -EINVAL;
> +	}
>  	switch (bpp) {
>  	case 1 ... 8:
>  		bpp = 8;

