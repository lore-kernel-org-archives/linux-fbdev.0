Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF1D3EE1C4
	for <linux-fbdev@vger.kernel.org>; Wed, 10 Jun 2026 14:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781102470; cv=pass; b=E1SNIFQSaAmJe7ovgDfHGPf0w2jsC4fdFJH+iGs5TyJNI43cXfC8bU/v4hBZzgGHaGCEvBZXyWLScidLi6SpnDdjCqAwwmOUyMy8k7iq0B2MX0xpBmqfD3ZuKCxr3+/d8KxoLl3Ule9kYui1DqwZj47FavJWiVgFu9YXUl7Eg6s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781102470; c=relaxed/simple;
	bh=YCrTVgxtNb3/Puhd+VuNFi+8Y/zMnTomZfUQA67oTaY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r46Sg7KzTrLztmq0sp8ETfEdgGekBhybmM69GYUwiLPZGa32B8MJrRzEE+hg4KZt3/Toi2PXMsfrl0RrpMDo7rXoyCYBiiE9O9Xud4cZryEjMjRDrkAvDsdfVxkC57pNXghkdE1DC4bqK4XeJFBqQyjz/a4t55Nj6rLOkaaDLA4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vgfd9sSR; arc=pass smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vgfd9sSR"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-3075ce9c05aso906286eec.1
        for <linux-fbdev@vger.kernel.org>; Wed, 10 Jun 2026 07:41:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781102468; cv=none;
        d=google.com; s=arc-20240605;
        b=UqdqSexU+A4vx1To2CRIuojz8/GmQtKcAPmGKr7KigLVTzcCPmNDVbl5swumF8F3Hu
         IKHqlOYIE86TV+Td97wnL9jy9xT0SbxE5RaeRCMWN/gXyjuV6lDvdplyl5nztT/TsHRz
         rg+3q0WH4AAzwlOGAC4JVlHIiw0FPBLlmxdkAs9U2BmBGIdiZYaO82VR4wlMrzEV9PZ/
         W+akc1YU69LT0C6m35fo9LuabFnTMw/1o3Pg2CnkcQR3tF/WSwW1KSw+0qKrmCfT5aXF
         mJSwzuMIjBNRC/9Y+GXSMBUM1AFR3qYOAd9HVbRxdfAkeClgn6JuWLQMwg3dfiFMvPW2
         hGgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pji6N0wT5lk6iw8ewt/c1NaXvzId0tCzXut761rthuw=;
        fh=O/BESuS+YqxdHt3laHxAJcKK93KrhslVWnYGXnRMxIE=;
        b=cVSAqa2GwqVZv6AnoNlRIyebxYUTo6appYqS5YiwEnYrMmkdFWqhttzDjm+t0H8RKU
         JBkhMg5iVOhwdcWqjrR4godYQzYLmlZbEG/Fz3IUtQmC0D8iu++/UvX9wAMndHvMXeqe
         Dr6PYPqlHGnuW8lcP8JcE87YAMBZhk0NMZh8h8eAynKn0DIFrMdeyBJ/LVY+p1U4Dp/V
         PXOBvRnK8JDHSzg7/hQKrV2RTsuwN5ZJNXDbLvkkM2HzbOyqWxNZW64b+x0RYbKjo4bK
         bR6B5OYOebANZStPySf9mrHGqYmJUo/XrkRvzuQH/oXdsqVFO2WoOMSZ2/gmtB1nxNdU
         Uk4Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781102468; x=1781707268; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pji6N0wT5lk6iw8ewt/c1NaXvzId0tCzXut761rthuw=;
        b=Vgfd9sSRIbk1PrSD2RgZpjXEoLqyOM46SOXwm3pspFkanQeV9n4y9HO3MvedRjXjqp
         1BEJVCKeyVVosa7InrIRhm67iKI1RCYWa3VzvMhcsCn/o+mxl+hbkJA9I35rZnf3TQqB
         E94GRyTNSV7osQqRMsmZ4gGekB25epjLVtln5NyyHQa/cDxTACpqsbMNayM3ogwSC+Qb
         wU16SIHJ5PgnE+ZYw2e7jrEvLZ/nCfJR3BwECDoUF8nZRovd1AH5ZaLjh6V8w4fR6/S8
         3qnVcvY40ulWhMRJpyG6Q+sjQjcYiGizwIq87WzPpfnVodfSbOk0aqZBSRpmZUEeD1G8
         4RZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781102468; x=1781707268;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pji6N0wT5lk6iw8ewt/c1NaXvzId0tCzXut761rthuw=;
        b=pFsgEcSDX5saWVyWK+iyfJq9wljRbES0rtJTC6V11fBQvoCandEpsGm2zUWS8jREV5
         abslQnlAxuym/DB3s+J5tNxbHLmIoz4DyHU4O7q5X/P2g7/WDhjMU1quI0Cz9SYp7dA8
         hbpGqZe+ifnftXRgO84mrw2dckOG7jujxmVZYncJGStlTjjXI1krL9R0Xi3WIcKzOM5v
         obKDnXNfR/KVF1e68r6byfzVCw8bTuvj3cQy2uC805RtrlNiIurG4YUhEKEjnfF36Yi1
         tlOlhRQEzg++AoISjT3GiCTfjOwnAfV8PHh56DWo31IskTCwAOrHnZ1hsNPO8GSqMrWC
         sVsw==
