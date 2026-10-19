Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7B048A2BC
	for <linux-fbdev@vger.kernel.org>; Mon, 19 Oct 2026 07:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792396331; cv=pass; b=gW+xKRiuq9FiJF64RefmwbAj6o35neyN9CM5XCI2VzkIgw1Q+pwgO0L4ifMP5ydN+N+p3+hMPrkvEKiPprVaIm4Xf5u44NmGz6DhVovQ0HCJb4uqqNF9qqMgM24T32zHaH/T9jfiOJ0ec6rGTPIR/HHISzYBDT3rvQQJh7ukyhc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792396331; c=relaxed/simple;
	bh=kNfL/Hla6UKgQQwI6Gv8t1MIM+Kmznse6S3d1b1fzrc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HeMAn25DJb8k0kmprV9EXWR1v2tSusu5bGtLwNL8MGnlX0JH1QtBGZhx0B6StML4sKGg+rx+PhRymioYXCPmGnADPL6dCiromATyiw11JxltAWDNWS2ZUzTiO8/c8mbTp+x8Sfifh1mN5olnKEoDYS9QAMtrK6l4tLlfBjY5ttE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=slNSKdhz; arc=pass smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="slNSKdhz"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-677dbe051d4so1509375d50.0
        for <linux-fbdev@vger.kernel.org>; Mon, 19 Oct 2026 00:52:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792396329; cv=none;
        d=google.com; s=arc-20260327;
        b=osp6wjXO0RbKxaj0Sebinvzeo/tUj6ULwroUOKun2GEFOT/fBMMKDC4uIQHTYSvn4e
         pEo+bkAF4JMEF41YWln407+/0oL5mrplCrGLMRLzDRuhwN1CH1OezLeedkhdTbcjsjQO
         9k2s2P/+pDleu75X2O3jgDNaiPQGgZk+Px07J2lsCVDt+OAs8W66+1XAx8wfyzdEwDDF
         fxTklBkpvQbLgqByCmEraWaRDF+DZO8/K/oYOaorQs5KK77Y4z1ZsCgVLh5kRHBMlpR/
         Dv5OCkosuqNUBErpxBkJXNAhKw53xtH5iunppeFSks0QZjWYywrgWLaaKnVljJbRRYcq
         jxcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6Hu/C8DuVAfrXVfEdGESTNZFy9FgHIiZtc7UqY19xf0=;
        fh=Ugc+X4YszPK0LoXh04AZTZzxMCM1yE9ply8N5PtwKmQ=;
        b=XYYnVCP6lOc0J7oLRr58uiGGSj64VhkKrrveOsAmYxuefHG/ltF3Yr3YaWNd+7dUQq
         Ek1f3JXBYowMGInY43oCcxDqle1PXPGzIMte8Ya4zNlp6PLSuaaRSRAYFyFDX1z9C4T2
         qY69rmBITCD4yQ25/5D94EzHnSmyEBsayBOq2Hqihk5U/HoQGpl0/T2b7CvxHBvBaMwE
         18RmRURUAokePZ8aOQ3tQtydVqf52aHENBSSsDhyn324jDkS+Pxzx2aPCBQfbUFFLccQ
         5MpzJGYzTb9WWNQuZ6CZxLG/Cn8mnlBS6kSxCNk92vkLZfEjWDI01q+98liuAmmpWrXR
         1SEA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792396329; x=1793001129; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6Hu/C8DuVAfrXVfEdGESTNZFy9FgHIiZtc7UqY19xf0=;
        b=slNSKdhzQDufNI/CyemCuLFkbABnOforDaBTNQIcdaxAv+mxfH28l5VPAToHuJOMMk
         RpQ+aWioG4md3ZFfkeWgnCBx0TlHwrM/kVh1CfaTqXWDlDpQTHPdra4NflzVqS9YtnEw
         eM/N3W4Ci3CrGgQj9RltcSNe6UI5Zct7+a57xSNQdmE0vxqtjuSVWec2qncPFa1UCWXH
         K8Xr+DnZQyqpRpr0WBdboItoqpJLaiJbifWCB0iTPTtgyuqAKxXX6QjcZdpKA2tLlhPL
         B6KPw5idkZqLk/XooROxf1J4fuvvVsqFEk/aT3axrz70RosIljgrqdFQmbLHI3TE/KGg
         EOXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792396329; x=1793001129;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6Hu/C8DuVAfrXVfEdGESTNZFy9FgHIiZtc7UqY19xf0=;
        b=B5yxAccbB6u5EnY5QDSVoRIMFsDrESMUHUeYU/9GUeQ7oD7ottqiXKolCp1hmpShsS
         3KwxTNwOX6sbmhJCmHHFhCYXv4otttqCxlRZH7KdS98+mzP0xEwCurXj5R8ysmB8sUY9
         irRpCfcLzwJU3kpjezEQ/f8gzMlgzOtjWdbhZm7EMGVSJ9Nh9wehYXBgbt4CI1l/y0tv
         mJE3Bmey1Q2JOtKqX3oVIK3CF0ctMt594QVWaFTDvRXh69K5xoGnvyBBe0RTYmwEigA5
         Ai2hUMHa16a13Tl8TY+B3Jp8nQRR2Vj+2G2gYdc/5iPEj7yeMPl4K6DnF7qwDhfN9rkR
         N9kw==
