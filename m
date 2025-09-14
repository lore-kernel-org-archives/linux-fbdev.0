Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C467155A4E
	for <linux-fbdev@vger.kernel.org>; Sun, 14 Sep 2025 13:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757855835; cv=none; b=ZP2GLfode6FTJsnGtK8KIqu5dvjexSKB3+YfgZIekldTm1awCxomG5EDV8XfXlmp/o1sRybvV7WLJxhfc9nOQC+xQl3V6897oC6FGNky4MWnEpZcBpzE9SDFwm1zHx1yAFD/iVjC/Vgv7vdNsfyYF5JRi1xwkNxDKA/keJJkYhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757855835; c=relaxed/simple;
	bh=4IJzghTZyFk+V7nl6fQn98vKJnXu9hEQAbqGTMr55Og=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I/xYWuFPQKO6FEauD+GgPFSP1KKusRswOj+aFBkjNmxVc7fWte4wUAMn73PW7YZy4B/FFWQQlaeJUmkEzorauYZMzYepgPwmHNHmrq9wqQUjbOtXoQu6lY3rhdFxU5Fb3xVM0gxtvM9vAVGyvXgiFQyCPtS/rUHkN09StQMmbzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eNVFUZ02; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eNVFUZ02"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b04271cfc3eso423560866b.3
        for <linux-fbdev@vger.kernel.org>; Sun, 14 Sep 2025 06:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757855832; x=1758460632; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VMvCzG2QohEMnNbVfOkDiJ2slh71CG2iSq4/6TwPDRY=;
        b=eNVFUZ023qOvwSPxEYP1hQu7C2nF8+9zjQUldquGucEAqzQomr6AgrX/zDfCq5mCb2
         ekwlR3hyJOh37T/haVyfpDY+Da7rjvjtd9EBV13aDF9NvPJG7wauyiMS4nj0ytfjpDqI
         PDy+iSorZjbYB7opSx2xmEt1CymbwOeRa5EVEq8aXj6nYn6IBiRj5R1gTWUcPOy14kLY
         Ly1WdAfWoUhWOr+VxDo2zXFn0mgmS3ycYOmzuFW8SfhUtyoAkDRV//wdcXoqXe5KB4o8
         hpN08t7b3BckEV1llpqexzS7pm4wNiDAZKLSiJQAmG1fBgxcieXS/QBCIRrIzhV7xcIG
         IixQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757855832; x=1758460632;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VMvCzG2QohEMnNbVfOkDiJ2slh71CG2iSq4/6TwPDRY=;
        b=IdDIT4NnHj+qSZDdYR+qTX+N/K1CT83uZgQ5GisI1EM2H5SL57oACteU3RCWqRvRES
         v6RkMpiQ4SInOAWys28t4jotfCfrq0lBS94Fx4yPry5ALKndx1Vob7SSK1vItn9QEorn
         JuWKZuH6EwJzRbegvTx17vdHyQJdFH+k5PfyJ3MlvZCd6nfO7v+thwX7MEi33y0EokNY
         89RzOzC6b7PsLzjMySelEi6zTkJJR1ZjTFEZ5nZkSrXVHMGK8pve51MRsC+02c/NgtpJ
         Wuw+NcLMuhkUdVY2f2EDfSQpvFpLzO5UDY6qKfFjpZ9gT6HDxGblBPfOsQBXaACB2RN2
         5mxg==
X-Forwarded-Encrypted: i=1; AJvYcCWaF+QG0CTeBnk/33rmWgZ75himnOvLJghzpQcrWJfyKPf7/HtAJY7kgC841m5dA6ObFXheMIMXnzkcJA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwLcx4QMHofGXMauclVouqQPzPjNzJYzqQ325iTPmUn8SX1xFlg
	k2v7ZZf2eLMZ22Ctwrrdl49gigU5S5S2Vzj5GjzMfBu8PM2pqYxP1OH9nqjy153cQ7evTGnVUBS
	i7zSUUD4kKp0M/4n0NWiGyr9OyU3qvt2qZNulGqU=
X-Gm-Gg: ASbGncvSdD8PPITA40rAxdGigfLNf9HGu8LPaC+0HuxAFmKjwV4u/mTdlQVQBmxbY8b
	kFpdICyHsCj/uDH/Rcz1tSyGGNP5HNuMEgwjmZhsrk40EGY2n/AyeQG8p4ksZ4GLbhHrS3fxAJn
	tI9/7WtI9qD2VM08pR8+gYPGuuWOVHZiyk+JfjcOJoDgkil66xwmt8uAIzWlC7VM1dfKApfRleS
	ZnrfRU=
X-Google-Smtp-Source: AGHT+IGQWCxR2Gac4xPiL8D9KgXgiGtd7tFcnyGpphGq+VIE+n1JrTdBZSMFUWqAi5ICISdmwA3yCJQTbDVPKdRiYZ4=
X-Received: by 2002:a17:907:1b1d:b0:b04:2edd:280b with SMTP id
 a640c23a62f3a-b07c37e1907mr843954466b.39.1757855832412; Sun, 14 Sep 2025
 06:17:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250913204110.24980-1-shaythomaspower@gmail.com>
In-Reply-To: <20250913204110.24980-1-shaythomaspower@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 14 Sep 2025 16:16:34 +0300
X-Gm-Features: Ac12FXxzo44Yh92_XgEzXec_KthqwpOATtacfY4xJGWidLeF3FTQ72dLqmHLyew
Message-ID: <CAHp75VeBq4rR0kqhFF=koN-Za_RdhWbzN0W7MHF4LWORsn1WAA@mail.gmail.com>
Subject: Re: [PATCH] staging: fbtft/fb_ra8875: replace udelay with usleep_range
To: Shay Power <shaythomaspower@gmail.com>
Cc: linux-kernel@vger.kernel.org, andy@kernel.org, linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 13, 2025 at 11:42=E2=80=AFPM Shay Power <shaythomaspower@gmail.=
com> wrote:

You must provide a commit message explaining "why?".


...

> -       udelay(100);
> +       usleep_range(100, 150);

In both cases this, besides not using fsleep(), moves from atomic to
sleepable context. This is the must to be explained in the commit
message as this is the main point of the change AFAICS.

--=20
With Best Regards,
Andy Shevchenko
