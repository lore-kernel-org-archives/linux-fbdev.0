Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA733D5670
	for <linux-fbdev@vger.kernel.org>; Tue,  2 Jun 2026 10:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780396317; cv=pass; b=Em7ANyC9XZz41M2xBzLKAT3+4lE/FR4BwrWDpG98Q36N0Vtlnbr0YY1A/Sp+8pcE2cde27yspusiVlqCzEeR7kIR7SKRtLppGc4NEW1+PFxyd5RP9wfTYOafs6oOjxAD+7Hp2I8l2L8lKGDKuoNg+urNf8VD0Dp8STAZNsG32v0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780396317; c=relaxed/simple;
	bh=FrPJKUKAeNpDp2O8s3b0xd97pGYPIKC59ry1jtVER0Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XTyFvXpxmKYTwwkTxTgi05igA5mvd09iFGIFHoBR+EUwhHQjWKYk/hQaxU2Y1Zsrnu3BNvLyTm0JeQ/BO/7JNC8eWwS1UowD3wwlFXoIg/xhS8UhqQF1RlxCRV9EcVFv8ix8SM9gjkDjqvnGT1R6ugj04dPU6ziRNk9dOHd4b30=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kgdcvLgs; arc=pass smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kgdcvLgs"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-304cf518c9dso7558664eec.1
        for <linux-fbdev@vger.kernel.org>; Tue, 02 Jun 2026 03:31:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780396315; cv=none;
        d=google.com; s=arc-20240605;
        b=NwsJWS6k4xN0HcgkpM9GlC0V6ml9SXTMidfWssqrnjy9irBNTXHNEJsiiBVq0k4WWp
         GTtvxUOisygOfl5kQmGPSpZxfMqSXKRHEdwnZu97x0JVhHwX+UUYhw+xVO7ljRa4rJQc
         VfzkvJpp3yU0Tl25YVZJtfPw6hpNbJQ8GdyP/tCYD0WIJqOetkpYRxe1ix3BEpx4g8/y
         hriPR7V152DzSRL37998o1eCGdaXAxp9ez9GdNYJtOeQmqyFeTmqtxbIzPHhZSre43sg
         xGpyL39UMaZ7ip/N72Ac53ALRZFq5ufmoDkNywlLFWkRAtwO203h/+fGHWFJBf1b26sG
         unAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lDdI0YPykfuK0xhOe7sArc4RNqAa0Hyds1kbH01jcws=;
        fh=QmLkRU67J+dFkJYas02pJ0BVufNW8if1Y3CQ5mjige4=;
        b=g5OEb/3Aa5uN/xIhAreiwF0Tk+ZqWY3XyJ1/DPcNFMU/gj7RXiSo8FCsHPiE4Ea6BB
         3baJ7WXIyLn+H5qiz9ED+tGAoNqK6uaQc2V4DZNEABbYAqlBlcAqJvw+oCTUMlL55DjT
         gnKz3EORNiLXgu5PEETFS0Oxkclf7KNEIsYYjynYFFiVBUJP+6KmfQFE1otttndNiGfY
         dnHBt+7pGWLwk5ezg2d/6a57e+Eph4xJr/t8tANLPb7a9ew1QSBrofkAJNSE0xDYwXa2
         2yMTp8IyybMlLpo4/MWeRKiDyjfgWYTVZEnSAidmfL9xO8u/+nwTZZq0hXw45l31mWnQ
         BRgg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780396315; x=1781001115; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lDdI0YPykfuK0xhOe7sArc4RNqAa0Hyds1kbH01jcws=;
        b=kgdcvLgsZ3uILaWfcIBvtHl1005DoEY8tGo67hlFEfjapWwGze3khJCdXZVrRKnA5h
         37CEtBPX6b8X0AaK1mntR77AtOfQ7CnhjfrTLJkgB7WDAz4Y/g/BYmJIegvqnORr9bq5
         n4OWtbMTtq/mjZcJIJcbF+jusrW4PmKgWNJhp8HOEGxYqPKN/UJEzHEriS9U5IkVSd/X
         a+n0v00qp7WOv4PuvEdollon2e7UV0qZEw4J8/TKa/gk16Yk+R6ZtCJeo0qvmGh4xIYN
         My3s/VQXDMREfLQ0j0hnhT0u5c0lkmltuEnWw+FvVO2NdGut68L28anjbQPSB74A/WSt
         icGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780396315; x=1781001115;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lDdI0YPykfuK0xhOe7sArc4RNqAa0Hyds1kbH01jcws=;
        b=ordgBH0YwI0wWEeVvBoIrWamjqNcMYdjXCzOkkjNgSGTdW6GF0eYgUBMCR85ql88oa
         NNuC4REttHeDNcwKloDpwHuSilUSyFQ32Du3VcSBZSNhxDLqoMb8Q8IJGOH4s+eWwgFD
         vFwBlgmwLHZejXdrcJq7s8u/4uDOAlgDxwzQarn8YnbNvRjh027C0DK7p6tCneo+akUO
         13P9kL0+2KHNTN9HQqPTV+n/hDWbq0JEJAZQDJIHTjHLsTfIe9/A2SAUAmEsRkb+edd7
         WG24R9i6bdmJn8xTUfFt5Jd5hT2gwOEGQWb1xcPeehUBXcGNFzZPAHw9DX8v2MiRzyvy
         NQlQ==
