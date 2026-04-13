Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9395D23A561
	for <linux-fbdev@vger.kernel.org>; Mon, 13 Apr 2026 07:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776066852; cv=pass; b=loAAMvVw+Pm47TY++s6MEY5wfAmE3PIEqt1bHlePsXBHbQh9I1FycBZBZbPxrc60PVYenm/Pcl3tjizOpl7fA2uTR+H/MLYgZY0Cu08f5+mGd0Usm4MiMt/QaMNDiJOwahK+SbDGLG/tDmg8JU69twoD2k4PjZ86aw0XvjQetjk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776066852; c=relaxed/simple;
	bh=BwLGd857a8/Gr8I9fhUqP7Q69S/w4GejNer6yC2hMY4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ol0TuUgSPNxMJY649ABMezj0/+Eii24J6O3GZ599UbCKlGRNV3wAstARjX5oV8XnSm0K7cfJ/WBOQYDEIS2IY1hbEFH3HKw91k4amCoYE6QqT9groJ1RzY8AUnprjAp7F9jB3sdnOyL4N3Ptnbg22nL3xG1IpWkkGSp4FQ+t0pE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CCmNZceP; arc=pass smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CCmNZceP"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b8d7f22d405so611603666b.0
        for <linux-fbdev@vger.kernel.org>; Mon, 13 Apr 2026 00:54:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776066850; cv=none;
        d=google.com; s=arc-20240605;
        b=FSVKntpDVP3BjVGky7tVW50ShnmN5sQ4GhNfqyfu2b0s1TzYFOfJIbw06P06KcLY4V
         XKSkWREYidzUSzpYLkUiPAu/VPwb+yC76y4vzU51669KHip42S7vL7vo/envEcQHKgMx
         xlJEP4/iBl1NioFNjgn9dNECHpTsBz9eoUA1fe+5W1RevAcTe8d4Di3FL+FIwUgJfgEj
         5+734qOHX5w7oB0jlOkTe2UCiyOVyIe17CoTVem4ybPn/eyV+Fyfek/BszKaRJpHWqbl
         yU+sQhF7/CZRNqqDahx4wtCHxLqdlna4Q4EOZwHaiPcldrEl1fMA42iWJxG3JoOOSI89
         kp0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WF2eIKkja7dyHhJJwMsSuEwqCgvKiY7IvupflJtjz2Y=;
        fh=qBqNgTWCCf2o9/sAaJ4aMvQHIte6PZL7hZ01fAUpmJU=;
        b=LUHc3RBAkkv8lRzY8n/EM1Lw36cRigsCJMQryovy/lBbL/Xx2E81+UBCtAoDYrMngG
         WZyuXu4uvWfuM6kVdpKr6qBtU+SYrFiTeBWj7QxVBP2GwiO2rdaT5NwYtBPB2rtBN5xZ
         AdD9B+ARgNkJEhIYLM2RpmgqxddKsv3OZVC4LC7SDGQNm4cvvOqwwQNbzi3Vf65tdsm4
         x/ToE1pNiK4L5J0UvTvy81QoZyxzranvUpgSGA+dMnv9Hx6Qx0wWLFtm16AjvXs5Wm73
         tMqbxz/u8IW5bm//ol13SolQmU3/zAs8bqRFDj5s0X3JW78YZFrZAC2cZNVexIYoMuvj
         zH9A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776066850; x=1776671650; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WF2eIKkja7dyHhJJwMsSuEwqCgvKiY7IvupflJtjz2Y=;
        b=CCmNZcePWVBeEikwDTbPLHppviif4TxNEs6sIIvxxAH18X0EhT2m47+8xlAQ7Jplp5
         68ibv5JIR+7Aq9mDkUUJiOBttv0LOTS87x7XRsWr8LQoihzUPIBLJLRu4A5Q1oJCONz2
         Q2iebFJ5KEbpP2wl+oaoeiYP0v9J3f6LIImIHRUS8ca8W1zGAGXEoE6gbcVAnReRq15Y
         O3X4ZJsO1OZw9yctwo0xQ4rkMiL+zFJ/1Tof2BklrGyc1qc8QthmoAfe8RxbAsBo2h2Q
         QRTUta9bg6Tu93lONjFfeHOeIrE9sjpZdxzj05mLR6Yg+vVShBHz59WdxIOoO0O2sSig
         QKIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776066850; x=1776671650;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WF2eIKkja7dyHhJJwMsSuEwqCgvKiY7IvupflJtjz2Y=;
        b=QQ4bbM5Mytq3+gY4s76RLXcAqYm0O7bTy2erCkJa3nr8PB6wQPsjttBjRjoxFDKHRj
         0KpVO+Gqpd04j1zZA9fWrlrErIWkRMcDNMPjxMw/zhUwJNbWD54UeypwV1226iZqQNAy
         bytuJqjZvxQy+A/7Oo+a8TXlNmH/UanOFs49/M79IIhXYghaELvSxh78Z/Ajzbr6EmQD
         w5ihKvX+PSYsI2Uoa+ctSJ3zFE9rYDe5+HyUouaVB3MN1K2y5Ze2RpVK6Fr2cb//0CAC
         f6hFQFrCzboX5igbbLya/9hVgGID3KCRxlkHrYmp34RJEJUVCVxZ2xKLRagV2Y9E6PcO
         DVeg==
