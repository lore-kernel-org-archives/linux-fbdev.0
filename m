Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0748E345753
	for <linux-fbdev@vger.kernel.org>; Sat, 23 May 2026 10:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779530876; cv=none; b=iJwPpau3Nbusq6LUnDE7Wbl44dRPEJU5QAlYxqZ/dIC6hY7VVy/BuGaRPlPoBIsxspEhkAzm5CHib5U4PWJrrVaetNvLtddj0DhPdQf1ZwCEpV5MhdiTk6jXziNu+WLtVEaHUhx+Zi6GHman9udwceui20nflLeogj/22CnLnj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779530876; c=relaxed/simple;
	bh=yUw57AUKGTJWPjso2A08rWzGSwCN5ccv4SOQJIMQU8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qO2253jh18/xJiobrhVJ+W7qlXCE3yEdNgZoULr2cG6BRrw7dsN05UPjLtJZp4kWdEzKQG4jkkneTqLFdge7kcqrw7Qix8K9DE80y0LwmkYw0qFNOyilxZAV2QpH5LsUtvZbcX8YBR6m4JUY5ArOPtt2i5tykf/Vi7S7iKdKsNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OhsgjcDd; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OhsgjcDd"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4904fd4f6aeso5297125e9.2
        for <linux-fbdev@vger.kernel.org>; Sat, 23 May 2026 03:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779530873; x=1780135673; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rBbxljADjESEwUhSP3sGL1Ty2LtZCjUvSCp2wxLG23Q=;
        b=OhsgjcDdeBxRC2sXn1OCIU3HmpNVu18cwYAd63pBpT62pmtOorCRRP1PXnIUBDU5pS
         HZUCyly/VK4Au33IT1p7ncU3pgcpjOVlwcXT0LgbM0ZQPndK2+yJ4mEVi1ZiOnYuoSsg
         C6ETFleVxpLdGWL9h3RQh1s6znNxSmJ4rQNmcIzbskLPfB7o0YBqFJ5bYDSvcnRZj9gP
         W+/TFqFN53Q3f+8clgyn4tfEdcRWEDBDBSzXDNnCSwY+qx+zBGj4ZsapgkCTYwO5LTCk
         zKzZUe2LH5DU5KpT+ust/cNn77LcXP5p1CvPbiuAUTy9MBGH74Xpy/EfiQe2LtuKTYFp
         LWSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779530873; x=1780135673;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rBbxljADjESEwUhSP3sGL1Ty2LtZCjUvSCp2wxLG23Q=;
        b=Hk4FpeeBpRDp1a7v96cpOCpuopctTlwtHnZ091t9XpJdJIB0iNXD8tJvAsPGGdgjdE
         rNQpuoBd/jyb25xo3PwSt3HI2W3bbx5kBDM1jmSZk9IHOq/35yOxrLc/uQjsIhHhxbDb
         0N0iaEE2yOlEpRrXTPD8rJVocYfU0U77brl/oZMdhxsVQh9xXYPRT6sWAcucN/RAcyPZ
         cJyOFEe/IHCnl1h6KsukURYWDl+gVTLYZw7aAM3GfmXOiGee81L/cC59AXV9Il2ZJuSV
         DvuKFtPWSW/j/pJpuE91tD71uPjuroasaVVObYWYzh9devCTOz6avoyxa3WDvcYPhY0D
         T5bw==
X-Forwarded-Encrypted: i=1; AFNElJ/0KP8rAGbSay65WOJPGX1G241C1ocEkq1CBA0FS2ao++7GgAKMoVLQQyKK/P6LN20qVlamu+vXOmMYbQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyY1NVXdVWvJOgt53ObMo6bJVzgc+GE95WBoO9ZZior6TTr2ib7
	1DdUkPJzM7XlUOhq4ZxpSiABLQo9MPoOOXqMidmFZA3hA3FwdCp0W2A2
X-Gm-Gg: Acq92OFpn2J1Bu6L3pRltNBlasehZx+sc+r0AHjiJ4RVmQIc4XUWyZuAtsTRsKkdADE
	nf6uXMpIM27YyxNzYPLiS7E+K4uQEq8VZ9er5vwOCt8mh8ng7gT8Et5Pxz1cMI+iDrO/pBUFVNT
	FmhaKa5ENofvQuPFR6PAeT0XtUV2qkjki3njRHyo5PEVj7DU98SXStOWW1JLFaH446ZAJ8UE/Gr
	J3ESPD7Yla8hf64k7tpGjqKc1Pgkjf+2he1NCDocIEy5nEsr1vGELlBtNX6sPmO/zaLR9INMrfq
	EHyLGaD3qCliOBoCXmqw1qKJQFrscaYlqzedppBQ2VzrB9tV2lX836dVCfu2WhLbtpY6mtEA/Vr
	mwjum9TNYZJGusMXgvnwrJRfwEk5YkuOMzaUVGqVLoTjwaeNqaMJhniHe4DzzJMuEjCaLSit5AF
	LbGFY8YeKYXFntIHYEyJgfvQ0=
X-Received: by 2002:a05:600c:474d:b0:490:467e:a3d7 with SMTP id 5b1f17b1804b1-490467ea4a4mr87771075e9.30.1779530873274;
        Sat, 23 May 2026 03:07:53 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490424aa561sm49634335e9.5.2026.05.23.03.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 03:07:52 -0700 (PDT)
Date: Sat, 23 May 2026 13:07:49 +0300
From: Dan Carpenter <error27@gmail.com>
To: Ahmet Sezgin Duran <ahmet@sezginduran.net>
Cc: gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] staging: sm750fb: use ARRAY_SIZE macro in
 fb_find_mode loop
Message-ID: <ahF8dacOkX0tdxGf@stanley.mountain>
References: <20260523051509.166152-1-ahmet@sezginduran.net>
 <20260523051509.166152-5-ahmet@sezginduran.net>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260523051509.166152-5-ahmet@sezginduran.net>

On Sat, May 23, 2026 at 05:15:08AM +0000, Ahmet Sezgin Duran wrote:
> The loop in lynxfb_set_fbinfo() iterates over pdb[] and cdb[] using
> a hardcoded bound of 3.
> 
> Replace it with ARRAY_SIZE(pdb) so the bound tracks the array.

I don't love this.  As you mentioned, there are two arrays and they
both have 3 elements.  Why prefer one over the other?  This patch
makes the code look simpler than it really is.  I would just leave
it as 3.

regards,
dan carpenter

