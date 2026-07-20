Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5318C42FCC7
	for <linux-fbdev@vger.kernel.org>; Mon, 20 Jul 2026 14:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784559298; cv=none; b=eeVD5qyHmm83EEKbasHDCg9yL/qL9Yn/t3htkPj/nsOnmQVhVPf1KQNOVDN/b78ZO1h+mrFAxFmaJO1pG/poqtLJHf9zoAqr/ewEd1+o//CnCgP01UGqgay1Q4sIXgP93H/8CTQagCcMhAk/nlazwbxaewR76BHYqL+HKNboLig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784559298; c=relaxed/simple;
	bh=W2IKmKNAqO3TftCaDx2SG4KLeuZkvV16dlDOF9KGTgU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hcTlQIqAOokbQDBaym620L2OvuCt5zpiimvtVAvX2Ay5y0I1wgIYrOurkiWBx6Pr69ZRQ02sN5wgGRH8Y3PhYA3CfIvbRLMTG18fsqhRb4ThRdbuiDwh2PHFx/PDCav3rrZqhuB5/Cs6QkQUhVt6JZCBgfDFwGJtQAHP/TuQGC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g6tmdnJ9; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g6tmdnJ9"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-47f633e6058so2854032f8f.0
        for <linux-fbdev@vger.kernel.org>; Mon, 20 Jul 2026 07:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784559295; x=1785164095; darn=vger.kernel.org;
        h=content-type:content-transfer-encoding:autocrypt:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=XnoNJySGi2Izzd1ger7ulGeh5cfeHWBXigWAMR6/Z+4=;
        b=g6tmdnJ9tyTDOswrRQcjTuE6+nRIKo5wBlHl6RdaKPa/Huf/jv2ZE/viI5f08OzrOs
         WOretoXi+FivDJJZ40hKLKIS3RvBvAU4qlXjq+Tj/ZN8IFmaVj6CzzPIFdgsijvt5KRB
         3uY7ekmysRgbvloDdfqVSgW+34W1M4bBwEgQRYCOFX3mpov0QCyym1StXi+ivEgmLJSc
         HV9xg6+D7DjxoaxbACNCSgPF98gJxCX0oJC8GFrU6WE4dz5JxKbPS49EvBdyRxPx3g1c
         OCdaNNd+3xhTKW8XANGnHM3/JPxTa9gRYQYO3lLiq6tGrMYwlZxSRT15NuNiBBFgNg9T
         oFxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784559295; x=1785164095;
        h=content-type:content-transfer-encoding:autocrypt:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XnoNJySGi2Izzd1ger7ulGeh5cfeHWBXigWAMR6/Z+4=;
        b=ERafswwSF/RGf1wppAiFIF9YCAgNvQ/3wq+snOQtoNXwRoxF33lgeWvzEUAt6HtJlV
         ptPSOaVUY2GO8RWbwxUsXvZ5u9seEcApckmM3IGxwpMk+9pc45ejSplLt8daOp+OIb6T
         p2bdsKpggoTMTDsOBsPhlfDmTprU8aXwJ+zyp3bCa6zlyIh5TlWuIobyh7FSsN9W/t43
         VHg6vY4xiUJ7oL/Ui8P0RwoG4PZ9TbZCdXnLapneGfdXrKyX1qEpN0QsnP9oS3s/f84s
         RU83qe82hAfsX6cmEXXMGArLAPUK8RG0QI0uEKB/mi7XXrFVP5dcZ4AysReIPft5Z+iE
         CRYQ==
X-Forwarded-Encrypted: i=1; AHgh+RrwR5TmEPlSToipGj0x7L0KK+8DBfvtiFgVR+pasxBL8lAp4XE1kmmzav7GQoE3lenldRwrHw8zUGoGeQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+b9qFKt7fU4/Zq5RtpfmVx2BObUsxRvHIq18XFxeYKPoXCUC9
	FPvTLNDU2CqoIJ1Jybg2QjT6xp+1yiH6rfONPYCHi+egppZpw3xSoEw0
X-Gm-Gg: AR+sD131Fa3+W5qOjYckg/0bLloBDWl51SDIkOyJZeMVaqi5s+2Ag86jcoAKue0vsQh
	r7EF+gGUtsuuNixrchrmf6g1sVEbiZQgcDzGpp3WG/C8IylcQDHL4qFsYLiXFmTg2b3thjUHNn1
	9RYhJ9NPodTeoBrXerqRtp9wU9RfvpwN3SzjJBzLIp5QwbL3qv/1D/CGuMmdxXB51m6T8iBUcRW
	QmaheVr6zOna/a6LbezamdGUlevT2u3jSBKwsXxarmpDM/muFNIGhN4Zh+bmTBFO2G/0WrBcd5K
	+RVuPa5ScEbhE3ZzliLa3p+Y18Yhv9zSa256A3XtHYHwaL5+eKw85nC0BXL3dTCcOzOLd261FL+
	pNo0KlovvBUoeNGcNkssTGDypSepKZJuAfpamqma3brozrCHBdDK3/GoMQU5oxp+NwvQQY45WOp
	4KT/sOMYyTjRJ6VjmoHg==
X-Received: by 2002:a05:6000:46d0:b0:47e:81aa:3822 with SMTP id ffacd0b85a97d-47f6232c96fmr10331792f8f.42.1784559295439;
        Mon, 20 Jul 2026 07:54:55 -0700 (PDT)
