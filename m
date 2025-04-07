Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD709221DBC;
	Mon,  7 Apr 2025 05:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744005473; cv=none; b=ROl8L9yz5BQ+LFTdyFe+ks6xA96V0Sz4YpsVw4joFLgS8z9oePiWLBJUf+OME0jihvhViMzgY4Cb5YshkOI3KFuMwDI/OouxlApmB21Sv1KndhXGWlByWPBjoCRZPExNvZlVBTjDWe/yzir+qjVyl0HjptywnK1qBskVfqEd+iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744005473; c=relaxed/simple;
	bh=Ie29+/UawBgvaIHMCeBJQcdJFBfOAaXTEIGtJaSIBvc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y4V2nPiajpr2W5n8qxQamwxiDuTHthUac7V0QQUjwQfZnSRRxiJghUomMEojHy96CS/5WfdFMltRnYLkuiF2WY3shRenjfQYPrRul2rGT3gN8Sr7TZiReNydmTuLnHNKhUzAsSLifyywnmhCc98TnER4SpqR+g5rNalVKvwqlTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kyw3hI/f; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kyw3hI/f"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5e6167d0536so7013381a12.1;
        Sun, 06 Apr 2025 22:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744005470; x=1744610270; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MU/QERwA590a39V1uHdiHYOh0ZGLgU5IxEfn8b8/6iQ=;
        b=kyw3hI/fhynrk6h4a8f0ywsbxxC+gD6yTyh7LCHpzx9RdBDirM06tRwJoJ3aHb+EUw
         eMBcBKXxn2J5ILM9P2hbkCg4pz6LhDGgDNlf2E4mLAGftmWRfgtn756BRVO4vcFowr5/
         bH4347mg5T/1O86fy0nI6gKXI6uIISrq+1w1CR6a44gPxKyeB8wdyULKhyNSj4wd3kT3
         aRCynbDPHKkhreNEmukoZTUhUtZANwVcTHhzcsOCkIgkrkPuEzJrxFjw0jCw/ivNci4e
         +psR7ySdSevZrbX5P7aT6dOAWufQHUqjtdXUJqeIhgTwwwBecXIg4i8RlKq4J/lJm//p
         87Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744005470; x=1744610270;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MU/QERwA590a39V1uHdiHYOh0ZGLgU5IxEfn8b8/6iQ=;
        b=IdLWJWHJFJD5kK1kena+vwOe7l6UxVqj8pw09cI8lwnfKw5AIvKJJ1erY6GSoFSLHa
         YdVV4p8VxzlOB7E5BybK10BOzV8Shss/K/hipaCExJMWpGFEVdTke/s1NZCaZnOC7z/1
         ZI3DcU2QMbbWgmfJZ2aSbsTgbYp3rNbV2OXGLX/Gme8PQkNECBRfHsI3X5Lt9Dja5v45
         BEN0Rh1aaevecLO7+dUxcbe1+CrRroweYo0yQIqc+QRFJ3edoTlvGaKMnIhZG7VlpSjJ
         STz0FIYlQUlW6S6LrsKN1qFoucAq6wZ5l1+NjIzeYxg7PCUxzybC9eJWpoDI98a7Tf/+
         9Mmw==
X-Forwarded-Encrypted: i=1; AJvYcCUivsBqLULATEF1ih65IsqE8wQtDrndfSFxeu88Giy+WkQQ94gN1sFfukXC8/jrbVeXjfAaYjRtdKWB8A==@vger.kernel.org, AJvYcCVEJRJNbk+xEWV6cTDUK4dOKZf00qYkkZnMIpYqcv3XnGqRjvb4EWe2GCE7heh6lZfsarYfCbBIogpRUpLD@vger.kernel.org
X-Gm-Message-State: AOJu0YzF3V7ukKZP3vUzilu+jwVqYzl9iO8eA85hm531vESlR2TOPsOh
	a7vsFnZyTkDPLaa9ff9VhAD+KeXsvfhzd/Sh5rfg9/NWkVJW4YeJL8o8sOQGP7FSJXXm/95Qf/R
	SXhKsqkP33ds6CYBfXD8JQTWlQbpAq9Cqay4=
X-Gm-Gg: ASbGncvpp8j487W3pwnHrP7bZ0istiYk6VQL9XZQy0QFBwQJlB7/T6GPXlv5fsH/lKd
	FacoU/A4daM+LfG2Vb7Z2gzZuKLSNWpJ8AEPR9IbByuvhY6Jc1P1AKQAIyNy0JCfVmTu/0DHJPi
	a6dv+75GjoSny4/1FWW0opyLHv
X-Google-Smtp-Source: AGHT+IELgjumJ/OH5wAvOqKNaKOIG+lfT/mrVgVJopPjWdFEehfMhOmWOSaLwOOa6/yim7LXwbc+NuGDmPdQpe8Z8O0=
X-Received: by 2002:a05:6402:34cd:b0:5e7:c773:ae35 with SMTP id
 4fb4d7f45d1cf-5f0b3b6089dmr9515458a12.5.1744005469968; Sun, 06 Apr 2025
 22:57:49 -0700 (PDT)
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
From: Richard Akintola <princerichard17a@gmail.com>
Date: Mon, 7 Apr 2025 06:57:38 +0100
X-Gm-Features: ATxdqUEK1yuNgL11LsgZ-ALo34s7H0IFI4v_BYAnXp1SFIlzhqYSGlc_Kvkyfjs
Message-ID: <CAMyr_bLkvFBTpYehG4fs-tqVE18YBf53okddU2=i7+Rr-zbCsw@mail.gmail.com>
Subject: Re: [PATCH 0/8] staging: sm750fb: change function naming style
To: Samuel Abraham <abrahamadekunle50@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, outreachy@lists.linux.dev, 
	sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, 
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 5, 2025 at 3:16=E2=80=AFPM Samuel Abraham
<abrahamadekunle50@gmail.com> wrote:

> This looks like a new version of a previously submitted patch, but you
>   did not list below the --- line any changes from the previous version.
>   Please read the section entitled "The canonical patch format" in the
>   kernel file, Documentation/process/submitting-patches.rst for what
>   needs to be done here to properly describe this.


Hi Samuel,

I sent the patches individually before, but I was instructed to send a
patch series.

Given that I didn't change any code, should I still add version number
and sending
patch series as the difference?

Richard Akintola
