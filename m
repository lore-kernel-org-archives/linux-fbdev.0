Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.176
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793006705;
	b=QFe/rOSPb3iFJmrx9fA0usbcMjZins1ISm6A5B85wlUMiaEHD9tbAO14jurKxNAqbAG+
	 96RqenKDWaWz4RP6UP6B3OoWmJBVG1fBlIjYoxEq/UaxrDmfgwDiJ7VNrBOS8nQ/FfW49
	 LVh6wnmIEmlu2ujfaia3jLlvxUyuevMEsG5JKPGGEslsEW+U1tTS2CizgYWa0VXt6+ZGS
	 pV5/QfijlDKyj9A4F8AVTLoH7WzXsCA6DwBf4M1cQFt5JPDYS9zKtfFl6od3ELsoE3H6D
	 QHOIjD/RzXywH13Hwo5O/fuTgHflLLAeEAjVUOEUrsoa1PXNuh43xw5Pk8hGHkP1ddA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793006705;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=iH7cQ2YJ8diUnJspTVTMz6UMogpLRPO/6WHl7KC9WGw=;
	b=V90826X6BHNSEZV5n9DLnjBwdTABNO58PXfGyXeGFvmpZe0nNWHtsxdl9Qw7+i/9dVw5
	 FTpe0noJFogYkM3BKUidc5LvlvKYpnFjfGG2CjamOtLT524+37C7Pj7l9bx1MGwAOoG9j
	 YuvyCzg6cFCH3gUdn3Ab5hLMvcZhfuJqAk9B95VxAc+U+h6Ux0lELIWpcMxQU0qDotFMm
	 cl73w0O2Y0APREVNX7wlExtlYu1V3meQCgTZlkanc1pEp8GpViFbSfpH9bb1RVr4kbg6Q
	 j1WwYv9/RiV1oPxBCHuex8k2pDmsTM6orSMeUJV2GpxU7uUiRR545s0ROqoeA1qE3yg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=npI9svaZ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.176
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F9C606A31D
	for <linux-fbdev@vger.kernel.org>; Mon, 26 Oct 2026 09:25:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 79F9C606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=npI9svaZ
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-54cd7de2d42so1553625b6e.0
        for <linux-fbdev@vger.kernel.org>; Mon, 26 Oct 2026 02:25:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793006699; cv=none;
        d=google.com; s=arc-20260327;
        b=mWJ0taeakfoVwC8g9BiZfPnrelaMfffQOUWh3yOmmRnk0/s1ddXe1TEfDbwm4VXFUo
         f0Ez6DhCjuaVHuSuDyvlq6KLN1Ksy9K+/G10nHSggVwPahR0lhNPsjsqeiQM1FbaPmTT
         IuWarHbAGkFMg+G+TdFCBuH43Z5Ywjln1DohPhBtNNfSFp9me3JwC9KfV207McSNG5ur
         RSwX7eaUvCnhS5X4qqm4A8F6v2F0w/HKAYrAehS67s98UwYkEjjjeXAsj7kwx97nv4hV
         3ERYL/H6OzM9XqUfHzzRzmfpjMPMNaBhJdGlOGd7VUWIoB1ztsK0JjkBD/WvanY5VRWF
         96YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iH7cQ2YJ8diUnJspTVTMz6UMogpLRPO/6WHl7KC9WGw=;
        fh=VS+NCrJ+dx08uGlwf8XAHUdg2KLyBIXDLj3j+5gaGS0=;
        b=IzSW1jvI1xuPjzcT1SkPKTvacRCEEPVICtLuIxjQLPSN65i1biTTBDIii4Y/yoR16C
         thFBmUkxWPJeqjmfflOgf2IAoCxJ6JxBLYmA/aDwHy/g3K1K2JgzmefdhJGilK3NWT7W
         9xueldUP+4EJQWpA6hkidGLodyICWzZKKvxE5Gnz8+uUaEQYEXV6JKG3eAKPKYZ5KhYK
         lREPdlAvrDbIN+fOJbhQHRsNg18Ti2FLGFpPpyNHiegb5AlVL56msWcsG0fiabgPBeUp
         rnUqdM04ztr/ttcpIqKdI53g/iv+Y7TIvXfRr2tpXj7lBmCyNY6a4+5ZYk4DxPwXY0Ji
         UBng==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793006699; x=1793611499; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iH7cQ2YJ8diUnJspTVTMz6UMogpLRPO/6WHl7KC9WGw=;
        b=npI9svaZBA6Q/fnfV8DcOEJhjM9ZLDS7VKmClWBDff5edZZiF6kchNGvifgPa1EOZd
         AeVbItT7ET3ew8/gY4XKFNZIgp3QInHg8Atm2aMpQYuGE2lDS8j4Ik7d70Nh4SaZ4PvN
         l7GdMvWvPCwYQzqgikQQHAV/HNGacsVxOHYaiMYK1V86tSfTxFuGjrmAFw/HXRc5qCw/
         vjDNT4a7X1v2QFgwiBxa/4Xs7AxgS7nD5gqWba2iwXTCO8zzp+mhd7kHZt1TnlFEJEvV
         SbdIv1kthQ0diCNhkVe+TB2b7HCMB2gfbD8m5PMKjcE50+qjjAzlI5i1Rc5GPxgeNnPo
         d9sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793006699; x=1793611499;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iH7cQ2YJ8diUnJspTVTMz6UMogpLRPO/6WHl7KC9WGw=;
        b=p1efrqDQSuQQtKk+q5e/CzpQcbP0b7aqp7m6YwPjQWCS/6hG1FiaWijCFDqA/B6ukS
         p0jaVeiEuBfDl51bwt8m7RnH84KA2MM3USZ/D9a26yCsav+P5ExNG55gnH3Ah1PnerCL
         CsAZuGGS5TPWMxkYBrwWHDoQytMZPU9V6FmUyygNbwws+VdelgmTQXUEQDg1iielXeN8
         zBbp69Cdu71oiu6Df3FSWaX5rfiH9CMSdLGvg0tfQZlmGKgdHrOaE9QsGbK1urcFnwbZ
         5nCp7/qRoBJ7I8tmCODJ/5t/aClMhxNFnJ4nBL3Q16ljziUIaz/2yVz0aaghVAQWPUFW
         CH9g==
