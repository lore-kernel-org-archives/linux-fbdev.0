Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8BB161320;
	Thu,  3 Apr 2025 22:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743719885; cv=none; b=mQBSZJwPbbI/9V4GZZbu9umaDpTwJFV7Qm4lzs3FBn06dB/rOxUVtf+9Ev56P9xif9wovlPEiFQTRixOpdJBbCHF86EANr1LbiN2trt+01MhKvbiXRUx5svFLgGSKqMftma+rx6uZe1wIwbP5Mt5GyDNPEu71unUzREJHO9ZoBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743719885; c=relaxed/simple;
	bh=zaM0dqs6hXmFjWycbkD0Nt/9XcQIztBGYBwn9DyGL3Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CJAQGzXsRDuwauw0XCv9tpZCvC+u/y8hmf9Q2y8Fj9k2tZ3o7c7W+Scc8Qpq3dnXdYFVkgNIsq0xtG6ofnu4gARjkZFFTLjkWF4kRe4MtDM/gAZ6tN2AZRhJ3/WdfZeDJquEAphNgC54/IwxbFqH1TvchoBfkMK0bsANKkYfDnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kjpks8pd; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kjpks8pd"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5e6f4b3ebe5so2559681a12.0;
        Thu, 03 Apr 2025 15:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743719882; x=1744324682; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iZ6K1JP10UBnpc6DTNs7X/b6jJulOtNE7dgvrXsrjCI=;
        b=kjpks8pdFay6vg+22AeRw0Y2LpttqyVqSqNX+DLjLUDh/h1snO2yGk96S22rzyFDuv
         R5Z6k/qMh/kw/Ue9OJ6zAX3lm+Pbqf5Tin+YarvtzOF7TuG6/2/a+8CZeoZIHxA0fPf4
         JF3I2m4e9C+F/Uz3SyFCfuWftKAoCRIAnwu+dKP2QIQp4RI6uVY/3envzdAp+z5Izl3f
         XOP2BoX5IaBUKDLogmpXATLVMxZnBAz6J2WkoFv6+4X00LAP18zUaNRoniLkqyPqIy/5
         WcyO0hZwJ+fPkL0rEjMAhWKZZ8u/9RGFIYgXlz8cYWfAv2XiBdZ+WALP6pqIUaPg/d8x
         z7vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743719882; x=1744324682;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iZ6K1JP10UBnpc6DTNs7X/b6jJulOtNE7dgvrXsrjCI=;
        b=q/JOsrkE674Xl9McX3offlfm4Xq8AxZsFFLS/rh0D1fhGOsPy+xkUjnJma/vdfYjI1
         vTOTGLNo0h6+G0bHygpeaC2Y0avlOhpXtE1VHlglirF8D23KqMjSF9lxDnCJRFeT/0j5
         x/f+vtK05+v7w7VMkZMlggXrB+WmGpaJ2XNBqUMst+6Dn5LVgsOQswSXM3nkSufVCcJc
         qRA+1oJu0jBxy/bZO8AUMWYZzgUEM33mjkyMXJS8DVG2ap/R5q/VYG0NfJdtmEwXOfVJ
         q54NFfvSonvQ1u2+tEtUuo6VYZSEFauqJQBNoghj3AU2XfsVXjpRf+kOuYMZp9Nj4uIZ
         CQkg==
X-Forwarded-Encrypted: i=1; AJvYcCVBLnZLeb5qfD/eXCo5gfq/rdhiGp8qi/MLRuN+8BW4lPaqMM1nKfsWAp2xdFLb8KPynP8we9HLNWlrEBdG@vger.kernel.org, AJvYcCWBMLKqkLOGgpACioPs7KiwknRpz28ydaCim9hfjTSaUtT81qI2QcWCmER+lIRQSyU1W4kUCj0sCLO3hQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwIV3ZwXY4uBqF89JD93cF2BLrjzq/8tfooA0XTl+59kbEmB0w2
	LsVtME/D8P04VAoSyRA/YzCDoCjL2D9HSQQzf5Sl8A47+wshkow3IJkLY8abFyHUCcZPjmfXa8Z
	jkv9DVeODW45J4WO4z2UCtSS/kO8=
X-Gm-Gg: ASbGncv9ZiIe7kv2nNDgTHsFQKu+aBk+A3SMNWfJ/2m2J0ZzpXTfEdXwOce+HKFzjQr
	ae3jmkIO+wIkywI7mxR9Qo+S7KvCilZZrZPBfXXKe5yNDDsavU03m4qpGM7j6uuRZGpYBI1Ihu/
	wWroUvIeI6JCbjtPC1uIgkAekIHA==
X-Google-Smtp-Source: AGHT+IGEP7WnNSh6HYTyjnZSWPMhY0n5hrhx3hnSpfSMjdSZBItxJqvw71uEdf0SfOoYMMZBoucnZPVuVO9LWzm64Qw=
X-Received: by 2002:a05:6402:2709:b0:5e1:8604:9a2d with SMTP id
 4fb4d7f45d1cf-5f0b3b65912mr685521a12.4.1743719882267; Thu, 03 Apr 2025
 15:38:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <67ea5813.5d0a0220.293276.775e@mx.google.com> <2025040301-tightness-giveaway-a568@gregkh>
In-Reply-To: <2025040301-tightness-giveaway-a568@gregkh>
From: Richard Akintola <princerichard17a@gmail.com>
Date: Thu, 3 Apr 2025 23:37:48 +0100
X-Gm-Features: ATxdqUE7EuV8mvnSRPJ_5BA5rAr5h72HjMUScB12TVQyWh-pzOcniirw44ZMhXo
Message-ID: <CAMyr_bL3sh3HyL0=Qb1h21_-5dqJy0M0Ewo0JMFPNr=x28oNgw@mail.gmail.com>
Subject: Re: [PATCH] staging: sm750fb: modify function name to kernel code style
To: Greg KH <gregkh@linuxfoundation.org>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, 
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev, 
	linux-kernel@vger.kernel.org, julia.lawall@inria.fr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Yes I did send two different patches (part of the reason I used
different subject lines),
they did similar things (change camelCase to snake_case,  I wanted to
get all done in the file,
but I learnt it is best done one at a time.

So should I have it all done in the file (there are more than 2
camelCase CHECKs), or send it
one after the other? (but you could take the first).

Thanks

Richard Akintola

On Thu, Apr 3, 2025 at 3:18=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org>=
 wrote:
>
> On Mon, Mar 31, 2025 at 09:53:36AM +0100, Richard Akintola wrote:
> > Change camelCase function name sii164ResetChip to sii164_reset_chip
> > as reported by checkpatch.pl
> >
> > CHECK: Avoid camelCase: <sii164ResetChip>
> >
> > Signed-off-by: Richard Akintola <princerichard17a@gmail.com>
> > ---
> >  drivers/staging/sm750fb/ddk750_dvi.c    | 2 +-
> >  drivers/staging/sm750fb/ddk750_sii164.c | 4 ++--
> >  drivers/staging/sm750fb/ddk750_sii164.h | 2 +-
> >  3 files changed, 4 insertions(+), 4 deletions(-)
>
> You sent 2 different patches with different subject lines, yet they
> almost did the same thing?  Which one should I take or review?  Please
> send a new one, as a version 3, and properly document what changed
> between this one and the last 2 submissions.
>
> thanks,
>
> greg k-h
