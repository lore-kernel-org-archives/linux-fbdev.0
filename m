Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D6034A77D
	for <linux-fbdev@vger.kernel.org>; Sat, 20 Jun 2026 07:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781941428; cv=pass; b=I1kF7nEomZ81MvKNVGOEc04iS/oVn6A8ssv02D/bO0Sd5mjdUF5XBk4SnN60F+xxv0GLRDJjgF7Jf3h05+sZlgprN+sApeXSgOP4efiSlkOKTdCnaP/+sM6wcw1CeRdscxun40QKMIzw0oanOPvAs+B507JoBY3yMiP8iVROHtY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781941428; c=relaxed/simple;
	bh=DzV/Bz091e8nL5SyiOpv/VkEA+1Mi8KwLdzoRNONtSw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dZMXrid2u0IXcLkTlLTF68c2Yj9+cKbju9Ql1/f940cbpmnjOjZOACtYhuZYI78H/HojCgAJYgnXunym/p7YYEWRoixOfovHjbkZvEZ++gzWFhTCePZzqCVgQVknRdIRCpqJuFB5J+Lt5owBAAEueZdd7r7yIEt52OJOEsLYedY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EzaQuBFy; arc=pass smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EzaQuBFy"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c0840dc2859so233778766b.1
        for <linux-fbdev@vger.kernel.org>; Sat, 20 Jun 2026 00:43:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781941425; cv=none;
        d=google.com; s=arc-20240605;
        b=ZZ3WfFuH1AFRCYThsxo1ZPPnLF4Ml/IloWH/dT+fVGwyidLwZwdBZz8j4M1Id0Dh7I
         2aKIBhSueKk7Np2jaXWxdYefR6qrib14Ux4R/Rtg4UOkFlTaRroRrkxFF+zDBryOigDf
         vkGdbuwC7CNFOMoRCJGa0QVRNfEpYIfyuoMOavYHItYSA9j3Q6RQy4P5d4+DbqovELOy
         1f5FLFJdrF8g1Uc/LncW5D9MRvhCfSHRnUy2/8Lw8j/dGc09+eeznkvEOsb0rHTXALAX
         6XGevEncDE1YL4W+H909633fjf6GZVZArDpSz9qY/NmZK+1IoaKVf286Ap096/Tq/9nG
         d2IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RwJUzJkFOp4tAmfXA6KJ4MrErpiHytjtZyfzG3vrPY0=;
        fh=Bq+vQpijbWfygwhlqB1DHkPXm5LquFA27ITKY4T/BAU=;
        b=AtV0bWjLHiKPyTzf0KgCcXSU8tBJEsqr4oHy+Q2zXrcPYdI2kD/wtQ9dqFpPXcfZOi
         xs2C2uN8SCcwwRQIfC47doNE2nwjZ6/XS2J5w80mtIDPN5n95Zsk8bhCS4GBHP/s8xNF
         yQ6wUyq6/pELUiqqKfQbqlhUuuWlxXCBEN+xKhm3LJGkj5kfb/xxTVagHic7J+0h+ZCH
         sV6oI8/0UWM5I1tq6WOgmi4drVsiXmNM9R8Z4GjVdWXleOWE4OiaSJZBOBXttSrls4vr
         b1yMqk8MSV8d5Yss7J/urpkfmRgCCExP35Hr1tn9KaRUP6Ac2COuf9xEbvlCEwo2QH3t
         rHqQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781941425; x=1782546225; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RwJUzJkFOp4tAmfXA6KJ4MrErpiHytjtZyfzG3vrPY0=;
        b=EzaQuBFyshUSpUYE+dcI4d24qfugPMpTsorIB7TBCNlFSLBv7AvwVycCZTyw1cATP1
         ZUBLMbxGMeYrVMvtr9z7Y3oCRQgY0r6gVIBrse0QelhGwdkeYDPQkVWOcvwaZ8Wr+yu3
         vI8lJGAkBRY+aRIJZwqRGWRO8Ju7ikXotzr+MKlOF2XknPe11PkeoA0UTgIWMfNPeGm+
         1WVc4VHvSNJXQ4mMAxOhGpbPA9n4Mx9YU1l6E7bEoPk0DtUOlonuKkYTfC5Kx4oyRfKh
         EEArI7kGGx0OnsATcqNyvzyYEovIz/VjPUyOaAnBPJI2UGLWUagacQ6szGFQkxZTUC4y
         SOjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781941425; x=1782546225;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RwJUzJkFOp4tAmfXA6KJ4MrErpiHytjtZyfzG3vrPY0=;
        b=Gd0L70avzJzZMkZnsqPE5YWkRFEu7bP9ss90C/8woNx8/dISLrrJZYeuwYKI9TKkR2
         uoY1RCnlKqjhtqqgxxxtDPvawx+UHPWjqwwu/jRpbnGpfmKWG3K2iCesias86VxwI5KT
         IqNSpSWU4Bv7hz7q3+QkvGhOC/1REL/DSgIkcRNT1lYBUXQ1RM4BAUAmeIVDrfzq0VhZ
         VTUYWDL3Uwa2ZrrlV6fzxESyNX/pvuXX2mojG4o1g51d42a1RywFB+3Tr5DOJoffbBjt
         LGza5NtaRVTyyWW11H1/kKbGFVvNJ0b9UzGv7SFZx6OWADouf1o6Cxu10phZMs03KCxP
         0OxQ==
