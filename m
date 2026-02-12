Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DCEB22FE0E
	for <linux-fbdev@vger.kernel.org>; Thu, 12 Feb 2026 15:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770908412; cv=none; b=lLOQ/+9nOlp70AqYNQgXdr07C5xXRcB69gd3+IKmWczl8cb4GL3veGqgCZbsTRayDe9z6Zqs5IGoy1dv/gyWBVBUtNozFBxc2ANMdCCeY6eIa7qBTmJvx/Oh9qYLsFgscoWAM8VxQm2pxcyPcahbgZQAXIb1DW7hAZ0aCaIhmlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770908412; c=relaxed/simple;
	bh=p5Hmrmgn1UcxHmYPea4G80SvvCs1nZ6lsT+jQk3xr2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=akhXaYv/9YtnBBvxF1J8epngPnx/JU0ZN4lrLoWokmRwMuAJC5vaKpfi6FYWhoxCJOHxd8J4ANQxskgzmCn35xmVZ+3AKilb7cOJRuw8dypO0BWrjMyCSRPY4z5seO5HPuj9E+oaX3huxGTGVYhFUCKjZa+Ebmdv+CPG5nwR2HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GPoFKOAb; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GPoFKOAb"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-47ee07570deso61329505e9.1
        for <linux-fbdev@vger.kernel.org>; Thu, 12 Feb 2026 07:00:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770908410; x=1771513210; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IINbxAJGaRHEvEhY0z4nrEUHRqDZtjxcQiB88qmwdnM=;
        b=GPoFKOAb5SJUvqaJNZgVLdNYytECJOoP/H05zzdU+wnwE1yFU+Epe9bn6KgFSMI3EA
         mB9lUK9WXJ4y3wUTPR7dBaq8FkKlHyEyUiSL0uxn9P8xTSBqd6jLv1pxph7Od358740H
         o71EiInrgMu6yQWNMsorME/HpZVxwChxeJ86j4EBoybjidK4k8A76syicGoIEaXt3lVO
         OULZBNfPCb2MXji5QqkAAxuv7GSCO9J54o5DMc9oD8cl1Bwl2ZTc8YkieIzFd8u2P6uy
         PkKL7uMBhTqAoS+g9VUx0asL0g1lSQbPi8BpoO9imYRxw5wEgBqNlcoX9NrqRkhPmGP5
         c2ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770908410; x=1771513210;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IINbxAJGaRHEvEhY0z4nrEUHRqDZtjxcQiB88qmwdnM=;
        b=AxP/4fBi+PecHaYVv+Abx+gbN+CjGUgL0gkJSc4hZgs4l2nBsmroKKJtqEV/YycH/K
         C/kMuA36OWCo5SvTJYU5zQo74ItmvXGwREKIIE8A5zj+SiVQjp5xpkH0pesSm5/cw8fh
         2aQ8fvWhYwuHVwyhadh+svShTQ60qdieWaKaG+d4o4638AUWIQHawG9aDO3Zbs03TwOO
         HYb5KHVc8u+QFztUDxqhFIuvCyN2jZWz4EACmEMcKUsFYfn5fL/pm32U+ZmJkjdtBCuY
         VgYO1y5fCJS1bInrB7shtvSu5n84H6jweTrp9T6Lfnm7m2G5yIy9j0uprZKGRD/h3Pfg
         1nvQ==
X-Forwarded-Encrypted: i=1; AJvYcCWttBj4lF0yY80E0fVusVf4QMwa2OboD6F9AcxZY2VddC6ZVwz7whejPv2yuvMe7d47wGmanL+DiYqXhQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwgFRrpRYn4ehe7BVF8Xx9P9HGhe2HBnvEEM8xJTzRGWO4npKaB
	wjd1Zif/0We3q43r3wIldIpSL176fFDMOy3F+lIxnhZN5oS4eTSAeFBz0rizuDguDEU=
X-Gm-Gg: AZuq6aIucvOJ/dU1l/kht1qTi5lzpZIKxRujg5tAcJiARexEgH7lZKmybDxJn6bNqCF
	d8BR0X0xB2gILsdaXtc0UJS54ZIrllCovyawisGWCv9RsuSfiVfkCi+EGdG/AcAM9LCuOvXskA7
	ukIVuCcYJa+9RtXghj/bX4FKH3ctw8R/EMHgJQhTCQLuCEZtAEnNWBKE8zfndqavMuGtuIApYXL
	IfenqcyymTFWT/kwninbByDDp1aaxCcoDXPR0qKk3e9iWuNNMA1IP6qfmGNFBOAZ7ONxchnD+mI
	UiGKEtt1j8O2teSlwHPlwAhtB4lFwoyzHrCJTRa+4HZDJeUHpWzku1RcSsMcuuGNGTuoClOpH9E
	phFhcqDOt4HylpYOuhlL8FWvjeuc2YKcxpT5zpwBq5k6r4oWxbguvs17QV0DLHuEZ4kFQR6qd2u
	E3Y7DDLjBd8xpiD4419ce6hgHg0/Uk
X-Received: by 2002:a05:600c:19ca:b0:482:dbd7:a1c1 with SMTP id 5b1f17b1804b1-48365720147mr47963225e9.34.1770908409591;
        Thu, 12 Feb 2026 07:00:09 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43783e0196bsm13599697f8f.23.2026.02.12.07.00.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 07:00:09 -0800 (PST)
Date: Thu, 12 Feb 2026 18:00:03 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: RachelOvrani <rachel.ovrani@gmail.com>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] staging: sm750fb: Rename nDirection to new_direction
Message-ID: <aY3q85hAYWUGPngz@stanley.mountain>
References: <20260212105842.36431-1-rachel.ovrani@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260212105842.36431-1-rachel.ovrani@gmail.com>

On Thu, Feb 12, 2026 at 12:58:42PM +0200, RachelOvrani wrote:
> Rename the variable 'nDirection' to 'new_direction'
> to fix the warning reported by checkpatch.pl
> 
> Signed-off-by: RachelOvrani <rachel.ovrani@gmail.com>
> ---
>  v2 -> v3 : Change the commit message more appropriately 
>  v1 -> v2 : Renaming n_direction to new_direction
> 
>  drivers/staging/sm750fb/sm750_accel.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/staging/sm750fb/sm750_accel.c b/drivers/staging/sm750fb/sm750_accel.c
> index e1877e5d0..c796d410c 100644
> --- a/drivers/staging/sm750fb/sm750_accel.c
> +++ b/drivers/staging/sm750fb/sm750_accel.c
> @@ -153,9 +153,9 @@ int sm750_hw_copyarea(struct lynx_accel *accel,
>  		      unsigned int width, unsigned int height,
>  		      unsigned int rop2)
>  {
> -	unsigned int n_direction, de_ctrl;
                     ^^^^^^^^^^^
The old code should be nDirection so this isn't going to apply.

> +	unsigned int new_direction, de_ctrl;


regards,
dan carpenter


