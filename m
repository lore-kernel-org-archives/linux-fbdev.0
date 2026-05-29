Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9694A3BB9E0
	for <linux-fbdev@vger.kernel.org>; Fri, 29 May 2026 11:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780053433; cv=pass; b=RLCAHxzwotYBRUNXYswrSZBO5M/9AWHM2dXMsyW9fGSm0Pqe9oWPliqdpRYFlZYgn/TgoP2Iq//ZWAxrjetH7AVNvIvpolY0PZam1k5rjQkW8nI46djOxZWdyWHpNL9Pv2Rpl4luMGu9k6iMtdjuHiNdRTiWW1YAeNMFmWIPnSs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780053433; c=relaxed/simple;
	bh=L3mfJ8b8ZEM+xhFAaS2hUBo/4NjpVXYO+a9psiGQoGo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hbavyIu5JmhcH29UJMW0ZNyDQGzjjnkcSWO1niGRI6irwcEm3i0Oml/+PmYkdZfynPO84ufFdARe4Z30Xz8B0628jw+0HcBMp0Mb3+RnEdY5vNwzJPyb8HQ7BEw8PjlCZXW5+DfvQFtpNlQTwu3uUVDga1WrGdmb66Lvc4P1SXo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PTj3gXwy; arc=pass smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PTj3gXwy"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-304545f5206so10569579eec.0
        for <linux-fbdev@vger.kernel.org>; Fri, 29 May 2026 04:17:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780053432; cv=none;
        d=google.com; s=arc-20240605;
        b=OKQrHQ/+tWokkuBTQtSVyxsi0ic4U+I7jlVlribCivh8Q5WsBqGA6vawHg7MKNTBnF
         ZkbZycddq0HFg0iltBj6JjMtaAjVR7TbLd118BQLXRiCMLmKfEwXyf6ytPdD1BEP+hBo
         GI8JV8FTmPK8kxNEmeZDfi0HoyVofd78P0KGbtV3R1J9ovxEyj/VTN3v6Z4LF01nKB4p
         WM8rID9g8IMpcb4omJ1O6QUQSPgPY+/tz4NjnAXjB+Ri7LSrAI/NqNpNvu41+NBsevfn
         6J/1kqmHLa81GLnI8rx+sThy772PVh7Iaxc7W3kT2jNTp94X+TySPcyabUu/4OjzZBY0
         rnlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=L3mfJ8b8ZEM+xhFAaS2hUBo/4NjpVXYO+a9psiGQoGo=;
        fh=1kMDEiVmiAM9O0c3kDcw2hy4ZACjzw3MGX5NkQPwcfc=;
        b=ADCeo82/Zq3oQY1esopWyZO+eCV6UzvU7hNrjUyi0VIaZay/yhR0i+fRIuqvqUMPgi
         oBVmFo500c7pxE8gFR1k1OiHSMzhMVDQKpEruxAn3j9/HfnT91tiJ47eXJnT4KCCGrGZ
         8l5YU3pqAfy9qRqPnfxJsnIlIt5dRlpKn+ziFpPFqul58rZC1OpnstmcHDPrkbfboWoo
         KPhpZN0YQVsrExcNbGANxuLkO7IuKAbsQnkUceyE/hS8MhATLmwc3OJzPLSCFkS6tnZU
         2p6nW1AUClnpC327ynpjdW1dcsdt8fsJYOcLCWeh5EgDpOnW+q62vok98fm+xa5K8og2
         Vcig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780053432; x=1780658232; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L3mfJ8b8ZEM+xhFAaS2hUBo/4NjpVXYO+a9psiGQoGo=;
        b=PTj3gXwyVBSTT/HcISlafISe3FMEQr96CaFFu7eOrHtXClvmFwtyfUXLrFPNq1Szs6
         4T15J8oeFmFgejfH0lV54qCPetLHJQco/9DSz2wKZeY3zWQLp7j7LRP67beQVIPGJceu
         rG8UMKA9CCPlFr0DB9YF55wJ5Nx/+YlPajyUV0WSHWT1qWWgAKUooDL9Slj53w1On9wT
         VLffTQKVJ89xrmmM2OYjqsPw1oTC8IEJ3zZqey9ZMHlc5g0zBM2LePCuR5PhGP7UCFST
         GnBjdQKM4Pmo+Lb7UzoiwsoxZ2KFkdlhkdxA573e8QmV6ZuKevBQg9BMJNbKYRy9QFf/
         QrVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780053432; x=1780658232;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=L3mfJ8b8ZEM+xhFAaS2hUBo/4NjpVXYO+a9psiGQoGo=;
        b=f9ZGevccK0YPExPzXxwrDb0CyguoQigiwQXWMrHrah2rfZuDg/Kes3B1wvVkW6GgT8
         GCS8TZSF4mwIG5PbaAVEKtFRsm+MnRzhCaSUv3R7eWzGKChBquBzRhTUQCCyGHJGAVjF
         fRjAKg0p8w3BGrUEkt0XZ+/sMs13prNk+lAPuZAka0tCfy/svodaHaERgmLTJUWm8AF/
         jCEFylBze+p40jBFhWA0CUgJOFpF3P6vQ9VUgeimvsiTAbCrKGbmkWR0eHKAhwtFTVYF
         voEqSc0oxECNHc7A9NAavabr4IaUQIy6+OJ+k4WdFZMcQLXKmsfKE1oRUXqK28I9D+EY
         RRkQ==
