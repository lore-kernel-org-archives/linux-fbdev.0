Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBAFD371D02
	for <linux-fbdev@vger.kernel.org>; Wed,  4 Mar 2026 11:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772622416; cv=pass; b=L9ZqijvxkbBqeqKS0aIoP0BOS4Y8hJfjqbcF7A/I7hN3hcmqr858IE/pjKuQBNOSlQqmsXj7DvuxIktNji/6Y22zowHYln96ngYTdDpU0ERuIb+frzM9DC/NDpQFqUgigagH1F6LpVWf95cTBkcO+FnwmKKDU5VQb1Apg4Y+zZA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772622416; c=relaxed/simple;
	bh=2fkFTv0j2bW2/GT0WLhD5i89XhK2zX/tXK9CGn4Uwas=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n67i1PZ96Lbm7Nal4Pwc2QzX9tg2H1BpLFVGaz/1BDjk/Ew7Uyq99EwhE/7lU3l6iElgp3yVUNCrO/+wv+vOV8FNFIYY3KM4WC7tGTWjWLR3FS/GQaXLdQtWk7hU0+f7/Q6zraE58BEdOhZSkOdTqGT4vR93AniywhtiHzirbkQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DD8UjN20; arc=pass smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DD8UjN20"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b935a74b7c2so911078566b.3
        for <linux-fbdev@vger.kernel.org>; Wed, 04 Mar 2026 03:06:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772622412; cv=none;
        d=google.com; s=arc-20240605;
        b=YdEM+omZw2HU/Y1vA46fOIsofikUaZfloOvfzZkUCfQ5+3XmlV1xp+VzijcBiC9ntA
         dqr351/0J23EeY2BovFsQy+z/x8uzp55OMgX9JibBtGq9onoWSvoRpWnuYyTUIGHK0TS
         VMZ6oY4izxoOkGgY9T5I55sjySQnl4a8zML5p4yQnq6KzbRO8psJ2+HA91AJ9+93NfFl
         29cb2QGuVv1z+0j2lRRDEBPOnF7KPQSSS+XheAUdVy9/Fn5zUabduHD8fLWByaCpMug6
         cbM+zjQcGDR1G4zjQ9yAfPoUsF8uGcVw2WCOAm3EAci5Q2uE9gh67jAbiqtmZ3PIaUeT
         mPsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2fkFTv0j2bW2/GT0WLhD5i89XhK2zX/tXK9CGn4Uwas=;
        fh=GO04nRKAXDnpCRAw4S85uxqrvtb+81kh4oUyJd4vwCQ=;
        b=Svm5QcGY4gvwmbmBywX+dgUBwwj/cvnykMll1EFfg0jwxvXaMnp5qDNRqVZhCpfFMS
         LUdu4HlsJ8xEJa/acQ1c0+QR6ac7fCcHDCWp/rnXwmZNo29FK1gskpc6adAMJxFZKMD3
         RS8+NVQ7KVe4y9K6IsZitexGl8qJtaI4Sxg0OUdA1DelJHpGeiGdrtlA0AhioukunfMq
         LOvPwHo0VMK7mfKuR0T4oNwy/kORRDaPC3Y4p0ghFsc9nF2QwCyfDCQ8URPiwjRwa4V1
         G/585y12Fp1ejGvZ6fIHSG0VH33RHfAD0KkyE1EU2csNHT+1THXFMKZGy8IwdPodEH/c
         kFGQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772622412; x=1773227212; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2fkFTv0j2bW2/GT0WLhD5i89XhK2zX/tXK9CGn4Uwas=;
        b=DD8UjN20HOkgp5uCOszU3O6j1qWZJx2nCB5B+/aTBUsWTLFLBZbWnqJLhuHVIAV9Ib
         FVT2gJRtThVNSnJUBR8cEz/mrLQ+sOQ5bYgJ/4+Ni4Cc7ftGbPAR7cyNW0p7X5+fO4mK
         m+bAnpwgBUXenFibpQSqBRi6QOUATtO1UTG0Lw/Inp2nhlW0+UVESIskSDunlF1XQfZV
         3C9LlhM0gucPfsEiCfZgFenvwAK7weQlsTaJWMvryU4PN4ZRj0vlyKAkPcksRT0Ir2yB
         8HyBvT4LI+ifsEYmiHvBolKYoN/hUJKUQaUYybCx+uEWFqyKKFR5ytErlP2MCeMpHm4N
         HgHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772622412; x=1773227212;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2fkFTv0j2bW2/GT0WLhD5i89XhK2zX/tXK9CGn4Uwas=;
        b=CGUylGgCo9Fq9jz9o0E822A/Ikzyso6d42yyO3jOevfB5xbVOQlIivlnO2DbrZmdh5
         Ki+3GJ6T464WlTWL5dm9alWW2EyydxyVFz7TIN4Wd2bz9CNT/zbCrRSVSzCJnkdi/SU8
         disatNcz+IGghOKO7pS3A//AXhd+mOm8K9bBJhy2l+a9SGH9obrnKmDyEcK8lGciMOux
         uRGLWMQ5Q167ExDlGhlYKH2vSrsw3W6HH+hifVjGHmF69fI6AxxeakfG4JMPqe/x8MX7
         xRp1zjS2Zvm/JG8sIu04fIPOkOfrn9wJ4SaV4znRG/OUXXOU4qxC3x8hXyshDumjE4dq
         PH4A==
