Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA39268694;
	Tue,  8 Apr 2025 11:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744110195; cv=none; b=EygH71VmRELXEpRC9dJ/lwtOFPGvvi/C6Pm6ocQl40DnyAX2tD2D/1d/Aot1DmsMoUyH5Svq1K1oJ05DlThLDyY4EViXjgz1YS39pSIwMSrrFZco4ri3wFMLKNVYy0f8DDHQXNtFZxMs1zlQgXR62qWbujq4Wvq0/PQtcziZMpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744110195; c=relaxed/simple;
	bh=BiijfwOxAtjf4oaJQt7JBfi9sANawaCZgX+NcFS9SlU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GxxLkffJqFoBG3h6BN56RoZqCyNNecNeDUPUh3GFHibi6daVz6GYS3BLxDGZXoXMZ0a5/yYHqhUxEzNWsgm8Pbfi/hM57dHizbnYf616C/PK2GaW4wyIxhJ+NYIddiwDJpuuwQh3S/WJ5BTZbhMB2QjMtUrbav1/1uR2EUmAxCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W3Gh/uFc; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W3Gh/uFc"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5e5e63162a0so8634416a12.3;
        Tue, 08 Apr 2025 04:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744110192; x=1744714992; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/00t6mg8lw/s9Ks8yQUEiUItwkteRs0MSMX6xy9kyuA=;
        b=W3Gh/uFcFpgvVlDRv8KntCoT0y2fkd1XZA8ykmXRMErxH9Mr3hdjG+3lhBB8opJzzw
         SfcJFQQqXObOTmBHnur/wAveYcSlIg9Qk8ZJ08UOHK6ixeiqwpjqxoBNhybGpqFUemIs
         TuJl/l+4NQm/dVz943D1x3vsZ8T04KRK4JegLjOpZh+NbhDerWqIRVfagOo3ObkZczcj
         xpkO1HgGiqMnJ3GjNxhF762TJ5vuybeEi7mDgSBxsewX2O7tX7h0FEKOpj2d5XW1r8WH
         dUjwqvx7kj+Hi4yYox/NC8RGyjvlQ204CimnFR13SgOz7M9fCZeN6yMa9suKEddO4+ym
         gnXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744110192; x=1744714992;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/00t6mg8lw/s9Ks8yQUEiUItwkteRs0MSMX6xy9kyuA=;
        b=c+YrJKE2C7kuX8GkLONCdr91spt6fQtJxwtuO4uB78Dh7UmSosa57E5WV1alL9svb+
         27+qnfOsrgQUzk7vkLlq4BD0SGEwpzTRjWItk4qVkwv90/D0inc8aG23CtQGL3oBWDi7
         fiI2EQbkBSZGwT9AdzPj1A68KOGP4xY/c7RmSzWmAUiOhootKdyi1IY5F9ixl56VZ/sc
         ywqXwgMBk8qkNClPCe4JYDBovNehxNzvcYrg6M9ufFZ8e4fudF2xFRR1e0ycFum1Oq2G
         5+yBpU0nR0UhK/p+NtDbFIKwKcZtCxmUQBNVz/246f/tuXuUTrKHbRNHmkoIO+NYBU0a
         FPPg==
X-Forwarded-Encrypted: i=1; AJvYcCW3VMYW/bBgUoy26n+Tqb5DRMu39USFInZ1xh3JC8DxCtKQcRpwpmB9fRnqDDSZkrZxXmD1rExNEhEaug==@vger.kernel.org, AJvYcCWHSyIUidSGhn/AvqnUlCwb6XTsvPptvl3/P3K42ctEJtYS9Mu9OlEctUW/M1tIezZFpXbVm9qpC3fuuBVO@vger.kernel.org
X-Gm-Message-State: AOJu0YzmzA6S5aks0kJJh9FH9OHxM8i6FLS+rKyqYGcMlVWGCW0phjcc
	EvJuJ2ey3A+oYc/KKJWdFkqQmtUpwQQaWOHF8dXjYyF64dz54WzkaPKHXBqD1oeO/st6pdLguh+
	CIeErpn3Rq2UfKPv0A5GN+1fBn1KFgfSVgfg=
X-Gm-Gg: ASbGnctQ92paVRk64+oEkibFdir7wm1GPhDq9lkVGo6uNFh+5MHesQpZ3FNyTVYSB0r
	1jtgGe6dQugoY7zLN6RESW5spE70DrRB2fx5M4Kmk2oqm54DHERTOBMO7vnJHPEzzkWLj/XHqMg
	hD/W+pIC3pvTArWQnHEr6LijG96+EacxXoL9kT7g==
