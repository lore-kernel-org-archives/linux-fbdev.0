Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OFk0ieiO"
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7919197
	for <linux-fbdev@vger.kernel.org>; Tue, 21 Nov 2023 15:45:40 -0800 (PST)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-5c9ea2ec8deso31536917b3.0
        for <linux-fbdev@vger.kernel.org>; Tue, 21 Nov 2023 15:45:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700610340; x=1701215140; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g/nq/TjG7rk7+xffRTTuBE0xXTcJ6woqoDgmivDyuJU=;
        b=OFk0ieiOP1eJwL/747sHGrZirlHv2iKgAsUBBOpTeNEtBK0zHxus5My7s6bhba2SxB
         rPZz9Z1mS/UDLrEWQ8qLn66FAQXyktlh1K22n1hP/Of2LEMDnbj6W330NmKt5QFycX4w
         CUNgAeTfCulKcKQEp1ENd+vaVrI+HyS3HOdpT5UiNGrJo/uSFbq3Fobjg7xocYCzpOo2
         BBjSePMpDjBb00imzQedXzvqH62dmCqhovjR0t3vNOEiWK5kEyoew0sKoES9WjcfImOk
         rWIC3/8JlbKHwgKDhjnTiegCVE6p0VYb3txTd531DpxZSvk547RRm2QRvfTlEeV9R5XN
         oHlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700610340; x=1701215140;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g/nq/TjG7rk7+xffRTTuBE0xXTcJ6woqoDgmivDyuJU=;
        b=imCuiuCJXkTBsYPQKG+Gekdmj/ZFZC9EzIx9tRLaExrVP0Fqr0SuulGQe5+IA0vIAk
         6vI3BO7WoPLW8NaEuaVBMX8fB5MQoamIx015MF5lgJ18062AEvCY8/ng4Hu+XABu8ZvR
         bctS6HTvuXo7WMUXynnnhrTAVgquHvRl12/n3ZFVQWnsbi+ej2GYSntL+yQrQk11hKMj
         hvpYGsPMgps6JAcMD5ChZaKQh5FHjRWulm6o0O0q2y1hfQrt6s0jP1fugrPSHnigtRur
         VSL3EdSijaVRZX0y3LyQNh7g9/kXambR4QwJ5eVNPTol7IVQn7nm19UifkMupGD0mgKg
         nZQA==
X-Gm-Message-State: AOJu0YynHSLuy1bpb/lEtw4LqGmhgLkVRqOP9j3jth6LQpIHEZVN8HYT
	aCaqFAZoHsDVDOhwMG8sLas9pjT2rLXDn1i0yj0=
X-Google-Smtp-Source: AGHT+IEjEi3+lnREUELpm5SMBsO3Qg61OF291Hs70QV3a6TayvYJ13WtCdBT0H6J8bJeFx6RGEQI09H5FYOeJU2bkkw=
X-Received: by 2002:a81:4e92:0:b0:5ca:18e9:8ef8 with SMTP id
 c140-20020a814e92000000b005ca18e98ef8mr619477ywb.28.1700610340028; Tue, 21
 Nov 2023 15:45:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231115102954.7102-1-tzimmermann@suse.de> <20231115102954.7102-11-tzimmermann@suse.de>
In-Reply-To: <20231115102954.7102-11-tzimmermann@suse.de>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 22 Nov 2023 00:45:29 +0100
Message-ID: <CANiq72ndeK8etkQD-hM01ZdOP-tEBwf39xZBVzeLDF59rDSiYw@mail.gmail.com>
Subject: Re: [PATCH 10/32] auxdisplay/ht16k33: Initialize fb_ops with fbdev macros
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: deller@gmx.de, javierm@redhat.com, linux-fbdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, Miguel Ojeda <ojeda@kernel.org>, 
	Robin van der Gracht <robin@protonic.nl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 15, 2023 at 11:30=E2=80=AFAM Thomas Zimmermann <tzimmermann@sus=
e.de> wrote:
>
> Initialize the instance of struct fb_ops with fbdev initializer
> macros for framebuffers in virtual address space. Set the read/write,
> draw and mmap callbacks to the correct implementation and avoid
> implicit defaults. Also select the necessary helpers in Kconfig.
>
> Fbdev drivers sometimes rely on the callbacks being NULL for a
> default I/O-memory-based implementation to be invoked; hence
> requiring the I/O helpers to be built in any case. Setting all
> callbacks in all drivers explicitly will allow to make the I/O
> helpers optional. This benefits systems that do not use these
> functions.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Miguel Ojeda <ojeda@kernel.org>
> Cc: Robin van der Gracht <robin@protonic.nl>

Acked-by: Miguel Ojeda <ojeda@kernel.org>

Cheers,
Miguel
