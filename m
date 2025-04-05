Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B6C1BD9C5;
	Sat,  5 Apr 2025 10:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743847748; cv=none; b=VNXEKieBMM3kzEuGQ0WhWwFNjzQfODA9LnCIbPkTjlB1tzHeyntF5Z+YY78IOfkoZo9Z4xIVk2JBe99AUlLHv3S8JsvNag1iLTDURaWn64SVeap8PvciOxHkWiGlvnsSTRDIhtFUQEOEgQpjynuL/oxPsIF7xqjc2sEI2h2wzkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743847748; c=relaxed/simple;
	bh=fGaTrB5oih+12PuhnBL5Qe55JuLREZCVtfXruGEhLTg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=rNF9MmL1GPBlzgH7UKEn/Zl4IWAwtqUKRjRTRVXbX3vBkcLcSOqpC81arPNuU7em3i2md2BZp5eSyQgLgDtv5Gt+axfT1EzB3u1cTie2QgsN/rDpx9xcZ0C3YTLWebbwFDbPqLaP1R5STo8lE30aPdweXSExw2Xut/LOLF8izI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gFtEpNzQ; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gFtEpNzQ"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5efe8d9eb1eso4963089a12.0;
        Sat, 05 Apr 2025 03:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743847745; x=1744452545; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fGaTrB5oih+12PuhnBL5Qe55JuLREZCVtfXruGEhLTg=;
        b=gFtEpNzQhctfVy6gji2ItPuutU1zOKFBuxuaIrBQcXW/abgPfKvQTBma+xiqWHi+t8
         j3+qiRmhDZmAyK1e/FjSYJDvyf9271s03MSw4VJn4oSHRMjKaRt8jh4mcvp9PeRbXmOs
         zF/fFxMtvmllDI1i9zGr3h35h16D5sYYSh+IcIhjzR3lRWK0BYoFwgcIgrgP6rfISclk
         gft2e5G92AbVIddVxWKzfpSRA45bic6dQ7i6v9/qmqioZpLuonJ6IxYhcPD7JxppNxrh
         Frj1Y9K8KlY7bwlqaAXubnrDhgmlI0SlyywUOhgg6/Hdu+AkDyt/6Y733Smf7h2U6M4j
         MpAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743847745; x=1744452545;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fGaTrB5oih+12PuhnBL5Qe55JuLREZCVtfXruGEhLTg=;
        b=QjmHbaGqAj500IuMiv+WSZcdOk5eAEdjPxMXKGywXSTnE9x3uI6jZJwHV055aMb0yR
         DDJ8bAVhyFpaDwgtun5dc+gVCSf9cH3vZelpQhbPrpnuixxN8wLSEOaKuFXCzLMSXtTH
         KiLxBU5D1ought7rUrUidhnJAJf8BJOkeVyfD5ucYc0UrEHV4za7/TAOrRE3yZj5eq/r
         5hIafalln0iqe15j/jIOaPPsbclqGcD5qUmdYRRdCI3Wj+LsCrrX1GoNHF716CzyCSnj
         6QUegsm738RssKeuC3CIUEQqWXyiMYlz6Lz2yWT501bY6ZWQzVhL1jn7AAIA4tgJS6wM
         v36w==
X-Forwarded-Encrypted: i=1; AJvYcCVVxXsA7cyvOqrSiYOkwLkDAOthpt/LPUi2PxyqUXPl26lsD48aLys7khYUhKkh0wuiuzAgEppVbxLIhCTV@vger.kernel.org, AJvYcCXR7EgH+jmXx2enPh8CPHcY//IHJmA2fNJmC6LkTbzDnMEDLKpm3dlwGRsfx/VJU2+XHU5cbrO32QdvTQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwKULOO+qOIDdw0U0kc7KrJuWCh6BEwztLwL6+1q3aqN+M4TEFv
	cZjklGkce+s9PbEXnR4kcikvDhMuELCZtDR7rZbGteVe5UMz1vXhoCuXfASDXfEtgA9u4iCAqIr
	OTmwdJ4RZ7WF7yUDWY8LTBq3VJfmDRPi9rB8=
X-Gm-Gg: ASbGncsfb2gVG9O/cGyw2ovfyq2zLmuiWHjvF9glIkmFwMQ1Q9vzJlqgru9soBc9DQG
	+bwepy4/tEUy+NlL2kj18y/shDR4qkZhVmGKnM6zzsHcB6AmxdMGgZKfIo2Ny5Q5esjF3j0MZoe
	ol8gg/YZpCnOnuVBNYcnpZr2XuzA==
X-Google-Smtp-Source: AGHT+IEtBG6cEhDYACphqOPFb+zuFQGv/Yn98G+ufkJiWugDbYthrSCzqMMX2xbYKLrgtVL37wmNk/64SlPv8In6SJc=
X-Received: by 2002:a05:6402:2682:b0:5e5:334e:86d9 with SMTP id
 4fb4d7f45d1cf-5f0841e7aa6mr9124954a12.13.1743847744651; Sat, 05 Apr 2025
 03:09:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <67f0f9ff.df0a0220.33076c.f0e5@mx.google.com>
In-Reply-To: <67f0f9ff.df0a0220.33076c.f0e5@mx.google.com>
From: Richard Akintola <princerichard17a@gmail.com>
Date: Sat, 5 Apr 2025 11:08:53 +0100
X-Gm-Features: ATxdqUGx0SOhwurgXEVnAhGv0GSiFsIfvW2iCASBPpp4rfdS8bnPT2PTeAb_8mg
Message-ID: <CAMyr_bJpE=NHi4bS=_eAWcm1gxKiKDA3YQ_mYRCDi3tjuBjknQ@mail.gmail.com>
Subject: Re: [PATCH 1/8] staging: sm750fb: change sii164GetDeviceID to snake_case
To: sudipm.mukherjee@gmail.com, gregkh@linuxfoundation.org, 
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 5, 2025 at 10:38=E2=80=AFAM Richard Akintola
<princerichard17a@gmail.com> wrote:
>
> Change camelCase function name sii164GetDeviceID to sii164_reset_chip

Just noticed a typo here, would send another that has the correct
commit message.
