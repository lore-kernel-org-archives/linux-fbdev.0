Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7CB33A63E4
	for <linux-fbdev@vger.kernel.org>; Sat, 28 Mar 2026 17:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774720215; cv=pass; b=gkRTfgFj1nb8RE15rtA0+kOELpjIvmFSJEBmIpdCZzVgFx08h3tBTIVx0FeYAn08ukdPVV9QxUKO/jkm7OCD/QTzKzM+iZDTQbSTnL0EstBz0Yrgt1sVkULJY7E2t44xa9M0OnRwg/xoh83cJJuuD0GYGw63crlFaVTpUtsYyj4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774720215; c=relaxed/simple;
	bh=/MHuV8XVqKwYNXoPzgoq+11DEhh4eCt8+xddHnvccEQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cMzapmXd3t6OMsO5l3r+kb2WkDJo0SjDxUSWCJokTxUVSwBRJP66tw0cL3hAuAjZH5eTIULP8xKI9U9YC3uXqFJ5WQKjBZZkcDKqtgsSdTbZ6bOAX0ELvS/z503nLpf6QhRNQUoPCVds/DrUi2v9frqFqdS7bAzyE7G3Nycj+5A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MwR2fI+d; arc=pass smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MwR2fI+d"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-66b2f6e983bso2716992a12.0
        for <linux-fbdev@vger.kernel.org>; Sat, 28 Mar 2026 10:50:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774720211; cv=none;
        d=google.com; s=arc-20240605;
        b=GMHF+0CRv3Px7jJJF5S98Cyw5MeA2M0KjxqyOZcVo9o9rq++c7F9qAf/CYCsQsjmfa
         Rq3wgmGOoY7dvgR85ihu3ISG1p033az5C0tzUk6pV0XLc6NX9qvwVQ4vabkio1uFrvz2
         sf+6GpVhgHib1QyGWA8E+ha9aKIcdsl2H2OgfMNpVSpSECq8Tb872g1tUm8BDsNMnbsM
         j6zQAdMjehUe+VsZONzRMlYtuuURnigdhw6QMrWEZFQxRjmIICuroRWASirMhKzaVcwe
         Uj5Ad7Pr5LfpQHQUM6bP8631Tnm2aGqZsQdj/heBBCcgYPcVDWck1R2QZI44tCI6pHvN
         Ot3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/MHuV8XVqKwYNXoPzgoq+11DEhh4eCt8+xddHnvccEQ=;
        fh=jQ1RElbVWR/w9fDf1PNyWSVQjAO4/Lr7hdrj9mqwTtQ=;
        b=ZTzb88LDjZYBbdajN2XpO7DcPzYub3zRtFbfs52zEj0pBBhEv3wdC9EdoqkK+iR17U
         Fo7jf4V8jzRBk+LDC1qExmPQglbO/x+oM7SgMFYHjjoVU/CCb55BJOIb1BNAvgtqLuPF
         ztjGgpOPIsVojkc74w4F6ZaS8PG0mHpRxxoVQXOkGVqshycXMuGItWTe5adr07yc4/Yn
         LnO/y2uKLzBz0htDso342ha/AwGZDlconmAStumT/0RWurzaj9bMiHxgGl2wMz0KA0rS
         Q/nBvqtDJi5bpvtuBPAYBq1eY/CtXN7FocnwXAJiL+4s+7AufZ8PB79Nl5uicq6zK+Zp
         PYsw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774720211; x=1775325011; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/MHuV8XVqKwYNXoPzgoq+11DEhh4eCt8+xddHnvccEQ=;
        b=MwR2fI+dAHMax1Yfs3q/6KKHQZqPRkzuSzBMMxJQJkKSbCpGk41HEQjwrHvEiZpmS8
         Q2yl5sK0Id4wS8MU5ekoV78ewQGWwUaV0XXC0MVdS2ARSexqZY4VcsWcSlWdInPAQPtS
         /7DeCmsWr+lRu1dzRXkypL2dW8OCFxvSmXZruJGBCnDakq7eQMzDD4uztq7/6O9qwtYk
         3XGvgzoSA4pUkp2khI0YvmJevaKp6MYY9yZJF93pY9cDpswB4Fge72QbERjnYaF3sZOQ
         Xl+grLoyoQBPxsVkOSEICPLAJMHyz6hLy3sA+e+Xn96Gob+fnV4YU+m0tJNgEsSScJMu
         6NoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774720211; x=1775325011;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/MHuV8XVqKwYNXoPzgoq+11DEhh4eCt8+xddHnvccEQ=;
        b=E1TLyCvKtz64ZwOPL7Cmp/qCuPJ2exK6unQduSvkWzFRS3s6HLespXaP5Vn5zfEt9r
         DReJBQHBXQI6B0d2LZRTrBvSs/ttRSTr4jR/G5IXtQASYghd+bE2tZf42sZH4THSsCBL
         pSFSGPVMfIOdvhuaAkQSB0Woo9mmCEY8zdRY/rILJhs9YWt0h0TTY/vul/aH8Yns+BaJ
         tKw0mDDtLnieewhDnM1Z8Bn1SSPndFOH3TNS/KGcn19cfLiE2exUi8aBwMptR54KmQp8
         /Z8SdCvTGF54joWAWRyju/Mg0Vf/VYVFdeIgr4jFUpqJQN5XyGEk4UOXVmQkmvgQE3as
         LK3A==