X-Forwarded-Encrypted: i=1; AKwUvBwmhfqAPjbLnWyTDs4v5PqxrdBSlYvy97jfLzjWGppEAscuatd2Gg4qGA8s1zvPBMlG5yqv48OcMebHWg==@vger.kernel.org
X-Gm-Message-State: AFq9FYJoUpCknsHzdbTOMrwcj2qn784OASInt2Aq1fnt6qUESRFcK43k
	FO2jpXjwjc6BW1tPosLFpjpWoaEFh7RpBQZBTxmIqjRXG6e20MlsX4skoD6OzsaoFkGP2Im6sWi
	/FqSKjQwu55E5nuVXcL78rwNOLXEOZYY=
X-Gm-Gg: AYBFou2HbILm5sXK0LBTT1h8jUIy8YW1/nHu0w23gHuZwaTEWydtjAXNGCBr/hzPEd6
	qZk6/JcouhWIjY5I1EQD2fA8/nIHis9umke4F3xBw6NQYo+DXqtqwFzC2OWXqP4g5Ot0WvqYZ/T
	JEZFjJzexoW2MXda4yBF9FlAZaanCtisZMOXx+e93QRh9TYBIcZa4J+qEhBwyYKJ3Vx29bRChIV
	BtqUs9mxvGZkmy5duMHiOkFGhex6w2RaDdo+FlDh0wasR/uan/+C1khJJ+royAcp4LzIpDnSKvX
	vYP0gosAQNt01UkhzrjeCqVTe1oornK1gzD8mcqcVOWZdPdsWdf19OTt41q9QKECCd3Sy1759lx
	QJmcAZi3FnVUCB1SAbyPKc8Vpq/yzuljM6uTFCSljRYI+1TqLHN1Ds9aE1EnI4MZJleOxCpU=
X-Received: by 2002:a05:6820:6fc7:b0:704:d59f:2a2f with SMTP id
 006d021491bc7-70ba1004bfdmr2405887eaf.86.1793006699407; Mon, 26 Oct 2026
 02:24:59 -0700 (PDT)
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261026081832.60570-1-himanshu.bakshi478@gmail.com> <at8UoLDzrO9ypMeR@stanley.mountain>
In-Reply-To: <at8UoLDzrO9ypMeR@stanley.mountain>
From: Himanshu Bakshi <himanshu.bakshi478@gmail.com>
Date: Mon, 26 Oct 2026 14:54:47 +0530
X-Gm-Features: AclHuK9P_GrPtY5hmmGoqr94XfczFIROopEnJs5pAYehQGelpuKw7iWG8V9_J8c
Message-ID: <CAGLmz9JD3UQ+4cAV4nigm8U4Jtb47=oBGi06miQWuetenszoYw@mail.gmail.com>
Subject: Re: [PATCH] staging: fbtft: Remove unused macro
To: Dan Carpenter <error27@gmail.com>
Cc: andy@kernel.org, gregkh@linuxfoundation.org, dennylin0707@gmail.com, 
	cenzhang@linux.microsoft.com, dri-devel@lists.freedesktop.org, 
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev, 
	linux-kernel@vger.kernel.org, dan.carpenter@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2026 at 2:21=E2=80=AFPM Dan Carpenter <error27@gmail.com> w=
rote:
> This commit message is sort of acceptable but a better commit message
> would be:
>
> "The fbtft_init_dbg() macro is not used, so delete it."
>
> 1. () after the macro name to show it works as a function.
> 2. We care about the whole kernel not just drivers/staging/fbtft.
> 3. No need to discuss dev_dbg().  That is unrelated.
> 4. No need to discuss compiling the driver since that is assumed.
>
> Otherwise it looks fine.
>
> Reviewed-by: Dan Carpenter <error27@gmail.com>
>
> regards,
> dan carpenter

Hi Dan,

Thank you so much for the review. I cannot find any call site for this
macro in the overall kernel anywhere and hence it is safe to remove
it.  I have sent over the PATCH v2 with all the changes that you
suggested and will be glad if you take a look at it.

Thanks and regards,
Himanshu Bakshi
