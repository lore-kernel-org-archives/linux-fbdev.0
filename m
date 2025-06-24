Received: from mx.skole.hr (mx1.hosting.skole.hr [161.53.165.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76142E3391;
	Tue, 24 Jun 2025 16:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=161.53.165.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750784074; cv=none; b=qTNZV4oZJqIy/1DAkoLZjzTO+yNyRzQSyd0OilU9FrsLgePH8j68CkSD4xswhH/hqNVL8YbdWYC+9hUi4a9t+iYWBaXItP8q7tg7srymEj+cO/MGhwp8B503cDgB+WYzcsrgsaIFRPoptvh+a8lw/Wuny/xzoyowxyQFOy6eZRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750784074; c=relaxed/simple;
	bh=ZsnPnYNjD20ceqOJx0siQLgevND5ZqJSYXN4f2BsgJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nxX3NbvBJwdI9wpBem6NZP0PqW5aGKHCEo3fRc7xx6q9cvopvCt0cW/nO/CLo4Bxw8KN7Z1jb7/JRTcWyqB5Wa77O4mcTvHorfC8/Ov8LDf04l0QeiuLgN+9F6KNXeuVbinLEOiffANKxOUtxaH4YosqJ+imQKeHsNQoOUzKiS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skole.hr; spf=pass smtp.mailfrom=skole.hr; arc=none smtp.client-ip=161.53.165.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skole.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=skole.hr
Received: from mx1.hosting.skole.hr (localhost.localdomain [127.0.0.1])
	by mx.skole.hr (mx.skole.hr) with ESMTP id DC118820AF;
	Tue, 24 Jun 2025 18:44:33 +0200 (CEST)
From: Duje =?UTF-8?B?TWloYW5vdmnEhw==?= <duje.mihanovic@skole.hr>
To: lee@kernel.org, danielt@kernel.org, jingoohan1@gmail.com,
 neil.armstrong@linaro.org, jessica.zhang@oss.qualcomm.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com,
 simona@ffwll.ch, fnkl.kernel@gmail.com, j@jannau.net, hdegoede@redhat.com,
 ilpo.jarvinen@linux.intel.com, sven@kernel.org, alyssa@rosenzweig.io,
 neal@gompa.dev, deller@gmx.de, support.opensource@diasemi.com,
 Thomas Zimmermann <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org, asahi@lists.linux.dev,
 platform-driver-x86@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-fbdev@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>
Subject:
 Re: [PATCH 10/12] backlight: ktd2801: Include <linux/mod_devicetable.h>
Date: Tue, 24 Jun 2025 18:41:23 +0200
Message-ID: <2784921.mvXUDI8C0e@radijator>
In-Reply-To: <20250618122436.379013-11-tzimmermann@suse.de>
References:
 <20250618122436.379013-1-tzimmermann@suse.de>
 <20250618122436.379013-11-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Autocrypt: addr=duje.mihanovic@skole.hr;
 keydata=
 mDMEZokhzhYJKwYBBAHaRw8BAQdAWJZ0hsI/ytTqHGFV8x6tzd5sB596cTeeDB4CQsTf+wC0KER
 1amUgTWloYW5vdmnEhyA8ZHVqZUBkdWplbWloYW5vdmljLnh5ej6ImQQTFgoAQRYhBG3/QdYN8x
 S1t2umMK0xk1JFj60DBQJmiSHOAhsDBQkJZgGABQsJCAcCAiICBhUKCQgLAgQWAgMBAh4HAheAA
 AoJEK0xk1JFj60D1GABAJVSorZdMOlrp/oQtCSH/G53NE56x/JHA8VX+ZQBd/H3AP4/EcUf6eef
 DUxVMh2bdkmuQKsVZGgOGiXpMksrVntWBrQpRHVqZSBNaWhhbm92acSHIDxkdWplLm1paGFub3Z
 pY0Bza29sZS5ocj6ImQQTFgoAQRYhBG3/QdYN8xS1t2umMK0xk1JFj60DBQJmiSH/AhsDBQkJZg
 GABQsJCAcCAiICBhUKCQgLAgQWAgMBAh4HAheAAAoJEK0xk1JFj60Dlw8A/i4lPOL7NaYoYePDq
 l8MaJaR9qoUi+D+HtD3t0Koi7ztAQCdizXbuqP3AVNxy5Gpb1ozgp9Xqh2MRcNmJCHA1YhWAbg4
 BGaJIc4SCisGAQQBl1UBBQEBB0DEc9JeA55OlZfWKgvmRgw6a/EpBQ8mDl6nQTBmnd1XHAMBCAe
 IfgQYFgoAJhYhBG3/QdYN8xS1t2umMK0xk1JFj60DBQJmiSHOAhsMBQkJZgGAAAoJEK0xk1JFj6
 0DG5MA/iuo4l2GDEZ1Zf+XaS//8FwdXDO9nHkfbV2MHjF4NZXwAQDroMzBdMcqVvc8GABFlTTgG
 j7KrRDz2HwWNyF8ZeprAQ==
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Wednesday, 18 June 2025 14:16:42 Central European Summer Time Thomas=20
Zimmermann wrote:
> Include <linux/mod_devicetable.h> to declare struct of_device_id.
> Avoids dependency on backlight header to include it.
>=20
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>  drivers/video/backlight/ktd2801-backlight.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/video/backlight/ktd2801-backlight.c
> b/drivers/video/backlight/ktd2801-backlight.c index
> 0489b0615ceb..17eac1b3bce4 100644
> --- a/drivers/video/backlight/ktd2801-backlight.c
> +++ b/drivers/video/backlight/ktd2801-backlight.c
> @@ -6,6 +6,7 @@
>  #include <linux/backlight.h>
>  #include <linux/gpio/consumer.h>
>  #include <linux/leds-expresswire.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/platform_device.h>
>  #include <linux/property.h>

Acked-by: Duje Mihanovi=C4=87 <duje.mihanovic@skole.hr>

Regards,
=2D-=20
Duje



