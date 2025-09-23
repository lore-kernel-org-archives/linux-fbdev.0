Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB6521C9F4
	for <linux-fbdev@vger.kernel.org>; Tue, 23 Sep 2025 21:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758661321; cv=none; b=kAnrdBp3p+578lnGb4M7edXryhZ5V//HnotLnlA93LROG9ZFL7UrrMsmeSK91I43MbURdKB7mdqIBP4aaHMHupq0lZQA/vgcdii3R713MgInrO1GMzmaGKAyf8Et5jlmNMGUMdGPCFNeyVrU4Wq9yAjzY7eMLMj1jM79JgaCp30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758661321; c=relaxed/simple;
	bh=GdeoEqhOUMKbsmamyUPZCj/3GBbdVWDAf/WbuzYo1JM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X1E2i4asakbPJl6RiIXSbnnB3fCp95jYKafyprcW4pn/2sdlv8j4Na+EuJxNQ9JyCgv0LXyWHn5fxc8QVXBqAkX7GsKk3kfphgsSii78o2RhZUvWy0UxpRjs2zDn3FZPcWx0Zsc3ykgE783/ZxNcCh51/A6ROFwagFpdV8A7ono=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T5B5ElUv; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T5B5ElUv"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-267fa729a63so11193455ad.3
        for <linux-fbdev@vger.kernel.org>; Tue, 23 Sep 2025 14:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758661319; x=1759266119; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IiShayob+wMbBulEHfowX58N88DexQXEmp0Our0Q2Vg=;
        b=T5B5ElUvnndRCvC+ihFX494sllLeusHobtd1Sdrxhlrfm5QpNm/+ZDJ0ZZA2aalnkb
         Q199dQfajLQLRFj73Dtm8KoZTatjEUsUfEViD+9Zk3dSn3/SsppqQhszjaKfdn1aL5Sb
         oYszoZWh+k8//hDL8noRPnyF+/Sk21imC5LvExcBtBuH25DkK3eU9JoIaf2t9SiLctZf
         MrvuL80HQM83N/YCA4cFHc/kLLJD8YI4C6EmZ4PR0jn6Qy3bnELYWQrLqoP1mKG/EDfm
         DeYQl8hz7lWoXaFg48IFIcifoXzvLZcQARmVaLmRziInmqSkXEIOkdt2luedfMXl4a8I
         S90w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758661319; x=1759266119;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IiShayob+wMbBulEHfowX58N88DexQXEmp0Our0Q2Vg=;
        b=UmtbMlMo41MRlfVJLQjbPydDdPRWzssvZnoesVc2KMkYBxVUi9FkrUGJoFqBjRW/Cj
         vfSkCQ0z1Bh38miGPN7mrTbR3cX8K+wqiCrzDc4/RyTutpQqtH0L/703C1KzzhfS3P9N
         aZMJoUI3V32mMODt6lu2Z3iwqsj0Wg5r/UpZCY97xzknurcqTcxmaehsNDE5P3C7UWRM
         TwM5snoe8mpVUoRW1Xxu4LVxAMv9C6c9GFMBcTXguTZmL3BcwQL85MUS1A6pIX603GKL
         QNxJyntMcNz+DCQaJ0MFmqB5/p9R1bgkYvNGNc4onB/VLr5Y5fRxjtlvYKwfitVs+9Gf
         vDEg==
X-Forwarded-Encrypted: i=1; AJvYcCWSlOUjTCNjxJyIJ/26RPp/tnNLaNMAIp+PePkCAX1UGPRO6D6t6Nsa2AItpnPjniX0zMzNSLfQbCMNoA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzX1GUt4YNwPKTIDV1W0aBSmqrxYsEBWzCCPGZeB8x3/WNocyt4
	OaR8mIaiA2MXykv6vYGbb7KCZgIaNNglrHIx87Lu2sqkJgAG76rnB1Kbn/HG+HSrXYIBs2+CTSU
	yRq6Hy3Z6DvyhWuOEgJqAWazC46Cip9Y=
X-Gm-Gg: ASbGncv0b6hioglYeSiEDSHVodpoWVNI1zgqaOLGQZIiu9+Q2HSZz77K1K0RYvEB+Yh
	8we12FpP6VzzRY4R8URYEqgbwOS2brPW2lsz3Klo1Yc+c76Ac/r+DEAJzMzQudg/tWcSw65B6Jx
	ms1VFQoSaqHyVQ4zTstV9a1ZDkvgfrWHBgjbFJPtkVwnK1tN9cNhY0TnVseHjHecia6Os3JdUCN
	DOW2mmxLMoVTcd/Kg==
X-Google-Smtp-Source: AGHT+IGBIpx9mrFyDSaaGSwsEdyPQMz8HXLpGnW+28xc1uhmMzsInV1+Wy3g/FV+hkJat3S8a2AqMq6CslP7cPKpxFE=
X-Received: by 2002:a17:902:ec8d:b0:269:67e9:4c20 with SMTP id
 d9443c01a7336-27cc41d582fmr27553505ad.5.1758661319381; Tue, 23 Sep 2025
 14:01:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250923171409.25927-1-hsukrut3@gmail.com>
In-Reply-To: <20250923171409.25927-1-hsukrut3@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 23 Sep 2025 17:01:48 -0400
X-Gm-Features: AS18NWAaDRkmma0nmJvOC0wFTTFBrD_CmBl8W6TTz0Z5Vyhfubp9ivnudhX4kc0
Message-ID: <CADnq5_P-UsY-uCYaTU5nA9jioCaL5jNPQHFn9YdtsBEVC_4aVw@mail.gmail.com>
Subject: Re: [PATCH v2] fbdev/radeon: Remove stale product link in Kconfig/FB_RADEON
To: Sukrut Heroorkar <hsukrut3@gmail.com>
Cc: Helge Deller <deller@gmx.de>, Thomas Zimmermann <tzimmermann@suse.de>, Arnd Bergmann <arnd@arndb.de>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Gonzalo Silvalde Blanco <gonzalo.silvalde@gmail.com>, 
	"open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>, 
	"open list:FRAMEBUFFER LAYER" <dri-devel@lists.freedesktop.org>, open list <linux-kernel@vger.kernel.org>, 
	skhan@linuxfoundation.org, david.hunter.linux@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 23, 2025 at 4:19=E2=80=AFPM Sukrut Heroorkar <hsukrut3@gmail.co=
m> wrote:
>
> The product page referenced in the FB_RADEON is no longer valid.
> Remove it to avoid pointing to an invalid link.
>
> Signed-off-by: Sukrut Heroorkar <hsukrut3@gmail.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
> Changes since v1:
> - Dropped the link entirely as suggested
> (See: https://lore.kernel.org/all/CADnq5_NHu5=3DesJZrgy_S80jF68ZapRRYX4_L=
70DwDDSN3VXitQ@mail.gmail.com/)
>
>  drivers/video/fbdev/Kconfig | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
> index c21484d15f0c..27639b2590d8 100644
> --- a/drivers/video/fbdev/Kconfig
> +++ b/drivers/video/fbdev/Kconfig
> @@ -948,9 +948,6 @@ config FB_RADEON
>           a framebuffer device.  There are both PCI and AGP versions.  Yo=
u
>           don't need to choose this to run the Radeon in plain VGA mode.
>
> -         There is a product page at
> -         https://products.amd.com/en-us/GraphicCardResult.aspx
> -
>  config FB_RADEON_I2C
>         bool "DDC/I2C for ATI Radeon support"
>         depends on FB_RADEON
> --
> 2.43.0
>
