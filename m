Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C32B3E274E
	for <linux-fbdev@vger.kernel.org>; Wed,  6 May 2026 10:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778064285; cv=pass; b=LFjwn9g0QPvi2e7H4ZMhyUdLv72jsfCWHaxiGrle6PbGzGdC8iBgYvfRO2W0n3aSWNhr83rVZ1b6UckMzsWMpbGLcdj9gXCTST4L469hL2wS7I68hkYv4znPFlhTe9hvc2Be6sKoIz2SIGSTgJJLpcirdlH2kCOYLlkFQvOdLEk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778064285; c=relaxed/simple;
	bh=Y0df9QlXapCfWt0fpDZLptLzc2sflOhB7BNttK8tG0c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YdPveNIbxv3Hv9yNu8hVNL7IlrhdPLA7Jd28TPDUuzb0h6aP6zzDHEUpJsew5caOwDa51CGrGbnJSL9Pq2WmALaqc7jVKnGiX9dl2fN9pKjpksdAkpqGpBKmQK64O+Zl1tz4HmDFBkOKaqADnUOm0HBEd3YLNXBGjawIIyG14tE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G592/DzD; arc=pass smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G592/DzD"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-65318dafbcbso5646903d50.2
        for <linux-fbdev@vger.kernel.org>; Wed, 06 May 2026 03:44:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778064284; cv=none;
        d=google.com; s=arc-20240605;
        b=DuDYWp5INOk5uH4ZoxaEo2JgbWv4BGhsodavSewYSMFghbeYIWJYaz+ShIhsduNLoq
         Ri2PF3Ftu1uiSVJyd1oe+gzqrOhVItvEEhkEFHKOB9b9LoIcI5/8pY551tV0YTOX/NXV
         HmUyoyCPtq1rcSReEWCVu+Q4Smy9Vgki0+YRCVo3ux9+YHMVqd87hlGKLszwTTRCBQKP
         udhE7S/tIMxpoT91ICLGUg9KSRrJS2ujNk+nWqMzXnxqZQsG42UpivvOm81iHfgGm6L2
         Km4Z1p5pp41motb4WKtU7qwdiUDIs4eMiRvcK8+lFCNCgHxQDjaZ2+oroeLOGYc50JDE
         yQ7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GOcVUuSXxU+mRMKW6rAuDSteuJMJ8DdJe3XSItK0MjU=;
        fh=zDeKY4jKNkhqpjF5LAD1xekxI6bo9I9ICDKAAPEftrE=;
        b=lwQpb+2hgZlqUAokgA9oIbg96T4IBtt7R3VzIgp/CB0inp/7P1qK4jbHUhYOkeku3t
         D7dBY8UGZbdrQ18UWQ1prmltr7OhsAMkDxe24WC4ze7Pa9UFWGUO5OG/YazRIsCv8EnZ
         RiUhcfsVujJQVL4IoLZtY7HX23wPgs1tjwryvcbcWmmaGFISwXFGJDLQZ8g6Gu5jiCbR
         xFPGeMl+cv7oKR95W0QXt4xa8jphT1f0HMnhPso+NeECIy71y6/LLO3IFsowT/jKTGAc
         ST5FzbU3VAf4oUVHpyQAuhUOILyCt+lJcLq1qExP/gt6cI4mHJj+Y2vU9kZkYUNyp2n4
         SHpg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778064284; x=1778669084; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GOcVUuSXxU+mRMKW6rAuDSteuJMJ8DdJe3XSItK0MjU=;
        b=G592/DzDYW4OA67M9lr0qOJHex4gXp6yeF61sBSAZ6cFSz6M1psZDU8dUn9G87tWlZ
         owztGYF1Ztd3PfakFuptBVynSSp0owQjIv95cGnQmt5j3xfPAVK6QKbYjGxArVKoWIGS
         g4VlFtgOmPE/ysxAX0nx8kDfZW1aABkXuPR78iS9W2PM4LVXnXvh9AaVqIp5QgnoOE12
         Aur+e9za/T8XXUnobardwHfEN4etdCIivPx4nV6lIvuG5a0zcZMOQ1PIDD6nolooPsZ9
         SI0aoJCZXUGk81Uv9LZxx4+rODZTzXV+bUXbtj/h0BY/Y8Vizy1esUcJalgPaEf9Jrmn
         ijkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778064284; x=1778669084;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GOcVUuSXxU+mRMKW6rAuDSteuJMJ8DdJe3XSItK0MjU=;
        b=LWjdsclL/5pYhON9lmEJtftBi3oeW9VK+mfCjEEBlGuvPP456jYKvZnT2MWTdbHOQp
         kuU929PV8O3W7fBDD3ry42OKvF6OeXJllYcEYAwAMng+MHVuhOpXoPw7aX+N2yFCR5uG
         MtjzUXV/6ChQeam0eyrQtOxuH33PyOVU/9CVZ+rxjWnAK8MC8ndMiJWqVDWCPGthRnmO
         yJpSotQ41JloS8bwpoF9PkygW9le3ZHIExe9OCed69Mg8tMupE5c53hmN6rfhsx3iltA
         tUpzHnqIjl/y2wA7tyavWWy8UREyXTvwvg+4hEoPeW3k/tH/U9HQ8v04GOmJXwCGP8E9
         axdQ==
