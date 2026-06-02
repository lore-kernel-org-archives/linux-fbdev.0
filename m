Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24603D6CB7
	for <linux-fbdev@vger.kernel.org>; Tue,  2 Jun 2026 10:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780395554; cv=pass; b=nd7Ht4kPL7xOhAodLWlUuhQHsXuYoHXVbB3KbjgE8asztlz4TW41rXxMnBqO9W2gvdXCpt5u/ojg656wLCHAEI/32lVnCcWyzwyWC0A/cvVWsRzlrKkbNgov0srOvOATrjhjyiRBYas4yyiWcFITuN7GLzMHMR47UfMy7jcTdBY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780395554; c=relaxed/simple;
	bh=3B3t6ptcOYLW8i15s/yZOStzPGXLE8YErZRu0mWiPrk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nIY6bPJlITMrxPoHBGStj3k0pInbEopzTF/G61dA0VRIQOcVJG7NG2UB5Hiwe2JOe5OxHCjN9W61t1vPrgrZakQ49C7ZnmSGvBhsn+pcxF6/a3PbUjLTm8qd+vWExRJKi7qr+/oEfPr4sR0sm3yUOtfVD3jQlyPslaseEXMlZ3I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AyUwTwsC; arc=pass smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AyUwTwsC"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-304d8e3bb72so7814555eec.1
        for <linux-fbdev@vger.kernel.org>; Tue, 02 Jun 2026 03:19:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780395552; cv=none;
        d=google.com; s=arc-20240605;
        b=JThN/+5cFoLa6+xHYnnXWb8OCTFeMqjoa4FhaKOlAaXO7rHbH/qg5Pt/SgpJPo7Ebp
         JwwdvS5YxeR10U3Zra728oX3BLIL5hDOhBcn77HZ7JtmbfVUB6U3zERR/ZmfMjpupJe7
         B6BisJ/uQl8YDnC8djd6Wq6w4swwi7GXPWPU+38KUdvUdtSubTwKKIs47StGkIzFHX0x
         RepT8CEB1nxedWBVIJJfaZ9Y+taDy6BOfOVqnsSdGC20+y2DEBLDlTuhIhJie3OrSAMh
         5oyJsBJQ+LOjyezp4AJrB0oWHo611mROCWTFcKktYkS0N5vNERH1UAbL8Xa/dukRgpVF
         bV0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+Rz2DgaRr0tqOwLOIkcbJ3/5tQrroNwxRI/2HG/tAbU=;
        fh=jFqyBeWfEhwZbe8YVcPRf1TsZF6U+GJltCAkiwfz+2s=;
        b=bTavC3Kn6TNChs+WTN99LiFJ+3SM0B+qQqF9pprqMyshtAFxXCBdUkVVuN+HctrlWk
         aWwrLq/+29eXY08ZPxYHlzkjD5L9LGLhvGDSM9T2nt4s3higUCn0rCDiEJepwzfv6CJM
         Jg/UAWGQFnoJu3WbGfPqm+hBCnFBFmY9Y/bRG9/qg6VNdv5ddmu6r0HG6Q9CJP1SEMDA
         qfI60x4muLFOIoqtuGkBIJddsE6JvyGaprkRPLZX80GRo8UYQvHgpnd5IlGonlJaHUu3
         e5keErVj2uNqqcfLVIKb/RlP5vUZ8sPYU7seDEEGrH5nyXIGx0Ax3g+7YzsrAoWwXKic
         kymQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780395552; x=1781000352; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Rz2DgaRr0tqOwLOIkcbJ3/5tQrroNwxRI/2HG/tAbU=;
        b=AyUwTwsCHthjP6xub1kYtxw/LI3RE35opRdOgCOuDfMit/QnFgIeUTShTZZIpe7lBF
         qRQWCXiVBDsalYrzAVptKLel2m0TfNtWh7rlB/0YfAa0JxZpFTBMXmCqjgmyp6XYUC2h
         QjJ6fthhtIhDtpCkrreEsYzND+1a/XPf++2mHd6EuNSDjeEjI7/TXRDIJKyO1emHRWQd
         zZIsyiRQ76oy+WEZjmkjDAgD1tRWUqjXZbd+Fs1Ujp7llqA6OFqX3OzWrDW1ZFoisIF0
         yd6l2WV2jaXKT5SEz13bXNf+ZxlWNte7M/NODRmIIqX/pt8TiBLOFbw5Wg3xJht71mBr
         S/Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780395552; x=1781000352;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+Rz2DgaRr0tqOwLOIkcbJ3/5tQrroNwxRI/2HG/tAbU=;
        b=b8SP5cuMj6c9rYHiwhlCUzv26CC1FZR/eYUt+9ada06rA9IvXvnIxoRXS47iQ/iro4
         MC1ro8C9JRzHS0mh/h0J+Ai48VFhoCLSNvAXFD+r5m4Ftges65CQDWeotbHcPOSVcoGM
         WC1orlPP5scxmvOxMCVJ22Z0xVpcxFrxLb/KUWWNFDL6yq/IC2pPAKOkXqxdmuagJhgO
         QivMMJYrDwvLpwLBO2BzC9jfZoHA2AEejQzmpGUlTsf0jJ5Wem+EdMbrH3RzFl/vDeu5
         E91RhOO7TNkzKoX9YHkot7SsUgZ8wvmN+Xb1Tts2HPwQZ3YtYonIgPwbIT4Z7czTzfwU
         dUMw==
