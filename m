Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025A5EEC3;
	Mon,  2 Jun 2025 13:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748871948; cv=none; b=nYAHxK4weRdTDTQkfeH107A9ZTOew8NwAPG5dTRBZWKCReqwnNNSyaHemaz/+CzRYiN06R6NogHTHXQ4iviRbHh9oIn4ICO598n9P6yVWbt9Zo3ss69hA8fZSmnLzYWf3R+g6MVx3Bp1vy/V3fT5/87LJlypkdyfdReLAyx0Oc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748871948; c=relaxed/simple;
	bh=S970LvgFik4CtRd8l9nyTXQOtk7DcwYM8qd00P7SiU8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kDlXDJ5ciEqutgDi9BzkVm4d0HDF1+E02/VCSdWv7g+af9E9IS7YqVO14Xcb5yqTlcIuLOIHQaxeZwNQiCCByBwrZxAdtLsNw8+k/C8S6+CV4UeNFydobjlubqFhYnjTLOXfUNDFna/fHRPfqFQqrT4yT81t8JQ5xdkjq8Vcz6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LweUGSHQ; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LweUGSHQ"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-234b9dfb842so39703195ad.1;
        Mon, 02 Jun 2025 06:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748871946; x=1749476746; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S970LvgFik4CtRd8l9nyTXQOtk7DcwYM8qd00P7SiU8=;
        b=LweUGSHQCbmU6Ty+I5EDCZhZxsXyUnfgWo0klP50JfoVq+aEm6cHbP9mEFYFT89Y7/
         HyCpi2JY0k8aVj6C3j/wMNSj/8+i2gMur30l/+/3LO58Y9XcP1HMHW4QUC2eEPNJNfSF
         hS4emLW8fIWDgN3f6361Hl1+mJzQy7oCQOivhveGd6vHYtPzJVDmhuGV/XGyTH4+kht3
         f3debT22/8UvQioOJTGU9X5jwrlYo7x6WJQHGACLPtKQAZyGkPITzQ39stfC+meYk30g
         zN7zqF6r0dB+ax3qjiN81hhrPSpxVigEFe+NjlqaJZYTNSUBNR4X1U/IZzLmao3FCE0K
         H5Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748871946; x=1749476746;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S970LvgFik4CtRd8l9nyTXQOtk7DcwYM8qd00P7SiU8=;
        b=OHjJFA4YM983aJyIK7HnaWs+NikxaY2f2DvU9vIl+kwM9FKEJJop1MS7dYlARZkNcb
         r+FUkN6iG48qkkwBhprnvqYpL9Rrr5apeYf8mrOqRTEsgqM+QiUKgn7BIgFLce7sRaaG
         VHM9pVtTlUVYximl66eXZi3YAtKw2xf6Dx/sKG7xsQX72GMJQpy905hKeAvMpt3biuyW
         riHgHEKwoDMjMc98/FcexA3f57td3HHKZhP9LolRxY4lpweJqAFk0DwgvteyTInjBuBQ
         rmFi/KRvn0RLgkOzBqE21L8QKNV2xG1wsZNOMPQFwJM/50qS5tHT+WWBnG5/GdyLgs5i
         yCiA==
X-Forwarded-Encrypted: i=1; AJvYcCUoMTBdbcJ5HfgdJbA5wAdaZSo8TCeGQ4ISgMw+PwVwDJzYdcqBC8Vom+N5zvkP5WkZOHk1Xz2kYJvJbQ==@vger.kernel.org, AJvYcCX11TQA5qqev04reYc+s428apTJQjbw2BL7xbgI0qvBqOY4BxbUcxvYxZTFL0aquPgzTDpqUuh7cq9/VVtm@vger.kernel.org
X-Gm-Message-State: AOJu0Ywhbm4gtyrjT9+/FShgNi7ACf4XujVI/c60xBHejd2jd+nwD9Ib
	voZhh8f69DZ51AOkKkRffVsQUXBXpU3001B0J04wbuGC2/5fEwoJ6ADS
X-Gm-Gg: ASbGncv/09aYqbCXkQKxzHwoualmbQtU0UhZ5B+rCyhyJvMJFeuFesEfSREwRbW2cTf
	H1t2LsXMLdMdxIcFPlU6R8B01GygJdDmbHRBhGa4k1HU1Dv+on4X34m0XDRobw5jSJ7wl8D7eXD
	RTMYA8KfYBUAX91llm57v9nfiZYCsvRL+AMrWlSRuOqb2O552rTMwPq9j+AAoigtWonsx+Z3Eyo
	inNQXms/GDBoMKJR745O4gskK48HYLdRVICe/s5L9oSiojPnhgjilt6w/+nf5m1gcNhkhvHrKoF
	n8aCI/ea4q8uuxG1NBEfAKG422+q39z4bksaV80ExsdKTt2Ppw==
X-Google-Smtp-Source: AGHT+IFQV0KYx8dlqZAj78pn1qmlTMJYNfvFmu2Nk15buJHM133DY8QNVn+McD/8+Bdfqcjfqt1YEQ==
X-Received: by 2002:a17:903:b07:b0:231:c9bb:60fd with SMTP id d9443c01a7336-2355f769730mr100658265ad.33.1748871946123;
        Mon, 02 Jun 2025 06:45:46 -0700 (PDT)
Received: from nuvole.. ([144.202.86.13])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3124e2e8e80sm5591447a91.24.2025.06.02.06.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jun 2025 06:45:45 -0700 (PDT)
From: Pengyu Luo <mitltlatltl@gmail.com>
To: jani.nikula@linux.intel.com
Cc: danielt@kernel.org,
	deller@gmx.de,
	dri-devel@lists.freedesktop.org,
	jingoohan1@gmail.com,
	lee@kernel.org,
	linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mitltlatltl@gmail.com
Subject: Re: [RFC PATCH 1/2] backlight: Rename duplicated devices to support dual-backlight setups
Date: Mon,  2 Jun 2025 21:45:32 +0800
Message-ID: <20250602134533.114602-1-mitltlatltl@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <7dc6a9e5171bc70be23188ffd8c45168fa79aacb@intel.com>
References: <7dc6a9e5171bc70be23188ffd8c45168fa79aacb@intel.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, May 26, 2025 at 4:53 PM Jani Nikula <jani.nikula@linux.intel.com> wrote:
> On Sun, 25 May 2025, Pengyu Luo <mitltlatltl@gmail.com> wrote:
> > When registering a backlight device, if a device with the same name
> > already exists, append "-secondary" to the new device's name. This is
> > useful for platforms with dual backlight drivers (e.g. some panels use
> > dual ktz8866), where both instances need to coexist.
> >
> > For now, only one secondary instance is supported. If more instances
> > are needed, this logic can be extended with auto-increment or a more
> > flexible naming scheme.
>
> I think for both patches you should consider adding a new interface for
> creating dual backlight scenarios.
>
> For example, this patch turns a driver error (registering two or more
> backlights with the same name) into a special use case, patch 2
> magically connecting the two, and hiding the problem.
>
> With i915, you could have multiple devices, each with multiple
> independent panels with independent backlights. I think accidentally
> trying to register more than one backlight with the same name should
> remain an error, *unless* you want the special case of combined
> backlights.
>
> Similarly, what if you encounter a device with two panels, and two
> *independent* ktz8866?
>
> Please be explicit rather than implicit.
>

For i915, I noticed that it renamed the device internally, so I tried
to rename it in the backlight driver.

Indeed, patch 2 may combine independent panels, I was playing with
android tablet, and I ignored it, you had well explained it. Thanks
for pointing out, I will consider adding a new interface.

Best wishes,
Pengyu
