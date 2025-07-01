Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50FE52C859
	for <linux-fbdev@vger.kernel.org>; Tue,  1 Jul 2025 14:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751379754; cv=none; b=YQGcper+OkcG4XP1i4XDB12E+l+PtMuzV6YipOadKwDK+PqoSE7rZW10QyDblv4FZWJO7dsG/ueVkWX6yIgDGLeoQE9XjSUB+rmHTLenz+feC2Ymztmc0tco9i1ss/cwZgeQ+dC6RkTREa3atPMsGGX8VIHAVNr2iScrNtRpeu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751379754; c=relaxed/simple;
	bh=8SNUHHsLZlbYQEbttYrEHI1FQBZFRL7HmeQ/RQy+dws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CtiLI2c26d2LP4bVofaul3nhShXwZB0ZE6MS4BJhZ//zwpUK1aGwgURxWcYzBBvYPN0UdiIonRhV8GihhVdE6DzdfFxgK/9GgrW89seVpkkG3BIYksodwvjHubV+YRxlF4+MI8FdHIfMrCs/viH3edSLsA4eqcs1BP8va3by5xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ulj1MEd8; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ulj1MEd8"
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-6118b000506so1367692eaf.0
        for <linux-fbdev@vger.kernel.org>; Tue, 01 Jul 2025 07:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751379752; x=1751984552; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=k8x0R9yhBqb5Y1VdS7ojeB/NMJonErKKyGe0msuTxWs=;
        b=Ulj1MEd8NodvkIiE2JaJkeoIM3ADNVilqidh0+V3y1F7GAVN/Yq9qQAwQ+30JyOiQk
         jYM1xS8Ry+xcCrnn5ROBM2swzKKvj33ZptwUhaXCIofnTGfJQ+OAA5V+K2gqDgcap6ZL
         klEJwyAHkdb/VTwKAJLH+MjUzkXf/uuQBJIwZQOpUn53WqZhB/WpqsHUbUeZ3PfgmmhO
         YcbErjdGBrTwDppUGOVrr4TUV0IKQJhpvmhRuBqWmqesbQGhcZe0xe6WKynkODkcwGne
         IGJYkzfT8CgopP7WFP0ZEPxA4sm+B4NUnXGIa7OcEILq2K/jzAw79FrNG29zBRPdi6Tq
         sb2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751379752; x=1751984552;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k8x0R9yhBqb5Y1VdS7ojeB/NMJonErKKyGe0msuTxWs=;
        b=pvGziwaXUcBVHzxojAqLDLE6GY5uSUKZY5hxkN1mpCM22HWXrndxbjFKv9OHVSx2eu
         OyOt//z78KdN+D91IxBY4foUh54xiHkl5Oy1+rOMWbzLvOc78zfXO472jH+6KNs9Ev/9
         Bpzz21FMZUKe1LSHVQhouoWLxRm9MkxSEN6a/rqJadAIgj2l/GNaV4f1bF+SocqhBYsN
         q5KMxMQg3t6odu9D7rXb62vjWnetVoVTNcxTd/f7hNtdMBRTGItRZufMjiir/135tKNX
         /esmEhZsIDhHtrJsAe6J72QrBr+CwTqFD6Ok7OuEy6VE9e4pojABzfU153qBCFPzkC3r
         NohA==
X-Forwarded-Encrypted: i=1; AJvYcCXRVw6vyitQM6F8OoQ+sQ8VCHupsWoDD/YZNWftwdF6bGt1G7RLxtkgcj4PrzMMyCgJkvzIXDlF49KH+g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzHARVUFiTLweG/+7rnRhbH/cvkPEqiW4tUwzaZWn2/EvOdmZDl
	Ke8a9w3sBUJ/bgQdSZYBEC1Eb3S1MDiaeFvQyqtevS8RX7BklHlX6a/9vbZzQVlszIY=
