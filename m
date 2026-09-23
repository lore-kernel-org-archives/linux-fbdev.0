Received: from mail-lr2-f35.google.com (mail-lr2-f35.google.com [74.125.230.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629EB5616C1
	for <linux-fbdev@vger.kernel.org>; Wed, 23 Sep 2026 19:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790191154; cv=pass; b=o/aYH8wD6/QNajJg2Vc97uANANtYLvMTyDvau2bPkXJD8nr76YgK0/VkJlUerVP1hiX+dGlbxlW6M7ftJgYi4MBuIGFzH3YXrdgoOb0sKG7BBq+snApkcN1ltYxkI1XT8BAh3L7VXiA/r9NHdCfBmJtuO/6SPPB0ouG08oaTuqU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790191154; c=relaxed/simple;
	bh=REliDhaH9+1Oq7CbV+dKfmJpG98JSKZR8x6JKNYcStU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aqj8MpF/050pjGc5tUanDyMY30uxfU2bl9x/jRNOVrKfB9iEGGSw9+gflBTmPHmrGB4Q5zsY/2a2PkVcLwGZ9XsrSM4zKQ4Q4ZpulyI3v7HsgIB1QZTcQGINd0FlY4BtSv6WhtR87qRxW2IMMAVsJVvQ/0SyBZ7mrgspcT6+eTY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YZ+Zg5nm; arc=pass smtp.client-ip=74.125.230.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YZ+Zg5nm"
Received: by mail-lr2-f35.google.com with SMTP id 38308e7fff4ca-3a3156692c6so9576411fa.3
        for <linux-fbdev@vger.kernel.org>; Wed, 23 Sep 2026 12:19:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790191151; cv=none;
        d=google.com; s=arc-20260327;
        b=j6X1nt3vf3yIqA8OSWVgbDO+9J6WkmBWWWfHKyGOXxvlv6qbr9pjHdrFPDbLY41quZ
         NTgrK9XsIfVjbr8a4cEePOCeuS61O9DxUie6kE1pjgZuU/YcjfTU9uQTCTkvNRoSNyMW
         nSOPFZRYMV6YvDlKsSyV2XSY8BmdfWGFbB4Dfa82r9KmmXopCrmmiYHCvXly6PFYaVw4
         D0B/OEqIckpHTXhJq7s8vQyxxeTAnsmOhCZKQJHF1eGkEKoB5rR8kOO/bneP2cHYQctA
         MetdfbkdJ/ddlObwf5BQuv9O3lRZ1Mow0iBhkxT08yy9OJ3rmfD9WFYDHd67oKEK8YUb
         AhVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=73WOzeiX39morD6/5z/QgMfS5LWgdgnhu2L7icH2rx4=;
        fh=jd55UCGk9B551XpLO7JT3C/WxSxp7jdCNF4JOcyWl3c=;
        b=Orgs4Sne1WzBLP2Bnw3OftU9fCmfMZ7tDdLE2450JV8+1W3N2btmFoAwWi4ZWXnAK8
         05bC9n/CEgAu1WA2g4Lj4v0ZkaxNo8Q1zRchdK8GHgUPhIMHKVaJRWmVhp/lpWSm7+GD
         +xctlWrzDSv97TuldM6tDXAdzOf6Cd6SwjSI/CbYDo0iV1XFgUZEIIY8PQuWannls1BI
         cLzWCCty11jjj3sXNTTBT/+tME7GLdT5RabUprIYCeMEJOAKMzvS4ygfAPuX2wlR1c7E
         rG+f5Eh6CyyCnCOa4XgZAMqWnIz1INFQtEH6W2KCbFMyViH6AK+boF+rXzdp22mk7MNX
         xtBA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790191151; x=1790795951; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=73WOzeiX39morD6/5z/QgMfS5LWgdgnhu2L7icH2rx4=;
        b=YZ+Zg5nmsvS1gx6r/JZHOUDYNeh1uJ141Um/09khgJiACqXA+sVxvybc+OCKrvjcGe
         0389+Nmt4eyn9JhgMiKxGgQ/fLFRI+3/iSZ9wcD4YRIbtKPjbGAtyYWThYdcKuTICyV+
         gYgnTtnN7XMcMa30HLz3Ogo0aNnaYeBIppKZN3J/OxoA2z4nxu/bURhtx1ld3a3vvnsx
         BbsxPw+mmla1KZOMKqMvEHsmq+WA/MjqyYr/y1rYDkg6GGLAKenjiKVFFrIAwmZ+0PfE
         b6mGCmtMrECwVlAJ3gmYFjIUcQ7yWBk/olKnIXA9aSN+/Pn8hDeCbOV3EDaAnpqn+zes
         rRqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790191151; x=1790795951;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=73WOzeiX39morD6/5z/QgMfS5LWgdgnhu2L7icH2rx4=;
        b=Jzk4m29UWt83V/GqlKO3ihPgCRtgLaPrmINfVUQ45jkOgau1LAngAUEZmjgCDGcyEb
         BmgxnLEg51CACaNsHkNrEY1oK3073MlKSoF/BRU8e7xm54EicFTnSLzq3+xxi7zjCFNv
         uTz0mDwh/aHJ1eJPIg7p+WPeP/OuZE6JUjPKHvVnNHOOCnA+MeKxYho+WqPVGbi6Cn3q
         mSkIcb/UcwTTvWbSbd+xZzW+7kxWhqHi8F+awbhck4Bf8BONHfGKaKlWv7IaB4bT5LXK
         ptKEPRho+LZ+s/roMoozEAkAtjRawwpxyoK+9fE011zPIm7gOsg1zznnR+ntTkQnfVW8
         +pNw==
X-Forwarded-Encrypted: i=1; AKwUvBxoyMvWQxHUeBSWnIUDd6kI6QxOkloUWQwYyM4uxALKKqCBYNJKS0V9kZCpT0AX7YgFjxCW11xQx6nNsA==@vger.kernel.org
X-Gm-Message-State: AFuF++mCAaHvpD4r+mQm/+DTMrgM4NXzmlHwRxTougCoW90ePK2DBQCa
	Q/hka7nm4SwHf/SuX50w/eDt8E42Ek6OM0z/5o35lv5UUiMsQaM7bJvv+5KDfQz8PaYe97nz91o
	5+5Kq/Dkuyk1UpP0w1hELy0zO1ooNolQ=
X-Gm-Gg: AYBFou2eFW3j2fMOmQcCTd6VK0KGqrvMNPxEJjgBF6a0LmnFkOtzvGNdxH7G5JStOpn
	BtxlU1nhMNrDWbMaUbjNT+OxUAykrzjuO3B24UoKfavLYA6CNVo3EWmUxqe0l68bNxQLTyo3Khj
	sF2YtDJU94VZWBgdOPtrLX4+3I9FYySB8UlzU6NiCp5/GxP52spJ5ryF3NAkPdx3oGDsnN7GUxX
	oFP1P4igpiFYKToAEiMAy5rPCPqmIxeDbwVTygHbDfO+Pw6DLANIfw7C8UwiEjtgJe0grHa7lEP
	wsgqkpcavCoyAtld2N8vD+vJKe/xZlf07I/KpTuyWkG14/9RI5JkwVNlUxjoKBKmsfGPzghg3fg
	R
X-Received: by 2002:a05:651c:15c5:10b0:3a6:32a5:efb0 with SMTP id
 38308e7fff4ca-3a63c427924mr207641fa.28.1790191150200; Wed, 23 Sep 2026
 12:19:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260922193653.16086-1-vladan.kalaba@gmail.com> <f6fc1427-f771-4709-8153-f9814254a50d@sezginduran.net>
In-Reply-To: <f6fc1427-f771-4709-8153-f9814254a50d@sezginduran.net>
From: Vladan Kalaba <vladan.kalaba@gmail.com>
Date: Wed, 23 Sep 2026 22:18:58 +0300
X-Gm-Features: AclHuK8cg8iU0N6lQ8j6fa9jUz41AkITQWJyDQNLWNfRC_PbGhUmbmDrR6aOYiU
Message-ID: <CAMfJq187r9dLgwnncT1zmCmwYYFiY0kNg102=L4wmfzuw=12gg@mail.gmail.com>
Subject: Re: [PATCH] staging: sm750fb: fix const pointer declaration in sm750.c
To: Ahmet Sezgin Duran <ahmet@sezginduran.net>
Cc: gregkh@linuxfoundation.org, sudipm.mukherjee@gmail.com, 
	teddy.wang@siliconmotion.com, linux-fbdev@vger.kernel.org, 
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2026 at 10:28=E2=80=AFAM Ahmet Sezgin Duran
<ahmet@sezginduran.net> wrote:
>
> On 9/22/26 10:36 PM, Vladan Kalaba wrote:
> > Fix static const char * declaration for g_fbmode[] to static const
> > char * const as reported by checkpatch to cohere to Linux kernel
> > coding standards.
> >
> > Signed-off-by: Vladan Kalaba <vladan.kalaba@gmail.com>
> > ---
> >   drivers/staging/sm750fb/sm750.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/=
sm750.c
> > index 1ea3dd8b8f28..79d0221cdeae 100644
> > --- a/drivers/staging/sm750fb/sm750.c
> > +++ b/drivers/staging/sm750fb/sm750.c
> > @@ -12,7 +12,7 @@
> >   static int g_hwcursor =3D 1;
> >   static int g_noaccel __ro_after_init;
> >   static int g_nomtrr __ro_after_init;
> > -static const char *g_fbmode[] =3D {NULL, NULL};
> > +static const char * const g_fbmode[] =3D {NULL, NULL};
> >   static const char * const g_def_fbmode =3D "1024x768-32@60";
> >   static char *g_settings;
> >   static int g_dualview __ro_after_init;
>
> Did you compile this patch? While SM750 module is enabled?
>
> Regards,
> Ahmet Sezgin Duran
Hi Ahmet,
My make defconfig didn't compile in SM750, my bad sorry.
Will double check that in the future.

Sincerely,
Vladan
