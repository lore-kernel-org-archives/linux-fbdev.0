Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8A43385A6
	for <linux-fbdev@vger.kernel.org>; Fri,  9 Jan 2026 10:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767955899; cv=none; b=FyX5lR0THXi8sjSkqjrRmzOHVBjRFyqxHZoYlpgUdOVSKqFaDh9yWF4IU4JNMLA7iuwdTz4AjN0vH+rvYGXfTEySDpm4OZQWOu9t8GcVDdDNhjiU7H3S73fiJUZGLakCyeJzhRHD/wMkKGJbtGWTSki8np6qq9jpA24igBjc3Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767955899; c=relaxed/simple;
	bh=KdToO14tef5GSir+chabd8B6NEOIpxi61cdldG3NByg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FKkDOjglD+uab6cl8vSqva1qbkmXUcNCzTj2BLHzgvB4OjleSab88JY3EZgDqaFRDWeqA4rs5C0STYr2UmDmsyaXg+CA65/r844Wpi3H5zp/K7fj5icLXp0Ht/57CWzcD7T9uSoS7bUGxErt1BAFUhhvRBHI0ymaEWFoxKiq/h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-563497c549cso1845535e0c.3
        for <linux-fbdev@vger.kernel.org>; Fri, 09 Jan 2026 02:51:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767955897; x=1768560697;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+PrHggOm39VeVydYN6TMkB/guB5c9Xengt3pqY0OQgA=;
        b=EVmUrufKg5xbe6caUshp7pjjcOAvovp0E6zJo3qfYKY4WGNVwFGLDP7mZ/Cn3acevT
         5TSqDI6Dj3iOQLhscKHTfuKls1z+0fvA7GY/EUK5huqrYcOEJYHZpYETCft45buRIVtH
         zU9J+qspT532kVqFxQIXB/U+z7W0L6ChanDhV6DA/4Ia+JyvR4E44vSb3PMcEm8ahJEW
         NiJ5lhouyvlDDcc4LpeiHhbu3DrgVJqleOwu/rYPwgARON2x7PsHMM/6VONfSgGPPsIO
         ASyOg4r2BdWoeqeUNQSnXhWTI8H2iDF0khgjNLfnMqm70VNpg1cbCsmDsg/7B7ETF0F3
         zT3g==
X-Forwarded-Encrypted: i=1; AJvYcCX3i9vt+J/hST2zuQp3e3EKRXLVQsgi4Twz05v9r+p1oxHyJwQl2OZAx81jIQmpA7kcdJAd89dtL1CPIw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1EMfJMCtDOWMLZsdShkrbX2GB3H0/xm4RPjkaMroay0/6DgNK
	aBPHhlfvHbeBZLbUQlYCwTeRIGpaoNIs7gKohqeokBiQpSLNZ0FNSpa2i7MVdAMY
X-Gm-Gg: AY/fxX527L4xGBO+ByBWdA9iZwunA8Vtq4RL/LS0ZBNN9N5zmjzlhTnLhr97MAh/iFX
	RzofRIofCbb5/sB6DgGGUTCBnrAtgJ7KVFxQYJuOjxCtAngcwujnRWsKfcan/eDPrXwq04E8vre
	SQ5FBc5rfyiW7XGzG30kpPNj8/Em9pbMMdn+ZFeW8uIjMzBkDQz2/AOUNHMuA1KsggmSh9o4f51
	IqjhFqPGb1XdgN/MjGWFe5OPgTrxyLv0Ylmt7754E7sxDPCgf2OeNwG0BE+aiY6/uNSF1EOaKX3
	dZY1MTAH5d1OXoRpa0DC64PLxrQa+11GJpGFclyXUWfs1u36Jn7vrUtWNe68h+HwszmXq9krr7G
	kk/0eWh7bWG8HxFFxPKKvsePy3OqGs1WGbAs2DM9Lj2p1PMSMoTEttlyNy/4LiT5PBYDGfHBuOq
	yxgJELKXdIjz2ZhhlQvL/X8Zl00YPWH6HqtQGfepWmzVXK2ycYclz5
X-Google-Smtp-Source: AGHT+IGg8QPnQQawBbG1cdtfx08Ax2RXAzewwBn5I6hj2vuj58sIygSmWBhIV4ODgmZULD2PASoICQ==
X-Received: by 2002:a05:6122:e60:b0:563:66ec:8fdd with SMTP id 71dfb90a1353d-56366ecc049mr488756e0c.16.1767955897071;
        Fri, 09 Jan 2026 02:51:37 -0800 (PST)
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com. [209.85.221.170])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-563618ff8d5sm3019926e0c.7.2026.01.09.02.51.35
        for <linux-fbdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jan 2026 02:51:36 -0800 (PST)
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-563497c549cso1845513e0c.3
        for <linux-fbdev@vger.kernel.org>; Fri, 09 Jan 2026 02:51:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWkEODWGgYLbnpYdQuRbGHo3Hbw2Ybc5XtX21u0k2KN3H6buLmzvW1l4edqUgrjJj2ixDfX2STB7WmlTg==@vger.kernel.org
X-Received: by 2002:a05:6122:18b5:b0:563:4a88:6ebd with SMTP id
 71dfb90a1353d-5634a887159mr2995245e0c.3.1767955895564; Fri, 09 Jan 2026
 02:51:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260108-custom-logo-v3-0-5a7aada7a6d4@kernel.org>
 <20260108-custom-logo-v3-1-5a7aada7a6d4@kernel.org> <CAMuHMdX04g+BfEuBt_0iCvmZiyCLp58d0QwnFtu3bM1Cv59TzQ@mail.gmail.com>
 <4e75acf9-2e04-4ad4-9241-d8fd36462404@kernel.org>
In-Reply-To: <4e75acf9-2e04-4ad4-9241-d8fd36462404@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 9 Jan 2026 11:51:24 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUM3JfgDCri0=rq8L8e+bvhZ0EhMvyFD_0v7NJ-Z7v6og@mail.gmail.com>
X-Gm-Features: AZwV_QjshkTYtV04MygmILu94BM_s12nNFHOxgxtfb9evPWzSLQreqflAdgzCzQ
Message-ID: <CAMuHMdUM3JfgDCri0=rq8L8e+bvhZ0EhMvyFD_0v7NJ-Z7v6og@mail.gmail.com>
Subject: Re: [PATCH v3 1/7] video/logo: remove orphan .pgm Makefile rule
To: Vincent Mailhol <mailhol@kernel.org>
Cc: Helge Deller <deller@gmx.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, linux-fbdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	linux-sh@vger.kernel.org, linux-m68k@lists.linux-m68k.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Vincent,

On Fri, 9 Jan 2026 at 11:48, Vincent Mailhol <mailhol@kernel.org> wrote:
> On 09/01/2026 =C3=A0 09:40, Geert Uytterhoeven wrote:
> > On Thu, 8 Jan 2026 at 20:06, Vincent Mailhol <mailhol@kernel.org> wrote=
:
> >> The kernel has no actual grey-scale logos. And looking at the git
> >> history, it seems that there never was one (or maybe there was in the
> >> pre-git history? I did not check that far=E2=80=A6)
> >>
> >> Remove the Makefile rule for the .pgm grey scale images.
> >>
> >> Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
> >
> > Thanks for your patch!
> >
> > There newer were grey-scale logos. Linux also never supported
> > drawing them.
> >
> > Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
>
> Thanks. Just to clarify, is your Reviewed-by tag only for this patch or
> for the full series?

For this patch.

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
