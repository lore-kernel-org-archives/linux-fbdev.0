Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D45522A7F1
	for <linux-fbdev@vger.kernel.org>; Fri, 13 Feb 2026 05:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770960205; cv=none; b=FRZTfNiHVfHDffDh63bwhlPlvgAZZevCrSQYP48GR7gQg6osI0TE64bgrWLWfjr8NQ52IBUBC7WYuvpNXXeMxRbQ6z7kstIXfeGlFfL3VWtnbmkgP57MOjewHNzh0+CERwrfcbOj5cSpG46ga5CbTrHL7InUxn6G5amDugkHZNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770960205; c=relaxed/simple;
	bh=YznDlfWASpy1xpDN6uAIUlTCrHe6S60V25yURhSlVqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MiqXPUirkOMGW0iFG290f4lr/6OSDSlbi0WrHCF6CuILv94mJPjf42+i+hkkG/mVBM7XCL1FuiPUXSUEaqFOaMPcGElrjwLyflsxiXmEKmrobhcqprm5TagrYMeVk5Ijt8zjkR4Erw8kWn6JGLpbgAS+YU5K7fB5akshMn4KqIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ijsLAlnw; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ijsLAlnw"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-48372efa020so1359455e9.2
        for <linux-fbdev@vger.kernel.org>; Thu, 12 Feb 2026 21:23:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770960203; x=1771565003; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ovbPn1UM2C0c4dxdYOWcvaxL8edCYnFQjJ5+Lm/SiyQ=;
        b=ijsLAlnw/dBpRBM3BUKrQ+mKUvwrCouiXHVwAC6ixDxv49nDAMoOOzzBYsMShwv2m6
         OYaKeVMoiuwlgI+HKT1d0UXHqx6KkLgTNe4/nbwN1ws0UQw4xNrtBI38kMT3/br3Obi8
         oAuwxkYFhkmLqzY9BykYqDRlPC5Ufdxg48XRbmJ8q+2/fFNq1OEwlZCHE7/v+F5AGZS/
         sDt2ZjWdRzLVv6RrDVwqmrK6hKhpkJ57uo6z6Mg1RuxVTJt75L5eReisXp1YKAPCTtCD
         pPsoLnsZCOgptWlGbWcDKDsmTwUbNDTupJa+FEypBOI1/hdACBBYe1hKVkOyydjgqLwv
         ywxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770960203; x=1771565003;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ovbPn1UM2C0c4dxdYOWcvaxL8edCYnFQjJ5+Lm/SiyQ=;
        b=fyKTzPb6C+9rBzH1F5EI59ZoQ80SscnzamOW7G0YR1ode1aV7RjGGH9n8rd7Al2qF9
         /IgXeorKmXJJ8D4tHzWDs9ffDL01wXzdDp/RhyZvMtJ8pKek9+sH+ZXWelo3KTco/L5X
         dWwNFgUjD6mBvPaGdY3zraLjHrLmbuLc3P+GhQt4UxLl/CK6kq5zcADK5QEHyj+ANYfK
         DUxdAAZ1Tm+ed7Km4L4Ph2Mcdd4jeY8vFXoF/Cf8dAXPl4f6/5633pVzSMx0C8x66kNg
         iuhEXJ1gni7I2k8agngNw+XAamchU1TUlzVcrGqfCn2LnMx/L1SQx5WDyOYuNyvVqmWx
         lQVg==
X-Forwarded-Encrypted: i=1; AJvYcCW9s/AeeVJOj3eXYiY93qZuwj3zl1OvJHTazQtWo/3j87uXwrf77ceLpNV00v0geQR/89mguNzwRLCKjw==@vger.kernel.org
X-Gm-Message-State: AOJu0YymkiFADgQODO/A+ShcInnZR6ZV5Iv/DNomaOORSnC5Qexj5Fp8
	0qUn4lUFQiH+UVQeH52LdjjIzdMopwyTrOXjTEJSi0enfVcT3YMGeY7mDPJRf2UMxOI=
X-Gm-Gg: AZuq6aLF2qGcgjCspaIDbIM0ltI7upPD2jrFe5abfG0Z8j/i3rj0HN/G6cwNRvgW9Fg
	DWM7jwTGs1KR7+OTEp0XJ/npo063IgsCIg2bnQ8Pr7VobyJZqE+Jf71pyySTaM3+e9dLHTCYEuH
	RLmA8WyJhqQ6nfJbBYFY+gTCD1g2rfiGaf0PGFujP4ZQ6K7MtVMMolEDtto91g/Iw7WVNcT1+aW
	ZnrsU1xppJyGXPyGVsdJmbM7Nr8k7H+Y03TjpgEQ1CERwEP3CnExOf1P3n82NzLNJQHGqsIl041
	InFi1qYFazo9eaxZNHpUXylhJ5xlAShNYwD3mnpLG6RHH6yybzLfeYMrlxBh66QkASehKQ5UEIs
	tT+xiaq3+aOyz/EX7TkGVOrnRioWDHiq0oWYiVW+Pgej6UYSTC+vyGT9vkhoMZi1t/Z7lDzWTYq
	AUl5jp6/VPmmx9tox3ht5dyi7VINEx
X-Received: by 2002:a05:600c:3d87:b0:483:702d:2df with SMTP id 5b1f17b1804b1-48373a779c1mr4996895e9.32.1770960202851;
        Thu, 12 Feb 2026 21:23:22 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4835dcfb28dsm164575935e9.11.2026.02.12.21.23.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 21:23:22 -0800 (PST)
Date: Fri, 13 Feb 2026 08:23:19 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: RachelOvrani <rachel.ovrani@gmail.com>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] staging: sm750fb: Rename nDirection to new_direction
Message-ID: <aY61R4Tv_vlvgANf@stanley.mountain>
References: <20260212180402.69356-1-rachel.ovrani@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260212180402.69356-1-rachel.ovrani@gmail.com>

On Thu, Feb 12, 2026 at 08:04:02PM +0200, RachelOvrani wrote:
> Rename the variable 'nDirection' to 'new_direction'
> to fix the warning reported by checkpatch.pl
> 
> Signed-off-by: RachelOvrani <rachel.ovrani@gmail.com>
> ---
>  v3 -> v4 : Directly rename from nDirection to new_direction
>  v2 -> v3 : Change the commit message more appropriately
>  v1 -> v2 : Renaming n_direction to new_direction 

This still doesn't apply against linux-next...

regards,
dan carpenter


