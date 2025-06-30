Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0AD433A4;
	Mon, 30 Jun 2025 19:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751311053; cv=none; b=YmphJnaWJdVTuVzsTkyrWOG7Ce8cDOjJIk31ZYSLb6M1dkVg88Jk0rk4w1n0ksBz/byg4HK0DR8o85Q6TY+B2oLLgWC0jMYvunYj5JLyaaney7HyOTAGaA1yBJtpDjYaTRupz2di/Um2GJjRLa3lIIA2e26WRLKlrYmesvzHxVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751311053; c=relaxed/simple;
	bh=NsqELtxqi47KDtpNerRjKlGBO25wxTKkp8u182cGn98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MfhqDlSpIxD8Nyt2GuFEOUflpCfz+kgOtF/V9tGcnkSBeSGGltmsnj2l9aBfNkMIk8wAqPttLQJBhUk2H9hePniwJpsh/RWnbdfAKDjThWxVQnAhNV9XWLn1GlXMqfDaSC/09wBFzXuz810134l93oZ0wM08zmqT6k9M76h55Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MVsc4yP3; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MVsc4yP3"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-747fc77bb2aso2367158b3a.3;
        Mon, 30 Jun 2025 12:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751311051; x=1751915851; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Um5P65+nf9UZ6CcWggyKqfAjkPQHQmkomV6ie3f7noc=;
        b=MVsc4yP3SLSSW2OZ/szdt2ZYB6W4jJ21YDp0TBTj9aiE7r/eKxJAembuSMNhCyxcJH
         wvGJAUF6Q7iQDRt7Eprk9hJx6uKU74DFZmJ+PLlpYbNTt+2veGbxL4nnPmkMCaSBOen1
         FNgrL8XrJ/ufjs6Ovkd4bIgocK8OACRikwfkaSQZgCyUb2a9YSOY3PjsFDbKZMqYPioc
         A1jimSQsJxXkQ6R0XcSWH9vYPkn7xZxy34qqlrJvDnaIMtK41GnPPp00DUevUEikL63V
         wPU6iMRryDrv3EKmSHiQP/raZt5LDvcCyl3jqfZ9a6F1scCi7WvG1/b7uVs+sKuJAOrB
         TIFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751311051; x=1751915851;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Um5P65+nf9UZ6CcWggyKqfAjkPQHQmkomV6ie3f7noc=;
        b=Xu+WXWNfNAUJwNzCrHZhTsXZ8W27Os3mZOzeKO7kaVUewvE0WQ8/kTGay/Ihm7xCuC
         tTLWse70MqxWh49J3TsDjFwmlce8lahG50uFYKf+h94tEhdFmo91eYghOr3Qshn7M0sE
         Sxx/nSvtTvvYM2GANkYUdJGAdhDPFTo5HL+P0vjdZcDmLfCCiU/xTnn6vPd4JxIcp0fx
         Hrmf15AdMs8TaB4jKgZu7nRMfo+nPiBlVQw/8RLGOL59SldUO9DzY3CXsVsfLAMv7T+M
         OKA/XR9Cyl0/2chxLDmUp/lCX3jSp9nvcO8k4KW0wLikzXv+DT4dnZYBdvAHEy3geuSD
         cjOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWdHR71pDDK2WtDSZQE9ezHSV8JcDZe1//l9i1vFdmD71Gfb4jSq/ApctUYHf33I+FdTJ+oJ9zgtRAU6X1J@vger.kernel.org, AJvYcCXZ9k2ZtysACO8l8n75AD/JJguws+nuC6sy4q4KQi3QAdi31iBTW8DysMIXFtR3/yunPhod5aq427scKg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyfCgrEE4p9G/E95W1Gri6uMIkSyABEMWRKE7cWvHy1WfYDvI/4
	0ItuWAH9/1q2SMBlVNFzEnuFHZgsYeqHHVSFPmcUyGN+yRXYakk7yjBv
X-Gm-Gg: ASbGncv70WPieJ4bR82E0I4JO/LGjQuVjjChADcc78hZ50fGQMbLPwu/IgnNJ9Eal+c
	d8QhJjX/qBT06+FHQKJ82qHrNUIRSFcMxEISW/oYhMyPwzNogJqZa+tLU4Xw1yRz81QHAZcdicT
	oGoc6Q5x4k7DCmZnZKRucyD3l4kbSfqvpImzUrs6EuY+T2FG0KKStTZTmLX9ENgYmlO7MHIQF7m
	/cNjcgEREwmJ61uEV5T3uexhQQUtOsHCOZaznuyGBTE0VEtKh++GtoNviztAevJ4F3n6PnEmGv5
	Ok/LOHzcaV2V9zWtThnVkGw08pzIz427l59lNn6Wwu/SQjxRu7rRT6A=
X-Google-Smtp-Source: AGHT+IH7tDIInMf2NZlvN/kfsFCNXiU4Z8uqHFH4ypgMKE0Hx9X2SxMn1hWbWYecPU0Ne2UXg2PsXQ==
X-Received: by 2002:a05:6a00:2288:b0:746:3025:6576 with SMTP id d2e1a72fcca58-74af6f222dfmr19186926b3a.14.1751311051009;
        Mon, 30 Jun 2025 12:17:31 -0700 (PDT)
Received: from essd ([49.37.221.186])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af57ef0f3sm9986457b3a.154.2025.06.30.12.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 12:17:30 -0700 (PDT)
Date: Tue, 1 Jul 2025 00:47:22 +0530
From: Abdun Nihaal <abdun.nihaal@gmail.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: andy@kernel.org, dan.carpenter@linaro.org, lorenzo.stoakes@oracle.com, 
	tzimmermann@suse.de, riyandhiman14@gmail.com, willy@infradead.org, notro@tronnes.org, 
	thomas.petazzoni@free-electrons.com, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v3 2/2] staging: fbtft: cleanup error handling in
 fbtft_framebuffer_alloc()
Message-ID: <ezkfonpaubsmw6gr4tutgnjmbhvsuwkhaiya7xozl2szfqi4f3@zmde3sfybyzi>
References: <cover.1751207100.git.abdun.nihaal@gmail.com>
 <4e062d040806dc29d6124ac0309e741c63f13ac0.1751207100.git.abdun.nihaal@gmail.com>
 <2025063022-chump-pointless-6580@gregkh>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025063022-chump-pointless-6580@gregkh>

Hello Greg,

On Mon, Jun 30, 2025 at 07:16:38PM +0200, Greg KH wrote:
> This patch does not apply to my tree, can you rebase and resend?

I think you have added both the V1 patch and this current V3 patchset to
your tree, that's why this patch does not apply.

Commit eb2cb7dab60f ("staging: fbtft: fix potential memory leak in fbtft_framebuffer_alloc()") 
on staging-testing is an older version of this patchset, and so it has to be dropped.

Regards,
Nihaal
