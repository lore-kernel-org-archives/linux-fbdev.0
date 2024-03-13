Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9553B5644F
	for <linux-fbdev@vger.kernel.org>; Wed, 13 Mar 2024 17:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710351863; cv=none; b=il/0GL2hxfWGak7GVccZYEo4M7wGHLPDfx2/iT+fk/rfXvGYr6xkY6PQYMlSSRUPGZqMgnza+vy2UQabwXkZKMopwGuopYw83MumtlwtldkrwGThBa8sWIuv6+pSdvirU93MKpvSYiYyCstmsfVt7vrRIds270i1NbBJPPVMFpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710351863; c=relaxed/simple;
	bh=hCUUui1NbQfp/vSqXOMgH0Aw3ATqns8Rr34Fh87bhTI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FwlOoQUh8o8Ecn/iO49E4NbxTgW5flZmPCDAbJy0rzJHV9v9yTlV3AmCA3lew4B8lkx6VpY/rYmO9gwFgTI5Y7X2z2XbvMnxRauD6eUiZqwx7DQWensMZCmhO/Utn9rPWad9wvXHon+zl7oIBI0xxswM1QftlkLUzxeyjtVOuNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HcgBxOwl; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HcgBxOwl"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-29b7caa88c6so140433a91.0
        for <linux-fbdev@vger.kernel.org>; Wed, 13 Mar 2024 10:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710351862; x=1710956662; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hCUUui1NbQfp/vSqXOMgH0Aw3ATqns8Rr34Fh87bhTI=;
        b=HcgBxOwlA4jQleOkrx7I2iXfoEqHMlRTLiIEUApbscr8M2PLY67Jh9QRmGlN7tsIPj
         F4pg6Xx0Ssmw5ENaDhc+DUhOT43K+pSmFEwbGYwPgq1vIJ8zMZ4p6q9HizdKPOLEatPf
         VtHXKqjKCSEBGrNjUWA/pirguKcCdufsIwB+I7ucMWLr3fnQYCvvCONsaYWrm3CpvhzD
         XylsIqfY1NV2Uj+9qxWEbF6hiVYUjsWYiLtQuMG0kgE+NCXkRim0jcdiCeGUkl5PBZHf
         Udf5VVPYvWzsAwHTkxkqLepbDAMT7k/hDFUeRt6a0JTgvpylULU4lozspqCgJqhHgGzB
         DfxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710351862; x=1710956662;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hCUUui1NbQfp/vSqXOMgH0Aw3ATqns8Rr34Fh87bhTI=;
        b=wbHukdivUWGO020lK4JUdPYYfZ9ck/S45cZa8YjGuUMxYnFktjDwhmzyd1bOd5JdY2
         DYLRPPKJeLJEnkmyHaTaovb5TsHdPpT6PXR3E0eS/fuA0i434oUiDwd6scLsp56E4smS
         irRAFKxJmMgYhqnHt+IsKfUWpEyj4WR8WrY6BCSd1Mir+2ZaLUk0d0cMXnm8bzZCSH34
         GrqgloE0iQ8ZI8n2Rm9rkxNKfpWCu6icdvfsKgHQtOf7j8Xto7P2e8Ww8Biu4bvVxMd0
         d3wRIOo3am3SJ8aGVRJK3Aqo2u8seApjCbdKXda2+2lVqaTWsgFXdQ9s12iMZ4eG2iiP
         NPfQ==
X-Forwarded-Encrypted: i=1; AJvYcCWaGS7XOCZEA9zOJEt+hx5I38g2brG6HQHRcRrEXpm7EFHHbjCSgUmseiyGI/bfumunyiklhzp9X0kLNzrbgJcOGsRW8Q3OwgkdDVw=
X-Gm-Message-State: AOJu0Yz/6PuwCt7xKdzWHFfnWIBIwKvyhmFP/Jao2MekF8aVeMDyyfIz
	YtNyby8YY6rP1jWsw1pVfupTIwgvT1ohAjFdFmPqNB/XsFkPJ9nVeMhg4ma+sJ1zuLu72IO8tOe
	r818hR3HXFP1uLCaeObmQWRkP5vY=
X-Google-Smtp-Source: AGHT+IF9f9pLaLdPeTSCtAhybglIyQQ2XIUnjYf9d7DmVSyCMeubFDXCZGcM00CwqQ2KUlRJTxsSfizN1sbtkt9PlhI=
X-Received: by 2002:a17:90b:4c81:b0:29c:71d2:ac2a with SMTP id
 my1-20020a17090b4c8100b0029c71d2ac2amr806844pjb.18.1710351861647; Wed, 13 Mar
 2024 10:44:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240313154857.12949-1-tzimmermann@suse.de> <20240313154857.12949-2-tzimmermann@suse.de>
 <CANiq72=5V_XChzDhaaWNC+B4LP7gqivPZj5Y10qqS4SkQTGB_A@mail.gmail.com> <03ea1afa-e54b-4f31-bf07-03d9cdbacaea@moroto.mountain>
In-Reply-To: <03ea1afa-e54b-4f31-bf07-03d9cdbacaea@moroto.mountain>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 13 Mar 2024 18:44:08 +0100
Message-ID: <CANiq72kJj+Mz6QAMuk7y-OeymWZKo9K9ccXaRwR2r0AkHmeKdw@mail.gmail.com>
Subject: Re: [PATCH 1/6] auxdisplay/ht16k33: Replace use of fb_blank with
 backlight helper
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>, Andy Shevchenko <andy@kernel.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, lee@kernel.org, daniel.thompson@linaro.org, 
	jingoohan1@gmail.com, deller@gmx.de, dri-devel@lists.freedesktop.org, 
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev, 
	Robin van der Gracht <robin@protonic.nl>, Miguel Ojeda <ojeda@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 13, 2024 at 6:11=E2=80=AFPM Dan Carpenter <dan.carpenter@linaro=
.org> wrote:
>
> Is there an advantage to making this const?

Not much in this case -- it is more about trying to be const-correct
where possible.

Cheers,
Miguel
