Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8CF519DFA2
	for <linux-fbdev@vger.kernel.org>; Sun, 14 Sep 2025 13:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757855898; cv=none; b=JGMHjSGc4BXDlV9evXduzEXP53xLkWEmiN6CBvujXNJEZwF4HIdkISggw6XpWQXYVApQdNa/x5gJG68uyB+DJhwl1qTJnLV48fU2xgPPjGzWqTjY4ASvRNATnijues2xB7laNvLglFJBCgiXQ8bZs0CkZUiHejZ7KsqcVvUOcDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757855898; c=relaxed/simple;
	bh=B/MHHbQKWKXKGrb3TcbxJQuhg0Fns/e+Mfok4N2hvrA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YC35ItGwNGngAcLnyfs21OI3FigkX4UWNyDmWY2RsD8KNRjz46fTq4wkik/0bYGzcgFuVhJFCffiIE8CA/Sgya3Xve+qe9U4VWh1fGlACRiOk7AMzKpEvut9iqoxlakTkB5iArgPmhp4dMEZcKMNZlLQTzBynEfnVS/886GgrkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JyH+xuXt; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JyH+xuXt"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b00a9989633so632894566b.0
        for <linux-fbdev@vger.kernel.org>; Sun, 14 Sep 2025 06:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757855895; x=1758460695; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B/MHHbQKWKXKGrb3TcbxJQuhg0Fns/e+Mfok4N2hvrA=;
        b=JyH+xuXtTzIw7P+pS/Wj9Z2HZzQ/wAauQs3hAFXYFxztmonsk0xxPMsbgnbDR61btb
         C9lhSgCe5snE/1Mdspi4PS/byFu1+9Ck0w2iT/GXHWUBiEjZhQgJvJhGuRHIDCGs0HYr
         fZ3PRKHVYti5DuKueBhv/7JgOXOss9cfZeRGEj8p/GeUCHdED+9/eyW3K3IdfKZVxGcN
         VU7/jAOkW+tej+g3jsqCBnaX9NVj9f79xee/BBwdt/S1TmtXUNG91k7h0BkAq+uOOOjG
         fGwnfIyaei06IU9Te18bJ7s3cpififLo6e29SDAmmH2SLIZSlOezouf80aRr1R8DuvoA
         5ulw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757855895; x=1758460695;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B/MHHbQKWKXKGrb3TcbxJQuhg0Fns/e+Mfok4N2hvrA=;
        b=dOGW04uc+kmaQ6uIRCVa7jMBb43e783aOJorZjZAOwjlE+mfouLdgfca5j8a78xBUQ
         f7XDjuv0OVbl4FgPt3TnsbXUhHT2SqRxIfu9KGM0NUZDX90s3as0x2pIERyeuO1RpLGn
         Xy3gwiv8EFUZ3KNRXKLhnBoD1hlGO8i+TJVCygt5zXpQZiG8CDbV0uK7YxahSJZRTgLR
         2TwjtJmYW1pBCbm5/E//6crNWR43VGqpLTZVRIYc55zaCT0orrIgNL648JRZFopk/WlW
         WNfkdirdypI6ZRSxF0DlYouRulKxmPujlS4VHqzbSqYwWBDGCSYV6e7fkHbA2MLA/959
         Fg+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUmH0YgzYWgirGu0+shf5xdCf3D9eV5a/7xfDX2+cDde0TtbktNWJrLylmLj8zi4/oQhh8eJTOxEcPiow==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf37tvx9ImfhOoC3Z5+D7IQS5rNZXJCm79tLUDrw/k3R1xDbWa
	E7GLYmhQA4V676HQegK/cIsDwhhP0uAFrDmxtwD4XiExAR90mvYzrPy4+etfa4J5fUvMBQ+LS3X
	9H41YTDx7gfC0TfUrKxIken6//DBvz2gyM2U9gKo=
X-Gm-Gg: ASbGnctlDFBeqD/flhUQ3aC2GMrjtNnxbdFv5KFc/yXhj9LujIG28POD/0dJBN2SO3F
	AXoZWtNi8VmRL8G2MIQGWT4KOa93lS+M6y/E7M5oM+cHygI9KQUSz2FSAUfriISgSd7rN/jWJbh
	zoC3ij5u2ZrIr3tiQ4EK0soxkCNhC1li3nQZw6NGO6flB7khzNQ7XHUG2TAs6e7bliebprgUf8z
	xWe5oY=
X-Google-Smtp-Source: AGHT+IFZJzjR3DE/qZmIuieb9Ec2cOdXAcGWHjEKWhar85GsXLWRAMdg0zButMdqYr0pWrjx0yF+GOztpSlmKRG4U7E=
X-Received: by 2002:a17:907:3fa7:b0:b07:880b:79d3 with SMTP id
 a640c23a62f3a-b07c2081bbbmr1208647866b.0.1757855895286; Sun, 14 Sep 2025
 06:18:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250913210600.36986-1-shaythomaspower@gmail.com>
In-Reply-To: <20250913210600.36986-1-shaythomaspower@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 14 Sep 2025 16:17:39 +0300
X-Gm-Features: Ac12FXxewCGgT69GHbv8Fx-4TnstLxtxDMBfEueTNpM_75YpkFCPUKNUam-IbP8
Message-ID: <CAHp75VcnUXcOWTBxZpTa6ihS0fef6rD8ySK_DHEjNribLjGU0Q@mail.gmail.com>
Subject: Re: [PATCH] staging: fbtft/fbtft-bus: remove empty macro argument
To: Shay Power <shaythomaspower@gmail.com>
Cc: linux-kernel@vger.kernel.org, andy@kernel.org, linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 14, 2025 at 12:06=E2=80=AFAM Shay Power <shaythomaspower@gmail.=
com> wrote:
>
> Removed the trailing empty argument in define_fbtft_write_reg calls to
> fix SPACING ERROR reported by checkpatch.pl.

Please, always compile your code. These are macros, you should
understand what you are doing...

--=20
With Best Regards,
Andy Shevchenko
