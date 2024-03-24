Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22471DDBC
	for <linux-fbdev@vger.kernel.org>; Sun, 24 Mar 2024 20:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711310627; cv=none; b=qGyRxGRMaHRHWBchRxVZssXepw5XGHYnSUWiXZ6tXuQO3ZIWym/6TvoASrrJwnl5CjXxI9ZFB36HEyxWFzal1ye/WhGC3oo8TMX4Q4lm9zQPHfhA6pojVYGhsOH/5/M9hiIGptCyZUH5elsD4BA8IFUDsej5Lj3c6t3UvKxThDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711310627; c=relaxed/simple;
	bh=cqBlhRUEL9bZZOdcM5Vyv15/CsDGCd6WAdiYTcNbm/4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=d7+Cs0XwjMs4FNiRBP4KXQPqiU/qqjQ0kqZ5An1U5bkc4NbpzFj/HTZd53Df95nXSfDzSJ4B/eCAyo1F6RTwsXs0SdSfwLFLiluoi0NypRGCtXj1thUKjAWoJJhPkY07jf4bQDAlEAkcUrNNROUB4QYERpKbe+xDUSj7etEmuwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f1/62anz; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f1/62anz"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3c3acf4b0e1so2288155b6e.0
        for <linux-fbdev@vger.kernel.org>; Sun, 24 Mar 2024 13:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711310625; x=1711915425; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5MqsOoodGzZPtDV9EL9+Kx91oMWToSpmgmM8is9DfYQ=;
        b=f1/62anz/gUQsXTjziOJtwdlLzvG1mY/QXTNjfsIML9fLO2wmBsbVYPX03q0ur8WRN
         Pq+w4CsW2/LAz5a+DA1zSjfD4vmXl/mhM4KNHUfmzlYcIWRZiJCH0+ST96fWGZOWFnlH
         CsUQtwOqVcoju+SJWbBniFw/Oub4ivAQEFUZR9PADnu4OgtGY6aeeniNmKWxK+j1Vf2E
         ntEOi7GCfJvlkfDkGtrj1sNa4gpw3RI9Wy8wsFFwPNGe0797TCXc7xKX8/c6clY5bNMr
         bW52oIyszytEp2prbBxx5UOMIo9SOHjL/0hAjfjiVLemTjVQ5DTIAe1+nyOOlnuixsIO
         PfqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711310625; x=1711915425;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5MqsOoodGzZPtDV9EL9+Kx91oMWToSpmgmM8is9DfYQ=;
        b=rWz2iPv5iDYtL09blEzCZjrCGQOSnqR43WYKmG5nV4JzdnkvWo1H1d2bXGVID/FFQ8
         nMUETRUOewwIcpeL3XXLjaG2dN+w3LzJ3/MOnrKlKU0CRJqgR6RtvhHMswYAzD/hDt+5
         LGbMWIs8T4Nxc9Vu8/tfw5oWm0T4oH+7zkk9kFes68nRFr9plUlQyHhFokYOXGkRTYqJ
         eBarGTPe0eLB8JURMppzLwgAxqSCfkgfzr3pTBUp+u1/pXwV117wT07WOcVNRBhWEfMn
         YdQ1PUs6x+Bj6J73v6BRlH0RplNnvMQz9e+Hip+RF70SiNwTcSBj5DuI15c4brprSb+W
         grcA==
X-Gm-Message-State: AOJu0YyW0kDGLiBHjzHSqpufuRh0GoII1edG1YxaVyhkgELmd6RicxKr
	DfXZ2uV4KGhed274E+EnF5oGw902sZAXkfrpCxqjIsojtY/Q+AEgIMBv3c5a3Dfbpkrl9+bugTZ
	fXAauGChxS4TF/VFbQwSISNxytfxX+cBG
X-Google-Smtp-Source: AGHT+IFPMjMKPTILWB3bmZraV+HizVc43SF0gCPWoPoWBMHsyz+FrrObCmeHRIiskvn43gADQZAskkPWfTuZVPuRJfA=
X-Received: by 2002:a05:6808:17a1:b0:3c1:e79e:5b2a with SMTP id
 bg33-20020a05680817a100b003c1e79e5b2amr8169752oib.29.1711310625067; Sun, 24
 Mar 2024 13:03:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGRSmLuWKhmthR=evQ7-5MKnE44ABsCdqQeysUyMG7ssQkKCEw@mail.gmail.com>
In-Reply-To: <CAGRSmLuWKhmthR=evQ7-5MKnE44ABsCdqQeysUyMG7ssQkKCEw@mail.gmail.com>
From: "David F." <df7729@gmail.com>
Date: Sun, 24 Mar 2024 13:03:34 -0700
Message-ID: <CAGRSmLtkaq+cyjrB600LYr=6G2jj+vkWbM1SgBk18mW3yjSYfA@mail.gmail.com>
Subject: Re: Wake from Sleep doesn't work
To: linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

More details on this - if you enable DRM it will wake, but because DRM
locks up on so many systems, can't use it.  It's when using the basic
EFI and VGA fbdev driver that doesn't wake.

On Wed, Jan 11, 2023 at 1:51=E2=80=AFPM David F. <df7729@gmail.com> wrote:
>
> When a system is using fbdev and goes to sleep and wakes, the system
> works fine but the screen remains black, fbdev doesn't wake up.
>
> There was a patch from 2009 but I doubt it would apply today.
>
> Is there a way to make fbdev wake properly?
>
> Thanks.
