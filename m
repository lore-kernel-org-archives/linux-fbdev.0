Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0B3242D7F
	for <linux-fbdev@vger.kernel.org>; Wed,  8 Jul 2026 13:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783516163; cv=pass; b=arRjD5RZ7lTTIw2HmLW1CmmPeVFP4NNYO0ePzPGys2pbbzedymnvunmQMeaANaP1j+taWrQzy+546GbY/cywO1hHPf7nc48o1yrlAul9X8fMP2pUwzWpzfdHpfswhQrXnCeaaTD+Ym1t6MP4gd4PfIOL6ssdcJ0rZXbaOWtaL5o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783516163; c=relaxed/simple;
	bh=Bep79+Nm0KT5E0hNBAXvimuSZeTsW1P8+5T9xVwMzYc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ly2zpBSSRt/ypnCJC9NaC/UQ1XgXeSz1NuNboLxXzrkLmPas3HO5ZFpIlSjhzyJYFp8Q/YOpWN3FiJqa9EgR4Ce9S6X1fQYSYjTsViy2Zs8IXGDaAFHrveXE0cj3a1DAbYDF6dM6OUWAAmjpYuFWhX27leQOpJM8fX38xH3tgrY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=izoHbi9Y; arc=pass smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="izoHbi9Y"
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-5bbd26a2729so549954e0c.0
        for <linux-fbdev@vger.kernel.org>; Wed, 08 Jul 2026 06:09:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783516161; cv=none;
        d=google.com; s=arc-20260327;
        b=X4p0p7gYvIiWKmN80YYhgiPpfkFhZcq7kOXJip3ml5vlfCp1LDkFBtJyULDnNBR6hl
         a2H31rjAD0jB9kL4NTvwPHwBdUdKnN38KZ53JhY/NxIR35zI8PKW5tqqKjqpz6AZdI1e
         VpTyzRjmRCd++12JXs2pqAFaU5X4SeaahSMF16h6GLWaxZJEIkKuApOU1NWb7NxXpA5g
         flH9HUlUY+3NId7S4NmY83wB24wiWTVj8j+Heb9BJXfWDfTix4O3R/2IzCGwmpEotyEx
         FU21yCs1joZGpndzaTm7D4CUDQetP8oLza/mC6g6OsYk0Ej/L/WWKZO9//Kq9VP/IfQd
         NDig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hsBQU5mcTVdYUucmcqEpkwbojCtOIWzKkEYP8GQ9mQ4=;
        fh=KfH0u8LKhD6lyoINE6IKQ8abeR7v8RBSiWo8k9cPxL4=;
        b=E7RflaiisA0JhquVkymTUy8j4X6XfnjPlC0UqC0JEWCvfitR56+4fAyvbqbruOXWTC
         j0AGhikVudXIgOwD/JLnTeo1b4N2kr0VZCa+gL7OT0gMFenefEjP6Xd7XSGN4iphsELj
         ySX5mNgmEpLJGlgRdzacgmWf0Xg7wXAQ/Xkr7QFkfdTUTMj8496EyZxsismfyR7pgEXk
         FhPfeO+c5+3y7RCXr0arT+BRsMUpUwwjgYKxRXbhSzGq4VNlW7ZM46eHNnV86et5swxb
         DRg5GFXwZKdOUzVvnShVcYN1+zntpUxpakntf+J8Wruffj8t/wJrk9gQaIw8+3cPTmlQ
         XuEA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783516161; x=1784120961; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hsBQU5mcTVdYUucmcqEpkwbojCtOIWzKkEYP8GQ9mQ4=;
        b=izoHbi9Yx+TxXhMXg6+MMqbRHb79s3O6x1h2GKrryBKeFI6BAOvBrgwgSDg+hSfmmK
         hYkBmpsskxVUJscxw6ECGRJUU6L/5CfGgYE8qxxQpnxvJTLRnavIbLxyITxoGRDKFpFG
         Ve9hGOo/PYsc2cP1PNd9U8wyOgZgJv2rFglt8zQU9UXs8lx9j71tSTcuTlkHA1ozxo95
         hXSQjdtX/W8wH6JN2Ilq+jqRi7SifVOhfqNoAI7xx/KCKBiexDggAAPM/CvxkZgejV1M
         V5ZhLsaY8Biglougf+bjetJrouBOl0BxfcWP1PAW4roHVdOJDl9CZuDD6yceAUmHAxgG
         7HoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783516161; x=1784120961;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hsBQU5mcTVdYUucmcqEpkwbojCtOIWzKkEYP8GQ9mQ4=;
        b=MCecAPjTRTxxl65d+dWn+5K+TASlBUzxse8dhirhSLLpXx/5wCCQ/nX6iP1ERyiOyC
         ZPjtZ1WJY+2F6QmcVwTrp5Jg43vYlNsbQQ/xPt0Dt6SQq9q2BWrOfa7GRM2RYkmvbofQ
         grLt2keKxazQuPU0KN+2/CNkQnmkBwOlojdtRH85i5K3FHP1OAnyuZxGNhyvSxjjTVcI
         C0+sPNYRBO+ZigrEx/SEmVtjtLLrLbI570twX5e+ZbIrywMn/pNBqahiVP0qlmIcMrcI
         5ZXk7ULUGqBxpsUkCugM4S+bbgZzClK5ki2zWISHNGwCPoxmeKg10KXgjmZUnjIxJcCW
         6wWQ==
