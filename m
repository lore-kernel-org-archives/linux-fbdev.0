Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6597226659C;
	Tue,  8 Apr 2025 10:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744108725; cv=none; b=Oj8OLydy0Nb2t2boDc9LVPxFR8Z0tCj7fcGf48zVW8faUCXr5fZW9QHZ+kXUVO1Gc2gtYuGnZv8MVWEx1QRV0zMY7wZOLk0+Nm99itazNlzMVEg2BwVtYdxRQHsINitpk0xTWHTxJ5xuKm4TBFRZ7bKI+2MI48tJlFwYVMElWSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744108725; c=relaxed/simple;
	bh=ClASX4VBDVwAzQdSceNylf/BZKDO4TwJQdbNrAChR4o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fyjZT8PRcYYIs9uSazQc+L3T/Qsd/p0qQV92OqHt7TqVzZtfHoF3FG1GXSq+ljFN7eqf5Ket9sfpFNeMm5A9iE7gBI4ii8lRO0uV0DQPAbEIctNGyxmjrBl83HEpp4BGnE1NtDLgx/2SJrXftta66/3UPBTpxx4kxIzIuFJ4IS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WVtF8ce6; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WVtF8ce6"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5efe8d9ebdfso10937598a12.3;
        Tue, 08 Apr 2025 03:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744108719; x=1744713519; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aLaSOgwbcr+Il2t2O6boJjLPotCqperIiZ1qWfjVdnY=;
        b=WVtF8ce6OjIUqqzDcJx7MAvYrNhl4kDzC39ErxKOoj3FuLAwdfNLGxP+8oWBMqLPK3
         vuqbByNmNhuIAmepL4Tepfyjj+TtQxbMMKzkNSeI9ZIyktmsY9/mvvVnrs5jDAAbx76f
         i3aYwHymc9SP3NLPUGiRI9CpfquUfQKHmpLl0Cc7KfyT53fRwM7WJri+ZUk2C3rsBA3z
         0NySltE5mLLqBEHVzcV4E8ygv+DM4+2EIzCl/Cq32ZvDgkC1Zsy+/cITTu7MxAi8SWjX
         OcO0gIXSJXvRY4/T/Io5PZ7P6Tzjc70UHW9qV13tbqQrfOoXFmJ/QMzKqB1m79yoQfSD
         jKmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744108719; x=1744713519;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aLaSOgwbcr+Il2t2O6boJjLPotCqperIiZ1qWfjVdnY=;
        b=taE4MILIeBRhJLUg9TSa4W9TGAC3GxpIEEfnHsJ/b3kMfIuHIxbI6SadnIOO9XkF1L
         iaj+5VE9gvi59hIUxfsJ38FaFNtcxem5zduyXH8SEQc6IwiqErgX18L8K+ud8aEqHGeT
         YMUPIvK9nbPlGtOFZ9PTN5obcCcbUk+BWeZlv+3HO0gf8In8IZmlS4ESriFDzzlsurw6
         M0XPgUgwTm4NiyDvQUuAhru4Xq0VQD9Irx5Blh73Qm+vhfMZnHD2sHMRrs4QGT6tkCvd
         HiNOFrI/3Pplhdl285vie5Lq1jQafC9fRmYNqdFk6oh5MurX1gEIM/Q6SBOMp0gTcDcN
         mang==
X-Forwarded-Encrypted: i=1; AJvYcCW9Hh901KajZiMezMZRoBHP6/OVHBWWOa9hpe03RVZWQZvkpApuw+P6LW1bHrnqCQEk580Fqn9fi33AwL3Y@vger.kernel.org, AJvYcCWUmUojnomx/eBcqNZN+EV+RfUbPN/BbZMNiSxidufjYWwuWEO/OR2CA+5RgIN0Ln0u1NvPQAj4+ViWxQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwkdZy+bkXwaghOsqBVRqaCoZyizVRUiM7Ibp2QqF2mF8RuSnHR
	p+fvR8BPzwvL25CGQnOCmImaRudAFXqLtdC4n6cfKLejP+ocAFa6PtHxdkV00kvw/ulwrpnTLTA
	KXp1bGEx4IyY8FL/04dxefrFplww=
X-Gm-Gg: ASbGncujsuwNOWLHAH5l07Wtv7qfdRM8hF4q02XR6vgBOiH+JOfILplpMOS4QZtuERn
	uF2TimTckJP5JlJs2GrPlYP2rY9HDQreMW/Q53AUFKnnKZRzowXB3kglZdl7mn1PLJpm1W+KhcD
	BqCb+Aabu/Ibrm9xM6JcIIgjq718o=
X-Google-Smtp-Source: AGHT+IG1OkLi2dBwtZHj8xh6E4uTxeL61LbO5cEWBcFX3jqGDmARdYvh3vX315w/re8lZ0aqREIlR0wet3AJ2lKZaAc=
X-Received: by 2002:a05:6402:5194:b0:5e7:b02b:6430 with SMTP id
 4fb4d7f45d1cf-5f0b45001b9mr13069758a12.23.1744108719601; Tue, 08 Apr 2025
 03:38:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1743857160.git.princerichard17a@gmail.com>
 <2025040538-breeze-espionage-dc6e@gregkh> <CAMyr_bL4Qo_eeVSHhy-_z9_PwcQAvD6N4jfqBb+rtN-Lj+YdmA@mail.gmail.com>
 <CADYq+fY-twT=NruAmfb6EpmYJLM971aTu-CUi-We_Fd6JSP47Q@mail.gmail.com>
 <CAMyr_bLkvFBTpYehG4fs-tqVE18YBf53okddU2=i7+Rr-zbCsw@mail.gmail.com> <2025040711-refutable-monetary-f0c4@gregkh>
In-Reply-To: <2025040711-refutable-monetary-f0c4@gregkh>
From: Richard Akintola <princerichard17a@gmail.com>
Date: Tue, 8 Apr 2025 11:38:28 +0100
X-Gm-Features: ATxdqUED4mJO0oYd1IguyXKnR51UPXRuHJL-QRIDRwetTTWsHh880oNHQC9O1UU
Message-ID: <CAMyr_bKgveKkpRdOWw+VfZDWridLirHp4VoeG_F-wwgSY5jpgQ@mail.gmail.com>
Subject: Re: [PATCH 0/8] staging: sm750fb: change function naming style
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Samuel Abraham <abrahamadekunle50@gmail.com>, outreachy@lists.linux.dev, 
	sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, 
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 7, 2025 at 7:01=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org>=
 wrote:
>
> On Mon, Apr 07, 2025 at 06:57:38AM +0100, Richard Akintola wrote:
> > On Sat, Apr 5, 2025 at 3:16=E2=80=AFPM Samuel Abraham
> > <abrahamadekunle50@gmail.com> wrote:
> >
> > > This looks like a new version of a previously submitted patch, but yo=
u
> > >   did not list below the --- line any changes from the previous versi=
on.
> > >   Please read the section entitled "The canonical patch format" in th=
e
> > >   kernel file, Documentation/process/submitting-patches.rst for what
> > >   needs to be done here to properly describe this.
> >
> >
> > Hi Samuel,
> >
> > I sent the patches individually before, but I was instructed to send a
> > patch series.
> >
> > Given that I didn't change any code, should I still add version number
> > and sending
> > patch series as the difference?
>
> Yes.
>
> Think about it from our side, what would you want to see if you had to
> review hundreds of different patches a day?
>
> thanks,
>
> greg k-h

Hi Greg,

I have sent the new version, please do have a look at it.
Thank you.

Richard Akintola
