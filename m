Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7DDB14B96E;
	Sat,  7 Dec 2024 22:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733610986; cv=none; b=nEND6YBAs6oGqCdduyS5xeKwg5DaYnAl3CMaSePnKe13bxDLcZnnlgX/Q44UqfDrco9gyEE4wOqzv/BALxE0p0/sMWNzVj0YOVMIJQX4l3k4dSPDbtMo7qM/J5U8Isq52krdl5QTvVBkkZiZESv+PqFFMbeTaAHRVhnqeC63ba0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733610986; c=relaxed/simple;
	bh=urI7US1zAMf6eOuwKNpt419Njn9MCMtobiUqyPiJ5WQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N3s4hUNWSZBAvkSA+XCRiwFRPj/XEjpPqeKEjiNKtMGyEfibbVi0+XxkSTFFVuHwQEbwB4kdg4AwC5stSq0z9J4wmF8ZR+NFF9YVSNq5Dko+0EkdJbcF8h0spBnmLdQLx3RKHA9z6HPCk6BjqyHwqcEPwn5Z19AqYrQ++ke5f1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AsYNoyC7; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AsYNoyC7"
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3a7dd54af4bso14706055ab.2;
        Sat, 07 Dec 2024 14:36:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733610984; x=1734215784; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=urI7US1zAMf6eOuwKNpt419Njn9MCMtobiUqyPiJ5WQ=;
        b=AsYNoyC7y04ut0Sf8vJSS+FrsfZGcMKAOEyGVKwo4rDaDj2TD1q4R33BvNNtoaDYYi
         Y1lhCih3AU92y+Amq9eSgDdwSPITW5OmI3LjYutyH+Iungc5KEXe4p0beHyVggVuMe44
         Wt76pCobw58ciBtDDKuqQktiaI4imFBmlXbgz6M/Ua9os7+3ZeTGsi/l4h8gTbZD0qzF
         lSyzjnmkIdzQoSyKlykOhlDpEcYeLBAu/K+jdEW0SBkXY8mWq+zQ1GgE+PnIWX9cg5y+
         vva/5HctCXXrZ/nY/6UhFlBtfX+hXhW9qh5Diivc+GJpqDEhOcANFwBkdgnCYmFl0cLq
         d7xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733610984; x=1734215784;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=urI7US1zAMf6eOuwKNpt419Njn9MCMtobiUqyPiJ5WQ=;
        b=ApDPTvPzIn2iSDj6qyeeZF3zqGGAmgCsUnLGyiruF5HinCzsyow/gdeAJ7oUCTPcal
         EIRt4lHAxEU94e5j8Hj/S6FwkTo8FR+7UzGQBRMUY0s/1qgz41gYKwdet0C3Qk9DwwTX
         CqDUy3RRlk297uvUYwIVV/+/TKkZgOhRj1t/43OyNYyXr5vGY2rf9W6LRv5pp7WRjUJ2
         yVbtSd6qRKLTtoKLwAe0zF6m9oxECkfhmxI7en/Cpq/1sVKN+XoMGEj1CY84eV5Vud/8
         0aqH46FlvSTmfwJQbDGYmczvawv0LJCALgigocVlLvm5lItlAM13HxCVfpTSJinxTFkQ
         GntQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVuhj1aQVvMT08hsPbDXN/IjbwIY8MX4UXFHa1PwTjdPZznnTkvbwIWL0c4C2BbJG6inqGf8MutLjDwA==@vger.kernel.org, AJvYcCVeROoOEExJmsPmVF1kHwo/GZi9EHXnn7FWQwmKqXIVVIsgA7pBugKxkyuSSmt6k0SsMlEz6mg7dnE22Qif@vger.kernel.org
X-Gm-Message-State: AOJu0YyI+X9bfJgmCm5xQ7g+GQOQMnBHclwNE1T5sa1Gx3Pcf0TkeT/U
	tchSvG8tstSpGQYOXli0c2zZrXXSWETnWq9dmthj1f4S1oj045ddnkFqnH8Bp5K+lGgwNasYmeE
	asajwKrYgPhy0igIh/cjYoeLtxqgq2DCKWP1jHN1/
X-Gm-Gg: ASbGncsDIMEX+4KGMDYhUA2VsknyheLxjfU7vvZdP+dYCUV8bhmf2+T3kssV/kAQToD
	jxqwlzgBs6EUN9QFtsdo7lix+SB0=
X-Google-Smtp-Source: AGHT+IGxzU83LUpVfJxMuU8ObhncHI3dIWYNbBVPEPvjuESw/sHk10gB7/kPZJqaK7jk0SPcqqX5+a98M+3fxcKvZ44=
X-Received: by 2002:a92:c563:0:b0:3a7:6792:60f with SMTP id
 e9e14a558f8ab-3a811c799a7mr92656935ab.4.1733610983875; Sat, 07 Dec 2024
 14:36:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20220621104617.8817-1-tzimmermann@suse.de> <CAEXMXLR55DziAMbv_+2hmLeH-jP96pmit6nhs6siB22cpQFr9w@mail.gmail.com>
 <d2562174-eebe-4462-9a9a-03936b3bcf89@leemhuis.info> <b4d28b98-a85c-4095-9c1b-8ebdfa13861c@suse.de>
 <CAEXMXLQEJPVPyqLpH6C7R6iqhhKBpdNS9QeESbEdcmxB70goSA@mail.gmail.com>
 <da4288a6-96cc-4095-bd73-d66b68e9ed01@suse.de> <CAEXMXLQw1yqUGbWcrKZdOuGvA4eZMG0utiyQ2PVRvTeuFedGbA@mail.gmail.com>
 <9c902ac0-a94d-4465-98ff-840132e482b1@suse.de>
In-Reply-To: <9c902ac0-a94d-4465-98ff-840132e482b1@suse.de>
From: =?UTF-8?Q?Nuno_Gon=C3=A7alves?= <nunojpg@gmail.com>
Date: Sat, 7 Dec 2024 23:36:13 +0100
Message-ID: <CAEXMXLSLau0sEy8WSZ3=ofK97xP8aPcDQEnT=JFkkt7K=Rzivw@mail.gmail.com>
Subject: Re: drm/fbdev-dma: regression
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Thorsten Leemhuis <regressions@leemhuis.info>, 
	Linux kernel regressions list <regressions@lists.linux.dev>, dri-devel@lists.freedesktop.org, 
	LKML <linux-kernel@vger.kernel.org>, 
	Linux Framebuffer <linux-fbdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 2, 2024 at 12:18=E2=80=AFPM Thomas Zimmermann <tzimmermann@suse=
.de> wrote:
> Thanks for testing. Attached is another patch. It attempts to restore
> the fbdev handling as before the regression. Please give it a try.

This one fixes it for me. Thanks
