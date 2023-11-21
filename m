Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PGJ2XkDK"
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E8598
	for <linux-fbdev@vger.kernel.org>; Tue, 21 Nov 2023 15:44:48 -0800 (PST)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-5caf387f2aaso22999257b3.3
        for <linux-fbdev@vger.kernel.org>; Tue, 21 Nov 2023 15:44:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700610288; x=1701215088; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UOF5PgRQ9MPypMMVvEfLf6iXDrFT39tkd9kVEoZ4pSY=;
        b=PGJ2XkDK3617KgsiVsAuxqaDKs1IvnXKtll/3lHQWuGqci3yAHwS+OgaGzYoBS/dxB
         /sMD2YylLXfdLTfmoo96FD1AGORHT8Y8tsYnN0KrPRM/h4PMJEhzdNciD8/8H+Gti5cR
         1aIJEMUbDqEPYZW4qZ4kXr54GuYMkHQLeEfMC1vWQcySNvf/uxSLX8Rozt5vjeTIY26i
         El0RnKXSDLFICY9jl/MoeB14dKBhMp5TBa6tlaHVS+9F4zOFm8JMSO1jDpdN+EqqD+ll
         8C1RHfUEXk1ThG84h/GiI1LxRVi3+KWVFy9RE/8gKSwhbqCGpupGXdueOcl63i/nqCm4
         KChQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700610288; x=1701215088;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UOF5PgRQ9MPypMMVvEfLf6iXDrFT39tkd9kVEoZ4pSY=;
        b=BtjOrzG/c01TOU0eJ2SYSVQkD2TO5YLVkawbNIGHiRPiv63qEVxJAFXBOOfebmraH4
         TNiXxp7/y6PG9jcQRuXIrBFnRFR7BM/0TJ2tBxluDQ3BbVcmEFKQSKd9EQPtoLviQQHK
         LsFkooXZbwB6X04YyeSTeKU1gojRV9KK47GdiqXXMmCcCH/8pRMcbAykF9UsIO//s7l+
         qk7gnBhpV6XZs3ztG2kbjtJEydW8WrZPgiB3yKKKXVgwBapVDRzvLmYxtgNK53/u9fn6
         o0n5tqFF81zbvbuhufO4AgpZUl2AVKJ+ew1ehzxQhtxtUhYqe6w7jmQhbzxfJcDnieBx
         W5Hw==
X-Gm-Message-State: AOJu0YxlBPrOQRGeonnitSZAt1gjk3cXL5TpRdzPdgZT2S0y5G7axL/p
	9E9TrMD8oTtAHLrXj5lcjKZM/7MZGoGFaGCrTkM=
X-Google-Smtp-Source: AGHT+IGWSSUWPLRaF4Wxh3sMU/os0Wv2ptxz81ue5ujUgU4IiUjxx8vdmEO7aP7P8A652LBWSejSP45UqO2icSDJoI0=
X-Received: by 2002:a0d:e304:0:b0:5be:7046:b2f7 with SMTP id
 m4-20020a0de304000000b005be7046b2f7mr496382ywe.40.1700610287912; Tue, 21 Nov
 2023 15:44:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231115102954.7102-1-tzimmermann@suse.de> <20231115102954.7102-8-tzimmermann@suse.de>
In-Reply-To: <20231115102954.7102-8-tzimmermann@suse.de>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 22 Nov 2023 00:44:36 +0100
Message-ID: <CANiq72nKSdasH+cweB66E-j_jesrXW-V56mNZYFg-0do-ef5eg@mail.gmail.com>
Subject: Re: [PATCH 07/32] auxdisplay/cfag12864bfb: Set FBINFO_VIRTFB flag
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: deller@gmx.de, javierm@redhat.com, linux-fbdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, Miguel Ojeda <ojeda@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 15, 2023 at 11:30=E2=80=AFAM Thomas Zimmermann <tzimmermann@sus=
e.de> wrote:
>
> The cfag12864bfb driver operates on system memory. Mark the framebuffer
> accordingly. Helpers operating on the framebuffer memory will test for
> the presence of this flag.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Miguel Ojeda <ojeda@kernel.org>

Acked-by: Miguel Ojeda <ojeda@kernel.org>

Cheers,
Miguel
