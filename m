Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329713803D0
	for <linux-fbdev@vger.kernel.org>; Wed, 16 Sep 2026 13:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.205
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789564500; cv=pass; b=MZmlrjXo7mFyKOrDe926k5r4N6W5UNk2O7bkzPOgyiqDeppBduEN6PZRevX9GBcD4dUw8kPkB//+R9oWgJsBFSRU7BuRYSZXDpuEOx9qZKNgwJ4Ojmy+cGQO+Eq5Dk3WtacstkVZhFphv5UXKj4b5X9HoEhDmin4jGuuv+Zpvjs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789564500; c=relaxed/simple;
	bh=ayPxym0az/dPYYVwbAryo+qLlPY3Bz4ZHUPUVaRwQrk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iEEA6dKri+GDo0duHK4i1idJ/ZyJWWam20m79pJAFgWq88JdoYS2wJZm5KdOgcVq5wAKgpnqjJHOeyo0cLbk2/NBCBDshejS0grRhZ0H+XlQHkhtbuqG47hYm9ZyFTwFSRS4R0paIWBRLGm2xZJFRWWeB2ZHqGTpkfNk2wmDbes=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JEvexrT0; arc=pass smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JEvexrT0"
Received: by mail-qk2-f13.google.com with SMTP id d75a77b69052e-52fb76bcb1fso8824111cf.0
        for <linux-fbdev@vger.kernel.org>; Wed, 16 Sep 2026 06:14:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789564498; cv=none;
        d=google.com; s=arc-20260327;
        b=NeZgZjL3LW8tQbnWXVu4GuEILFuLUbWbGPemYMeYGzVvnykLKN5DI39uaA36GKOE4D
         SEkKP5vLkogkj4rexZasdeckBrTyckEn5sfjfEy6dOBQOjRuaChnGqgyAUnWRmq3fcQ0
         0L+7j04fYp9YJinhed5fWNmVDVY2/KcxQgVbIWsc0Z2CiZwassfJXshsiHn/E8g7blF1
         zDoZofCl1RbcR1fmmTeub18tmRGau6J/eL5fakdXihhMVmOr5RvT3dJAVbwkZW2qz58f
         veYUra07miiC81jlFx2j/I7/F0Yj9sQDpjwZdc9t+rwsJxTf1dODXZV//ub5+y4PiWZ0
         HK7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ayPxym0az/dPYYVwbAryo+qLlPY3Bz4ZHUPUVaRwQrk=;
        fh=6pYdiMxOJSSVg/fkf2+yXuNMz3kWuRAPquvuXVH3iKY=;
        b=dQzC+lHdx67zDm/xaxhdKErrKKO5yYLQwVA02brD7CCcfzYGpAnNRA5e7f6fxYu53u
         muULx54LEyBR78cfC8OAtHjl/q5UZFbAj2g1KXt6Qd00t51c4vl+pDbsiFKpZFaMhSXj
         QY34tvPNEm0a4ZgvDHpkfjVHK+IcIPOtvyoXGpJx8vQmoldYp9v2tWAxN+icf2nVYsLY
         USuXlHomfXecGknT2gWboNc5PZR8mOOMBlskg8nntryZYQ6VJlsqiooMPKqwjEC/IAse
         X4xlJDRVxQt2CtxdxOCQgLTi6kgwgnF7DArgTVfryVqKqFUHHgo1sCiPqkWDml9I9M6H
         Ajcg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789564498; x=1790169298; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ayPxym0az/dPYYVwbAryo+qLlPY3Bz4ZHUPUVaRwQrk=;
        b=JEvexrT0iWf8PBk47nWDIzana9YQffJnYDN7qes/1AQhVvmTNtFx2uhhdxCDskGUtK
         NDtTlbOR0SsJ5Ady0YtTh9HkrRwtTxzsUv5j7Zd2cJN3dOacuJ7LRo74rPalH89RzT0a
         HN+UZU7Ewmn9ebL7MEt4ejT112dbBr7Az/rcyXmzoDqScCT/oioZ7XrS9vICyLrBrVmm
         rCrpHmCL+k4/La2s2QWaYDmkaiFZG8QR+QREtUp1pR9hz8viXe+cBJmtcPCPR14uNoaG
         o1sH04uNX/qSfy+ouRwan1sUIxr31XAmAeEq9EfYVCH5bxGIoPwQg5R9v2RadqAMGBdA
         Xk3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789564498; x=1790169298;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ayPxym0az/dPYYVwbAryo+qLlPY3Bz4ZHUPUVaRwQrk=;
        b=hP4eW0SJtSGKrDbd0cLNM5q5Vf6lsoCUtF5ACVTxhRs1UNiFCkwSJ/kakNmtT3ohLS
         onpa81lXQKoN+ClYX8iNL5WSzTuZyswBU184vRiEjIYp8S/DdJZi3LhqH2y9UARHiTLl
         fmwx6ZibGb1sqMykJs0EGK4qnRvS3yDTMyBDhI7nWRGaiGBPLIbNc9i5GptIz6+UCzR5
         SJK9RP4/N1Atm/ZFF1oAUhfxY6n4dPfKqrGnzFztf7QY1VZxFDpSE8r/p+r0nKyXxHZ/
         sIoIDqBrG+IThGWNBHkQ01djBaZqfLcK3FTj+aR7LgYMwIlC7J7MzwL8y5tQUFY9kYSj
         IA5A==
