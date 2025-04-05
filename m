Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467F73A1BA;
	Sat,  5 Apr 2025 14:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743863022; cv=none; b=q4qkUh6hlLHFM0SIz9U6MuvdctQNYwgCyTDN4dZs1tZ33GnUOB4srcB644mZZQJYo0vgwo/dfQb1IoLAD9bgC4+ACgKyvcoKn5u3BYgAc6qAGCjb0H4N+nsRxTQxptWb2p8x0+PYhwwJeWemppXnyP5LWM7jEV3MLf2uL3r05H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743863022; c=relaxed/simple;
	bh=Fb6nWConfM+SUWjQ8BRZyfSFDinOwn/Nox294oZsV6o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GUtFt2BAVTPpkXltQanr3jfpXMMRhAgPB/H0I+B+s6LGI9UpolVETP0K9cAYUutbaBPwcg1wnoa4q3K93T+xzoqg4YUqPgc3TgnNkOQvPRPm0C69+K0xZmGGo/5wb09W60usddvEO9F7+qAizBLyU2mzTgWxeyh6ro5QQHYJ/5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EEB06SwF; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EEB06SwF"
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-524125f6cadso2872783e0c.2;
        Sat, 05 Apr 2025 07:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743863020; x=1744467820; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/p/4bsPFAwsntA6dFF/zQ5mVNq7asuGZ7eLM61oyzaQ=;
        b=EEB06SwFvC2qZsjfhre88djhOx7u5SKOF5IVP5BhNfcsIYWX/cnfHVlYTC518gp00H
         e9CQIzGYAX2UNgX1h64ndusD3scEBfQadA1+lqMNmSXefW22mDakOHiKgqZR4I4NfLzx
         DdLMalSN4srZZDxgQAi4uYzeuSSwzbyGmJClweTgnCo7zeWcxc1pRrM8bbmmuwFi1zSN
         7GmiGwxtIyxvHZWxRrKIKNQyxGSAkFBRME7n7fNr1EmXvCeMdmHN0TLXkexfvR2DlYBY
         /0RKPMYq/FABl6oCa4OF+7oYAp9XxruDcYB6Iul+jmO5FPgbUrmFK6g6AVlBRYNkWY6r
         N/Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743863020; x=1744467820;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/p/4bsPFAwsntA6dFF/zQ5mVNq7asuGZ7eLM61oyzaQ=;
        b=q7l7aUbRyBu0x+lMoL+944qJiah/TCLOUkAbj44G/A5uus0anKArLcInBv2h5yIrRc
         39fV7977TocUhktd2FPxAht+QaMr8sp04M0THe70DnxaINv3o9BsYgocPHQdD4F8aNK7
         8H+7vUlvtJfrXNpg9bMNsJk9m+wvADo/TB82cq5MwWOzh0SdrvcZ3ka7bl8gq6caJ/Fa
         XGcdP3Hbikw+EV7AKwyM1WWVTXF0+3u3eP3JcJKTNXWWh2SIxgfXcmhFbZr9g113m2t/
         MONOI2r34DiFdaq+30BNmNq/DPqUao2o1rg4zHE42k6VHRxxnMFMIyhN31xSEnM7V/05
         DxTg==
X-Forwarded-Encrypted: i=1; AJvYcCUVX9C2fC1SZgE3KZkIfF9JRClff54jYENU76Ot2dUNJYPnihEbHVw0KhmkyzbJPl+tE/o86GIRW/XGLQ==@vger.kernel.org, AJvYcCXbt/lvpzRLR+Ijj9I7CaKRac0t7kJmSIfhIFC/trejeTBCGTbEDg5KCuheUjSBe7hJz8h8OHgNjwpXlxeJ@vger.kernel.org
X-Gm-Message-State: AOJu0YwoDDrCqCFws0QiQq5T/sLCqS3xfXbaw0YLDsO97C8xYr6Kftr2
	FLUzmgZTUZGTTDqntNNQRILSyO1iBTj89/xVAI0uy69L14Waefciiyk+Ho6R1QvEorxtntophk5
	5YlI/nu2/9qtV6W2kyqvkn9K0t7I=
