Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C2A4414;
	Fri,  4 Apr 2025 07:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743752212; cv=none; b=JQFzaVtHnopsGuGkEImmXr6c7sSeyTOD2g4W5V9QczJxlBk9oRQLR5Cq3NA+v12Wp3dJQHRTdYy5Tx5AJJRrJ2i8OPNA3enZRAddS9QeiP/OMKzYEhO8jkl9EbjWE1yMjyfkny0sq1Eig+FaBgnlEUlJv6t3by4NBt80eEFcjmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743752212; c=relaxed/simple;
	bh=/JMu30CjQcudr/fHryRHNEXoPsMTAtgHdEimYDirric=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=plyaHDzUCZAoz36RcgA1eCIXz63L8rI7Na3zGLko+1X1w5IHwqkgF1Usgkjrh4cQw5zITOkIeHhy0RBEmp5Fpia8kZqla+r4MBFmQfeDvztqWYCnlVstwv9pIFK3M78yRpLnO8Sz7ahkbDOUXKbMCzwrE8Z1HdwhP3Gupc5kgqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D2rNVGJn; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D2rNVGJn"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5e5bc066283so2809459a12.0;
        Fri, 04 Apr 2025 00:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743752208; x=1744357008; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/JMu30CjQcudr/fHryRHNEXoPsMTAtgHdEimYDirric=;
        b=D2rNVGJnPOD4BzMsofDbXvFjQ0Ind8QWIg5womQYc6UX+TtdC5vKR8TzcbMPIOUX62
         /iy3yYA1qous9jojrdAUYuPocwN25SwTa0XA76Gi1hPo1gdPTiGbApHxM1fYgX6jURqk
         8qfr5rjOiXbQC6sUACNr0U+cQ4B34/u/09MzTQxxhxM6K5hUPwBV9JauXiAng4pVA2QN
         nUhbRe9Yjm8rBYgGTBonbWkP1u3HaDye3iAZCMJ4pKijgGJDrQzVKCR8F4YumRAOqYn9
         Z3m5vTaAPg/NiibiCB/Y8sYX6zbKUNlF/Af3ZWCPGtOcTH7GJ4dxlXi020m7ZPqC4Hed
         l+0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743752208; x=1744357008;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/JMu30CjQcudr/fHryRHNEXoPsMTAtgHdEimYDirric=;
        b=XutHj0pV1EbNMoNwqM4sIpoXNCK5CxuWR2mAU2Hdx9rMd+tgfFLD8bRdBCR3koFWJp
         U03U4NPSdEJveiRHZLyFmKPIT1ek+gZ05kVyi0exW5K0PduxJl8J2Zr31nSXyq2rP8lf
         ebehLH8Qt+PflHbskExdPM2Alsi9BI0Ll0u2q2e/lRCyuXJMgY2lUkMXCarCQL6N2FYX
         lqrN2+G5/d81a4fF6FgHsX16MfE6+b6KNYHU8+ky6SZYcD/6gTJRTLZqhfRFa5FyPcX2
         tOYey6QMk7XYcyEd28xe/lF+0gSIbwi0Vr0h+Kp9uJxwBX7xVq6bhKWYK1s+z3srRxur
         NR+w==
X-Forwarded-Encrypted: i=1; AJvYcCVgynVzi8eWI5fHr4sQKoDhRyvmRjw708Fm8K3ZRXvt770BqCGsBAhbHvyfjjR05tG7zoNtUsMGBUbURY8A@vger.kernel.org, AJvYcCWL1DuznjejZxfzgtKvjEkKbGKkjHtQ9tREPegFW7rlzzfsFkbqQZ5XBmAtxqBNJ+f1HRXkxXDhs2YvxA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzYWFkK2vaHMUWQbPxdDCJ5YeNiTWTwW12MfFNzclPGCnotmC39
	lnxw2uahDnGB+sxKw/fdx2KAAL7ptiibARdsvmKmoMdehAmx5ZbJVuJMWzukCcEA0Rw4qX/Hs/K
	AfIAxNSyRP1068XJ2R+2s7A45DYc=
X-Gm-Gg: ASbGnctY1/1hvJ7w26ghl0IVfn7ErpqW7MfG2VJYFXhRcxOTNX06geVTLxSOyChX2BB
	nA4GNUfH1ph7r+kKnif7XOLsOj+7kh2Ma3QmT7Fc0nzKlnw0anJdGKJ65aZ1e2dFnYRWPrKE0rf
	wvYbm6Y+SzLkOfJoFbaqwE/khZIBso
X-Google-Smtp-Source: AGHT+IElOHIIytFmbfWzBLqXsSKpHYVQVhB5Rj/aFXMOU2l0b6DC0FX/EUK3uWLpCJMa0J4+h8O+x/RydaTbnd1jyuk=
X-Received: by 2002:a05:6402:1d4e:b0:5ed:837:e3db with SMTP id
 4fb4d7f45d1cf-5f0b6623595mr1315347a12.32.1743752208346; Fri, 04 Apr 2025
 00:36:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <67ea5813.5d0a0220.293276.775e@mx.google.com> <2025040301-tightness-giveaway-a568@gregkh>
 <CAMyr_bL3sh3HyL0=Qb1h21_-5dqJy0M0Ewo0JMFPNr=x28oNgw@mail.gmail.com> <2025040443-serrated-flying-c329@gregkh>
In-Reply-To: <2025040443-serrated-flying-c329@gregkh>
From: Richard Akintola <princerichard17a@gmail.com>
Date: Fri, 4 Apr 2025 08:36:36 +0100
X-Gm-Features: ATxdqUGY1yYTDvMXmhJXcUVznI-zoiX9fYi0bfoGGmZDMxXxSTlQAlmX6W5FJtE
Message-ID: <CAMyr_b+XY6hsDvxD2YMghoz8oFEePuC6DgsVVzw5XrjSTEy5UQ@mail.gmail.com>
Subject: Re: [PATCH] staging: sm750fb: modify function name to kernel code style
To: Greg KH <gregkh@linuxfoundation.org>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, 
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev, 
	linux-kernel@vger.kernel.org, julia.lawall@inria.fr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 4, 2025 at 7:22=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org>=
 wrote:
>
>
> A: http://en.wikipedia.org/wiki/Top_post
> Q: Were do I find info about this thing called top-posting?
> A: Because it messes up the order in which people normally read text.
> Q: Why is top-posting such a bad thing?
> A: Top-posting.
> Q: What is the most annoying thing in e-mail?
>
> A: No.
> Q: Should I include quotations after my reply?
>
>
> http://daringfireball.net/2007/07/on_top

Thank you for educating me on top-posting, and I really appreciate that it =
was
given in a top-posting style making me realise the consequences by experien=
ce.

> Please send it as a patch series.

I will send in the patch series as advised.

Richard Akintola
