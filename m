Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6782367AF;
	Sun, 29 Jun 2025 14:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751207004; cv=none; b=JChJWbiGfwzqYE6MmBtaM1ZZyp/JzPt1NHfk+mLJJtw5tGDb3eVEmy3MRHzQSiKjM1X8MNZ2XZh6LOwPJFTOvyRkiv6EJZLW7Cr2Sfl3PeW3WFmPDrXnwLRsdAPTuvef+QZsAUr/7gLCh2iuJp1NOuRILwxvJ8mm9WO7t6yriCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751207004; c=relaxed/simple;
	bh=nAzkLf6fByBaHr2zsZXR+WogUuCuVekqUNUPbP7vlYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BCEukwPVS6XFbAFB7yXa5TtXOulDVzVUmfbvkfEacCuWe94hR8YpzyinljjRKTMNb44CUR598r0e7RDnvWJfiavASEUKQoiyl6r56X6rRwvE7V1nhMYMuSqVI9idxWD6uuKEHIlwoS7oVc2rIKBnn7Ahv+Qg61lT6ISB1Yj1y1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pfzka5qg; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pfzka5qg"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-236377f00easo12778685ad.1;
        Sun, 29 Jun 2025 07:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751207002; x=1751811802; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4XmE3HNeFPwhvV3YapnRmO/5DkoCIHrdHE5yflvWYiA=;
        b=Pfzka5qgLdul3Gb1rfEqLZHPfPHl3vUmUDCaKp+R3D3jSWWy6weXW6qIHFS4B4n7Zb
         uL4GDGo72r49p873rKIhEYsea9uteMWeFzrlUS+Q0cVfvPL1H4+5G7j8/1IWm81Lz933
         S76GkMlmOe2GxcBYhHbZZkRwt9DbHct1CHDqF8F8Y91ZXPvE4T4wZWjJhohI2qpGKC8V
         OjVkvaw41HAwO5bHo1oiJrWXEWHnvjGOy5eAP5PPT8DhyHAhxMLIJjRjST4GFDBd7/yg
         6/0sLu4x7EBlYVcWL2+vvcbn27ECnRRu2h44/77QkEg3Cr7n3/c/I8P1ZLTgnVOyqg2I
         H2YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751207002; x=1751811802;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4XmE3HNeFPwhvV3YapnRmO/5DkoCIHrdHE5yflvWYiA=;
        b=pbxoLsHTDaTlW9oMziNejOP1nNgy/GMrVH/4C5AGm9MnqnDnv5CeVOF4KLsfufwy6g
         zpqvrnZongIiLhqJElafkJ5mZWsKwA/9qk77awcY1eoktM8TrBREss70cXwUdAiTwP/C
         cLs1RzPRTdkKKLYSHnS9wSAFoLFX8MjulL+5qP9FRJK2s6dpQZRjA4hZ+2PmOzEsUCeH
         vp1a4aWTFTQfYjFyQ2/Mxmm9zukbeQsagcR352snZmDB29jdqy72yU8P97AoWthaAGUI
         8JG1bQuFhQ74cN3c+aoIZL2YpSsfxRHFJgaHPL+/Zax/7BBEQWwd11mTJvHvrCUn3aqb
         74Qw==
X-Forwarded-Encrypted: i=1; AJvYcCWM0137MPlifS9M11hLPZw61DvusV/d1tz/OteViWyBVvEATGwD159TxoKPMrF7qWn9/0SP6rtHV2ZJj92h@vger.kernel.org, AJvYcCWpF0F3dNtzVsmIZJ1fSfApM1+X1dTFjx44HJAZ9A+rna/PMLIatGev8tUJluxxmdNdF1idfK7in4nX9w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwsD66A1+zY3EoLYb8J9BYrIc4sD14th7OmTO5zc/jY4sNpdSi3
	L0ntIQ/g8pV1oxOn20j2XU/vFGpdC4u1jCLq7n6h8e3tThkQ0WwP2InW
X-Gm-Gg: ASbGncvsB7UAUerUhFMOPq9pBRClROx8jeH5JiuXVBCPb0L8XKB2CyWeQBJy8sWallc
	vr59lfug3OGkkmkaAR5W3KBqTjdOO5GbabF1Y8lbcfasj0KNIIt/hIEHDSX3lc2Vcu1AFlvrpAv
	rxOX1qG3JcA+cCT8vo5F9rGqWDD0W9O2/K7cjieeT1K+Q2UuHkJS4Pv59hyjjAwfMQ/q5P+OBCm
	Ud4rxbk0xZBmWjf54b34+p6vwhLFT4cRhIRbyi2gdU1o5pfo4+j5tWqgpBSPyblhzz40zwcjem4
	s6S7+kZavr2Q5x7fMxABu25KhCGLX7ia7X9H619koSZ9457HzOad6J0=
X-Google-Smtp-Source: AGHT+IHXD8nXRq9dLp21pFDQyRXR7/wWUgH4S+2XEaLAGY7dzwkGVIgjA3e+5v3+0oNfgBvPx8YFhQ==
X-Received: by 2002:a17:903:1aad:b0:234:ef42:5d5b with SMTP id d9443c01a7336-23ac3deb9a5mr167279295ad.16.1751207002043;
        Sun, 29 Jun 2025 07:23:22 -0700 (PDT)
Received: from essd ([49.37.221.186])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb39bd67sm60442735ad.136.2025.06.29.07.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jun 2025 07:23:21 -0700 (PDT)
Date: Sun, 29 Jun 2025 19:53:12 +0530
From: Abdun Nihaal <abdun.nihaal@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: andy@kernel.org, dan.carpenter@linaro.org, gregkh@linuxfoundation.org, 
	lorenzo.stoakes@oracle.com, tzimmermann@suse.de, riyandhiman14@gmail.com, 
	willy@infradead.org, notro@tronnes.org, thomas.petazzoni@free-electrons.com, 
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v2 2/2] staging: fbtft: cleanup error handling in
 fbtft_framebuffer_alloc()
Message-ID: <eemnoitjhvt3nkt6k66dl6p75zqvsdttalyncfg2dqs2bcbkgy@pvr5wgx3x5xz>
References: <cover.1751086324.git.abdun.nihaal@gmail.com>
 <62320323049c72b6e3fda6fa7a55e080b29491e8.1751086324.git.abdun.nihaal@gmail.com>
 <CAHp75VeSYesZuJ-NEfEAvaRepEUtdLmxGrYmthD1YkSg-bsK_g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VeSYesZuJ-NEfEAvaRepEUtdLmxGrYmthD1YkSg-bsK_g@mail.gmail.com>

On Sat, Jun 28, 2025 at 10:58:20PM +0300, Andy Shevchenko wrote:
> > +       struct fbtft_par *par = info->par;
> > +
> > +       if (par->txbuf.len > 0)
> 
> Do we really need this check? If txbuf.buf is kept NULL (please, check
> this), the kfree() is NULL-aware.

I assumed that the par->txbuf.buf may be uninitialized, but I checked it
now and it uses kzalloc to allocate, so it must be NULL to begin with.

I'll remove the check, and send a v3.

Regards,
Nihaal