X-Google-Smtp-Source: AGHT+IE/TipTw9wWWEYZAgWegMiEBEde2oa+sSYBenoR0MFphvXErC+5XgStffEBQsCm/1nD1TKQBdOyTJl6ckwjXMQ=
X-Received: by 2002:a05:6402:d09:b0:5e4:9726:7779 with SMTP id
 4fb4d7f45d1cf-5f0b3b6255amr13150494a12.2.1744110192194; Tue, 08 Apr 2025
 04:03:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1743857160.git.princerichard17a@gmail.com>
 <2025040538-breeze-espionage-dc6e@gregkh> <CAMyr_bL4Qo_eeVSHhy-_z9_PwcQAvD6N4jfqBb+rtN-Lj+YdmA@mail.gmail.com>
 <CADYq+fY-twT=NruAmfb6EpmYJLM971aTu-CUi-We_Fd6JSP47Q@mail.gmail.com>
 <CAMyr_bLkvFBTpYehG4fs-tqVE18YBf53okddU2=i7+Rr-zbCsw@mail.gmail.com>
 <2025040711-refutable-monetary-f0c4@gregkh> <CAMyr_bKgveKkpRdOWw+VfZDWridLirHp4VoeG_F-wwgSY5jpgQ@mail.gmail.com>
 <2025040840-domain-boasting-81ec@gregkh>
In-Reply-To: <2025040840-domain-boasting-81ec@gregkh>
From: Richard Akintola <princerichard17a@gmail.com>
Date: Tue, 8 Apr 2025 12:03:01 +0100
X-Gm-Features: ATxdqUF4gjnGhN8bVu9BMwjWfNpNmxpcYUvHkM9x18Tm4IWpbKt1sumwvhHSY_E
Message-ID: <CAMyr_bKpXh99=LLpvunwRO91c2u3TMqiO2a1npcjohxRs57Cqg@mail.gmail.com>
Subject: Re: [PATCH 0/8] staging: sm750fb: change function naming style
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Samuel Abraham <abrahamadekunle50@gmail.com>, outreachy@lists.linux.dev, 
	sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, 
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 8, 2025 at 11:48=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Tue, Apr 08, 2025 at 11:38:28AM +0100, Richard Akintola wrote:
> > On Mon, Apr 7, 2025 at 7:01=E2=80=AFAM Greg KH <gregkh@linuxfoundation.=
org> wrote:
> > >
> > > On Mon, Apr 07, 2025 at 06:57:38AM +0100, Richard Akintola wrote:
> > > > On Sat, Apr 5, 2025 at 3:16=E2=80=AFPM Samuel Abraham
> > > > <abrahamadekunle50@gmail.com> wrote:
> > > >
> > > > > This looks like a new version of a previously submitted patch, bu=
t you
> > > > >   did not list below the --- line any changes from the previous v=
ersion.
> > > > >   Please read the section entitled "The canonical patch format" i=
n the
> > > > >   kernel file, Documentation/process/submitting-patches.rst for w=
hat
> > > > >   needs to be done here to properly describe this.
> > > >
> > > >
> > > > Hi Samuel,
> > > >
> > > > I sent the patches individually before, but I was instructed to sen=
d a
> > > > patch series.
> > > >
> > > > Given that I didn't change any code, should I still add version num=
ber
> > > > and sending
> > > > patch series as the difference?
> > >
> > > Yes.
> > >
> > > Think about it from our side, what would you want to see if you had t=
o
> > > review hundreds of different patches a day?
> > >
> > > thanks,
> > >
> > > greg k-h
> >
> > Hi Greg,
> >
> > I have sent the new version, please do have a look at it.
>
> Again, please realize that some of us get hundreds, if not thousands, of
> changes a day to review.  A normal delay is about 1-2 weeks to get to a
> review of a change.  Ideally it would be faster, but there are only so
> many hours in a day.
>
> To help make this faster, please help out in reviewing other changes
> submitted by other developers, that will cause your changes to bubble
> up.
>
> thanks,
>
> greg k-h

I really do understand the situation and to be candid, I am in no hurry
but won't mind helping out in the review, perhaps a help with Review 101?

thanks,

Richard Akintola
