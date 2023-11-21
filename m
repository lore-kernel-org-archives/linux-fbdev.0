Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qg5VkxR6"
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EC5219E
	for <linux-fbdev@vger.kernel.org>; Tue, 21 Nov 2023 15:50:14 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-daef74513e1so5614718276.2
        for <linux-fbdev@vger.kernel.org>; Tue, 21 Nov 2023 15:50:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700610613; x=1701215413; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/l06aWoK25tymroRAN5LfyNnos2Y6Vu7701TLiI0gjY=;
        b=Qg5VkxR6Rqhb9d6EfXYvVrbMXVvA7Q/ikDCk98Q6KeJua84lRoINsXOXSt+Uul/FPC
         jp/UnBYh0UWqy737qMIFMqf12xSTkt0960JnjMt9TONL8Fqi0gPPzlSelZ00sMrunzTs
         Bx/BYQUD1/Hq4sApnxMazbaI/qQDckN26w8Nb0dftACbd8CT38Z7bA6U/hT3uELcsXW6
         oK9A15dUAqOs3M20wUigndHaTdtFY8fE1rASMoOrHfAko9qDV068TnC+qqLJDVeJE2H7
         7r4K+MEe64niPOpheE/ttoknxqxXPmHWfMkfWIeEhcfCk1KDf0k8ck6X0fd+MVopXPae
         Qasg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700610613; x=1701215413;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/l06aWoK25tymroRAN5LfyNnos2Y6Vu7701TLiI0gjY=;
        b=Me5dSuskrTWMzle9m05Vj1hGjgNo2XrMlddfO9wA1K4eRhdrwszhTCrFz7B0OpTsE6
         d8pjhRyP7meNPXMfcCUzlbtPokyX28wtSIgTp37EDadt5zbnIQjVSSNw/AmprU3petKC
         Cw6177YTvyUticJezNqjdIUj971Ntt7qHIpmj6ZN9a3gY57odrKTsBdQzWZOJ0d628kb
         nmWS27trlf41a8ufy6wscfsTxYArin4IWomVmIGotOR5uR6K1+RqQXtKZd6qzsFz86rw
         5Lql6PUWtBNpHiHdbleWrxFxaQ6ZZbZrMjPmwAK8odqjOW16n2ZjIvFJQsjbwnMYTivK
         CFHA==
X-Gm-Message-State: AOJu0YyESfXokjK6sJAV/VSczWbvdYuL4ujCuUHhq45BWvPylpUo65DF
	wsvhpkmTlXF/4T4eUH2M5DiNDaOXc4+f8NBfsRs=
X-Google-Smtp-Source: AGHT+IEzzuDV7yVqOAYdb8QTA+Z2UBeO8W2J9fCl1SqDbEuSh3wlQ0jjreshbPUr2xeguit6WfU/uRSs5USbXzR8O9Y=
X-Received: by 2002:a25:3489:0:b0:d0a:8973:b1c with SMTP id
 b131-20020a253489000000b00d0a89730b1cmr508381yba.12.1700610613318; Tue, 21
 Nov 2023 15:50:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231115102954.7102-1-tzimmermann@suse.de> <20231115102954.7102-10-tzimmermann@suse.de>
In-Reply-To: <20231115102954.7102-10-tzimmermann@suse.de>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 22 Nov 2023 00:50:02 +0100
Message-ID: <CANiq72m8=KMin6Hck1XouqC3bV3oBgBxj0Qb4HCXsOjgFdgKjA@mail.gmail.com>
Subject: Re: [PATCH 09/32] auxdisplay/ht16k33: Set FBINFO_VIRTFB flag
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: deller@gmx.de, javierm@redhat.com, linux-fbdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, Miguel Ojeda <ojeda@kernel.org>, 
	Robin van der Gracht <robin@protonic.nl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 15, 2023 at 11:30=E2=80=AFAM Thomas Zimmermann <tzimmermann@sus=
e.de> wrote:
>
> +       fbdev->info->flags |=3D FBINFO_VIRTFB;

Is the `|=3D` (instead of just `=3D`) used in case someone adds something
to the flags before (e.g. `fb_bl_default_curve`) or due to some other
reason? (One of the other patches uses `=3D`).

In any case, if that is intended:

Acked-by: Miguel Ojeda <ojeda@kernel.org>

Cheers,
Miguel
