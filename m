Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B452EAB9A;
	Tue, 15 Jul 2025 13:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752586487; cv=none; b=kO1gKCtFNPGhl5v82s86n4+E0AfGjChy1zfUOkpj3O/h25fzGNI+HooI9jf63UQB3WDYc/IBIpGye2/zT5928wK+LkJ0nc3rJMpLT/PF+wEVK9xUWKZo2DgkbTPzp15Cnq5k7cOPhRiqHVj1qGrpHl3hA86gsPEsRVq2lLXxEV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752586487; c=relaxed/simple;
	bh=+5fnVYi8jGUiwllSXfccJ9ZG874S/+1gUDYyvoKFb0M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J1meRunxCqa5CaEhx0XbvtBH9cbCk5Jz8ry0yhWV1wLs2ikjZ24V70gGBkVC/ffxfxgHXh/C1nNUpa89TdXlthBqGLWcGquPlWz3D7kgf+0EnlSH1WLTIEbgmXDlvkWlc3+qrjQ4KNQtnv/NAbXjJuRRQHW1TaXZYW0EV4fsuT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Om3RG4Gp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Om3RG4Gp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23FDCC4CEFF;
	Tue, 15 Jul 2025 13:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752586487;
	bh=+5fnVYi8jGUiwllSXfccJ9ZG874S/+1gUDYyvoKFb0M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Om3RG4Gp7iPuBcFfzV0TJrXSvVZ1ziTXeDG8NIjHzeKf0fzxyzu5ewG1JJjYIBDEh
	 oMSlbAknTx0ATbzw8IpDlNBIrVW1lnP16fyzsfYVc8m2i8t74qls7qpTRI/P7OaYVc
	 KXCsvanIabf18oIFopxNwYFsSaT8eOo7AiatP31ifLhGzXVqrVk9e5PUixsZudYIJ4
	 XQkjYpDTnIyf1Tnn8whwjtnj+T5Ygx5q19IlMqCmDHati5kjPJYO+Mk2NdzGwhLMqq
	 wqNzqzPR/BjhVlVfVFNVVKBr1g+0D7TLomCWzuYZ79x3izp2CvaFAvbhU3NSfX5CSV
	 m+shVTHiN8DMg==
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ae3c5f666bfso971694866b.3;
        Tue, 15 Jul 2025 06:34:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVcbklHJqzuGJvbcYNJCjsMbsEPDQuC6opXFjOyq2peA86j2zwisLIe5W9vrcFm23sfGWYwTOljfUcRwA==@vger.kernel.org, AJvYcCWkn/zF9CyLW2wt2iK4jkmY3jPo7gKrw88+eWR8O06zilCP8l7Wk8xYrnZ3fZBzb8KzAUfLlOsdSA0HOiEjCve0ympAoA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2xPT4cgqmUtM7JoYIYXYYSwVxuBLP0scW3LyR/4TPTKm1+kWo
	OM6ptbU5PMBIvWsQrwjOEVWici/3bBTia8D2Mt9bHedLAbJ8Gc5kJDXwTHSMqrqHLCWs9jFjAek
	iu3OXp02ixt3eVxd8OUDCDCjzfVjL1Q==
X-Google-Smtp-Source: AGHT+IGRu2JZfsUA5LKiQLqa/UEZNxt2u/LBgONat/gO2EH38uOyxF+eGpc7ilCTo4wwSiYodRP/HpFAhZMX9LDqasw=
X-Received: by 2002:a17:907:9686:b0:ae0:dcd5:ea75 with SMTP id
 a640c23a62f3a-ae9b948923cmr254110266b.5.1752586485564; Tue, 15 Jul 2025
 06:34:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250715122643.137027-1-tzimmermann@suse.de> <20250715122643.137027-14-tzimmermann@suse.de>
In-Reply-To: <20250715122643.137027-14-tzimmermann@suse.de>
From: Rob Herring <robh@kernel.org>
Date: Tue, 15 Jul 2025 08:34:32 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKSjQy8CVohbVL50kn=o_kPVUsAUFjYvNC3mpcA7pm_Og@mail.gmail.com>
X-Gm-Features: Ac12FXymC2XmqYlRUlcYFWrwlgiDEh1VRFeVs1QRm6fJt93kN_btbEF-gtsl3Qo
Message-ID: <CAL_JsqKSjQy8CVohbVL50kn=o_kPVUsAUFjYvNC3mpcA7pm_Og@mail.gmail.com>
Subject: Re: [PATCH v2 13/15] backlight: rave-sp: Include <linux/of.h> and <linux/mod_devicetable.h>
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
> Include <linux/of.h> to declare struct device_node and include
> <linux/mod_devicetable.h> to declare struct of_device_id. Avoids
> dependency on backlight header to include it.

struct device_node should be opaque...

        /*
         * If there is a phandle pointing to the device node we can
         * assume that another device will manage the status changes.
         * If not we make sure the backlight is in a consistent state.
         */
        if (!dev->of_node->phandle)
                backlight_update_status(bd);

Well, that is ugly. IMO, we should just drop the check. A DT built
with "-@" option will have phandle set, so that's not a reliable test.

Rob
