Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA103358A0
	for <linux-fbdev@vger.kernel.org>; Mon, 26 Jan 2026 12:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769429736; cv=pass; b=Ypcqv0DeLy1UjDxyL7xNfnhqL4yQ5qCkF60v1CY2NkvO2zGBeny60sGbVMaOWcjQNLARCOa3ErT2a5TXVuhrwiW4Ek5xezKfJRSbgMVT40Pkmj9mh1Y7Okop5QCefM+PiYJAEkZGdFf3opOf9UF2SOtR9kELF2hRQ+TwSax9qSA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769429736; c=relaxed/simple;
	bh=9xseSJ5P28PtHb9TqnfdbLmC1Wb0o0LuhCZEaoJRH5E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O2jp8m3xvZntm8jKa0GIUfNBkfvvDFhCEAr1X/oFOQJadaqQWWHQcSbvaGs/VfUAeP9eoHZ1BSDJhA9JYC6PV9mSv1SDFBr1ocBeN2Uwk7/Nlfj0dwVuvCSMG8MoImvgLmQ1IrXR0uaE6iagthaZ2aAMLNC5vMoODyyyd0s6+oQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mT2cgmy5; arc=pass smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mT2cgmy5"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2b6aa67a792so225613eec.3
        for <linux-fbdev@vger.kernel.org>; Mon, 26 Jan 2026 04:15:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769429734; cv=none;
        d=google.com; s=arc-20240605;
        b=Uq2ExYZU/NO7oY4gAmVW5UgF2mS4JCMYucFVnH6mJJp/eDHdY7atvCGVRjDQF2t9/S
         ckjYgM4WWLvG/mxhUaI+m7u6LezTnN86aceaKbrXvlJkDJIpU7Tz8ap8vOf99W6N7lsd
         4jLJhpSqdcoGTIHt9uB8M2EO5FoCmr7uaykNmiMpQzjIGfypU6Gu1GMYzdJS6cSS75e8
         595S+PbEftfRfuv7DFpQgtY+16Rdn5gwZw1L5BUg8LUa+dXPMTPOrOBtdaR5rTdgKZo6
         hlnECre6n2QGn0PX2Yfng7wkL6VBDxDXURXK16GPXYsceioxxWWfKOE3yCPP7hErFi+L
         VcIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=467gqcHqnIQ9VVwNI4wTrt6UrXfdyjXK86YLFCrFEFQ=;
        fh=+cC624L+r86L6tjMZyZe6mHGTuoF6DX3UgZEZbedxEY=;
        b=F1Xzy4AiQ2BI6UT+kppygZfvx98qTyH5yzvghfOKoajrj5VwZnRVo3NjOtKVFfsJNX
         CyKwnaTrvN8fS02AkkEFFNa3MvigfnLty3t9Z/VsmYSOtTGRsnqY5Md+bdq0r6IzuWx2
         /9BgAuOFJjNxll+wQNhP7ixSxN21l55d0ZodlYR+0lX7v7a54vVk9L85sVEz+96lJYwC
         PSyowJ3GDoa+NTjRrR2bRydoLSAC4aHduayMFUG8mo3A+Sp8aJqWIpnPdesOFOkxWQQA
         GdRHe3oHUNNv63S46khOLLYVwNwwaua5M5wEWnDbySlbCZvO3GwJmZh293ewCAd60oUQ
         Duew==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769429734; x=1770034534; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=467gqcHqnIQ9VVwNI4wTrt6UrXfdyjXK86YLFCrFEFQ=;
        b=mT2cgmy5IlA5o9pe4yQVrBhIEKnh22HLL3tGyFS4757p142cD4qVAoFvM41eDVJwZ2
         tww1tyH9KJz3wBlW3ZcIz+9ELTR1Dg6jVwrFrKEnfX90lnEpqrC1OOC0BKwY88Q2IhLU
         uNmgvVzGYt0b6vU+vPwJD8XRV2hHfGwZH5OA7lhAXx+7dTrJ0NxKdHPbyxQU+9J/Md8l
         fm6JdH4WMghOLpMA9W91B3N0iVDWoBUKcsraVnbHzvcavlurKMSsTQ624QZEvF34doUO
         q5U964u6y9BOHo0jSlE69/6JbPVHjpjWJd0AKkBezdJBr1K/g4DxyapyMrlovmH1JvHQ
         q4og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769429734; x=1770034534;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=467gqcHqnIQ9VVwNI4wTrt6UrXfdyjXK86YLFCrFEFQ=;
        b=Zn8aLN63g+LkNdzXS0McBIZbVknHdpNUwj7/yNzLPh5u2CdGTALsrMAwk6iMjZw7Qc
         rRXC/Cpl+EB3G3VA7wGUtruV+5OWITHQYuamCfSX0w1g5MZDxWPoYVqrZlOVLi04JhMg
         Pb6+ylCgbvhkF+V11077/WaUcvN9Ey5A1Kq2u6+z16fP3xOr6SSgFPSy7aAT4Am0Qix4
         UW99MQDHsAj7BPpFPLGiFaZOMbBA61g5mr3YG9WXzREB7u9teQcqSygp4ImpL0Jqm0UR
         9+oh6xswm39DRDGRAYxG1q35rIVXcKqYpHtubR9bdyN7hvrHLrQDQZJcn1t/z5zf9tio
         dulg==
