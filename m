Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15CAB3E168F
	for <linux-fbdev@vger.kernel.org>; Mon, 27 Jul 2026 08:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785140691; cv=pass; b=BuiewMZQiRvRvfbzxrGPumwqEHoiMJA/5+74NHnepwlGbE2ImDs5Zx0dTonoNpBgITbeJAb679G7ZxBXzZjbj1kC2ckKtF+y9eslxTpsEcPMrrQ+XkeqjFbnfD9dEUCYj0mDtcQL9XXzVJc9nvQd20aoCXyfAanxY+LVMPg+s3M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785140691; c=relaxed/simple;
	bh=fkQtSqlmS9bP4148tvn2U0aV7x97yBRmtgLuyiKo4kA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rLQx6t+07LTQ8tSTWmDDlTKrk/W27yNZyoRWhifA2kFmatCg5nRP7GhDyotHJlCMgPXbof2OQ5fuVxBkeZh4p/C8NL+NjUUwJ2qAnXPFyctjtyiuyuL6bZpWkwpxptgUJHs03zF9RAG5id43SlmBEy8pz7KooXLSBS3S38AKGKw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lu7N5Fkw; arc=pass smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lu7N5Fkw"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-ca913a601fbso1770716a12.3
        for <linux-fbdev@vger.kernel.org>; Mon, 27 Jul 2026 01:24:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785140689; cv=none;
        d=google.com; s=arc-20260327;
        b=r96AH5VACAGlSf+2CoEV8V+u4Z4+H5VTrS3jPMYx6AlweUdOOewy8hNNwc1+I/HXYt
         EDRaDIK1J4LZdQ2zo1cWZty0bkpbLmLTwa4mtFQt1GCAUEXA6HvzGbrVHk6fubd7gjtg
         72fbQbBK1IN3ymKzMcqFdOqAd/MJzuGNjCuxlaWcbwX8yrEhDIQpppMQOSUL1yehzEfy
         awyOVajxAc2bxVm637ipzI5V5UXYrkAfAEdYJucHXpsYLf8RHEOIwlJVDc0odxg8Vs/Q
         +SCeTYsmgn/uzOU9lOC4pEQ2jfrsVwFFUR8EoI/16EXnlHpKPDzewnkDQU1o3PZbsSse
         hKfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/9ukOamIO2gMXk9qWFix4f5rPWog946EHuIuaO8IQn0=;
        fh=3PmF6X4UsYzwm9qQ7MqaPkyVB4sddR9DfG80rliIPDY=;
        b=iX9enSvG861sUIja4G7yjY+AHBDcY9gPJD8uKzdgDPcI5pQMky4TZLlpHehDJxu0Xz
         i+REy2SwoGrzDjHl/LDFq+uqPk7h8te9l3t+DCJ565fKEDwUPjNT57ZoFuE2rzQ3BFpz
         D/tes/YURHmXRRH3rfSlRNumjlYvUX2g8tGMu3AKP6N2JOcXr3LjcjDAXqMX6zzN/i5T
         O+wTZlTCtQIX6mNen0n32+/yDjzih8PdlmUOuoQ/u3nnyNdXfRHlZRAAmb7gjtu3GZTa
         P14H/bDSrO28E00ylfTcx4ZK79PT3es2E2IqV7zfVqJvAoeUyxQnhkRc4+D3yn/Vl1A8
         JHBQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785140689; x=1785745489; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/9ukOamIO2gMXk9qWFix4f5rPWog946EHuIuaO8IQn0=;
        b=lu7N5Fkwr8FCMNgMaaxNdwucjP31CfVDYVlf/pQZMo+eVdn1FBl6kpF5hpR94lshhe
         A8S4sYp3ZJ/sDaX8ltGAX5YkPKMYoB+SQRE3rrLftwE/hhZq/YX35j3z2xqVJBsJMO0I
         bjJMJTNTAVmqWGrdQKmLfsrTKPbnY18aNSfClHxuMdTJ9vvP5PGN+Yw4PWNatKgg3Tkl
         +7AZqQzU3JNXDp37qbMcIHq1W2BSX55SZs2vQvR27KQiFN/4ZTT2vuoqNc/K9v/dHDtX
         Yub8gUqCA5nl1rQq/ybRTGVfK1pHh6XqpvywyF/0SMfOc/iRhSqzTWhHdh99lBp1kDn8
         YL/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785140689; x=1785745489;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/9ukOamIO2gMXk9qWFix4f5rPWog946EHuIuaO8IQn0=;
        b=jwT4ngWACBPri/KjlEp/AUQHvwg89gjtJeVSX8ltBzgFRmB64u0CrWIGgGrGgdkT+j
         C5kngvEhd3h/sfUXphYvgpiWBC7wW0q26cr6L21rrPWLm+LgpM0jsmAQp0bG/SzMJTUG
         pdfxmbwB5RwQaCME/pATpwfkQquVzC4yVRcSwHs9j2zJiuJdhWlDWW/xvMUb7CJG7b7L
         AtEZ3r5QrE11yww5k2ju+7B6lyuyRMGjDCVQm3194uZUOPw09vo5+ffr1PqMErA1BitY
         wzARzLT9VZtdOzDWil9hLrBwPY3dAoKi3cPEfNjDusjssiBW4zNUOUJStpTHjfERmpaa
         0cMw==