X-Forwarded-Encrypted: i=1; AFNElJ82TTXvw0pshJS4MHX4fqB5rxrFHtd3u9w/suTYehdLiw8RNFQE3GNLid9a794LZ9OJETpao5tILGw4Pg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwdRsoZeL8VzNSTBhzM90DjW4Xqwq4p+YnQ83pn3Xva1bV65VyW
	lK1b1z2UPAcX/e0VYl21YK9Ue7gU54m5Psi6aRtpJ7a2wKUJ+3hhmAt2RUZ2MkgisaxjsuwtGTf
	Otmazy3kgDJcOJkHcJOkykvUhJ0f+vv0=
X-Gm-Gg: Acq92OFrcLaGjB8uToJ22Vg+LAr98T53YD+B2LoO4wlv9uhUD5LB1ZyoSno46ntblYh
	4NwLyRvKiDIC2a8Nf0IC55ZGZjUPra/PB5j8CKqYeAhlf9MZB9/faajBOPTRGdZ99T9K3ENiigW
	K39pZ5hl2Itge1SvA3Q3b5tFA+qJGUxRfRDi75Rl68DGnBJH6JoSdlfuQ7gLGu1DjTQ7QZY1vGI
	gbgtJULRaIRMg2G49B8CYJoKW9ir2IKNwusxTwZEZ3fn3CeBbclLq63J/XkdGJn/AR+Lf9OtrJA
	sUXzgehxlByOI5xYILLww8o4EZt8lw==
X-Received: by 2002:a05:693c:2c86:b0:2c1:7793:7bbb with SMTP id
 5a478bee46e88-304fa64c553mr7093613eec.27.1780396315135; Tue, 02 Jun 2026
 03:31:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260601151831.76350-1-clamor95@gmail.com> <20260601151831.76350-6-clamor95@gmail.com>
 <ah6TGjRNnDpQGO60@ashevche-desk.local>
In-Reply-To: <ah6TGjRNnDpQGO60@ashevche-desk.local>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Tue, 2 Jun 2026 13:31:44 +0300
X-Gm-Features: AVHnY4LWQiJbbknL3YlvePeYbIxJnooafI1v7YVQtfA6307ubpWpYRL37q4rijM
Message-ID: <CAPVz0n21RGAaJc1sda4xyp1h0z+6R6FJ4=XWdOtB1mgtV8=RUA@mail.gmail.com>
Subject: Re: [PATCH v3 05/11] mfd: lm3533: Convert to use OF bindings
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

