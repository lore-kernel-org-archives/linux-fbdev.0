Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB57978685;
	Tue, 18 Jun 2024 07:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718694899; cv=none; b=j+3ID0qxVKbLANUnP4+vDoUlQAv5ePDO5zcStyQkgPM+HFxhFAY6XDufbWcQn6J3psc3E4cE+MQ8gWGDC2kN32xxMUs/lmG61CbjXCPnjbXT8XaMVAvpsbjjBesL5NWmQddUTJJ/f1N+OKQTQ38WbYacZtqBlOOg7T59tF8raGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718694899; c=relaxed/simple;
	bh=sgQ/ecmz9l8V9R4Q0gmicwHAABwSB1qETXSdYXgXGVs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=atmkRdbaAAFZx851HruId6Sj4ynTZAdgokprfbGOuxFNOvT3FAxnlBomhbazhXCwW9aqwqaHr/0u3uZwd0eHW9+4I6FTXq7WUDWH3n1RvjJun4UZg/1EW1C4E5dz1WCed/jiAY6krzHqmlRicTbXfFNawyBzovLxrfo26shWswc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6319bf71f28so44430937b3.1;
        Tue, 18 Jun 2024 00:14:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718694896; x=1719299696;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b/mPXpBtKaq4fENYlENLj25BgA6Zpb9v6MwGbSxQAog=;
        b=TcU7csXXGLnYId5U5tHomcKf21EmiRBBjZiTwXbjeIO2jYfObP3vlHKhDBulwj72Vt
         2FNAyIRm7kEvKWqcrqeo19DbQdoiZjNNk43PMuRQALPp3nIDZ79+A0a19BhOilBhJ5D7
         7BXSJoIlmun9199oGxgxjLpHfj61kSHeT8oXRMFGlp/F9Tenhz/ILxpA7ahncrZELK5y
         XYBjF4DqvP9L9OGvTMMAa/dx/X3btQnsEGH8ImTlDMUdNRlBjyg6VQexTILdtFe5h2nM
         UyqyLmGhOZ4wGUJzdYa7Q7XVJg1REKTOlhD6qMKk+hKCUq+QzjiQTS2OB7hDEb2eP/Y7
         4BYA==
X-Forwarded-Encrypted: i=1; AJvYcCVUsprm6rUCLqghNvMYJ0rkQYoDLtRus68x+5hMRhd/K48yHL/mo3hH2R2rQJB+8OuJmbSpz4hbdEV2WRLD7C2/bE4w1jlXjpmzM2IW6PHxJD1ekoF1+OXmRHaN21Fe8riTgakoHBB03fHkyzU7PREQfxGsj2yItaeMP+Ze+FsXdbb/fjc06yq5Ewk=
X-Gm-Message-State: AOJu0YzhP07lfyznO+n9vtfI5h3ExBj7zTSMo+3jejZsZwgmDxieyzWA
	5Bm3DaePQVvebaY+MDfOjMrW9Cnyj/SebiwUxVNckodO6LD0UuqzD4DdC8Ba
X-Google-Smtp-Source: AGHT+IFJaP2c3hhyYL2ZBwVazR45/fpBX8Ffdam1MqXNiwRTQv57kCn4JHIKKS6eh2DueY7wTwi8DA==
X-Received: by 2002:a25:2f53:0:b0:e02:7931:64db with SMTP id 3f1490d57ef6-e02793166c6mr972615276.9.1718694896320;
        Tue, 18 Jun 2024 00:14:56 -0700 (PDT)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com. [209.85.128.172])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-dff048bd833sm2286973276.35.2024.06.18.00.14.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jun 2024 00:14:56 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6383f01d1deso14933387b3.0;
        Tue, 18 Jun 2024 00:14:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXgnb6B7/EVP2CYGX2cz1t7uJte2ZL7XeOBJJz9LVR4a1Dyx/gi3xLt4M3YkkapU46/gtbHkUJLF33AznmAsbm7dDNjZVUSmz9Q2Jc+RN2vEH2+0Y/oxIJbgpZG56F3GagCuozwkwZdpBSYw1ChTygPRVUsDcAnshh4tHz5MUc061q5xLmUWRp6Cmc=
X-Received: by 2002:a05:690c:f88:b0:615:3262:ffb1 with SMTP id
 00721157ae682-63222a56021mr139227977b3.12.1718694895868; Tue, 18 Jun 2024
 00:14:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240617-md-m68k-drivers-video-fbdev-c2p_planar-v1-1-8262753bb4e8@quicinc.com>
In-Reply-To: <20240617-md-m68k-drivers-video-fbdev-c2p_planar-v1-1-8262753bb4e8@quicinc.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 18 Jun 2024 09:14:44 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVvYxJiwC6rU_tT3rCDnTO-R0KsNT9Sxxd5UGTC5Yab=A@mail.gmail.com>
Message-ID: <CAMuHMdVvYxJiwC6rU_tT3rCDnTO-R0KsNT9Sxxd5UGTC5Yab=A@mail.gmail.com>
Subject: Re: [PATCH] fbdev: c2p_planar: add missing MODULE_DESCRIPTION() macro
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2024 at 5:05=E2=80=AFAM Jeff Johnson <quic_jjohnson@quicinc=
.com> wrote:
> With ARCH=3Dm68k, make allmodconfig && make W=3D1 C=3D1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/video/fbdev/c2p=
_planar.o
>
> Add the missing invocation of the MODULE_DESCRIPTION() macro.
>
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