X-Forwarded-Encrypted: i=1; AFNElJ9WnaqGd1FNElZkHd/tlIj2c3r6ikDFuVj3wpXsBYnP8hInKw54A7Fc10s5106QIeIPdBrYieSHrrfRLw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwSK3gZoXYtSKzvw6L6qU/0OC9I/9AL3JqZJtEjRWwcRCIJHaO6
	wxTSAgnxQIYKF6OKryl46KU6ito9feuyDwVWDHGB2KsV7qfQss0Grb27MUoWQUXgeb6JbA4aBQN
	wUUyT54K2YlYNwxPA5vQz8CmIyw6bhxw=
X-Gm-Gg: AeBDietnElTtztfF60zUPcFjan64nTotVZ8GFxy2IZoiTB2gD/oHOJHTgSGJfPa0rcq
	nGHiGCKQkcJutNZ9TJmHMaSApWwdgdpX6oEZgMPJ5PxdHaFTdU8fzFR+jX6T5yglhGChTbJSWVX
	wSutDqoLYhGtUSI0yg4Njoa5cE9V7TkxgNt5fX3K0t2Wum5rBGX7hJCgvhcpbgw0nCpQLceGUMz
	Zs1DWhJ6c+Ep+lwPBneqlmGxTkY8EQ2smayFCAz91x6UWXAcMGNpDbzXE01kRNEyqE157bk8OhQ
	q2uJwvRYArIFB7d6KgkdvRO0SeA+2M4lGaV2OQe5BcMKsFmCrcLgfWn6zDz117HrH8tpdRTMAzL
	TiA8A08w=
X-Received: by 2002:a17:907:9615:b0:b98:6984:6627 with SMTP id
 a640c23a62f3a-b9d729c0986mr635516166b.40.1776066849676; Mon, 13 Apr 2026
 00:54:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260412144552.18493-1-mahad.ibrahim.dev@gmail.com>
 <CAHp75Vdu6pih=NqkYT0CR_oLyr3YgNKBeqYM3+naqVp52UCgVw@mail.gmail.com> <adygIkRhnsGv-LwM@stanley.mountain>
In-Reply-To: <adygIkRhnsGv-LwM@stanley.mountain>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 13 Apr 2026 10:53:32 +0300
X-Gm-Features: AQROBzCmapfAP5XxJL0BZHSYMWhRjgPMxX-DCGpXJHZVAmXSTow49ekBVs85ec0
Message-ID: <CAHp75VcZU21syEY7rx9BsvckKq-Tic259xPghetPad-gY7kDng@mail.gmail.com>
Subject: Re: [PATCH] staging: fbtft: Use %pe format specifier for error pointers
To: Dan Carpenter <error27@gmail.com>
Cc: Mahad Ibrahim <mahad.ibrahim.dev@gmail.com>, Andy Shevchenko <andy@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Shuah Khan <skhan@linuxfoundation.org>, 
	linux-kernel-mentees@lists.linuxfoundation.org, 
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 13, 2026 at 10:49=E2=80=AFAM Dan Carpenter <error27@gmail.com> =
wrote:
> On Mon, Apr 13, 2026 at 10:03:58AM +0300, Andy Shevchenko wrote:
> > On Sun, Apr 12, 2026 at 5:46=E2=80=AFPM Mahad Ibrahim
> > <mahad.ibrahim.dev@gmail.com> wrote:

...

> I always like these changes.  I wish that there were an equivalent
> %e which printed error codes that weren't stored in an error pointer.
>
> KTODO: introduce a %e type format thing which prints error codes

Never happens until it becomes a C standard.


--=20
With Best Regards,
Andy Shevchenko