X-Gm-Gg: ASbGncthWajXCbY+Aup5vzvRtw1G5TWnZbScgM6ZGu/k7/6mNF+x31FDPinBa06fUqP
	dBi0lHc/vzD8BTGYHaAD+VKXtJrGaamWw5pPzqMf0/W19sIQDtJGBaugYUyJrx7HNlfzBDgPiUD
	9jTOkGq9g0hIbfNnM4I4Q31mmNNpN4P0yIkdOsxC6GXAdXZffHCw/AbUeevfxZfdMoozUG+lweJ
	om6IMlvaewp8GmRWyIOYcqfziFxT5XusjP9i5dvWj37dTeFo8/VWHvS1jnEonMKKt8Md/V9sYKl
	6yt4S0RcuSb4fFx1nb4sFZoNuTbdAZmiPkGfitWl1N2gEultT2YVGjKUzie8YuWjjX392Q==
X-Google-Smtp-Source: AGHT+IEpvP/IKG4XnE3h2afzTDYxxLm0xCTQLhlMLnl5t9v8LU08VB6RFSQVJksDddfCJibRGqTUbQ==
X-Received: by 2002:a05:6820:189a:b0:60d:63fe:2472 with SMTP id 006d021491bc7-611b901bd7bmr12009783eaf.1.1751379752307;
        Tue, 01 Jul 2025 07:22:32 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:8ebc:82eb:65f7:565e])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-611b8474de3sm1394279eaf.3.2025.07.01.07.22.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 07:22:31 -0700 (PDT)
Date: Tue, 1 Jul 2025 17:22:30 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>,
	Abdun Nihaal <abdun.nihaal@gmail.com>, andy@kernel.org,
	lorenzo.stoakes@oracle.com, tzimmermann@suse.de,
	riyandhiman14@gmail.com, willy@infradead.org, notro@tronnes.org,
	thomas.petazzoni@free-electrons.com,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v3 2/2] staging: fbtft: cleanup error handling in
 fbtft_framebuffer_alloc()
Message-ID: <89390196-a23d-4410-a8ff-b068f1795653@suswa.mountain>
References: <cover.1751207100.git.abdun.nihaal@gmail.com>
 <4e062d040806dc29d6124ac0309e741c63f13ac0.1751207100.git.abdun.nihaal@gmail.com>
 <2025063022-chump-pointless-6580@gregkh>
 <ezkfonpaubsmw6gr4tutgnjmbhvsuwkhaiya7xozl2szfqi4f3@zmde3sfybyzi>
 <2025070128-amplifier-hyphen-cb09@gregkh>
 <CAHp75Vev8r7KZ79=CoUtt0wbx0x3O0ZckesWtQrxs-MBpiBz_Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75Vev8r7KZ79=CoUtt0wbx0x3O0ZckesWtQrxs-MBpiBz_Q@mail.gmail.com>

On Tue, Jul 01, 2025 at 10:03:50AM +0300, Andy Shevchenko wrote:
> On Tue, Jul 1, 2025 at 8:14 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> > On Tue, Jul 01, 2025 at 12:47:22AM +0530, Abdun Nihaal wrote:
> > > On Mon, Jun 30, 2025 at 07:16:38PM +0200, Greg KH wrote:
> > > > This patch does not apply to my tree, can you rebase and resend?
> > >
> > > I think you have added both the V1 patch and this current V3 patchset to
> > > your tree, that's why this patch does not apply.
> > >
> > > Commit eb2cb7dab60f ("staging: fbtft: fix potential memory leak in fbtft_framebuffer_alloc()")
> > > on staging-testing is an older version of this patchset, and so it has to be dropped.
> >
> > I can't "drop" patches as my tree can not be rebased.  Can you send a
> > fix-up patch instead, OR a revert?
> 
> I think the cleaner solution will be revert and v3 patches together as
> v4. Abdun, can you do that?
> 

I'm reading my email in the wrong order today.  I thought Abdun came
up with the revert idea on his own instead of you and Greg suggesting
it...

This isn't a case where we revert.  The patch we applied was acceptable
quality and it worked fine.  Just do the additional cleanup on the top.

regards,
dan carpenter

