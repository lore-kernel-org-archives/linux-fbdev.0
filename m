Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2AE2BEFEB;
	Mon, 21 Jul 2025 11:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753098213; cv=none; b=ihR8FACCZ73Ye2nZIyD1501tK+lrozN4Ro7esjIyRfvbPa5+35ePzVV2IAHdgRR+xLpq9hm/qRHRiDMxlcx+dED1subR+erb3uktkLl/wX7mXbbpfLplGp9L2yi5m4dify8Te9Z4bFuqBDQ5HhzslEwh4S/DujpsfqLmcNDyRlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753098213; c=relaxed/simple;
	bh=hrgwN/w7MfcXcqLWZdBF/zPXpxKvQfR7TLLQJgj1w5s=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=PThXC/h3jMHVLIxWpADS98EgOKvCjss8qYJVbb8DiDHYVcZL7o331awyY8r2BsGN9lrJa07fjAOC4bOQh8A1cvgqMLuTu2uriISFxFvKBxYQf1bX3eksbpu21dcSW4gZV/y76u6k7Iea37VaOXh8Ceus9oXZoYY6XX86p9Xlev4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aJT02HYb; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aJT02HYb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753098212; x=1784634212;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=hrgwN/w7MfcXcqLWZdBF/zPXpxKvQfR7TLLQJgj1w5s=;
  b=aJT02HYbTVag092hOhZBLAP1xdIqXb6KSTxEui9H2ezH7XTYU9+o/KoM
   uaaDJYZfJ9VC+UUKj/56VRgcYqOooB2YFkStW4LHYbUxSQq2khtYUuTuM
   YwA9MH8ugHpE1Xrah0z9YpUDqsBTZ6yuvaiVJguHM2RRbuQN8r/TQhreW
   u4JN2pA6NM0kmR/rJFvZ1e3YYguITdib0KEy/E0qria9MdKMI2r8/3wx/
   poZ+XYfdLY6pP4/sHFQoKGBCYX8mBxJWLiAQjW7pO6eJgOE+F/lHGCdTB
   Lc8ylI+G4gf94S4H3TeY+oYFc3YudG9LjQ8VphxN3Rn3aKHLrl3fbJ2MB
   w==;
X-CSE-ConnectionGUID: 3M1MjPu1RrGVwAEYBgCYRA==
X-CSE-MsgGUID: QBN6Ei2qRD2LuRacfPZwjA==
X-IronPort-AV: E=McAfee;i="6800,10657,11498"; a="59122817"
X-IronPort-AV: E=Sophos;i="6.16,328,1744095600"; 
   d="scan'208";a="59122817"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 04:43:31 -0700
X-CSE-ConnectionGUID: OYVcffK3Q/uchzoYBJ7H7A==
X-CSE-MsgGUID: k7jugmWySG2MAQVowyMegQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,328,1744095600"; 
   d="scan'208";a="158476181"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.225])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 04:43:24 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 21 Jul 2025 14:43:22 +0300 (EEST)
To: Thomas Zimmermann <tzimmermann@suse.de>
cc: lee@kernel.org, danielt@kernel.org, jingoohan1@gmail.com, 
    neil.armstrong@linaro.org, jessica.zhang@oss.qualcomm.com, deller@gmx.de, 
    maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com, 
    simona@ffwll.ch, fnkl.kernel@gmail.com, j@jannau.net, 
    Hans de Goede <hdegoede@redhat.com>, sven@kernel.org, alyssa@rosenzweig.io, 
    neal@gompa.dev, support.opensource@diasemi.com, duje.mihanovic@skole.hr, 
    dri-devel@lists.freedesktop.org, asahi@lists.linux.dev, 
    platform-driver-x86@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
    linux-fbdev@vger.kernel.org, Hans de Goede <hansg@kernel.org>
Subject: Re: [PATCH v2 01/15] platform/x86: dell-uart-backlight: Use blacklight
 power constant
In-Reply-To: <20250715122643.137027-2-tzimmermann@suse.de>
Message-ID: <c380d3a4-2a99-cf52-0952-ee916b6c9676@linux.intel.com>
References: <20250715122643.137027-1-tzimmermann@suse.de> <20250715122643.137027-2-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-766033278-1753098202=:69097"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-766033278-1753098202=:69097
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 15 Jul 2025, Thomas Zimmermann wrote:

> The backlight subsystem has gotten its own power constants. Replace
> FB_BLANK_UNBLANK with BACKLIGHT_POWER_ON.
>=20
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Reviewed-by: Hans de Goede <hansg@kernel.org>
> Acked-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  drivers/platform/x86/dell/dell-uart-backlight.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/platform/x86/dell/dell-uart-backlight.c b/drivers/pl=
atform/x86/dell/dell-uart-backlight.c
> index 8f868f845350..f323a667dc2d 100644
> --- a/drivers/platform/x86/dell/dell-uart-backlight.c
> +++ b/drivers/platform/x86/dell/dell-uart-backlight.c
> @@ -305,7 +305,7 @@ static int dell_uart_bl_serdev_probe(struct serdev_de=
vice *serdev)
>  =09dev_dbg(dev, "Firmware version: %.*s\n", resp[RESP_LEN] - 3, resp + R=
ESP_DATA);
> =20
>  =09/* Initialize bl_power to a known value */
> -=09ret =3D dell_uart_set_bl_power(dell_bl, FB_BLANK_UNBLANK);
> +=09ret =3D dell_uart_set_bl_power(dell_bl, BACKLIGHT_POWER_ON);
>  =09if (ret)
>  =09=09return ret;

Hi Thomas,

Do you expect this entire series to go in this cycle through some other=20
tree than pdx86? If not, I'll take this through pdx86 tree in this cycle.

--=20
 i.

--8323328-766033278-1753098202=:69097--
