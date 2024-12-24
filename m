Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057341DDC3A
	for <linux-fbdev@vger.kernel.org>; Tue, 24 Dec 2024 13:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735045670; cv=none; b=Eu1PQ+RLTxNCdK5zo8yVctcVdkONSM9QItezkDBb8UdTOdrU3PXytdzfxFUN5UneaEnvSs5LnUdpIIXk1tg5xBNigNkEbqWFsyYQql913KLO2dPz+6jND4+HrKcSGfJH5y++UpMgeOXfS7fDfsGRmIyukNDXQpq/DeskoFTyFmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735045670; c=relaxed/simple;
	bh=YweF9VemGcXsKj8sWdWnmLKmPuCyyQEk8qlDLYGMdtU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=QZ00v/PjxCf9WJVfdQLrGlH6yY/UHp4LDDz5RIv0u69nc9gXIEEEs9MGL88GrZLaeyAMsYX0vW0ovx2BI3OlPukJHvDeHPamYrGQUc1ULMFjovl612usw7hrNZ4SSsbNh9w6TkWXKNlUE0csjMngr+qVtqLRr4cvln3qXF77NBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-467918c360aso57757901cf.0
        for <linux-fbdev@vger.kernel.org>; Tue, 24 Dec 2024 05:07:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735045666; x=1735650466;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BK2vF5xE22xTyQQ2fXMJ8o7UExSmC2aCsctst9o0X+0=;
        b=e6Z2TP3Vo+Jywqg2vz01lMavY5iGoAl/WQfPWHDypFBFVjjytBTwkGVdlzLNe9uies
         ZV4hjLVGuMtySEZH1xG1JOpC8UT2glezy9Wim3iYHt/O1bJS+4eE5/u4EaeMvxg89KQw
         6KNrLimy3eSYSK50IU7spF1HZB26TFskuTGYIcf2/632hfxW0DsQJpBoHABDdsa7Uonm
         NCzbJ+8oKWewEV/OQmfttEinpO5xd6xutcsC4cYClwsds5H7XmFwBV0Nfu7JVkIwd+Un
         zWv3ZvHeeV5AD9Gxl/hJ4nrtgEimYTXfK8bWig0VgnF+WXNHGg5ZcTXicc/RQX6Q6TfP
         I+HQ==
X-Gm-Message-State: AOJu0YzwkXlg4ZiTd+BNvRTQmyL89GkDOXAWOJo+lYCpTjdLKYhAneVG
	B6UKzBmzN4E0P1598PT3A/9m/2SsoKDkHqEPXMGR4NCCXVMUb3HLSSiSu+MS
X-Gm-Gg: ASbGncttgZ4FoMXxLv1tCzBBBd+AMlhLyJm0I2Gxdx0Q8LuwEXqpHL4vscUiYoZ/vEO
	cvF4rYu/0wyeP/2pycun0bmSPFHb9ugzlRYbHjIj6mdaTVExc1glAcjFMpqskfPtQBVsF/Buyab
	BgPMhVRESztiyHgLZVrOZoJHAJCEyfMAj77TV9N6QnCafZJbRTEmhCWoA3UQuuQMXjWyKZ1SU4X
	Fb19XocpdjLiOhX3ik3PNStrisw3aG0pjCNNepA2Nj4ZPDXgohPaNsVjX4aB6j18TjYlSNyYlk0
	+q66jXAfIgwj4n1gg3vfWcE=
X-Google-Smtp-Source: AGHT+IGSiCaRcvFMZqpxF7lKt2qXCsYaUdTKxMDxz4+p7U2dMmVF0lflmOJLHZwDlqiSdiDujo0+0A==
X-Received: by 2002:a05:622a:5c6:b0:467:68a3:4c44 with SMTP id d75a77b69052e-46a4a972791mr313840021cf.39.1735045666515;
        Tue, 24 Dec 2024 05:07:46 -0800 (PST)
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com. [209.85.222.178])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46a3eb19684sm53156031cf.58.2024.12.24.05.07.46
        for <linux-fbdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Dec 2024 05:07:46 -0800 (PST)
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7b6f0afda3fso528832185a.2
        for <linux-fbdev@vger.kernel.org>; Tue, 24 Dec 2024 05:07:46 -0800 (PST)
X-Received: by 2002:a05:620a:2901:b0:7b6:dd9c:fabe with SMTP id
 af79cd13be357-7b9ba74f084mr2895023085a.19.1735045665995; Tue, 24 Dec 2024
 05:07:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241215104508.191237-1-geert@linux-m68k.org>
In-Reply-To: <20241215104508.191237-1-geert@linux-m68k.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 24 Dec 2024 14:07:34 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVoExpWK_AfQdq3_O19rp0cBFybMfV-eFy22rm65_gJfg@mail.gmail.com>
Message-ID: <CAMuHMdVoExpWK_AfQdq3_O19rp0cBFybMfV-eFy22rm65_gJfg@mail.gmail.com>
Subject: Re: [PATCH fbtest 00/17] Export feature and large ellipses support
To: linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 15, 2024 at 11:45=E2=80=AFAM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> Recently, I ran into a segmentation fault when running test002 ("Draw a
> grid and some ellipses") on a system with a display resolution of
> 2560x1440.  This turned out to be due to a 32-bit overflow in the
> ellipse drawing routines.
>
> This patch series:
>   - Adds support for operating on a virtual buffer in RAM instead of on
>     a real frame buffer device, and exporting the result as a PPM image,
>     which is useful for e.g. testing drawing algorithms on screen sizes
>     not supported by your hardware,
>   - Fixes the drawing of ellipses on large displays,
>   - Contains some small fixe and improvements.
>
> I intend to apply these to
> https://git.kernel.org/pub/scm/linux/kernel/git/geert/fbtest.git/.

Pushed, with the Cortex-A9 performance figure added to the
description for [PATCH fbtest 12/17].

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
