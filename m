Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3DA74C19
	for <linux-fbdev@vger.kernel.org>; Thu, 14 Mar 2024 18:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710441904; cv=none; b=bKXzbl18RFRWCa4VQjSmAhZtulJjlouiY6KKpMmCi2GEvgvE/9tSdKGXO4h4ayveM27roLhvRhLRiVh2gSRQv4X1nG3VeSTA4k8LMrryuIiM8uSqOK0MARSrZckCRj7lxMXj4NIBhp4m7kU36RSr8+SL23bf/ojc06o9eyYb6TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710441904; c=relaxed/simple;
	bh=MdRUBQjuQKEr2keYvjv61bWNOQ7/Rlg66Padmbb9nNM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pz+Z0wPkJ5HDchSZJzmLEMVYbMp9RpWkqXSK7ex7uIZFChks3SaSa0YLqOpD0OXqOTJFIgHnmbEb4HFvVTDwEy1oo3mB6eMm64yhOVc2TiT94S2cAnZ1xhGlabMEz2+bBjNGSdSp1LSCqQ0KPlUjKuPcmvcoBKv64x2YX8jq3lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hND/YFQR; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hND/YFQR"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-5d8b276979aso954108a12.2
        for <linux-fbdev@vger.kernel.org>; Thu, 14 Mar 2024 11:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710441903; x=1711046703; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MdRUBQjuQKEr2keYvjv61bWNOQ7/Rlg66Padmbb9nNM=;
        b=hND/YFQRkvRtz9Kf2UetIgXlVYzvOd6yTq2L+rBP7QtNZg5wuhRxXCKRl9L0vPMt0g
         JRB4/ujSRw/AByA7b+JtvGIf5W56Qwr7+TQDh0J5rKRrQwH5flr10zee03nhro47qcOP
         FGgk3TN38c/yVZW+wJP/AZqZkdB37FyjOCdcnrti8DcOJdkf9f2O1B+MYka4ZP6I8Ekv
         sEHsXKzVEvM/S1eFcqkts1nEotSPv21ezU2N9z3sJnVot66e7X+01XicXvhafATjEzbn
         xy/Q9Oy6h4GyOMogHBKBhEa/5Va/S+BZkr4mLj3FW41c80JS9KWMfc6iplH3GHFmII6s
         P7/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710441903; x=1711046703;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MdRUBQjuQKEr2keYvjv61bWNOQ7/Rlg66Padmbb9nNM=;
        b=nXzrVc5/ZQMPRgX8F7E32oDvmzBZ+JykHloUOxYgWUTpwb/19Pe6RceqM+S+/X/Jqh
         6drlTULoim0T58QZvs90jPMAqVwgKw/8uVOo85iUcN+sfN8HuKT4iMq8dgQfdWrpbS3N
         +RdiyvmGa9tFBal71KBnateXxAkpl011mTyPbb2bDwtVljH5noYwFihAOA/HyW+yfaGP
         Ic4Ihsr25BG3hXCpNMYpIjYwodEggP1QaRHMuLzXEjVea/Zd1GyR+xH/kEzryjYHw5gi
         iAJ9L+8Rdu4ol2t0DEekuqC2Doe6wPQ+yjr+SJfeHnQGuJfOmMm4N2K6bbzwC/x+6LEO
         ugAw==
X-Forwarded-Encrypted: i=1; AJvYcCViFWrM5JCYZC+GUCpqVAlB0SeJWx9l/piSc7w8P5RT/CRx4ossPJBQB/z8l5i58nBlvMWldXIiElNl1A7+j46ELBRzJ4dIlxyLAg0=
X-Gm-Message-State: AOJu0Yys5wM1+sna1CL/UvQynLe4MT3+O6VQiOrTC53SPaHZH20aKFB6
	MXnRcnB8UGo4Bb+UXxDu62bLIuDjA6D6eY3LYMoa2hyUK9c+e9NQhFJhTMWedmtkBrwUPcA3Bgi
	H7IdHzJaEIxt0uLa22iwTHt7u8i6GJNEYDIg=
X-Google-Smtp-Source: AGHT+IElVDkE6h2N+narObE2NptN8URSUteehVkaa7yyeR14RvAyrq7UfdfojrQVblxCfBAHP3mM/HO1U0Dhq5D4HGQ=
X-Received: by 2002:a17:90b:3118:b0:29a:e05f:3f55 with SMTP id
 gc24-20020a17090b311800b0029ae05f3f55mr2569865pjb.2.1710441902809; Thu, 14
 Mar 2024 11:45:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240313154857.12949-1-tzimmermann@suse.de> <20240313154857.12949-2-tzimmermann@suse.de>
 <CANiq72=5V_XChzDhaaWNC+B4LP7gqivPZj5Y10qqS4SkQTGB_A@mail.gmail.com> <f17e7660-ea10-4d5b-8234-79251c4c3483@suse.de>
In-Reply-To: <f17e7660-ea10-4d5b-8234-79251c4c3483@suse.de>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 14 Mar 2024 19:44:50 +0100
Message-ID: <CANiq72=hG65K-Npx1uRxr1SdEZACAQTvAZPD9UgOp129y71NdA@mail.gmail.com>
Subject: Re: [PATCH 1/6] auxdisplay/ht16k33: Replace use of fb_blank with
 backlight helper
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Andy Shevchenko <andy@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, lee@kernel.org, 
	daniel.thompson@linaro.org, jingoohan1@gmail.com, deller@gmx.de, 
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
	linux-staging@lists.linux.dev, Robin van der Gracht <robin@protonic.nl>, 
	Miguel Ojeda <ojeda@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 14, 2024 at 9:09=E2=80=AFAM Thomas Zimmermann <tzimmermann@suse=
.de> wrote:
>
> As Sam already said, it doesn't seem to make different in practice. I'd
> mention it in the commit message and that's it. Ok?

Yeah, that is what I meant -- thanks a lot!

Reviewed-by: Miguel Ojeda <ojeda@kernel.org>

Cheers,
Miguel
