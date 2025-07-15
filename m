Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D152E5436;
	Tue, 15 Jul 2025 13:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752586134; cv=none; b=e+EhLZtOsLYB8+QYfl3yBRJGaqO96hS7JxEa7v1B9uVDIWQvMFnyRcdeaqpGr+7nWS8/AfCqBe3JEa7AhXw35zwuaVIkqLoWKAv9cOi/E8S9HlxMdJPIwLYuGPTMr30PO+JSt2oWkTIGdgk1r9dG2vKjnzjnyr8eJ1FNLrW0Jdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752586134; c=relaxed/simple;
	bh=cjc0RDMZbltboQ1RR5x3p4nAwpio8fE7hnW+L8x5WwQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LnKkNAKF8U9vQB9Q6xTMDbur5QgqnC+20tYo5LmHzEEqQfQUEMdohk6BA2MKdbDYWOV9b7Uk74TrpbAFPCJPuKky+iWlQbv5nmJb1kEHpPHSB6KuiOhkYwbLF8qG0qa1jVMXEa0CDovDifOXTvDYYPkNKGxkjGpCQDYm0A0tc54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SY3/KylB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SY3/KylB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1966CC4CEF9;
	Tue, 15 Jul 2025 13:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752586134;
	bh=cjc0RDMZbltboQ1RR5x3p4nAwpio8fE7hnW+L8x5WwQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=SY3/KylBUzz31er79bfw/JgAJdDa2ngkftst0JZzy928l/GgYBS73xdw7M/MN4DW5
	 Z6dbSTP4JvIOP96BayczV5VUU+43jcoyu/15zQKSWIbj0cjQ1eHhKuPwJHQmFX66Ao
	 c1JAE0zXp/BrQ2teMrDElkQoln1mQBLwl6ShQRGRFPSSIKFTeagmpdyi7/xYT3Hkg7
	 bi+LNkWJoOrhdN7+s1WZ6cFgXYFnoXTuzlvnUYC28IJkt31IxnxPD0LlORY2dJE4y2
	 CFzk1DuBG+y3ktemrkz/2iMka1VwssdRacpiFf2Vad9euP/bH1P/shMIDlNwrtHfsj
	 q3mx5Fy+aie7w==
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ae0bde4d5c9so1062716966b.3;
        Tue, 15 Jul 2025 06:28:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUvVBccgl+2/GyWbQzX9EjNnjiUzpFC9xnCcHcpKhJYjPWhfZFE/MWhkKC4GfEs/m4//DBxWXffUs/T0w==@vger.kernel.org, AJvYcCXqAkyLZ4DMJJZC/MKwyaijkJTpnbpvH3IBNh2q/Muav3QRKZRNyyWpP1RaRn3vpgG2D8Pbj64pOb07n/kWMTwcaDID0w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwwHFutgUzDoKKrHkPFoJFpD/QfBgkJCHfB7W5H168D5O60CWI0
	TuonmoDU1b78dcLupBnq0dOSUt1u8DtmQ1Ba3ml1kFaEkFcLu7RtvkC5M/OxJ/CUFnsEFHh89wr
	3EHbpIxJMEJKR/UKPZwLL1Us+VAs0Eg==
X-Google-Smtp-Source: AGHT+IFs4W+Mc6KDmPR+BhSyiX4vw23rKBtHp3go5SamoCNjOmpMqCPQF8aMkbamXqomTl4rbMZSJDZEUQ5/54iNNzQ=
X-Received: by 2002:a17:906:730b:b0:ad5:4a43:5ae8 with SMTP id
 a640c23a62f3a-ae6fbc63f70mr1723987166b.12.1752586132534; Tue, 15 Jul 2025
 06:28:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250715122643.137027-1-tzimmermann@suse.de> <20250715122643.137027-5-tzimmermann@suse.de>
In-Reply-To: <20250715122643.137027-5-tzimmermann@suse.de>
From: Rob Herring <robh@kernel.org>
Date: Tue, 15 Jul 2025 08:28:41 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJ-o05oO1TGexj7s68=9peSQURxF3siw5hDK2fU7AgMxQ@mail.gmail.com>
X-Gm-Features: Ac12FXxI8wW_XXiQYlbiT9UidRz349kSHXmlUTD2OUpFDmpZ1t1a8EguF44xgCA
Message-ID: <CAL_JsqJ-o05oO1TGexj7s68=9peSQURxF3siw5hDK2fU7AgMxQ@mail.gmail.com>
Subject: Re: [PATCH v2 04/15] drm/panel: panel-summit: Include <linux/of.h>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: lee@kernel.org, danielt@kernel.org, jingoohan1@gmail.com, 
	neil.armstrong@linaro.org, jessica.zhang@oss.qualcomm.com, deller@gmx.de, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com, 
	simona@ffwll.ch, fnkl.kernel@gmail.com, j@jannau.net, hdegoede@redhat.com, 
	ilpo.jarvinen@linux.intel.com, sven@kernel.org, alyssa@rosenzweig.io, 
	neal@gompa.dev, support.opensource@diasemi.com, duje.mihanovic@skole.hr, 
	dri-devel@lists.freedesktop.org, asahi@lists.linux.dev, 
	platform-driver-x86@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 15, 2025 at 7:30=E2=80=AFAM Thomas Zimmermann <tzimmermann@suse=
.de> wrote:
>
> Include <linux/of.h> to declare device_property_read_u32() and
> struct of_device_id. Avoids dependency on backlight header to include
> it.

Neither of those come from of.h.


> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Reviewed-by: Janne Grunau <j@jannau.net>
> ---
>  drivers/gpu/drm/panel/panel-summit.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/panel/panel-summit.c b/drivers/gpu/drm/panel=
/panel-summit.c
> index 4854437e2899..02aa1ec287d6 100644
> --- a/drivers/gpu/drm/panel/panel-summit.c
> +++ b/drivers/gpu/drm/panel/panel-summit.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>
>  #include <linux/backlight.h>
> +#include <linux/of.h>
>  #include <drm/drm_device.h>
>  #include <drm/drm_mipi_dsi.h>
>  #include <drm/drm_mode.h>
> --
> 2.50.0
>
