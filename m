Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3432FFF90
	for <linux-fbdev@vger.kernel.org>; Sun,  9 Aug 2026 21:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786312055; cv=pass; b=XmPFQ8Juj5A/16ztyczuHAE2DV00irPV28tN+sQuXSKeDGRQHREN1kOdcq2oDscS6BfIJgJAjVC6THWAIkGNwyMn1SzZgu4Y5VuOa7RFzasdLJJGAdS0QyD+fcL9Pqkf4HXOdPVNSea/WYDjlh960lo/71JaAM6dstkRVqH3ipk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786312055; c=relaxed/simple;
	bh=y1udmsBEzAQtkixw39R/oiQFVpMr+tk/0BM/vlqjjHw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fhypND1eCH/ixvDQ14c0gqwv444el98rcRpgu/LiyH50T7ZYShWbFSpNwsIem4TSrouIdp79RWjFEI64IfJ0X8jNR1boGOFkc3OeG7kM6EvczlTBzniMZYj4V6RBp8tPPZHNjicE1RigX+i8oQc1o/MqdrAbOCf0ylSD/QNTUJs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SptmK6J8; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SptmK6J8"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6a063d211ebso1360427a12.3
        for <linux-fbdev@vger.kernel.org>; Sun, 09 Aug 2026 14:47:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786312052; cv=none;
        d=google.com; s=arc-20260327;
        b=AX1FijctHGuKTby42xtSZ+TfztWvmiDx5T9T9SiB7IYPoSs5VVvUO2TkB89yZ3aE1j
         FIRmg1HtP563eoaF+0UUkOS3RbaLUG3JiEg1JNopkOcl2+NUbMU8JaXEsD7SlLHs930+
         y7gzO2ap8XkTTwFPS+IpcVnjYH/vNWkMjsuR6vnI2A56qjIKG0FDaPyefZN/sHlCC8FL
         zUZx1xHr5rLc/elsLlekCMvNug0zWSR15n4sVQqEk2o+NETMZVWFmSUtYRqdnsxFbqNS
         sUidFL8HGSwcM5t8rPwksvFe8z+a6xftgM+oeTEIMq59lIXA1oTAUSdVE5nhv4GQiEf0
         q5oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kFa6zcCkY2hKTR0O+eW7i6R9ggV2gSRqn9c14SMG6lw=;
        fh=C+YI0kED4uNhs0BdolELG/10nujK6pggL/J/ZaQAsWk=;
        b=kD+w314LmO7/J33UOsPOXTumiGwwHgx9SfuNjoAjAbcIKLcJ//gm3rQ1o3dPL+nOEM
         dgAfxtfFn/JtUMQ8wBd/26iulhD0WC3eXH6jI/ZewI9FVAh4oxNpZfS2qmpvtEjJbz/i
         qu9Fk6LzaoMurh1YK/aiq8bbfggIUf32ntiRTkhLHerPE38yVPkhCfmxkVOCOsge4BuH
         3GfpA0Sh7otrcNOoTf6AinCBmrIZIxAUoDr2HAf4pfqX+PJKhR6xJoQQrbl1MVPJ1Cw2
         DaDDshHuFwOCBBAHdEmfpzHtDCbOmNgfeInYvKfFfJDcG39yWRQzSjnTHCN2evhL/ZmE
         oAlg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786312052; x=1786916852; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kFa6zcCkY2hKTR0O+eW7i6R9ggV2gSRqn9c14SMG6lw=;
        b=SptmK6J80H4u0YjRuUn+UWrZLYdNILBlIyLTGcH54BP5NF7eVpLbZ7tLdNk+xSuwe6
         fZ+rw2oH+YEUEZv6Cslbor1usE4IYugU2i0itFAggZ+proV9ZsPYcwnNSXIhRGAm39+N
         45WZMicJKeBCKD2aZy1C3sCh6j2VK3+mrWIeHgCAkIgz5w9nYLh8hXQ2wWi0Kf33S/TW
         Aj/5SWFFz0gW8TeEW6dnH6mT7foMeTdiFT1EyQKHE7RuA3WB24WU5uP3nlNFUkLxbNdl
         tf/6rc5ZC8JZdMGgTqDY09/rlksTBKtxVt3MBVAdLEIkA8ZoeUbZDoLYZKoJtg/+USTi
         mYmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786312052; x=1786916852;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kFa6zcCkY2hKTR0O+eW7i6R9ggV2gSRqn9c14SMG6lw=;
        b=VZbdLibX/QUK5nExipLO3+ZKqzzUPSoMD3c9y7d6bpb0PHUzxGu1ADi6qzhikeSEK4
         B06buJ2e73GLK0CT5cZmXJmrbOUhK2nFbjewv4RpG2Tf3/o7Wk3kwLfjAEcGHAydOXrb
         GlONQhpMcBrgMWuhxA/x11ZCpQeIHNDhvUj6izp4I9HfEl5LEE6mREMSzYkeWCGZO6+r
         Ekz9Vs1FFyQK/swfU6Gl7qQlSM8D5wQdUlkVP/U4e/g6z1+nahs7PARhFaaPbnwprsLM
         c42RXBADYrVlGS4dF5K0xF9+W4lrt3Klz8n01zraORjUJbzLCyzBiNnSBldDMM61CRez
         us7Q==