X-Forwarded-Encrypted: i=1; AJvYcCWMzypFYa+S8X/ZTLzj/Uj0SfupVCBrlN0jgCC4alNwpVQyRXlWlxFEPq6WADBVPDa0OdljnyUsvhkpkA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7XvKY6B+UMKaOIPHZ94pCvS92Mx48oxrZIL46h39CrvM94IvK
	XZw9ypLHkgJDdBRBqah2YcTmhr7kSq/5hrCf42U5rMGwY11UcAby9/SP1G/jBpnl03iWIexJuj+
	Pke5nEIy5JytYAYbcEXc7SasvAriEnjA=
X-Gm-Gg: ATEYQzxE6b4zpG0PDAweBEynze8qRtCxwnA7O+2uwZ7TgNdPQ3zAoGbYgPAVtrRkiUU
	MIUpCHFvI83a3o0ViDr6Q/NSoLnLJC1bSBaV8mSTHcyLP/cM3glQWGtyR0JIqTATsP62ELpH2kS
	XNnWFOIZMpYb8zVRPdKQszFCVB/uuHrkyrhQ+x06/NZwEs27YNW72Kr4eVG7vLV/QdMuX7yXVwR
	aM487Ca0Ovlh3ZoV+ThQTrMg0vJU/UlNP23fNTbLahL2ict+LXyGyrx5CyBMhPggn5JRZ8RJnKm
	OhyCULk34wgj5yOXdbn7DisBBmlYMt1A1Ypv0AcUJLsEH6drbK4HL4Usf14s9Xiye14o40FjMcq
	7Au2MPfQ=
X-Received: by 2002:a17:907:846:b0:b98:51d6:883b with SMTP id
 a640c23a62f3a-b9b502bee4bmr483537266b.4.1774720210902; Sat, 28 Mar 2026
 10:50:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260328160114.1143108-1-caiyuhe80@gmail.com>
In-Reply-To: <20260328160114.1143108-1-caiyuhe80@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 28 Mar 2026 19:49:34 +0200
X-Gm-Features: AQROBzAslN_ZWujLGMIjg5dfPBwHz5pbP2BKbO1h93l6if0I00QuCKVboVXLlB8
Message-ID: <CAHp75VdGieY2qTZ_HeODxLMW8P2E3O9O27K6RRJoujxB3NZ-DA@mail.gmail.com>
Subject: Re: [PATCH] staging: fbtft: avoid empty macro argument
To: amanohina1 <caiyuhe80@gmail.com>
Cc: andy@kernel.org, gregkh@linuxfoundation.org, 
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 28, 2026 at 6:02=E2=80=AFPM amanohina1 <caiyuhe80@gmail.com> wr=
ote:

Read Submitting Patches documentation along with
https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git/tree/dri=
vers/staging/fbtft/README?h=3Dstaging-next

Act accordingly.

--=20
With Best Regards,
Andy Shevchenko