X-Forwarded-Encrypted: i=1; AHgh+RoAqzWj342R/gExPd7oHjJMI7w+dd6LHKQIGVxGQbYpIpj+wi3UDwWSqSMIMgOhpU5Qg4LAbsCPqlO26w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwHRGMn/8lJeptCcz8UFLTcccbnLS7aMsGXSgjvBqSmT169XZNv
	FaZSXFu6RBiTSDsXMSh3r5UW0QB1SOP+FcFd2Gu7o5nLkn89yi9CCKIfUGN7JFr0fCnUgT37IUE
	PMHfjSBC23QrDr3+wnBJd7mBB5/8aZ6o=
X-Gm-Gg: AfdE7ckzzKdVX+PR2cu7MKvM1ARJbFvkWzU0tbL4+GeDfppk90Fp7A5K/hCH6X3shOc
	DUvWNXelJqFe6qeExqOsUBU0JLzZDoQJjyMUZoot6oFzcyJoFZOXwxw3inrIDh8F0JNFXE99Ztu
	LXeCrSC4NlXoNuqEZgt4kxM6ketQQ3+MKaXP83DxXeHaRROAuvBdppjGxjOQmBDBFclssdAnaYx
	kwdkFJPpgpqtkOw62GSDo08NwrIyq6mHJXuWkroApy3Fj7cQSzcROkovb2Ivk/bUTagK6kvuw==
X-Received: by 2002:a05:6102:3e17:b0:729:cc7c:7de2 with SMTP id
 ada2fe7eead31-744e000d349mr1220107137.10.1783516161146; Wed, 08 Jul 2026
 06:09:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2026070710-exact-unveiling-e321@gregkh> <20260708060307.12237-1-andrem.33333@gmail.com>
 <2026070828-arrange-degrading-a2ed@gregkh>
In-Reply-To: <2026070828-arrange-degrading-a2ed@gregkh>
From: Andre Moreira <andrem.33333@gmail.com>
Date: Wed, 8 Jul 2026 10:09:09 -0300
X-Gm-Features: AUfX_my45Q2tevoGqF5EtS1St9Km9BvGWs-C4r7mC4HKR6GOpox7QrqhzNm-z54
Message-ID: <CACO0qFJhE-p1NfEo-oVfVrrmxr=QUmOy0L3OihE6yTd=CeQQiw@mail.gmail.com>
Subject: Re: [PATCH v6] staging: sm750fb: Remove unused variable 'setAllEngOff'
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Teddy Wang <teddy.wang@siliconmotion.com>, 
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg,

Please disregard this patch. Upon rebasing against staging-testing, I
noticed that 'setAllEngOff' was recently renamed to 'set_all_eng_off'
and its value is now actually being read/used inside
drivers/staging/sm750fb/ddk750_chip.c.

Thank you for your time!

Regards,
Andr=C3=A9

Em qua., 8 de jul. de 2026 =C3=A0s 09:01, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> escreveu:
>
> On Wed, Jul 08, 2026 at 03:03:07AM -0300, Andr=C3=A9 Moreira wrote:
> > The variable 'setAllEngOff' within the 'init_status' struct is only
> > set to zero during setup but its value is never read anywhere else
> > in the driver. Remove it entirely to clean up the code.
> >
> > Signed-off-by: Andr=C3=A9 Moreira <andrem.33333@gmail.com>
> > ---
> > v6:
> >   - Change patch approach from renaming CamelCase to entirely removing
> >     the unused 'setAllEngOff' variable, based on Greg KH's feedback.
>
> This doesn't apply to my tree at all.  Can you rebase against the
> staging-testing branch and resend?
>
> thanks,
>
> greg k-h