X-Forwarded-Encrypted: i=1; AKwUvBxHOFpMLr9JSCPuuuwo6EOP9URQzDXWyvKUMIc2kWqD+TfGbmfjnmRHx9saLFSWkcJ/fSSgPtSi5TqKpQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYLNZxF9xNIQrssN2Sq20JbXgaJGGqJrGj1BtNgSOnhlqar9xa58
	NgLi5Aq/VyqvzBOOVU2bgTtGpIvUYXs5gHzJBaaZ4GeKZflTrtNziyJfbPNtWZ0XEfPZCuTkeu5
	7DkefuO0Ij13/jwdQQpgMqmubP0KrVYU=
X-Gm-Gg: AYBFou0deGyAq0pmRvNrfQQsmSnpXy0GbADifpNuWe1fkAGPk5Et87G/qg5NF2SS64c
	JNoefxXYBv7ChJepZPeLqp+9tBYLY9qbxXLPY6byHlTJduH1BmGXcT0vucawdEc4mTjT+uPu8iK
	iP2n6266B8YPMjoAC5I1drFQzkFuRRsmxtm43tN+625ITgIOuhLPInojJf+u+SN0QgNE5jFl/tn
	6O9mZG3tpvtNi/vxU7dek17kuEWjtNK1SvEWegegj73NJ047xpF2E0w2IqprMd0GtCxbs5Ekw/k
	eoVPlUZF9oXkqZAEJtujkjF9BaOP5oaOqDxQgeIQoQh8Nnx20hFPFDsVOgADhpzwIjsNZizlAEL
	yrpjpolHXTn6DJMZg3MK0eeyK/SsBhf4HSpNFwD7GzatnaGPIf+bdOCHZ/q54APWK41bo6HFNVq
	l7c4G1kQ==
X-Received: by 2002:a05:690e:12c4:b0:677:cccf:445f with SMTP id
 956f58d0204a3-679ca7ca9e3mr2034762d50.46.1792396328411; Mon, 19 Oct 2026
 00:52:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261016162912.64581-1-lukapanio@gmail.com> <20261016162912.64581-2-lukapanio@gmail.com>
 <20261019-yak-of-subtle-protection-8ed0da@quoll>
In-Reply-To: <20261019-yak-of-subtle-protection-8ed0da@quoll>
From: Luka Panio <lukapanio@gmail.com>
Date: Mon, 19 Oct 2026 09:51:57 +0200
X-Gm-Features: AclHuK_A1TQjZsCV3MVlGkJ8tdfOzXTmuHWmMEHG7bKSsC6HnztuOLMJSgs52SY
Message-ID: <CACi=Ov5C9xuFvaYTcPapc=DzCFqrKng-V53voFHGWptvvs8c1A@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: leds: backlight: Add Awinic AW99703 backlight
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: lee@kernel.org, danielt@kernel.org, jingoohan1@gmail.com, pavel@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, deller@gmx.de, 
	dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-fbdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Krzysztof,

On Mon, Oct 19, 2026 at 9:02=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On Fri, Oct 16, 2026 at 06:29:11PM +0200, Luka Panio wrote:
> > +  awinic,iled-max-microamp:
> > +    description:
> > +      Full-scale current of each LED string, reached at the maximum
> > +      brightness code (and 100% PWM duty cycle if PWM dimming is used)=
.
> > +    minimum: 4800
> > +    maximum: 29600
> > +    multipleOf: 800
> > +    default: 20000
> > +
> > +  awinic,ramp-on-time-us:
> > +    description: Current sink ramp-up time when leaving standby.
> > +    enum: [512, 1000, 2000, 4000, 8000, 16000, 32000, 64000, 128000,
> > +           256000, 512000, 1024000, 2048000, 4096000, 8192000, 1638400=
0]
> > +    default: 8000
> > +
> > +  awinic,ramp-off-time-us:
> > +    description: Current sink ramp-down time when entering standby.
> > +    enum: [512, 1000, 2000, 4000, 8000, 16000, 32000, 64000, 128000,
> > +           256000, 512000, 1024000, 2048000, 4096000, 8192000, 1638400=
0]
> > +    default: 8000
> > +
> > +  awinic,pwm-trans-time-ms:
> > +    description:
> > +      Transition time between brightness levels set by the PWM input,
> > +      for a change over the full duty cycle range.
> > +    enum: [2, 4, 8, 16, 32, 64, 128, 256]
> > +    default: 2
>
> Feels like you are re-implementing triggers. Several properties actually
> feel duplicating standard LED ones.
>
Thanks for the review. Agreed, the ramp/transition timings and the
mapping mode are not really hardware descriptions. In v2
I'll drop them and leave the chip defaults, and switch to the standard
led-sources and led-max-microamp properties instead of
awinic,led-strings and awinic,iled-max-microamp.

> > +
> > +  awinic,i2c-trans-time-ms:
> > +    description:
> > +      Fixed transition time between brightness levels set over I2C,
> > +      independent of the size of the change. When absent the brightnes=
s
> > +      ramps with a fixed slope of 1 us per brightness code instead.
> > +    enum: [128, 192, 256, 320, 384, 448, 512, 576, 640, 768, 1024, 128=
0,
> > +           1536, 2560, 4096]
>
> Best regards,
> Krzysztof
>
Thanks,
Luka