X-Forwarded-Encrypted: i=1; AFNElJ8WSRJT/TQ3CVz7ogi6npOkTT4FNzV8FsiOhcTNPRHhGwEHVEwpcM9S2TO9yoHiOPvldmyw3yQnLNCXqw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzK3ZmL5Lvue6Ht13k0HC1XGtdV4B4MJ0RxILAHadMo7trAo12O
	E9oPruHanM4+W4vXqCv+KfK9s2bx96N66ysr99HHDNNZSwkCfGWeRFpjllmOD+qfLMze7r0xptn
	fQvAtUEnLew1wcOAD1zW/h7LWfAWU4KQqG8e/YcZvdA==
X-Gm-Gg: AeBDieuoTzv9gyYy3klTSyE74gVhdzH3WJA1sy2dptNC8duMu0EOhpGzvHDhsWkAg0o
	RbMBlxYjgySY22yGXEIGJsZ4RVCotjDm2swsCDuvN5sy564YSJ5RoLheEIxHbhUJK/M3O5c2Xhr
	snFliKI9Xfd7NsNrbdlBoe03S51QBaWy/ClED8bXn/hAT3KZ5LS3HCfRg9blynqmA9ymrDvir0m
	KULYbpdIK1Y2EpLjjWSmSaooksOfhT7feHZN0egifagW+kjf2+GxgXCKw2ncLz4ghbYvRyLo14r
	WCnWjcPtqgswzsh3qMW5IVtXZaoqmgMRye0qJ672
X-Received: by 2002:a53:e8d0:0:b0:65c:1011:8a8 with SMTP id
 956f58d0204a3-65c79e61076mr2147667d50.34.1778064283600; Wed, 06 May 2026
 03:44:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260506035641.5060-1-chaitanya.msabnis@gmail.com>
 <fcfbdb1a-188a-4ab1-b7cc-b2c430d2cca4@sezginduran.net> <CABjkosGtM-bju-gn9QtBfOMKMUsoYFb22noWjELnNi6B_ZBQ3Q@mail.gmail.com>
 <5113f014-f0fb-406a-9b3c-725acff62c9f@sezginduran.net>
In-Reply-To: <5113f014-f0fb-406a-9b3c-725acff62c9f@sezginduran.net>
From: Chaitanya Sabnis <chaitanya.msabnis@gmail.com>
Date: Wed, 6 May 2026 16:14:35 +0530
X-Gm-Features: AVHnY4JPaXNoGN9zz1U7PeVImzyha_1cov6nxk831hyykLfr2yFQC3IIXdjzu9k
Message-ID: <CABjkosFMeZBcWaEpF77_a+0AETWY5RtbGK3jdE8OkVgnLbLxYw@mail.gmail.com>
Subject: Re: [PATCH] staging: sm750fb: add const to g_fbmode array
To: Ahmet Sezgin Duran <ahmet@sezginduran.net>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, 
	gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org, 
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 6, 2026 Ahmet Sezgin Duran wrote:

Are you sure that you had enabled the module? When I apply and try to
compile your patch, I get these errors:

Hi Ahmet,

You are completely right, and I apologize. I fell into the trap of
running make M=3Ddrivers/staging/sm750fb/ without verifying that
CONFIG_FB_SM750 was actually enabled in my .config first. My local
build silently skipped the compilation, which led me to falsely
believe the syntax was valid.

Looking at the errors you provided, it is clear that g_fbmode is
dynamically assigned during module setup (lines 896, 900), meaning the
checkpatch suggestion to make it const conflicts with the driver's
logic.

Please drop this patch. I will ensure my .config is properly set to
build the specific modules I am touching before submitting in the
future.

Thank you for catching this and for your time reviewing it.

Regards,
Chaitanya

On Wed, May 6, 2026 at 4:06=E2=80=AFPM Ahmet Sezgin Duran <ahmet@sezgindura=
n.net> wrote:
>
> On 5/6/26 10:14 AM, Chaitanya Sabnis wrote:
> > On Wed, May 6, 2026 at 11:57=E2=80=AFAM Ahmet Sezgin Duran ahmet@sezgin=
duran.net wrote:
> >
> > Did you compile these changes?
> >
> > Yes, I have verified the changes by compiling the driver with: make
> > M=3Ddrivers/staging/sm750fb/
> >
> > The build completed successfully without errors.
> >
> > Regards,
> > Chaitanya
>
> Are you sure that you had enabled the module? When I apply and try to
> compile your patch, I get these errors:
>
>  >
>  >   CC [M]  drivers/staging/sm750fb/sm750.o
>  > drivers/staging/sm750fb/sm750.c: In function =E2=80=98lynxfb_set_fbinf=
o=E2=80=99:
>  > drivers/staging/sm750fb/sm750.c:785:33: error: assignment of
> read-only location =E2=80=98g_fbmode[index]=E2=80=99
>  >   785 |                 g_fbmode[index] =3D g_def_fbmode;
>  >       |                                 ^
>  > drivers/staging/sm750fb/sm750.c:787:41: error: assignment of
> read-only location =E2=80=98g_fbmode[index]=E2=80=99
>  >   787 |                         g_fbmode[index] =3D g_fbmode[0];
>  >       |                                         ^
>  > drivers/staging/sm750fb/sm750.c: In function =E2=80=98sm750fb_setup=E2=
=80=99:
>  > drivers/staging/sm750fb/sm750.c:896:45: error: assignment of
> read-only location =E2=80=98g_fbmode[0]=E2=80=99
>  >   896 |                                 g_fbmode[0] =3D opt;
>  >       |                                             ^
>  > drivers/staging/sm750fb/sm750.c:900:45: error: assignment of
> read-only location =E2=80=98g_fbmode[1]=E2=80=99
>  >   900 |                                 g_fbmode[1] =3D opt;
>  >       |                                             ^
>
> Regards,
> Ahmet Sezgin Duran
