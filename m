Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A794429898B
	for <linux-fbdev@vger.kernel.org>; Fri, 27 Jun 2025 17:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751045723; cv=none; b=bZZcCdJRVv3z+j4dDnOaNFRYSlHGk9WLACKLMK9fLhxhuDXNMerr/BldGP0x9s/H9a3XVMDtho/tYrqFOkWdq6eo2iWurYhORAR92a+Zgu2Mz+j/JmEQSB98nSJ2miVK3b43S6pGrH5rMbZpA5I5md4LIUCEzo0/q7WeD4i5Ku4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751045723; c=relaxed/simple;
	bh=OOACCwPSww+nakVoXLJXnwuALHZbONvPwuZkfSXf220=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SddYRyIea68T7QeSmp7EzqdzUrLR//zOpHaz62hwUssgMGFnTHSmQmQ3Ai+Wr980nMDYFGu+QIgcpqVSo8o/ta2K5HsgVmUDiAp/uZTQ73bNwWyVQCEe5GxMwmldb74pMFgP8PkcII3OQUE98ovqnsksTIs+z+30zKTu0mizXAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=p3uPGaRI; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p3uPGaRI"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-40af40aef06so1669154b6e.3
        for <linux-fbdev@vger.kernel.org>; Fri, 27 Jun 2025 10:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751045720; x=1751650520; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9kg2kWtBf4IBcW3c+iSCFB6Ml1Oao6RTyx5C3qf0IPM=;
        b=p3uPGaRIMXYhrRIv88zO6ViYQXKC6e52PuEQSBp+fH+F4pH8Bu9MNnpWu49w9Uz0sa
         0FenFSZ2hvuAp1znoPzEFAW+1jv4YuFVnegDb6MuImVwVmn1xev9U/sMbfOXyuKnwEJI
         /de7iQY+dg1CyRRQ9h70O3sptJUBJiP2LxQezcIVVNKM1DokGhdPGISpBga/eXtH/3yo
         ayBCT5MOBnS1mQb9twI/7+qUv7k9NXV+cRxg1jyNRbmD6iOxL2Z/9oYftP0RoT7rVfrY
         etCnh9dVPVQjAhLj3G3AjHIq4ON5C3SuW57h4Re2LE8HTOZ82STPNmd88KDCxxj/g7TE
         Jsgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751045720; x=1751650520;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9kg2kWtBf4IBcW3c+iSCFB6Ml1Oao6RTyx5C3qf0IPM=;
        b=OPGJsgfK4e9CLa8xRf5tzl/xdFM64A3sFK+qJoBKS3exa2dkPu/gklMO2IHecr9t4O
         Xk9XP3icUs9St3ki8TZmvBM28Zc7PFNGd9jWLkr2s2aoIa6U9aMWLFVJVeNsi11s7iy9
         4KbDd7kppi4iN41tR48mxdV0grN8bkz+vympoR+TbF7jclGNjb7ePaq5aMMmRF0Cs3aE
         KixgMsNe7mIKfJvWSHw8TrtATGK3a4Shp3NW3hewM9sQjPTyArHclB0sRxwSTNWKa8OX
         3wxjM0E/8YpxjvlHYlI6OIdiutuHYu1IFvHjXwE7MK1vFM3d72ImG4MhPlGJbFCqHa+w
         nOsg==
X-Forwarded-Encrypted: i=1; AJvYcCUwX+ndAa872/fl7J5u2UDeYbMc31Z72Q3Rm4ND7gXHJ/y4M9xB3qRky6F1GFxrQVM3KKlCPaB8h8Xg9g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwsXhUbbhLJOxuI/QjyUGgkp5JaovIUN6ox03i2/EH37zAx0axu
	N8j0QPZlO68DVa+vc5txjqXGBR0xKOctKNRubDg0CVf8PNVhevv57P/7p0ZhUetFwyg=
X-Gm-Gg: ASbGnctrV38QjFGZhrOPj3OgsXgaaYHuETV3kr58Q9POW0PhY93NyaBo/ayWEfmKx1j
	UtHD74Gd1pMUKBPLZnY3N7cQpd9Y1jL6mNM76WUpimxSz4Vnqg1+Mcytraod900oMPP3H9Zbtb+
	bA+Whyhody3JfHqmdFQzWakYll7nx9mBplH4rtw0ALk+1YxtEhypY0YEozwTwszGkNEfVcYz99z
	8Y7aMV77fluxfYg+A+bAu3U7EUl4qSP6ylv0s1CgsSAGNKp0n/ZkSiC8TssT86whTFr/pxMDyAw
	X9sOXArojCIYJlTim/tPuT4ajcV3/x9joKs6lcyK6aH5J9WffQ0VFR7GSVpObAhevH1gIA==
X-Google-Smtp-Source: AGHT+IFf5eWy1kO/K6jVYD16XsJwEx0QOq1FyauR/umecLHRc0ZN+z3ZkHsKlonhP8bD8EpUmoiswg==
X-Received: by 2002:a05:6808:2f11:b0:403:56f4:8780 with SMTP id 5614622812f47-40b33d7a583mr3749189b6e.9.1751045719766;
        Fri, 27 Jun 2025 10:35:19 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:f3a4:7b11:3bf4:5d7b])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-40b3240548csm429800b6e.28.2025.06.27.10.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 10:35:19 -0700 (PDT)
Date: Fri, 27 Jun 2025 20:35:17 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Manish Kumar <manish1588@gmail.com>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: sm750fb: make g_fbmode[] a read-only pointer
 array
Message-ID: <c8f5f917-8412-408d-9dd9-6635af8825a7@suswa.mountain>
References: <20250627173120.7639-1-manish1588@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250627173120.7639-1-manish1588@gmail.com>

On Fri, Jun 27, 2025 at 11:01:20PM +0530, Manish Kumar wrote:
> This fixes a checkpatch warning by changing the declaration of g_fbmode[]
> from 'static const char *' to 'static const char * const', making both the
> string contents and the array elements read-only.
> 
> Signed-off-by: Manish Kumar <manish1588@gmail.com>

This breaks the build.  Now we can't change the pointer to anythine else
except NULL.

regards,
dan carpenter