Received: from radijator.localnet ([93.140.52.191])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63edcf8dsm33115875f8f.27.2026.07.20.07.54.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 07:54:54 -0700 (PDT)
From: Duje =?UTF-8?B?TWloYW5vdmnEhw==?= <dujemihanovic32@gmail.com>
To: lee@kernel.org, danielt@kernel.org, jingoohan1@gmail.com, deller@gmx.de,
 Julian Braha <julianbraha@gmail.com>
Cc: rdunlap@infradead.org, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, arnd@arndb.de,
 Julian Braha <julianbraha@gmail.com>
Subject: Re: [PATCH] backlight: ktd2801: fix unmet dependency on GPIOLIB
Date: Mon, 20 Jul 2026 16:54:53 +0200
Message-ID: <-BogvF49T5iTuPtucSB0VA@gmail.com>
In-Reply-To: <20260719024902.151710-1-julianbraha@gmail.com>
References: <20260719024902.151710-1-julianbraha@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Autocrypt: addr=dujemihanovic32@gmail.com;
 keydata=
 mDMEabRVUBYJKwYBBAHaRw8BAQdAG5VJBpoPRIGQml4+E2LcPdyVtnXRuuqoD1BsHxRjNQ60KER
 1amUgTWloYW5vdmnEhyA8ZHVqZUBkdWplbWloYW5vdmljLnh5ej6ImQQTFgoAQRYhBJvUYwF2kA
 idqo3CZidfVEs7G0eSBQJptFVQAhsDBQkFo5qABQsJCAcCAiICBhUKCQgLAgQWAgMBAh4HAheAA
 AoJECdfVEs7G0eStq0A/1SDcm8Bkq1JV+GTGMC8qE1QzCFvnoJuZqtUuQRCkd31AP9Mbc3pmg1K
 JDxgPl17/CQohZ98dbUVffmdQpJJLLMsArgzBGm0VXYWCSsGAQQB2kcPAQEHQH8nnS6QNfgpc1Y
 tqU80DWMWMsDPEGJ7yZ9Nf90mPEEQiPUEGBYKACYWIQSb1GMBdpAInaqNwmYnX1RLOxtHkgUCab
 RVdgIbAgUJBaOagACBCRAnX1RLOxtHknYgBBkWCgAdFiEEA6Ue0g5lV5FAcj1ivjIt18NZWcUFA
 mm0VXYACgkQvjIt18NZWcUyDwEA5OK1WRFN4/psOq/bS6Wuh5ysy0CyXIydqIwDJDdAFukA+wfc
 lr1qyAbEX0FHVunCl+sxv/ymvjsup85rAH+a2j8HA7gBAIolabvAIUTUfCQNCu5MUt482b2EC8K
 40xl/6HT43dunAQCqxwRLI2k0xmTdia2AZwqbbMvqWonOLWtdZwWvodgjBLg4BGm0VaASCisGAQ
 QBl1UBBQEBB0CoqkQL2R15WHRvj3RlkxjW3pPpZVUOHyfhEX+Q9PhTcwMBCAeIfgQYFgoAJhYhB
 JvUYwF2kAidqo3CZidfVEs7G0eSBQJptFWgAhsMBQkFo5qAAAoJECdfVEs7G0eSnB0A/3oyRxS5
 cUJMNnM1+4UkRahmU5/42NfVOxIL5d5oaW13AQD617LpOfnCuZR3U0vHLOW5vrnFtdvi32N5zLD
 9wyShC7gzBGm0VbYWCSsGAQQB2kcPAQEHQPRL1mWe9nIhjicyAqqEN80IXEF0NeKSFFpN8n75b2
 YIiH4EGBYKACYWIQSb1GMBdpAInaqNwmYnX1RLOxtHkgUCabRVtgIbIAUJBaOagAAKCRAnX1RLO
 xtHktyGAQCJPD6JsQhQZEB8ciZrJz+hnonsJp+KZZQQGEK/KsLHEgD/ePz/x0pQdI/DcJd/5Qge
 +IJGd+jyv4zyevPxipVbyAo=
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Sunday, 19 July 2026 04:49:02 Central European Summer Time Julian Braha=
=20
wrote:
> LEDS_EXPRESSWIRE depends on GPIOLIB, so its selector, BACKLIGHT_KTD2801
> also needs to ensure GPIOLIB is enabled. Otherwise:
>=20
> WARNING: unmet direct dependencies detected for LEDS_EXPRESSWIRE
>   Depends on [n]: NEW_LEDS [=3Dn] && GPIOLIB [=3Dn]
>   Selected by [y]:
>   - BACKLIGHT_KTD2801 [=3Dy] && HAS_IOMEM [=3Dy] && BACKLIGHT_CLASS_DEVIC=
E [=3Dy]
>=20
> This unmet dependency was found by kconfirm, a static analysis tool for
> Kconfig.
>=20
> Fixes: d95963e309bc ("backlight: ktd2801: Depend on GPIOLIB")
> Signed-off-by: Julian Braha <julianbraha@gmail.com>

Acked-by: Duje Mihanovi=C4=87 <duje@dujemihanovic.xyz>

Regards,
=2D-
Duje