=D0=B2=D1=82, 2 =D1=87=D0=B5=D1=80=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 11:24=
 Andy Shevchenko <andriy.shevchenko@intel.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Mon, Jun 01, 2026 at 06:18:25PM +0300, Svyatoslav Ryhel wrote:
> > Since there are no users of this driver via platform data, remove the
> > platform data support and switch to using Device Tree bindings.
>
> ...
>
> > @@ -57,6 +60,9 @@ struct lm3533_als {
> >
> >       atomic_t zone;
> >       struct mutex thresh_mutex;
> > +
> > +     bool pwm_mode;
> > +     u32 r_select;
> >  };
>
> Have you run `pahole`? Does it agree with the layout you made here?
>

Noted.

> ...
>
> > -     als->irq =3D lm3533->irq;
> > +     als->irq =3D platform_get_irq_optional(pdev, 0);
>
> > +
>
> Redundant blank line.
>

Simplifies code perception, whatever.

> > +     if (als->irq =3D=3D -EPROBE_DEFER)
> > +             return -EPROBE_DEFER;
>
> What about other error codes when IRQ is found by can't be retrieved for =
some
> reasons? IIRC we check against ENXIO in similar cases
>

Then we treat it as no IRQ. Original implementation cares only if IRQ
is present or no.

>         als->irq =3D platform_get_irq_optional(pdev, 0);
>         if (als->irq =3D=3D -ENXIO)
>                 als->irq =3D 0;
>         if (als->irq < 0)
>                 return als->irq;
>
> ...
>
> > +     led->pwm =3D 0;
>
> Isn't it 0 by zalloc ?

It is, thanks.

>
> > +     device_property_read_u32(&pdev->dev, "ti,pwm-config-mask", &led->=
pwm);
>
> ...
>
> >  #define LM3533_BOOST_FREQ_MASK               0x01
> >  #define LM3533_BOOST_FREQ_SHIFT              0
> > +#define LM3533_BOOST_FREQ_MIN                500000
> > +#define LM3533_BOOST_FREQ_MAX                1000000
>
> HZ_PER_KHZ  (since you included units.h)?
>

500 * HZ_PER_KHZ
1000 * HZ_PER_KHZ

You meant this? Sure.

> ...
>
> > +     nchilds =3D device_get_child_node_count(dev);
> > +     if (!nchilds || nchilds > LM3533_CELLS_MAX) {
> > +             dev_err(dev, "num of child nodes is not supported\n");
> > +             return -ENODEV;
>
> Why not dev_err_probe() here and elsewhere? It looks inconsistent with th=
is
> patch.
>

I must have overlooked it, thanks. WDYM elsewhere, this is the only occuran=
ce.

> >       }
>
> ...
>
> > +     device_for_each_child_node_scoped(lm3533->dev, child) {
>
> > +             if (!fwnode_device_is_available(child))
> > +                     continue;
>
> Do we need this check?
>

This is nice to have if the node is disabled. If we assume that there
are no disabled nodes, I can remove it.

> ...
>
> > +                             dev_err(dev, "invalid LED node %s\n",
> > +                                     fwnode_get_name(child));
>
> %pfw
>

Noted.

> ...
>
> > +     ret =3D sysfs_create_group(&dev->kobj, &lm3533_attribute_group);
>
> No way. You should use .dev_groups.
>

I did not change how driver does this, just swapped lm3533->dev to
dev. I will set is back as it was.

> > +     if (ret) {
> > +             dev_err(dev, "failed to create sysfs attributes\n");
> >               goto err_unregister;
> >       }
>
> ...
>
> Can you think on how to split this change to smaller steps? I believe it'=
s
> possible.
>

No, I am done with tinkering with this patchset. It is broken enough
and it has inflated enough.

> --
> With Best Regards,
> Andy Shevchenko
>
>