X-Forwarded-Encrypted: i=1; AKwUvBzrXFawuEtlRJDTER6DuwScq8zazVGGXzpPQ2SkWVkI9czQKOPARr5ewaSvgbo12BRp0mIy4kr26XMtOQ==@vger.kernel.org
X-Gm-Message-State: AFuF++kQCfFbdYMCEOKnyDcRp/J/I0RIF5z4z7RrYmr5TwHlmpHx48df
	BvINtX/8TL2FD9vQJCVC2vGetrGdpOocvidkrYKe7SbWqG5jBo2xqzdcdaTbCs2opmhimUsriD0
	HvcM+isbi+gwefC9+jz92c1IQ142S0MQ=
X-Gm-Gg: AYBFou1qco3phB0SXRIaEsOhwm6FNUtUeeKsILrFERbhd2xVnkmlnJu1jS5gT0fVgRq
	KrnWReJPikd3wQDE2l7jaHj8KFxWeKV+naq8zIDYsVTKRjT0P7AQE3WZ7HIXsZE9OYcldSh1WHr
	G75gbUNgY7rhsQFKlHfWs6LRxx+XVTo9OhV5hl2DEN1YdpDuL0mgLOSLCtUkEhkuckhGq9WX7e6
	vT3MSnkTZIeozmFkDAQqXYfTBZn+at83b6qWeqTTuBK8rG0bzxfibA2FVoFSNkUdLD/dRgVd2pT
	cv+dkV/Cw5cFPYuAmVzi08psfx+2If5HcNt2KAOmSUT4AOixwpPtEUKt
X-Received: by 2002:ac8:7f04:0:b0:52d:cf85:aeea with SMTP id
 d75a77b69052e-5327eeb282emr41860711cf.24.1789564497846; Wed, 16 Sep 2026
 06:14:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260916093928.52057-1-palaomer100@gmail.com> <87ecet5xos.fsf@yellow.woof>
 <aqp4GA1q6cLKivZo@ashevche-desk.local> <CAKhZXnr0GdUrEu9vyMAWRCWyQzPM7cWQ6LRDa8fX0hnMkTN0RQ@mail.gmail.com>
 <87bj9x5pii.fsf@yellow.woof>
In-Reply-To: <87bj9x5pii.fsf@yellow.woof>
From: =?UTF-8?Q?=C3=96mer_PALA?= <palaomer100@gmail.com>
Date: Wed, 16 Sep 2026 16:14:38 +0300
X-Gm-Features: AcwNN1Vm49ztxlf0ieuaRYYQIq3zlaRFigYw8UrkluaAB1jpWTaPVqREkoTpZDM
Message-ID: <CAKhZXnqBko0LABgLa-A6G+ztt1Y4p6yXdcnGDp7HbC3psv9WUQ@mail.gmail.com>
Subject: Re: [PATCH] staging: fbtft: fb_upd161704: replace udelay with usleep_range
To: Nam Cao <namcao@linutronix.de>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, andy@kernel.org, 
	gregkh@linuxfoundation.org, dri-devel@lists.freedesktop.org, 
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Nam Cao writes:
> A crucial difference is that we can call udelay() in any context, but we
> cannot call usleep_range() in atomic context. Thus, a test run with
> CONFIG_DEBUG_ATOMIC_SLEEP enabled is recommended.
> I don't know if non-deterministic delay is an issue, the datasheet would
> need to be checked. But udelay() is not deterministic either, for
> example the CPU may need to handle an external interrupt while the task
> is calling udelay().

Hi Nam,

Thank you for clarifying the atomic context restrictions and pointing out
CONFIG_DEBUG_ATOMIC_SLEEP. That makes total sense, and I now see why udelay=
()
is mandatory here to prevent potential kernel panics in atomic paths.

I am dropping this patch series. Thanks again to everyone for the valuable
feedback!

Best regards,
Omer PALA

Nam Cao <namcao@linutronix.de>, 16 Eyl 2026 =C3=87ar, 15:50 tarihinde =C5=
=9Funu yazd=C4=B1:
>
> =C3=96mer PALA <palaomer100@gmail.com> writes:
> > Thank you for the feedback and review. I note the line-length
> > formatting (~72 characters per line)
> > for my future commit messages.Second, do you understand the difference =
on what
> > code is doing before and after your change?
> > I understand that udelay() provides deterministic, busy-wait timing req=
uired for
> > hardware register initialization, whereas usleep_range() introduces sch=
eduler
> > overhead and non-deterministic delays.
> > Out of technical curiosity regarding the driver IC: theoretically, if w=
e knew
> > the exact window between the hardware lock/stabilization
> > time (min) and the internal state-machine timeout (max) from the datash=
eet,
> > would a range like usleep_range(min, max) be acceptable,
> > or does scheduler wake-up latency make it too risky for
> > timing-critical init sequences without hardware validation?
> > I will drop this patch series.
>
> A crucial difference is that we can call udelay() in any context, but we
> cannot call usleep_range() in atomic context. Thus, a test run with
> CONFIG_DEBUG_ATOMIC_SLEEP enabled is recommended.
>
> I don't know if non-deterministic delay is an issue, the datasheet would
> need to be checked. But udelay() is not deterministic either, for
> example the CPU may need to handle an external interrupt while the task
> is calling udelay().
>
> Nam