X-Forwarded-Encrypted: i=1; AHgh+Rr9Xx2+mwohinR9jxse5YlrkYVK5I2VIre6w/HZHit4ZyqRfm4NWBo/eW/xnSdWWyTekh9RVa1WCY2tBA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxvm+Q6v6zw4SWuYQyEJp9wPIX28VhCVg7wDqcj0Y3UijVxnHeJ
	n6OALUYSaYCiXUHFWpEkh00O8s633gtDFrufNYOY86x3wLZfCkwP7cjWiKjPWHwLRT5DLF6fLDN
	pCcMmomprYH00To7iKW+h4rP7mWC2rS8=
X-Gm-Gg: AR+sD12sGoB8LjIfEJkSWT+vwSkyMN1G+Nm+/LCpO8S5teSviuxxQX4ArjhKA8cE657
	XXqgv/wTgFeIIfvG/LmYMbqxJZgzOmgbLH2lNEhi+pfs/goNo9xtPk1bsH6/1A1oDK9GhEHlrOk
	7s9Ep1phnjBjgqSPi3rLNAZIBM+hN/EB4h3E8De/d3fS0nD7iUsNtQCofcYwF+3ExrbTk8P5Tah
	v3LwZbivdQmGrp6nJt0nROu1uSGEwLXBVa+ZD8f6x0qx1GJgdayop62liXNdKXnMvsZ2loo80FF
	VlX8s7MAOpbKFGJYaj9lDVHivp+uLOFcnMJ2wD4DVPHO
X-Received: by 2002:a05:6402:3215:b0:6a0:ffb0:273b with SMTP id
 4fb4d7f45d1cf-6a14f00169fmr20000239a12.0.1786312052321; Sun, 09 Aug 2026
 14:47:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260804225617.264861-1-maximpedraza@gmail.com>
 <20260804225617.264861-3-maximpedraza@gmail.com> <anb6ejVQMPqD7G3r@carbonx1>
In-Reply-To: <anb6ejVQMPqD7G3r@carbonx1>
From: =?UTF-8?Q?M=C3=A0xim_Pedraza_Padilla?= <maximpedraza@gmail.com>
Date: Mon, 10 Aug 2026 01:47:16 +0200
X-Gm-Features: AUfX_mzKCodxQvroNt5kk61f8zcTHiHxpI_vZk2XUB7pEBxAz8egjMYfztdkV_Y
Message-ID: <CAEUXW=GPXiGaShnDp4X8UrK+2_cgd2NS3XPZyJCP4i83wOdGEw@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] video: logo: allow the boot logo to come from the
 device tree
To: Helge Deller <deller@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, Helge Deller <deller@gmx.de>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Maxime Ripard <mripard@kernel.org>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

El s=C3=A1b, 8 ago 2026 a las 11:44, Helge Deller (<deller@kernel.org>) esc=
ribi=C3=B3:
> This patch feels "stamped in" into the existing code.
> I do understand that it is by itself clean, but maybe merging it
> better with the existing code makes sense.

You were right. The placement is now a patch of its own at the front of the
series, with no device tree in it:

  struct fb_logo_placement {
s32 x, y; /* -1 centres on that axis */
s32 offset_x, offset_y;
  };

fb_center_logo is exactly {-1, -1}, so it stops being a second path, and th=
e
device tree patch only fills the same structure in.

It also turned up a bug. fb_prepare_logo() and fb_show_logo_line() each ope=
n
coded the same decision, and my patch had made them disagree: the reservati=
on
took the larger of the console position and the device tree one, the drawin=
g
took only the device tree one. Both call one function now.

> why so many fb_logo_dt_read() calls?

Down to one, in fb_prepare_logo(). fb_show_logo() is only reached through
logo_shown =3D=3D FBCON_LOGO_DRAW, which fbcon_prepare_logo() sets.

> I usually prefer if people use the IS_ENABLED(CONFIG_XXX) macro instead
> and put it at specific entry places

Done in both files, following your example.

Checked with CONFIG_OF=3Dn on x86_64: neither object is left with an unreso=
lved
of_* symbol, and the structure is dropped from .bss. That last part needed =
a
second IS_ENABLED() in an accessor that read it unguarded, or the compiler
could not prove the read dead. Also built a Cell config, where SPU_BASE mak=
es
CONFIG_FB_LOGO_EXTRA real, to a linked vmlinux.

logo.c was the other file with an #ifdef around it. The rest of the series =
is
the binding, the reserved memory parsing and the host tool, none of it
conditional, so there was nothing else to convert.

One thing the reread turned up: fb_logo_axis() added a coordinate and an
offset, both straight from the device tree, in int, and the binding bounded
neither. A large pair wrapped instead of landing against an edge. It is don=
e
in 64 bits now and both properties are bounded.

The series needs this, or dtbs_check rejects the node wherever it appears:

  https://github.com/devicetree-org/dt-schema/pull/204

Max
