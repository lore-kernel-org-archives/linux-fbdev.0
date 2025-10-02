Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9BC5283FDB
	for <linux-fbdev@vger.kernel.org>; Thu,  2 Oct 2025 06:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759386968; cv=none; b=evpE/XL/gTi7drGPM/vQkFTNX1VhtrbCRAkOSL4FLww0E/AHIJtUM+UjpXXB9sf0Pn+ubRZ6T/BJrnVVWFPguHmXgdAydq88jQwaYfndkPxKYnSDpRm5hsZdjnGjcyxmxOYkz7P5+4YGZFLOnwhJ9NreHSiZ6XlD5v8UiZEEjlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759386968; c=relaxed/simple;
	bh=+JxJRHM7RKVe2VKLf1OZeMJvur9jkhqQvZ7AlHIqtmE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l2S3pj+pM16Pn9S9WJk420c/9WQijwZ1y7oXvwzaKqFqkJaJyQF4tqoC2/34pNAAuOALaoy/2CIL2/3Hr/KUyFUPCzy9WCEei20MhCPsIYYzjwTz8xWnzsFQlu+q1n8b5CE6GfeM1kpgZD1hgWEP+JiuCzL9kw8vazudoEgyyxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XzF0HKtU; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XzF0HKtU"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-57b8fc6097fso848720e87.1
        for <linux-fbdev@vger.kernel.org>; Wed, 01 Oct 2025 23:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759386965; x=1759991765; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+JxJRHM7RKVe2VKLf1OZeMJvur9jkhqQvZ7AlHIqtmE=;
        b=XzF0HKtUp3JhSd5aBjxb+mlaVzAKzDGAjkbrKCxDyQFXDLcqyGqY2iLKr5X/RXZB0y
         4iPJx5IbHo0beVb7eGLrZp30q8G1k1tcpi0yFIcG1f0NpzEOxBexAUAON6By0nAXm/1a
         HBA0qTOwCKN6zkfIjSN/81VXUo8x33e1kfaZ5B2xt0guv6h63yxwDopeaJQsRZElGW21
         PWxVkEliaS9e8v67IOF2P3cBE115zy7qhyQrn8Aj2qBdYesVSNADP2RaMH4vUWIqnpyP
         6m70q610h98RqRx5sSjDuamJA4dRLvRZFUpg/bbrV1jS5xUoZtlhzWTnilcdABHxiPcD
         qIZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759386965; x=1759991765;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+JxJRHM7RKVe2VKLf1OZeMJvur9jkhqQvZ7AlHIqtmE=;
        b=Wg10OurxkdP/T/h/Fkql/q9dPNjPA5NswNRg59mEL5kad+beNerd0mLqEBdJ2yKjq7
         xpRF3ZoQGtoI1NKsPiXc6sfFRuKh6EiYyLxWzq4PsxXIivBHxkXEv8W/z/KNwmHSrZV7
         g43tPFaPE+qIay6LFI5yU1N97BQuz9CadOW+ly0gS7pQiUHTWQFlhlXq16Qebwi5Pc7k
         U1efo05JPaWkXUWVKDBqTbrYTkfJliGUg1H6SyjzfvI60YW9LtvFlLGmGbV9p5qo1chF
         dpvtDVShjSfdJ3qhojtQnonfpadNEXcQaqN4iPmsYw0HNTW1vtRFR72uzE7krXWcZp58
         LlEw==
X-Forwarded-Encrypted: i=1; AJvYcCW6y/Qhd6kr5+UA9nKZMLIDiLprcIrkBNhQ8QejgoXage6nqo7LGXF9BUfp4KJ8MR9imVMh1pXOU+clSQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3LWP7UtyjKIoiwjj2Y/V+3vdQoqcflCr3J83S/FbkT6ulvdW8
	WiR24BUKbAH8wV3Qp+qgyO/lBWT8ukopX4+5ereYgC1LCVBmFSELqshPsPBfFSGSpuj2yclMj3d
	bGAVZ0LYqwOID3p3kAeZaRO+BKYYKnEZG8SDiq/E=
X-Gm-Gg: ASbGncu8BVgsp+oBHu2Qvt/epPXIEIQYPWeWVJe0qm34VEUhxHSJ1/wv4BoTWmP3JZ0
	EJABF0RN7JXafmI+Ytm2Ny/Zz/6x66m5T939p0Sf3UysAkxuUQ6wyCfGpmA8QyKDtjvDZlyV9zQ
	eA9IBrsTG29PuG8xc2miDCohhptJSu5qiPISBi3DFfSNs7gjCkDDgiO/SDuoZnJA1WZRkgss3h7
	6R21pNsM4eYujZINptbM8F4STlacawWD77wsGBkGcG+WUnjZtVOtyGyFE8opqxoQw==
X-Google-Smtp-Source: AGHT+IF99G3AYiAUEQrPtjf+2h2PSZdL5Ih8yjphXmvu9P7cETElAJxwS9A+P9E5rAaBZ1LwUTeNFcGEcpOdmxasB90=
X-Received: by 2002:a05:6512:3b8d:b0:573:68fd:7ad2 with SMTP id
 2adb3069b0e04-58af9f6b129mr2083801e87.35.1759386964675; Wed, 01 Oct 2025
 23:36:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250924175743.6790-1-hsukrut3@gmail.com> <202509272320.3K8kdDCw-lkp@intel.com>
 <bb9d90ca-aa4d-4168-bdc5-543109c74493@gmail.com>
In-Reply-To: <bb9d90ca-aa4d-4168-bdc5-543109c74493@gmail.com>
From: sukrut heroorkar <hsukrut3@gmail.com>
Date: Thu, 2 Oct 2025 08:35:53 +0200
X-Gm-Features: AS18NWAtwoESXok4b8-OK2ehiGbNAGs6cVgv71Xx2MQ4h4uKtcLLpvhfJQAkNZ0
Message-ID: <CAHCkknrZ-ieNKeg-aj3-NVqgGSk770jJpUpCvn_SuffkPu+ZrQ@mail.gmail.com>
Subject: Re: [PATCH] fbdev: udlfb: make CONFIG_FB_DEVICE optional
To: David Hunter <david.hunter.linux@gmail.com>
Cc: kernel test robot <lkp@intel.com>, Helge Deller <deller@gmx.de>, Bernie Thompson <bernie@plugable.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Arnd Bergmann <arnd@arndb.de>, 
	Randy Dunlap <rdunlap@infradead.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Zsolt Kajtar <soci@c64.rulez.org>, 
	Gonzalo Silvalde Blanco <gonzalo.silvalde@gmail.com>, linux-fbdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, 
	skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi David,
Apologies for the late reply,

On Mon, Sep 29, 2025 at 1:29=E2=80=AFAM David Hunter
<david.hunter.linux@gmail.com> wrote:
>
> On 9/27/25 12:12, kernel test robot wrote:
> > Hi Sukrut,
> >
> > kernel test robot noticed the following build errors:
> >
>
> Did you compile and test this code before submitting this patch?
>
>

Yes, I had compiled & loaded the udlfb module with no errors. Please
let me know how to proceed
in this case.