X-Forwarded-Encrypted: i=1; AJvYcCVP9g+kkgVbQNiGr/e1YvX5SvHdBwD0CMd1IASe+IfYjNKsqI+sBBNitIgk/lEIW9HzLp0o7TGF9ql4bw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3HcGPWJNekliUQyasYGewhrR2Pw349mXaWwHp+I/eNKElkYt1
	XAhawCWXJals1BD2XtP7wV0IITiAw5HeDz+GXsgQygBLjIMACJr/drmPZAhr8RfHG0GQzB5v6CL
	EGabjjwef6vqxclrQyRZCheQyC2lT5eM=
X-Gm-Gg: ATEYQzzArF/fJcxXA9tm/h2AzJ2cxpQ/WNqNUssbQ/x6bmt+Z1pih1I1XitSlc99vLW
	/Z5FXSEf4KfGMlj8RUcwAROCwsh0LrpEMdbbTZM7a0s/VsEEcduN3Jmlt1torX0CigaU5e1Cvjn
	wt1wKzI0SmdgApJXRjaKo2VfdgZcf0HS23v+7SlGGDmPxVnFm6BbGZNyjNB6XwiwYIIIHJpyEW9
	DiQgIURW9L1H6/LuC6ak8Cv0TK/ByEjUx9Xzocajn0NKIs8HALhJfTLk0tmopc+Yv2pDlaZgirD
	NCZajgp421wOR09ILNuvzEYwRw53250Zapj5JZar3GLbuVGTlmqFy2a0A8mdjUCZoZ0TNiWdF1V
	zZbIdwE079NtwX9w/YA==
X-Received: by 2002:a17:907:3e18:b0:b8e:d4ed:5ee8 with SMTP id
 a640c23a62f3a-b93f11eb667mr103028166b.12.1772622411906; Wed, 04 Mar 2026
 03:06:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aaf9uQOBzCwQuff4@marchy>
In-Reply-To: <aaf9uQOBzCwQuff4@marchy>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 4 Mar 2026 13:06:15 +0200
X-Gm-Features: AaiRm537Tqrc3m_d0DtxfH65gd9ff1kw56kzwnPZ5X9o-CIIf_MObBUVfO9E2pw
Message-ID: <CAHp75Vd0FqVJ0z8bsxZtArXRy+h8d7i1_XdUpu92GGuFwSGkPQ@mail.gmail.com>
Subject: Re: [PATCH] staging: fbtft: Update RA8875 Kconfig help description
To: Adam Azuddin <azuddinadam@gmail.com>
Cc: andy@kernel.org, gregkh@linuxfoundation.org, 
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 4, 2026 at 11:39=E2=80=AFAM Adam Azuddin <azuddinadam@gmail.com=
> wrote:
>
> The current description is too brief. Update the description to
> include the manufacturer (RAiO) and the supported resolution
> (up to 800x480 pixels) to help users identify the correct driver.

While this is a good intention, I don't know if it's a good point at
the end as the idea is to have a proper driver to be located under
drivers/gpu/drm/.
Reviewed-by: Andy Shevchenko <andy@kernel.org>
in case Greg wants to take it.

--=20
With Best Regards,
Andy Shevchenko