X-Gm-Gg: ASbGnctom2VfLYBVHD3lfXowQ44oaq+QlzG/AJTp7Px67RTS4cnyNKiSp49wFg82vC8
	lN5rf1vN17cIwJruS0tMNCf8yu2AR9j5JuIef8qCIkrf8pqBEOZHYXsV9T/1/MUwukULYKv2GO7
	014GI3AnQzKvIGZRUjfUDBmOXUyyGl
X-Google-Smtp-Source: AGHT+IHFtRTL3RqrMIPJ8vf/tHEaDt1ARljHgx7WlPToBdwqJ724tsN+pZxlRaKfRKWlCe/z7fwyCcOgbtVY3pZp2Rk=
X-Received: by 2002:a05:6122:168f:b0:520:5185:1c71 with SMTP id
 71dfb90a1353d-52765d2d188mr4284391e0c.7.1743863020171; Sat, 05 Apr 2025
 07:23:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1743857160.git.princerichard17a@gmail.com>
 <2025040538-breeze-espionage-dc6e@gregkh> <CAMyr_bL4Qo_eeVSHhy-_z9_PwcQAvD6N4jfqBb+rtN-Lj+YdmA@mail.gmail.com>
 <CADYq+fY-twT=NruAmfb6EpmYJLM971aTu-CUi-We_Fd6JSP47Q@mail.gmail.com>
In-Reply-To: <CADYq+fY-twT=NruAmfb6EpmYJLM971aTu-CUi-We_Fd6JSP47Q@mail.gmail.com>
From: Samuel Abraham <abrahamadekunle50@gmail.com>
Date: Sat, 5 Apr 2025 15:23:30 +0100
X-Gm-Features: ATxdqUE8ROfu-fqiRiJp-D_rItN8bhudjw6IQvFtkopPWSBx-EbHPIFhi5qw-FY
Message-ID: <CADYq+faiOqMVsi6KDiR2GkYrU4FCqv7j0fo3fw_R=72=UL2oPQ@mail.gmail.com>
Subject: Re: [PATCH 0/8] staging: sm750fb: change function naming style
To: Richard Akintola <princerichard17a@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, outreachy@lists.linux.dev, 
	sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, 
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 5, 2025 at 3:16=E2=80=AFPM Samuel Abraham
<abrahamadekunle50@gmail.com> wrote:
>
> On Sat, Apr 5, 2025 at 3:07=E2=80=AFPM Richard Akintola
> <princerichard17a@gmail.com> wrote:
> >
> > On Sat, Apr 5, 2025 at 2:37=E2=80=AFPM Greg KH <gregkh@linuxfoundation.=
org> wrote:
> >
> > > - This looks like a new version of a previously submitted patch, but =
you
> > >   did not list below the --- line any changes from the previous versi=
on.
> >
> > Please, how do I resolve this issue?
> >
> > Richard Akintola
>
> Hello Richard
>
> THis is the main message from the bot
>
> This looks like a new version of a previously submitted patch, but you
>   did not list below the --- line any changes from the previous version.
>   Please read the section entitled "The canonical patch format" in the
>   kernel file, Documentation/process/submitting-patches.rst for what
>   needs to be done here to properly describe this.
>
> It basically means that if you made a change to a patch, you will have
> a new version.
> You will have to indicate the patch version and also what changed
>
> So lets say you have a first Patch then after review, or you edited
> the commit message
> or made a change in the code or something,
> you will now have a new patch which you will call v2.
>
> you will use git format-patch -o /tmp/ --subject-prefix=3D"PATCH v2" <com=
mit-ID>
>
> then when you want to send with mutt, immediately after the signed-off
> by line there are three dashes (---),
> You will then write what changes under these three dashes in the format
>
> signedoff-by: Richard
> ---
> Changes in v1:
>    - This is what changed in v1.
>
> I hope this helps
>
Also, you can go to the "Submitting a Patchset" section down the page
of the firstPatch
documentation for more information on versioning patchsets.

Adekunle