X-Forwarded-Encrypted: i=1; AHgh+RrLBdGtEVLpmtmKNGrVEXNdQQonVtwCejGjaoCHquDHbWi5LkXtdqMo2WWuuLn4pkGm6+sq446HzyboKQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/zgoLU6vaKKczrsYAFNDOT4ttMf4v1adlUZ67/zQyGtaYrpjn
	m/175Nh+hdUhaoPKys6rxcdjeG9N+4PTtAvPUqHhn2AT9a8Ho+7rqDq9P43MaA3AqzQ0WjpZ8ZS
	AkJfB4Wpb49Nhrhf3CMTQNgEiR798Qq0=
X-Gm-Gg: AR+sD10Bw6oaNG8PGhPxbOPRQeDbOKOM9aapULJHJ1Ws9usKacoJJ+o/cRvqjxfe8xw
	NAcgOkoPFl6JUqrUvrtBa7LxuGEc0A0tWXxSoTX5tmpFnoHKlbm+TclMPvGY5OZFNrZGCadAw7U
	3KbCzrCHcpwaZ5wCAa6qpIst9a5cFt9zOc7hmE1epbi2a24RMhb96r4uilv8BrJ7f/8jh9FgYMu
	7+ZAyZbOkswbkJwWQx/+5ADLQQ0Kjd+QB8CUFMXZMQ/KzmMD/b0S196TqcGOFHFvkjR1LAtumMV
	KL5rykkeUyEOB1F20jI=
X-Received: by 2002:a05:6a21:7002:b0:3c3:7ac4:dac0 with SMTP id
 adf61e73a8af0-3c67dae969dmr7046276637.13.1785140689346; Mon, 27 Jul 2026
 01:24:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260617080031.99156-1-clamor95@gmail.com> <20260617080031.99156-9-clamor95@gmail.com>
 <akeXAOpb13hupUGM@hovoldconsulting.com> <CAPVz0n2trouADTziWXnpt=-hwKdsZWGQib+-nVCLaSLibTbATg@mail.gmail.com>
 <20260722023037.776f4bcb@jic23-huawei>
In-Reply-To: <20260722023037.776f4bcb@jic23-huawei>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Mon, 27 Jul 2026 11:24:36 +0300
X-Gm-Features: AUfX_mx8whI7gSCba0GgBVBHpAVLRZADgHNcCPlSfBxfKQKn1EgxosjjezqzeSY
Message-ID: <CAPVz0n1dnoe=Xw2V-nZtm3ggD5KLO6PVrhXOAoPnqvJn+C3L-A@mail.gmail.com>
Subject: Re: [PATCH v5 08/14] mfd: lm3533: Convert to use OF bindings
To: Jonathan Cameron <jic23@kernel.org>
Cc: Johan Hovold <johan@kernel.org>, Lee Jones <lee@kernel.org>, 
	Daniel Thompson <danielt@kernel.org>, Jingoo Han <jingoohan1@gmail.com>, 
	Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org, 
	linux-leds@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=81=D1=80, 22 =D0=BB=D0=B8=D0=BF. 2026=E2=80=AF=D1=80. =D0=BE 04:30 Jona=
than Cameron <jic23@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Tue, 14 Jul 2026 16:57:01 +0300
> Svyatoslav Ryhel <clamor95@gmail.com> wrote:
>
> > =D0=BF=D1=82, 3 =D0=BB=D0=B8=D0=BF. 2026=E2=80=AF=D1=80. =D0=BE 14:03 J=
ohan Hovold <johan@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
> > >
> > > On Wed, Jun 17, 2026 at 11:00:25AM +0300, Svyatoslav Ryhel wrote:
> > > > Since there are no users of this driver via platform data, remove t=
he
> > > > platform data support and switch to using Device Tree bindings.
> > > >
> > > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > > Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org> #for b=
acklight
> > > >       indio_dev->name =3D dev_name(&pdev->dev);
> > > > -     iio_device_set_parent(indio_dev, pdev->dev.parent);
> > >
> > > Why are you reparenting the iio device here?
> > >
> >
> > Because every cell has its own binding now and using phandle to parent
> > when device has its own node is not a good practice.
>
> It is however a good point.  So should at very least the ABI break should
> be called out in the patch description with a brief mention of what the
> path change actually is.
>

Ok, this is a good idea to add chapter into commit description.

> >
> > > That's an ABI break.
> > >
> >
> > This driver does not have any active users in the kernel and no
> > activity for more then 2 years.
>
> ...
>
> > > > +     u32 count =3D 0, reg, nchilds;
> > >
> > > Don't mix multiple declarations with initialisation like this.
> > >
> >
> > Checkpatch does not complain on style issue, hence this is not prohibit=
ed.
>
> Prohibition vs taste.  I fully agree with John on this one!  Those mixes =
are
> messy and hard to read.
>
> Checkpatch is a helpful tool but there are both rules and preferred style=
 things
> it does not catch.
>

Ok, fine.

> Jonathan
>
> >
> > > >       int ret;
> > > >