X-Forwarded-Encrypted: i=1; AFNElJ/UeCnJLW4hK2g1TDcEbSVxTA/HU/rzkm2+Pgj0rmWX3fPDwW13vHmb6QFktfywicMNjMWZt23qdzCz+A==@vger.kernel.org
X-Gm-Message-State: AOJu0YybrE2ep+Wt/oQJeVSMzkKu3Id3yhdCMSVIYIAZZLuQ75ReCI85
	I96I4qNmzKLOiEcubu1XDCNIASsI7IX1FZKfg9qvCQYnr5NUiW7neXvXE+GdcIHi4PNENrCeM0R
	LvKEMlo3HdgdtCcxV1kvFbYYQ/i2oiuw=
X-Gm-Gg: Acq92OFeEffHtmBSWsUvUtSBaYP0ChHugsaS6wxzBGu7M4BLj5dclsYEnieVk/J1Z9V
	tE55CYUVlXbhnesOsMKxBJVaCpMyNtbBN1cx6mIEs3Wq+VQDOaaW6z+Fap2YhX72ks5/yEgTRgi
	g5u7j4QT+HTTba62xgd6odrK2Z0EskIwRiDvT+Kzvr0HItFU+o889GEdu9pa4mLNaQhs4s6QCbB
	S/xLh14xgIl2fXiPJGv0Y+Cj/NFcXQK36oNT3B8giGsQuyHkR78R31gUp3D5HsoucmCfk/tjTEF
	Vh/yFScdwlRGPadzYOY=
X-Received: by 2002:a05:7300:ac81:b0:2ea:c085:44b1 with SMTP id
 5a478bee46e88-304eb17ec82mr985940eec.19.1780053431705; Fri, 29 May 2026
 04:17:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528135123.103745-1-clamor95@gmail.com> <20260528135123.103745-6-clamor95@gmail.com>
 <ahl0La8OQHXAlV3m@aspen.lan>
In-Reply-To: <ahl0La8OQHXAlV3m@aspen.lan>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Fri, 29 May 2026 14:17:00 +0300
X-Gm-Features: AVHnY4LHdqQWkZI96KeyzyHPIcreHN1kHpCMC5cCziI3ntwRYA4WURCN1WE3agw
Message-ID: <CAPVz0n0kpYBACOo=YyNk31KGwBEoyrf+dii8V6QY4iRCGd2PNQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] video: backlight: lm3533_bl: Set initial mapping
 mode from DT
To: Daniel Thompson <daniel@riscstar.com>
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

=D0=BF=D1=82, 29 =D1=82=D1=80=D0=B0=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 14:1=
0 Daniel Thompson <daniel@riscstar.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Thu, May 28, 2026 at 04:51:22PM +0300, Svyatoslav Ryhel wrote:
> > Add support to obtain the initial mapping mode from DT instead of leavi=
ng
> > it unconfigured. Additionally, update the linear sysfs code, which uses=
 a
> > similar coding pattern.
>
> Words like "additionally" in a patch description can be a sign the patch
> should actually be two patches. In this case the patch would be a lot
> easier to read if you cleaned up the linear sysfs code (patch N) and then
> added the new DT logic (patch N+1).
>

I looked into this in reverse. My goal was to add DT logic I don't
case how sysfs works. My code matched with what sysfs does I just
included sysfs change as well. I might better drop sysfs changes
entirely since with such pace this patchset will inflate from 6 to 15
and beyond.

>
> Daniel.