X-Forwarded-Encrypted: i=1; AFNElJ/W9kgPQ9XD3apQ77RMyP6PNLDu04AmSO2mRdnEq4v/NaiMfLWxE0QLQf6uZiIXHoiG58rh+cjCSczylQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxyOXdCh+uxbnXpoTDK+IUHBVlfexpCkvq3yDK2vmFORQF+zyCx
	4ms9ur31uJ3WGt3uVKQrvKWK2fH+Ok6xqX+9JAvaUPKScFXiO39r4zK23cEV8oc/JHPAYsfzFxH
	VSkgiYMfrpzuvVg2Wb0Bdq0oR+WSZ38Y=
X-Gm-Gg: Acq92OFdt/l8SikukQe2nAlW+uE4wkAJv8F/2WVt2SvocEXz06ZzFybnY075epUlnlt
	iYOPe5b10YcqdIJzmJhgRAzwaobyntQ7drQ/OihIhRt59YpLMCOnOcku+k5IoNWHes94TeBHlzS
	mBn7NghKB/L9qFbUad+f9sdtZljYhIi7EGa0dxYSE027qMHHpKTICooGDqZdz6nqQcgT43W6OWQ
	MuNLp0RvhO7+7+ylJ6jX24cCLy5nZgW3EtgrJhxdnlLZbxaVa6m1bB1mM9tC40raePd30XxdRH+
	nJJZ4lxZWBfsf1K8n2g=
X-Received: by 2002:a05:7300:6427:b0:2df:919f:ce59 with SMTP id
 5a478bee46e88-304fa67ee46mr6895369eec.19.1780395552116; Tue, 02 Jun 2026
 03:19:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260601151831.76350-1-clamor95@gmail.com> <20260601151831.76350-9-clamor95@gmail.com>
 <ah6PxFtoJUWkd79P@ashevche-desk.local>
In-Reply-To: <ah6PxFtoJUWkd79P@ashevche-desk.local>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Tue, 2 Jun 2026 13:19:00 +0300
X-Gm-Features: AVHnY4KArfWMr0jnHoh9vtR5UqW4K7jQ3330Z8FTAYXvtwkDG99A7ncLjymdKC8
Message-ID: <CAPVz0n0P7Jk17cM2M1zuHZfySo2=Uibr5izwKU2tqiBpBcg0FQ@mail.gmail.com>
Subject: Re: [PATCH v3 08/11] video: backlight: lm3533_bl: Improve linear
 sysfs logic
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

=D0=B2=D1=82, 2 =D1=87=D0=B5=D1=80=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 11:09=
 Andy Shevchenko <andriy.shevchenko@intel.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Mon, Jun 01, 2026 at 06:18:28PM +0300, Svyatoslav Ryhel wrote:
> > Simplify the sysfs logic of the linear property by switching to a macro
> > and a ternary operator.
>
> ...
>
> >       if (kstrtoul(buf, 0, &linear))
> >               return -EINVAL;
>
> Besides _assign_bits() in the below, side note here to unshadow error cod=
es:
>
>         ret =3D kstrtoul(buf, 0, &linear);
>         if (ret)
>                 return ret;
>
> (obviously in a separate change).

Won't happen in this patches.

>
> ...
>
> >       ret =3D regmap_update_bits(bl->lm3533->regmap, LM3533_REG_CTRLBAN=
K_AB_BCONF,
> > -                              mask, val);
> > +                              CTRLBANK_AB_BCONF_MODE(id),
> > +                              linear ? CTRLBANK_AB_BCONF_MODE(id) : 0)=
;
> >       if (ret)
> >               return ret;
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