X-Forwarded-Encrypted: i=1; AFNElJ+09KpbItt2oGb+xD1i3GDLTSlUPx/TaQfSIl8K4aCl3grDfyih7TP9gTK0W5o/8NZ1Hd/gqNJt+s/OnA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwMBYDTlf0sYgIxAQ/X/Fi++miRMGgpP7HPLQtXfuLw6t/+bWDG
	56WcXhqA9ufiLkPXGI5qsTVUfd2PSa7CPL0vCC94XfAJI2LxnucsJuVX3qBKrONZD2CxW4MyP4e
	nHPmwnOcUgb0CTiveUbNG1qEV4m8RSTM=
X-Gm-Gg: AfdE7ck3iYhdr7gzNLwWcwtqjuaI3cSk3n11qq6glM/RhB8AXuN1Yz8z3cE+MlWg5IZ
	yPgyMkHrpNgIwy5oURWf2FqrgF3UGLDMQWy72lHvGP1uwZzYV8d/TZtOFXKDEr/0iq+RK6aAIVj
	MunRjtTwvq+xrNR94pvM9c7/O0TVUI94KZqG+pGUa/kUa2WCFM3pZIzVMOc5a9g5/7uhiwOHlcT
	y3+4Gcw5QKASk1QznMjsdPbUaSsqt2UZ8JHr4WU+Ox0SYWQ3O3qMb+BG0/JybiYLojWe8X1xw==
X-Received: by 2002:a17:907:1c84:b0:c08:695:8819 with SMTP id
 a640c23a62f3a-c094ab06232mr347376166b.0.1781941424883; Sat, 20 Jun 2026
 00:43:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260529111927.14138-1-neharora23587@gmail.com>
 <CAOWJOptv1JcOGcEt39HVy7LkpAsvzbw9yj64kJG+X5J=VbWrMA@mail.gmail.com>
 <CAOWJOps9RBNAGsPFsBCbzFkEUN1=75YvwmqJX6RdQBbt1C6W-Q@mail.gmail.com>
 <ai-j96dVwtPMERVM@stanley.mountain> <CAOWJOpt2CW=-zybOrPr2pwfPVQFcd+j3YoNP+rMyAar_2kJtbw@mail.gmail.com>
In-Reply-To: <CAOWJOpt2CW=-zybOrPr2pwfPVQFcd+j3YoNP+rMyAar_2kJtbw@mail.gmail.com>
From: neha arora <neharora23587@gmail.com>
Date: Sat, 20 Jun 2026 13:13:33 +0530
X-Gm-Features: AVVi8CcREoyjcHXowOc7Bxi7M8cmts4kYSlT8u6k6tHdF-PG1aMmVvHCxP8n4jA
Message-ID: <CAOWJOpuObcnFMW_abhZVjLbkUSyiGMbgQwB6FPekgSU5Bn6eFA@mail.gmail.com>
Subject: Re: [PATCH v3] staging: sm750fb: rename pv_reg to io_base
To: Dan Carpenter <error27@gmail.com>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, 
	gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org, 
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi everyone,

After further investigation, and feedback from maintainers, I have
concluded that porting DRM to the SM750, will cause a huge performance
regression as DRM has no interface for 2D acceleration, making the CPU
do graphics, which is slow, the only way to expose 2D acceleration is
custom IOCTLs, which is not preferable.

So, it is best to keep using the fbdev stack for the SM750.

Regards,
Onish

On Wed, Jun 17, 2026 at 8:30=E2=80=AFAM neha arora <neharora23587@gmail.com=
> wrote:
>
> Hi Dan,
>
> Please disregard my previous patch submission.
>
> I am currently working on a complete rewrite of the sm750fb staging
> driver into a modern, KMS-based DRM driver (sm750drm). Because this
> is a complete architectural overhaul, I am building it outside the
> staging tree structure.
>
> Once the sm750drm driver framework is stable and ready for a RFC
> (Request for Comments), I will submit the entire new subsystem patch seri=
es
> directly to the dri-devel mailing list and CC you.
>
> Thank you for your review and your time!
>
> Regards,
> Onish
>
>
> On Mon, Jun 15, 2026 at 12:34=E2=80=AFPM Dan Carpenter <error27@gmail.com=
> wrote:
> >
> > On Sun, Jun 14, 2026 at 12:45:05AM +0530, neha arora wrote:
> > > Hi everyone,
> > >
> > > Just following up on this patch to ensure it didn't get lost in the q=
ueue.
> > > Please let me know if any changes or a V4 are needed.
> > >
> >
> > It doesn't apply to linux-next.  Did you work against the lastest
> > devel-next tree?
> >
> > regards,
> > dan carpenter
> >
