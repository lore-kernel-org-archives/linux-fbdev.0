Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E512D9798
	for <linux-fbdev@vger.kernel.org>; Tue, 30 Dec 2025 22:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767134599; cv=none; b=mLMm6vrm+ZCSVV8GdlDuCuXAI6RqAORqFmSubAIXO7niEPTxEld9KLc7noJHINRSdAjjwcEpcrDuOKiU8mA9mFjYHyY3jr1Yj0Y/K5w0nF1wjHYDcpVXGHaN4lgCDohL6+GBU3mK+0YYxXqNbqiv0rAFb7ZJWC4n66KVyNQGbCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767134599; c=relaxed/simple;
	bh=9mEi6OrHM82M1e0Eu4BKfGlCSswhhgbyi6wTYu1Esdo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e9x/Lzw4MvTD1y5+TF7fo4Dd2gN+ELPpN/xr0LXPhwAdNA2h+yrZN1cuhm4Lb5mjRNaqcztXtvN1EioryfixT6SPPkSoFC3nE7BoJgb4nB5/IR7ZA9qUtYEiwrLJhCeU21RzjbxhEtCMqujEwVj1ub1EyCGmgm1DvMYWHxJZBFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PAg5++er; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PAg5++er"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-64b83949fdaso14156134a12.2
        for <linux-fbdev@vger.kernel.org>; Tue, 30 Dec 2025 14:43:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767134596; x=1767739396; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9mEi6OrHM82M1e0Eu4BKfGlCSswhhgbyi6wTYu1Esdo=;
        b=PAg5++er65WS9XxvwSqI8vU5Ei9DZ2ee4hp1LUGGnmc2jZNXAPLR7coXt0b/G3L3yV
         nyV8UJzcGetCTEKtLWahDfzGtaLZNKn869cJf5jbkfZncAIannxQpy3IK0wFiXzkN6Fa
         aqUJz6DxavxE4PcCXu168uImohUIhai8eAttJ3Q2bdlcEbrowqaqcCLB/PGiYnJ3gGME
         ZraCnBDCDShBa5uLsuQL/Vr2cBv8cTSQkNhJbDxKK/FiNo7xu/qWmcg2QUXtkzdsegeZ
         yIR+5tegggkV1fjv2waDstCN5xgArYM4Op6vtTSX9DPtUVi+cs96n6JZ47k6TLyeWRxx
         uLNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767134596; x=1767739396;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9mEi6OrHM82M1e0Eu4BKfGlCSswhhgbyi6wTYu1Esdo=;
        b=Ahu3fUgKruAH9pzKwAAMVbqShYg3yTN+g8WS/08XlRy8vTuiPCoPYKkkgGOReMMpgC
         0OT5MCK/cxU0Zj0y5EjHgjpYmhZx7KrOuHfJWpQmPBqAhf2Z6ymQRdYqhFLfnwOyuRly
         Txtd5yjotGTqOUCh4mW38jkIVyOM22VsCrgrdmpfDJpxq0A8UXol3j29wo/vA02U7Ec7
         ku4e6+6bQM41DwyaCzYue+04JJ6yhGea0Kcv7wLQuQOTqHX+7FOCZmETXbf0dp4Rbs24
         oc6wQtJnCWqBqgB9Od7RgfO9iV+23aWt9d9J4TqtGfXISnVkZGzVtmNfWfAS3dC6p/2p
         qOwQ==
X-Forwarded-Encrypted: i=1; AJvYcCXcCO4Alw8XLCKxywNaXTD4Ecr2xSZZAK+XVTOqgdsingTEQNi/DZW3wCQKqovvvEptIchZ9/WXi7L0iA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzTtObNUvnZ/unAbGt8GRsluKJ742V4Rkp/Vaj7uuBcU+2GWXaC
	rKOUQbspCiAOu+N8P84U90ynkyAtw+tFyRA8+63xyNIUtZXz3D0genxVB+YiShb/hzq0Qk/5r3k
	wYlWgi6KuXY4na6QBzWPepyyfWereoPM=
X-Gm-Gg: AY/fxX4tHS6189jFkAYZSJZJx7UUMmXOIHqaVMARtJ0OLz/mTOdRAWpPZSzG1ku7gAb
	Ba4yBRT5lR0oxmH8Fbk1v9rTaqC4WX/RSBFM1AL8Xcyjvr1p1tBtre/q78Jj430xDl1nLDiUjMc
	CaQ9M+Nf0AxSHiKoyK+wwdEWvd6qRx8r0ue8GV+p2DJ6pMROeoBmMvUxyYTnApxqluJ6dQbEWoL
	vhL4BH5qwUQ3dUOX5NU+g0icF+MS5ePkWeC9W697ssXPbEDSG3NE9mXPTVlud6/7cFWG/+1qq8S
	bUWXIE5a3gm9ULzfN8ylR26Fup72ijyEs0R8P/s8iyU1bUpt1gVXtq2KvyBc6Xg5P/t53QW+bl+
	m98EEZpU=
X-Google-Smtp-Source: AGHT+IFQWfQKkPBeY8y1lW4UgnrOAAMI40g1X5cdWEdu84v+wi5zQgy4ZIJWy0xewaTSwh16p/etDzIVCFjsFTSA5bA=
X-Received: by 2002:a17:907:9408:b0:b73:6998:7bce with SMTP id
 a640c23a62f3a-b8037152a19mr3578554666b.33.1767134595488; Tue, 30 Dec 2025
 14:43:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251230052827.4676-1-chintanlike@gmail.com> <20251230052827.4676-4-chintanlike@gmail.com>
 <aVO5X0NKSdkH6Ab5@smile.fi.intel.com> <081b59e8-e74b-4af6-bd31-00ebb4e12e5c@gmail.com>
In-Reply-To: <081b59e8-e74b-4af6-bd31-00ebb4e12e5c@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 31 Dec 2025 00:42:39 +0200
X-Gm-Features: AQt7F2qWtePPexAYMwq8dRDWvuDOrmxY5lQaE1jMdbfoOaWp8Hbs7ajPSCcSepQ
Message-ID: <CAHp75Vf0n2wQAEt_kfvZKKyjS7VqU3_SvF0vYbYBGikP=7dQmg@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] fbdev: omapfb: Make FB_DEVICE dependency optional
To: Chintan Patel <chintanlike@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, linux-fbdev@vger.kernel.org, 
	linux-staging@lists.linux.dev, linux-omap@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	tzimmermann@suse.de, andy@kernel.org, deller@gmx.de, 
	gregkh@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 30, 2025 at 8:01=E2=80=AFPM Chintan Patel <chintanlike@gmail.co=
m> wrote:
> On 12/30/25 03:37, Andy Shevchenko wrote:
> > On Mon, Dec 29, 2025 at 09:28:21PM -0800, Chintan Patel wrote:

...

> > Still the same issue I pointed out in v2 review.

> Sorry about that. I had actually made your suggested changes but somehow
> I mistakenly send old patches instead of updated one. I will send
> updated one. Should I send v4 or v3 is fine?

v4 needs to be sent.

--=20
With Best Regards,
Andy Shevchenko
