Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7DE3D47CF
	for <linux-fbdev@vger.kernel.org>; Mon, 14 Sep 2026 10:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789383492; cv=pass; b=Epb0UfLrwto0ax2tDXQKRLjw9rCkU61uq5WeaC5NhyIwyLhqCJVo2AFPkdK4TWdgkN9aKu4fg+HNorhz39QlCw8fGYnhgYcr7OzwrbMdtdKb/0jd4Wgj8rjgZzIzRJfeIP2JvVmH9YvGWLpIiF6XGqhhMEDskFn0Vgzg+i22eU8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789383492; c=relaxed/simple;
	bh=ctSjyms5FYhlDQXWXqeD511TmiPd3o+lZbaQdu4ST1g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=laVLmnIniy77ovfOYgVi6aJp7tr6O40YYF0lQLo9BFBdQzweL1HTWMuygncFsIjpdYrhKxRf0jolGbm9SPZ0+u6v37q/i3Q+K9MGVdUB+1QOCPD4LYm/NgUDujBeDxW9qTgXhOlYa3EkFMMeWBbhxvK2Gaexvf2CpjHQi2MIgCA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g6XGIwmI; arc=pass smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g6XGIwmI"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c2949ed8cc3so508143966b.2
        for <linux-fbdev@vger.kernel.org>; Mon, 14 Sep 2026 03:58:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789383487; cv=none;
        d=google.com; s=arc-20260327;
        b=eZdmJdAyFMMwD4O+CLgP6GHlhKr1KdKSvUd2nl1JNl/nYDC3qbV4fN+sQngZ5l3AXw
         Muik71cN/HWQmmr+YMzJbluqBr9dOVbi0ny4kunCA0kcErLxHLLp5JQtOFrE8s7rrJjn
         mV/0OSyRkQM2Z2DvPF+zrrUo8Wz++B3TXPK3SDSEAVvz5se6j2/D4QcfNnWP1btKDqeY
         s+34VWEPfxqLmLm6ag8XC1NCPPGBDZ9/Ow7QGQ1SDf6XpqksdZDalafhdS1s+eU3ObnW
         fFu3k7D8Zi0BDAWb0p5BQM76grkiLG7EspU1IkS8EhAgPfIaQThg2lHq9GnsAbjaCJ3t
         pHfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7HbvJ559effrX1oZMhom9NMAuGQzZm3TFV5OOXNcnto=;
        fh=y0A+tcxVqYz8mvXlPWYf712Yl7IM9LeUQgrhYPusx/M=;
        b=EmaLQEIU7JT/YcjLWGaKaloO+gyLoyTgiPHNSAV5He3IYU/JPkxrm4tjuQKvXW4r4l
         5Hzy6XPU9/Den5RTFLb8JERUWSJlGpcrDkJn/+Cj2S44DmZDRpdK0eNwAaYz3BwKrEMO
         +x7/H7m9ov6fx5fQXmoB0oO8DMG9LT8cKTwpEEE8Mp8FHfWI9x+7VzZzMnB3H+IDim0o
         9XgDcvOAuyFsUjWzCS+jGQk4c/SPwrj1zDsPOPIll7vEHNOoPoN9ZOrN7MJO6id8F/mx
         4Z6pBTI8qkl2n1W2qqXNdwjrBx3W91Q1krhKc216Y4m/L0bx6G0h02ZbIAdfR22I1QBB
         0Icg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789383487; x=1789988287; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7HbvJ559effrX1oZMhom9NMAuGQzZm3TFV5OOXNcnto=;
        b=g6XGIwmInuRHYFgQAFjZ3yyLFhL9/psdEalBkpeWveTZoV5ttaa+4AnUld4kx6VCwN
         eOlj5FNb/zfxxlNiOALabUK+t+jNsJ2DMKnOrnhx/7Co0aOyK4TKaYk/s4022/o4yY+v
         3gHP/HO2ovlTwUDBlgATdwsYQwyjQirlQS+zxKh88dlYyKlbHlgnVg2+SIe2lHLEQ/fx
         FVcqn5ClfCAaiExtG3z73JosuEr2JDDu+KlFv3stC3Gl39uR1PUHgwmFQ3ZyC7yfFCKL
         i5BJCPPMOqPaiioUaFOaILC98H49zuxttAiL3H7DheHbRDO9ZpHUUK+n2OfWPiFB5lHK
         PaSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789383487; x=1789988287;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7HbvJ559effrX1oZMhom9NMAuGQzZm3TFV5OOXNcnto=;
        b=impbxe7+DVhYh4WVgC8vb7GnUMmJ9C67FrX5kexTsuXP9NcwhkZU/pJrzz/NIHuctd
         INxaFE23VU5fxbegjwBafG8MQdwH4yXtP2LJl+DFA4x3epITLTf3+HLbYoojbcqeuhsr
         HCBfdRywis4gqmptqteZpXoDFlRWbLXZSF8QRYskJRjTDHO5GQhcQLMSimwdKk/ahB42
         MkPQ3l13+VrRUYKjvo621EiLDbcfS4/lVPNthuO4kwuw4eXu6+jxjL+GFgNbfu4+mWCF
         tXWN5Lsh/1b/ngn5YQZGwPWWGYiWypgXPyRFw2RvlbFeOY6UAphoH/Nr8mrESUIDS2fm
         rS0Q==