X-Forwarded-Encrypted: i=1; AJvYcCWpqZYMNTFEFONha30IbIOMByYJ/LwA1cfgM9+uJjQBuUg8WEPqotMrR+BTeZyO2jEZ4T0zAzs9qeeWkg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh63BSslwqldUzlKH+nmE0qcQC0babn+zYvr3QN9KhGcDtujfe
	8gF6zHYMazc8ZRtTqa8HAZ+Nv5FSrvL7muSWXH5DAwapA1JUE5Bw9shO2sJSGXkgxcvbSc5bxc5
	5QNb0Q9vUn6YJlp5YZAF9/Pgq1TNkt/0=
X-Gm-Gg: AZuq6aL0lxJZbi/MS51imySU/IWA/pK7big2JOEowCGUdtnefEpbvVV/fBTRm2ndf8F
	iV1QqRBNFTd33sFshBhcFHuX41MrC/ywyrxcUcsccR+smGuGZB2NNhOYKeJb7Y3H/82J/ifSLqr
	DDl4zf1Ii1z7qcaGbWxh0iruSJiUi7Hc2oXcIxPiwCfoYlluP9GDcw9Gbn2K2oG7szbtQEUzA6o
	hmjdhFQd07QdSOh9w9aTAfEP+AspVGLEHRK2Kv7f9H9DbpJNuOFP4SUyWrV7E3dmtWUmoCk667E
	7Y0j6Yw94tJBqYQl9pLM08KMV8kx3MScIYDJf/gkfRNhNcIKpBlEpaPPHBEXqHw5QA+zUj07Qu3
	hvi+Jnr8iWj02
X-Received: by 2002:a05:7300:730c:b0:2b7:103a:7697 with SMTP id
 5a478bee46e88-2b764828e58mr995313eec.5.1769429733882; Mon, 26 Jan 2026
 04:15:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260126081744.781392-1-pengfuyuan@kylinos.cn>
In-Reply-To: <20260126081744.781392-1-pengfuyuan@kylinos.cn>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 26 Jan 2026 13:15:21 +0100
X-Gm-Features: AZwV_QgKhnNNbMKQO6XKgBIfpElvwvwX8oVrlUj8qdRiKJuHYG8VHhtnfvBlY5s
Message-ID: <CANiq72nNRh-yx7Tts17kJ1M=x+ML=Uk663TW9HN6HnARrg5J3g@mail.gmail.com>
Subject: Re: [PATCH v1 v1 0/4] [RUST] Framebuffer driver support
To: pengfuyuan <pengfuyuan@kylinos.cn>
Cc: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Helge Deller <deller@gmx.de>, Hans de Goede <hansg@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Lee Jones <lee@kernel.org>, Sam Ravnborg <sam@ravnborg.org>, 
	Zsolt Kajtar <soci@c64.rulez.org>, =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 26, 2026 at 9:18=E2=80=AFAM pengfuyuan <pengfuyuan@kylinos.cn> =
wrote:
>
>   rust: io: mem: add ioremap_wc support
>   rust: device: add platdata accessors

For future reference / others, these are essentially the same as:

    https://lore.kernel.org/rust-for-linux/tencent_63DD850B43CC086844717B73=
C574B8358F05@qq.com/
    https://lore.kernel.org/rust-for-linux/20260109080528.478731-2-pengfuyu=
an@kylinos.cn/

In general, please try to mention if a patch was already somewhere
else and add a changelog to understand if feedback was addressed.
Otherwise, others will have to do a manual comparison.

For instance, I may guess you sent this as a sample user due to what
Greg said back then. But that is just a guess, since you didn't reply
to the feedback nor mention it here.

Cheers,
Miguel
