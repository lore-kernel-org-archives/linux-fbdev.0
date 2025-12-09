Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BB42C0F62
	for <linux-fbdev@vger.kernel.org>; Tue,  9 Dec 2025 14:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765290349; cv=none; b=TTOoJTGSXdoxoYXY6hmV6ItVYvA3sQ0yGwyrHk+ZIY1gkGkZmkwlC4+n41Gxt4Iil9y1yCpZP53Zgn5CF4Zw9/UQjf/Z2KjHKjXtJxRwZAKdZ8CVCajtcL4ezERqHltDFlKKjgnj+tl/TeEVq+yFaUQ/F7bQt+Z/Q4OJqy8//1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765290349; c=relaxed/simple;
	bh=p/QNLZHkkEp+08g4pHXLslu5TUvKGyb9J5Qo1iBjVxg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TBwIzam5KBeoBjLwePOd27GwhUJrrHRQTEbMuXk8iItvViqqv67q3eUx2sNC0KUvGeGoX7EEFdm4r8eawg3SIs2ZU3cknDL1ZZxP2Z8RIvtu1zOOmoEnMHchCTR5+OsaHbpzoTUluPRvWivKjCxhDIsU6zabW8Y2W+a3rJXH/sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eWLSqmpX; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eWLSqmpX"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b79ea617f55so1084757766b.3
        for <linux-fbdev@vger.kernel.org>; Tue, 09 Dec 2025 06:25:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765290346; x=1765895146; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7tczTAGf+NRaPH/lcY4iGZ+jG9JiJwZWejZNNrAcawA=;
        b=eWLSqmpXxVbLqSmhyOUffWE8c0E+TQ+ueWJOdRrtCyDuyeNgf1alcBFttZCOLhj55O
         H5wFcEHFyMNl9XAsoMtqOqkccrKEelJnsJ+vo70TAhGpW+ayJx5/GczJGRmBPwtBZwbW
         NW9QyI9kaUKqn33gM+43VcQ9LszLl3f/hsxPVQBoS6/poPn/3ZjNo5zL8H30LoQ4LhMz
         jhl3sWP7MVBuJUt1LiNvBf5Hcj816Bs+DnYMpEN0po2cihBhjrR7my3g42gdJbh+CO70
         1PGDRTf9azP7ZxndFubvWQN9GGTEi8KX07sKMH8bpf4J/blBfXfewSINKcWxyj13sam/
         MN0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765290346; x=1765895146;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7tczTAGf+NRaPH/lcY4iGZ+jG9JiJwZWejZNNrAcawA=;
        b=sa5yAEvNir9mVOo9f2gof4dYWEdy+FnfWopr5LVDaWKWXmvawster/26GMbY6MTCYq
         9pDnDrZLDwELAvgHrJ3XaNkZP5FVYaGgdfkK50zUhUuT/Xjr9pgrU7NJEU7oRPxZ+7Nz
         YFtFCakO4yhw/SBhTlgg72Q9BshSOSGKVBoVITvEC7ktmFsyJbZICAfcTjl7rWt6hGa3
         k/4L0pN87QwAnjLu9QRHff9NHHpMTFdpsWvdqr3Khv5q5DQpOi1YaZ9asTIdV67Yib2k
         2I5P1pfE77pVKqG9caDkTAxxexXHCRupBrJTh7Mh7ryaAHE6P8ajNARb9UheHE4Ak2JT
         E0DQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNtYc/aSqnA1f8yo1HvuK5eVB8ZNoUVZ+igAYvBaqQdvN3P/wy8Nu0YBqIUrosJ0p1DuTq+vsAq+KatA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwSrfiDPauYJ16plQ2WcH9a3TuZtdfsk851NpR47Pjc3A4XSwan
	lR+VLkS0S+yyA6aZ1vFrjqj51yzvc2S2pd1uH7yPKsPvjK4mqbk4lPz01oIGFLtMxgUbBmfXjrp
	t9R9RLBmsHEwgpfbWiZmlZpn25OL5zwg=
X-Gm-Gg: ASbGncv7tghTH553ZJ2jZT6GapyXvhBZjjZwWJEkbPJcGIm110eylbC4xeZ/OImjMXf
	ewScQq6iQx6HdfBHzSvsi5J8xdBQu1f5i1jd9o7fOmf4Ttp//xQNVaoeMKl8F0cP+Zs4Vk6qGWm
	It3Y5UrWytfZQa4dze6BTcjPL1o7pgCZunYmMqC9zY4P2SdrQN2pqxnTfB35YJpP4FycjuZ/aIw
	ekOFBJiYDqVcAk5mvwyJQjuzN6nYuRfoovhX/dK6aZNDF6AcduqX2b3qaYZojCFs8B6fg4hfCuy
	0PUonsf1A0hJ8fyz9Jvk5oU0c0hnljvkQ1OqVi1NH2y1aAP/D1yecmYI4T/nqtC+KLiMBzA=
X-Google-Smtp-Source: AGHT+IEUDyZqURELnRBTzjTZuETiToxli9ABhMGm4/e9CoRb3wfwUJvgUlRqDbyn79ps6rpZIghHoUYB7oNXT7FULvM=
X-Received: by 2002:a17:907:720b:b0:b7a:1b3:5e5d with SMTP id
 a640c23a62f3a-b7a242be82bmr1105272266b.8.1765290346242; Tue, 09 Dec 2025
 06:25:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251209042744.7875-1-chintanlike@gmail.com> <19e8a1b0-75e3-4c8d-911a-15fd70f60bea@suse.de>
 <f5d50007-5b48-47cb-8133-72fca274d562@gmx.de>
In-Reply-To: <f5d50007-5b48-47cb-8133-72fca274d562@gmx.de>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 9 Dec 2025 16:25:09 +0200
X-Gm-Features: AQt7F2oJ-HAqvTo7dPHCW2Uqr5UaQh_WR7_Bb48h-O510S-3IyA861WvQJm_2eQ
Message-ID: <CAHp75Vds8GP+daMe9WcEbOaNT91kMHUjidzGUN-1_kVDuWBtLw@mail.gmail.com>
Subject: Re: [PATCH 0/3] fbdev: Guard sysfs interfaces under CONFIG_FB_DEVICE
To: Helge Deller <deller@gmx.de>
Cc: Thomas Zimmermann <tzimmermann@suse.de>, Chintan Patel <chintanlike@gmail.com>, 
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev, 
	linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, andy@kernel.org, gregkh@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 9, 2025 at 10:23=E2=80=AFAM Helge Deller <deller@gmx.de> wrote:
> On 12/9/25 08:27, Thomas Zimmermann wrote:

...

> This whole series adds a whole lot of ifdef'ery, which I think is the
> worst approach. It makes the code less readable and leads to two code
> paths, which may trigger different build errors depending on the config.
>
> I'm sure it must be possible to do the same without adding more #ifdefs,
> e.g. by introducing a function like   dev_of_fbinfo(fbinfo)  which
> simply returns NULL for the FB_DEVICE=3Dn case.  Then, that value can be =
tested
> like
>         if (dev_of_fbinfo(fbinfo))
>                 {...do-the-things...}
> For the FB_DEVICE=3Dn case this will then be optimized out by the compile=
r,
> while you still have full compiler syntax checking.
>
> Thoughts?

I second you. I am also not a fan of ifdeffery when it can be avoided.

--=20
With Best Regards,
Andy Shevchenko