X-Forwarded-Encrypted: i=1; AFNElJ+ipdVxtXGMQt9mntHN+yfJUzg8ai+57Ye56tnUDNqA/0DqpwWnNdg7TTyVKbh3WvGfHyAVb+icR1katw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwQi6L992/hGKfa4FovAGOWs/UoIaSB2NQtXZJ5eprK1yE2a4WV
	YExk2Il1CD6DQ+jO7n7ddUWB+KgEjLmIdFxweIQZ/zPcZKZfDYhZ+xh/tMNYkNAh1MlDwbiZfCS
	fqLPSDsUr1FcgPlB/SI+McfwPE1DiW8Q=
X-Gm-Gg: Acq92OH1abwYjw/3gOu2407rt0/E78EaCWRAJzuohgqeUX2rwD7lBOa4yAoT08fOjiM
	s1xHd7j3pujno8/zo9ejAtofTmR103O2HX4f1fh+wUhPwiDzaYX4CLXwfob+Hqh6qZsE+7wIlRF
	bLH+TN4Cd8wPJYCnAfGFDh398M6LnAUGhMaWYbYO+aSBydht4NEud8b01aU0qLlzzKjr2J1qkob
	TTetAENZWYl4YOunO5D3ReC3QiSgVOFoA3fJopGylc2it99nmNS0I7HV3IbZpcvFfqPit75dmqL
	HhVgC/mjVkqIWYqSrh4=
X-Received: by 2002:a05:7301:678e:b0:2de:c5ca:c1f3 with SMTP id
 5a478bee46e88-3077aeef992mr17016589eec.4.1781102468242; Wed, 10 Jun 2026
 07:41:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260606045738.21050-1-clamor95@gmail.com> <20260606045738.21050-11-clamor95@gmail.com>
 <aihm315UtdqJclhh@ashevche-desk.local>
In-Reply-To: <aihm315UtdqJclhh@ashevche-desk.local>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Wed, 10 Jun 2026 17:40:56 +0300
X-Gm-Features: AVVi8CcyvQrrDJA2ZF-oz3jxiSwxgRbJF6e_otLwcACmPvI2rKDir5j4hVf0fFQ
Message-ID: <CAPVz0n01ymfYGH+_MgfHvWqzg+tczLi8E-1q=rZ5cHu+uJrpdg@mail.gmail.com>
Subject: Re: [PATCH v4 10/14] mfd: lm3533: Set DMA mask
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
	Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Helge Deller <deller@gmx.de>, Johan Hovold <johan@kernel.org>, 
	dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=B2=D1=82, 9 =D1=87=D0=B5=D1=80=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 22:17=
 Andy Shevchenko <andriy.shevchenko@intel.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Sat, Jun 06, 2026 at 07:57:34AM +0300, Svyatoslav Ryhel wrote:
> > Missing coherent_dma_mask assigning triggers the following warning in
> > dmesg:
> >
> > [    3.287872] platform lm3533-backlight.0: DMA mask not set
> >
> > Since this warning might be elevated to an error in the future, set
> > coherent_dma_mask to zero because both the core and cells do not utiliz=
e
> > DMA.
>
> Hmm... I am not sure about this. The entire kernel has only two drivers t=
hat
> do that, and thanks to their commit messages one of them pointed out to t=
he
> commit from 2018. So, if no other devices suffer from this, I think it ha=
s to
> be a better way of achieving the same.
>

If mfd framework warns that DMA mask is not set then this must be
addressed. Why then there is such warning at the first place if mask
can be just skipped. Then warning would be just a debug message. What
is warning today can become error tomorrow.

> --
> With Best Regards,
> Andy Shevchenko
>
>
