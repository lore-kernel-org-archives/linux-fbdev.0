Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A174437C
	for <linux-fbdev@vger.kernel.org>; Thu, 13 Jun 2024 06:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718258448; cv=none; b=XcoS1kov5kO6FXKPcoPtbxWus+gkgArk0QwQKlokdrhEaBFrpoCtlsbQ6QhnsSfCEjg92lZys6H1zInGf/5tuIctJf+Htl46vJPWOtvm255kCgqTq32UEr2Wf+JgcytljzqRzwbZ25e09HbaMUb82ZP6SomyVboHcWzZRFhlwbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718258448; c=relaxed/simple;
	bh=XkETNg3TjLcuapc1XDVyMeEIgeH7D2BgDPYHR4M0i+0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=qROC+HYWGKdSgbbUGY2fGoZU0H/9QJqb8mcvHEH35zMO8npaW8Ab6Sjf6HqxoKaqT+UT/pwigiudXJTzb79oOpfBzAzJvttugpP5hM02ugFJOum8OylvP2X5tptYN6IdWamchHNs9OYcrYpkU/RzQPo8CUOTdoO9lAlkNf2yd/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d1inEyYe; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d1inEyYe"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a6efe62f583so57086766b.3
        for <linux-fbdev@vger.kernel.org>; Wed, 12 Jun 2024 23:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718258445; x=1718863245; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XkETNg3TjLcuapc1XDVyMeEIgeH7D2BgDPYHR4M0i+0=;
        b=d1inEyYepX/BUS0P7FM22V+U6xGa+W0jknm4ULWnGCZdHWsxnFkmk6t+qYTus/oE7i
         U3+RRwPWXvUjVAGy1izHLLnoNpwUqu81tLHoU5rU1qe7yqPBmf/IIEKcwww4wxvb1fpI
         NZevb1ps1q7HCbLhL0BEFeL4Im2gXxt7hcK3cgxVgOgQxg8cxzSgHwCuoscH0Ypzcykc
         It0rQM8bRYaBDPzH0N38Ix+xIjGYBSVZyrjZapRNV7Hvpbl5ezW481L6irW2Ul0fdiH2
         ohwvpZo4SMT0sajJorWZGtz9tHSfEJaqrJirUYpCzaDZUVOU0o3xwHU1XNJi4aqJjyiK
         /eOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718258445; x=1718863245;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XkETNg3TjLcuapc1XDVyMeEIgeH7D2BgDPYHR4M0i+0=;
        b=ds8PelDL1QFr5bR0smPd/GX1Oywvt9et0dt+rkhBJXpSS2s7+XGj0X10IOstilmdsv
         kS+QrfgfiEP1TqqrAWx+8yOHceX/Z2Rorese3PcrKDiC7VJrmYQjeiuMBuUKg1O+6IRA
         OanpEPocO42l9tDChKudg7veJXeioOgWkX9vd4YLE8s8IGe+nVa80Tih23eJV/zHb++8
         TjYlxuem+S7x41ozljI5lSyhCcJee7k9d22gMd16yJF5/yllWRIUN1gjv4nF+fylPktb
         qDEeBXm3ezfjTewGPbmZekNmp7XMnBumJdrri1aAWHEZNSsKQAifEf+KKCoG2DGiVT7u
         MSrw==
X-Forwarded-Encrypted: i=1; AJvYcCWjBvKHE2dXygHgupzQRucMX4CCxaaY25FntXn5/aBUjGCKmUP108xXtcY8Wl81FLLCuF/54LZcpWfl5fyWpK3MYa0+p+Kk/MfjsP8=
X-Gm-Message-State: AOJu0YybYPykNXJ/gSZw2xT+rLpgc7lYJAS3MX5xMldBRiVOS0gQk1WG
	SpO4z+nEnQ0zAwC2/tZexKnts+zjNpP0EQ6BxP/uKPZb21Mp/kkkIYVf6Znz/mKoJ2gwkGSJjnw
	AGNm8d4WP1bROwmDANMftcDOJHDY=
X-Google-Smtp-Source: AGHT+IGIz+nb7tUNhdmga5GH1WElCJmXV8gUV8SSU4YVGdNxpcJjnzYBS4s5RvopRuwx1geXDPCUSm7imojIvYBukaQ=
X-Received: by 2002:a17:907:7e96:b0:a69:d82c:167f with SMTP id
 a640c23a62f3a-a6f47c7d729mr285424366b.15.1718258444884; Wed, 12 Jun 2024
 23:00:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAxE2A7qK1-b5g1RR-GJ+QTLEr_OxEr9vcZGEOkZY9yLOFLb5w@mail.gmail.com>
In-Reply-To: <CAAxE2A7qK1-b5g1RR-GJ+QTLEr_OxEr9vcZGEOkZY9yLOFLb5w@mail.gmail.com>
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Thu, 13 Jun 2024 02:00:08 -0400
Message-ID: <CAAxE2A6971oJ3r-8UWhL0BUZBiYxq4K0-Q39MJnb7ZozX3da-A@mail.gmail.com>
Subject: Re: "firmware/sysfb: Set firmware-framebuffer parent device" breaks
 lightdm on Ubuntu 22.04 using amdgpu
To: Thomas Zimmermann <tzimmermann@suse.de>, javierm@redhat.com, pjones@redhat.com, 
	deller@gmx.de, ardb@kernel.org, dri-devel <dri-devel@lists.freedesktop.org>, 
	linux-fbdev@vger.kernel.org, "Deucher, Alexander" <Alexander.Deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

+amd-gfx

On Thu, Jun 13, 2024 at 1:59=E2=80=AFAM Marek Ol=C5=A1=C3=A1k <maraeo@gmail=
.com> wrote:
>
> Hi Thomas,
>
> Commit 9eac534db0013aff9b9124985dab114600df9081 as per the title
> breaks (crashes?) lightdm (login screen) such that all I get is the
> terminal. It's also reproducible with tag v6.9 where the commit is
> present.
>
> Reverting the commit fixes lightdm. A workaround is to bypass lightdm
> by triggering auto-login. This is a bug report.
>
> (For AMD folks: It's also reproducible with amd-staging-drm-next.)
>
> Marek