X-Forwarded-Encrypted: i=1; AKwUvBztPO4PAKg5iBKbFPAggIP8JWFy/FMYzLG21yJ8aFBrkurvohTPcG25lXzHIS+QndHIKUyy0MfBuqA9XA==@vger.kernel.org
X-Gm-Message-State: AFuF++kWLY+SJhQSmGcWy5zJdTaqiPoaLo+2q3br/zVnoItlGtj0je6A
	NHP/lSOmpdrYzLuWW3U0XxIiQBwwZxhf4nKQRMfYbj5FLEiOOujBFhBxN6BwB/LZLMVr+oBFsOC
	Kk3TODh8uE7pVNY29AhDZff9hOHr1D48=
X-Gm-Gg: AYBFou365Yn0yFYuIa00yloMFKkk0PEZHnIhAbxsdVITK0hiiCFubWKM9te4JjZThiX
	n7/Gyb/cQiFrlU/Wlkct5hm2UXKeRuYofcPtEbqVPpE2JIsjJTsoJoXblW9WXK3QFT2iRE9p0k+
	uZC+Zo4K2Uin/G2IZ0aw3T3pZrL7H0eAVEAmhrsEUfnuiD2XUIPgYvnJoqWvbfkTl+6V2Ep3Wgk
	qTGyqLAOIqGG6Qq1A45Lq1DzfgRnBcObOZezq56K0A1PYB7t3f3mc1yVN/has6VSSTrMZtsW5Hu
	aNIgpCJ6tRHXv3M3bWsjeDItYo0MaxOfMRFUlXncMzJF3RkEegW+ZvOK5bFlpkuc4MC2WzCZc7U
	0moyt785ORzPNNOHOGB5I/zrI9zx+Ld/CExlwJmptT6L8x6+x4cVJEzc5+JktPX3a8AxJ8qxNuO
	lUzH6H6hMIiqiWMCL37HrB6L50TztaWXoAb+SBdQD3lXjhdRXLLYg=
X-Received: by 2002:a17:907:980c:b0:c29:45ad:7af7 with SMTP id
 a640c23a62f3a-c29b86ee829mr131881566b.30.1789383486731; Mon, 14 Sep 2026
 03:58:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260914090858.9939-2-manuelebnerli@mailbox.org>
In-Reply-To: <20260914090858.9939-2-manuelebnerli@mailbox.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 14 Sep 2026 13:57:30 +0300
X-Gm-Features: AcwNN1UCS4c0mLENuPHDYDtqcMcsoOZID1y92p_Z79HcLzYNNZxrCUfwyzX99MA
Message-ID: <CAHp75VfApqZk6jz0TzQpm8H7qE08uqpJ44_dWdGLOcq8r+y-xQ@mail.gmail.com>
Subject: Re: [PATCH] staging: fbtft: replace number with sizeof()
To: Manuel Ebner <manuelebnerli@mailbox.org>
Cc: Andy Shevchenko <andy@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 14, 2026 at 12:09=E2=80=AFPM Manuel Ebner <manuelebnerli@mailbo=
x.org> wrote:
>
> Replace integer number with sizeof with the goal of prevent future trunca=
tion bugs.

preventing

>
> Signed-off-by: Manuel Ebner <manuelebnerli@mailbox.org>

So far I see only a single patch, what are the "future truncation
bugs" you are talking about?

...

>  static unsigned int read_devicecode(struct fbtft_par *par)
>  {
> -       u8 rxbuf[8] =3D {0, };
> +       u8 rxbuf[sizeof(u64)] =3D {0, };

This is an unclear change. Where did u64 come from? Why do we even
need a 8-byte buffer when we only do 4-byte operations?

>         write_reg(par, 0x0000);
>         par->fbtftops.read(par, rxbuf, 4);

Perhaps you need to read a datasheet for this panel and come up with a
better understanding?

--=20
With Best Regards,
Andy Shevchenko
