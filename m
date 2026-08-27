Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6F9374A14
	for <linux-fbdev@vger.kernel.org>; Thu, 27 Aug 2026 13:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787835835; cv=none; b=VsWaGeQ4/zK15fDtVw7jggvdJDwfVusTHTN1cvYN+Da3VIaAwq79G83OQP6i3xIDtgCE4ubEBpoI43F4hsluzvvYpAdgEVKWgCicUsj4NhlqAy2+O5epQLi/lKEO0I7Wt9qpcjdWOnC5eXuFEiRCDQESOJWeMm3uVb+myhLbwoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787835835; c=relaxed/simple;
	bh=dqLzRTCo+L0EQjgbjzQjQe0D7hZOV3ykAmOsZdQxIfQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=epvhtvROwg4ApAba36IXrhjzIhJhdaR1QdxtKSKLKxQtKRvQlsxtRQ10+L3X3Z9nq7s/+E6C/AKMcHepPxEKNJDNsN72kvmmqOgcpggb4E0tI3qQDt/tAMZW6nIvF9+cW8J6ZO7jZjtCNJP8L2tMGGQhghoGQ8qASYER0ljBSqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-5c655961faaso1640530e0c.1
        for <linux-fbdev@vger.kernel.org>; Thu, 27 Aug 2026 06:03:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787835826; x=1788440626;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=WzKYk3/+V+rOzh1rTxaW+egKeE53pqTO5dJe7JNkRn4=;
        b=KCUuGqYKh3bb3MXgZqHg8wBSIRhRoFiEU0ExZps/UxKdvdlq8+3Gc8L/93qQ/qID9C
         pYRsAvGjtbGfTdFZN0QrR/7HDEWjBa1e1PGFZdojFybqH3nN/FUidCpkDUv7jg1Bhwq9
         QBt1BJWJkFHkYM4lBg75sxeEUYAwpyXNhBG9dMx+2qedRNj3kQHHr6yGItqYPUSuuL3C
         tuajg/Bwum9InfnDD5+aa/OiIlAIz+b4yI+1Pc/essuV9IO/VsC9YLYOaoHdZAHb/Gy+
         WjjxkqNTpmz3qMtKVCs0SeALgGmLya/xVqkUKUiZtFyVX8NHOJEvP9GsIIygDTC7K+zl
         0PkA==
X-Gm-Message-State: AFuF++kK3lgP7eNPHVMmLppu5fGZJVVQ/R1XCGJgOc8McQvBRhqjSDMQ
	+KTk3lCwqtSrmCHXuKozYszDvEYIQvO1A7DxhZH1Su+UFuy252xn/4z8Y+JkLg6G
X-Gm-Gg: AR+sD102Pwwrt6DrLVSoXRFyg0Nxkzs8CitYfTAP244H1w4H3BP7Otli90l2N4paPjk
	4Y1z0V9nQKhoV/8IqkUsfuPKecNNfYZmjOXVUm9oYKh73ydT5ml+1XPa/k93pm4A+KAk+VFpHi3
	jNVMp27OhiTPPVBF8eH2keoDropNo3+8hJyB5ZzMzQCKf79BXaZnvm/CbAC6pLUz1WTqwZMwMzJ
	5WyJkmjrDrtLx8NuPaeQneX4x65MDO+GS4e5FK6FHEu3JG4THgiJKU1Wwpi0r7fGrkubSxK82mR
	SjjHCyCnB+TO+/sdm/wXfqXUbD8AvtRuKhtl5O1PEPFtWfkqefmbmH8xBC6XlvT1zuJUlpT/GTe
	DZ+aS/ShLePmOeIvcwtEuzjLq08m/cgLLJqYK5ru0ZJkPFF6joHYvp7Z8D0rAtKU2I28zxsXww7
	4+adN+oi7FDMcNE18xCVXOLywuo1qLogCy+Kt5WltsvPaBZ8ZKLbRh5VrTBmQ7k6nzujjN85dOZ
	bq2BwX/SuhV07jh/DUKmXcrM8/k2cIIPXd5
X-Received: by 2002:a05:6122:e442:b0:55b:d85:5073 with SMTP id 71dfb90a1353d-5c65c1b81d2mr6160563e0c.4.1787835825764;
        Thu, 27 Aug 2026 06:03:45 -0700 (PDT)
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com. [209.85.217.50])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c65fe7bd68sm3591223e0c.5.2026.08.27.06.03.44
        for <linux-fbdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Aug 2026 06:03:44 -0700 (PDT)
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-74a9ac9cda6so1448234137.1
        for <linux-fbdev@vger.kernel.org>; Thu, 27 Aug 2026 06:03:44 -0700 (PDT)
X-Received: by 2002:a05:6102:8499:10b0:782:e392:2ba6 with SMTP id
 ada2fe7eead31-782e392308fmr3427230137.9.1787835823964; Thu, 27 Aug 2026
 06:03:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f2Kf9GYn1lKR5S1dbvGVtykMxK1RlgP5z8sW@bugs.sh>
In-Reply-To: <f2Kf9GYn1lKR5S1dbvGVtykMxK1RlgP5z8sW@bugs.sh>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 27 Aug 2026 15:03:32 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUPF3vzpTQWWJvjPmrHahXcdo_USyWX+LxK9bHppuc1tQ@mail.gmail.com>
X-Gm-Features: AcwNN1X2bkBw8SIWU4yTCrO5AX2qiaKB8yFkpoNbbPhB8bGMcoiC2Ojl7dqCiOA
Message-ID: <CAMuHMdUPF3vzpTQWWJvjPmrHahXcdo_USyWX+LxK9bHppuc1tQ@mail.gmail.com>
Subject: Re: [BUG] drivers/video: use-after-free in _copy_to_user()
To: co <co+c25629c98ba36ebe@bugs.sh>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	Simona Vetter <simona@ffwll.ch>, Helge Deller <deller@gmx.de>, Petr Mladek <pmladek@suse.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Song Liu <song@kernel.org>, Biju Das <biju.das.jz@bp.renesas.com>, 
	Oleg Nesterov <oleg@redhat.com>, Andrea Righi <righi.andrea@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Co,

On Thu, 27 Aug 2026 at 14:43, co <co+c25629c98ba36ebe@bugs.sh> wrote:
> We found a bug reachable in:
>
>     path    drivers/video/fbdev/core/fb_chrdev.c`, `drivers/video/fbdev/core
>     crash   use-after-free in _copy_to_user()
>     commit  843bc34db94b
>
> Config, environment, the sanitizer report and a C reproducer follow.
>
> == Notes ===============================================================
>     If you patch the bug based on our artifacts, a tag would be
>     appreciated:
>
> Reported-by: co+c25629c98ba36ebe@bugs.sh
>
>     Everything in this mail is validated by the reproducer below.
>
>     We also hold an LLM-generated root-cause analysis and a candidate
>     patch. The patch passes an A/B test: the same reproducer panics the
>     unpatched kernel and runs clean on the patched one. Neither has had
>     human review, so both still require validation before you send or
>     apply them. Available on:
>
>         patch.diff  https://bugs.sh/b/c25629c98ba36ebe/patch.diff
>         report.md   https://bugs.sh/b/c25629c98ba36ebe/report.md

Thanks for your patch, but both links are almost empty:

    No artifacts published for c25629c98ba36ebe yet.
    Request them from co@bugs.sh, quoting the bug id.

>     This is an open science project. The code and the full set of PoCs
>     are not public at this moment, as we intend to disclose our findings
>     in an ethical way.

Please read Documentation/process/submitting-patches.rst

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
