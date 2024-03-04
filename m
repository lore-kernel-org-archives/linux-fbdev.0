Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5CC3FB02
	for <linux-fbdev@vger.kernel.org>; Mon,  4 Mar 2024 14:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709564153; cv=none; b=sjpPSHgLE27+LDTQog8pa0evUiYXXAYOPcGUJrgNxbrREPDZaYv3kqtF3n3C0Mjr2D62GLqqt9EHMSef9HreLigBljIbv+N11tcA2caE1SaxTosZpN4irC2hy4f0/Ug0hHfrmbc+GOwA0M4UZAbb93rZkC7WsHpqXmRxaUL9868=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709564153; c=relaxed/simple;
	bh=em9YUjFkpzeno/gvQM325mN/Zt68LM+X3qfM17oePbE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A8GUqUPz1OjZiWmNW7KYUGkh3/oWg+uDAyXnMEzpq8OR7bp3zmS7udYCidi6GBoyG1jh2SCQ00ZCeAEKcgD8++NGu9TCQ3NkdT9blsTeAeDeoGHJRw7ZpCyMjmZ1EUYfhMpwinIllxIUqQZncwPVViJ4aQkR4yVRPjZIbvc6Bow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yWExFihy; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yWExFihy"
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-4725acb539cso1235188137.3
        for <linux-fbdev@vger.kernel.org>; Mon, 04 Mar 2024 06:55:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709564149; x=1710168949; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AWTkZgsoLpPKdOGgcn1hzOrRfxw8EPkwi9BIWs11TSI=;
        b=yWExFihyoc93KBaHOuofUoWwWQaah7fGF/nim+U2eB7kKKNvp4cleKrVHiCZZRYSy2
         X3/75o9Hft/DNBEXAbkViqFUgdu5kAGrwVpbmSn3Jg7p6Jb2b9A/dHJfE2Dfnh7jTkVI
         ukdBgfYvDqUQlVhGatTYjQnd5RRk4HX6Q7vVVKU2DcBBXyI5QUhuOQsGsCF3FQm2ooId
         QSBVJ08lVxvr0a8Jo3RNSeE88D/AFfUMSjZ4BQLsCm8K7/0GE8LKKFzZ+lTMBfmRJLRN
         S/MTDkdj93qp5jeRPTWpGMfTcSfDN170kqYKbJXL+e4JLVw+xGk+hGVZEOTASgswfzLv
         jm0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709564149; x=1710168949;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AWTkZgsoLpPKdOGgcn1hzOrRfxw8EPkwi9BIWs11TSI=;
        b=jdI3H0es0Kv+/viLsmTer3RdglejhZgYsAIDKohEximFxF8d9ZBJE6MZ9Wsz1DuVI5
         okpGCFoDjjIRkpA9T64hX/i2PkVumcUZOv5dHsGNU8i/bvubMECstZEB5wPwhSCDF/r+
         qmbqh8OW84R3hdmvw5wLw9kQlGf9PH/fNppQnTVihOcA5Rk0gTXNk9vVDOQjPyFMcpQw
         rIR0idN3/dAaqLIBdiKS5oM3x83MiHrh6oegs66+UAOZa7kA/QNlKZjuEAa+S/egjuZK
         5ew8qe3i1cyjs8GMcwKLoE9Bn3ps86MJNduGcystT8B1qeBu5xEJ7nrhRfDZjDOLxDCo
         DdKA==
X-Forwarded-Encrypted: i=1; AJvYcCU1q9UbNoGFjavLlt79YEpCmb8f1DxVULebVuMTXb+jzJ/Fch9o09K9hpTL+e4l0RAjK3rfKBLE6N9bAD44ZmOF8Tfu6tKvN7cXGug=
X-Gm-Message-State: AOJu0Yx9P61vmT80XjGLZOHul1f9+dazghZrzq/l5SxMOkD3QZCgR9tn
	o7ryCDaCoDo9HkfGRVZ9DRnE0IaiHym1qbuhE6Mb1fESsM44xnJ4Mk32QFJO2GgkdL2Y+FelrbL
	ccb5q4JQfvSbhPe2bbFmcYdGvyOa5mUOxpYl0oQ==
X-Google-Smtp-Source: AGHT+IG934W8fniwCAisOtWNbw/y515juXyLVnR2Fiu+gO0N2Ek8hxZbk2Rv0Vp8Lo6V1b7KKlvuokOu6sTWZN3xv2A=
X-Received: by 2002:a05:6102:2927:b0:472:d517:24cf with SMTP id
 cz39-20020a056102292700b00472d51724cfmr879625vsb.15.1709564149443; Mon, 04
 Mar 2024 06:55:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYsAk5TbqqxFC2W4oHLGA0CbTHMxbeq8QayFXTU75YiueA@mail.gmail.com>
 <20240304095512.742348-1-jani.nikula@intel.com> <87bk7u5n9h.fsf@intel.com>
In-Reply-To: <87bk7u5n9h.fsf@intel.com>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 4 Mar 2024 20:25:38 +0530
Message-ID: <CA+G9fYtQobCEno5oRgqPzhHrjff4zMki=9fWwJ1NPtKeKQ+aUg@mail.gmail.com>
Subject: Re: [PATCH] powerpc: include linux/backlight.h from asm/backlight.h
To: Jani Nikula <jani.nikula@intel.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org, 
	dri-devel@lists.freedesktop.org, lkft-triage@lists.linaro.org, 
	linux-kernel@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>, 
	Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"

Hi Jani and Benjamin,

On Mon, 4 Mar 2024 at 15:31, Jani Nikula <jani.nikula@intel.com> wrote:
>
> On Mon, 04 Mar 2024, Jani Nikula <jani.nikula@intel.com> wrote:
> > Removal of the backlight include from fb.h uncovered an implicit
> > dependency in powerpc asm/backlight.h. Add the explicit include.
> >
> > Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> > Closes: https://lore.kernel.org/r/CA+G9fYsAk5TbqqxFC2W4oHLGA0CbTHMxbeq8QayFXTU75YiueA@mail.gmail.com
> > Fixes: 11b4eedfc87d ("fbdev: Do not include <linux/backlight.h> in header")
> > Cc: Thomas Zimmermann <tzimmermann@suse.de>
> > Cc: Helge Deller <deller@gmx.de>
> > Cc: linux-fbdev@vger.kernel.org
> > Signed-off-by: Jani Nikula <jani.nikula@intel.com>
> >
> > ---
> >
> > Not even compile tested!
>
> Naresh, please try this patch!

Thanks for the proposed fix patch.

Steps to reproduce:

# tuxmake --runtime podman --target-arch powerpc --toolchain gcc-13
--kconfig ppc6xx_defconfig --kconfig-add CONFIG_PMAC_BACKLIGHT=y
config debugkernel dtbs kernel modules xipkernel

# Applying patch set
Applying: fbdev/chipsfb: Include <linux/backlight.h>

The reported build regression is fixed but build failed with below errors.

My two cents,

I should have copied the full build error log in the morning.

Few more build errors on powerpc builds,
------------------
drivers/macintosh/via-pmu-backlight.c: In function
'__pmu_backlight_update_status':
drivers/macintosh/via-pmu-backlight.c:74:21: error: implicit
declaration of function 'backlight_get_brightness'; did you mean
'pmu_backlight_get_level_brightness'?
[-Werror=implicit-function-declaration]
   74 |         int level = backlight_get_brightness(bd);
      |                     ^~~~~~~~~~~~~~~~~~~~~~~~
      |                     pmu_backlight_get_level_brightness
drivers/macintosh/via-pmu-backlight.c: At top level:
drivers/macintosh/via-pmu-backlight.c:108:21: error: variable
'pmu_backlight_data' has initializer but incomplete type
  108 | static const struct backlight_ops pmu_backlight_data = {
      |                     ^~~~~~~~~~~~~
drivers/macintosh/via-pmu-backlight.c:109:10: error: 'const struct
backlight_ops' has no member named 'update_status'
  109 |         .update_status  = pmu_backlight_update_status,
      |          ^~~~~~~~~~~~~
drivers/macintosh/via-pmu-backlight.c:109:27: warning: excess elements
in struct initializer
  109 |         .update_status  = pmu_backlight_update_status,
      |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/macintosh/via-pmu-backlight.c:109:27: note: (near
initialization for 'pmu_backlight_data')
drivers/macintosh/via-pmu-backlight.c: In function 'pmu_backlight_init':
drivers/macintosh/via-pmu-backlight.c:136:37: error: storage size of
'props' isn't known
  136 |         struct backlight_properties props;
      |                                     ^~~~~
drivers/macintosh/via-pmu-backlight.c:154:34: error: invalid
application of 'sizeof' to incomplete type 'struct
backlight_properties'
  154 |         memset(&props, 0, sizeof(struct backlight_properties));
      |                                  ^~~~~~
drivers/macintosh/via-pmu-backlight.c:155:22: error:
'BACKLIGHT_PLATFORM' undeclared (first use in this function)
  155 |         props.type = BACKLIGHT_PLATFORM;
      |                      ^~~~~~~~~~~~~~~~~~
drivers/macintosh/via-pmu-backlight.c:155:22: note: each undeclared
identifier is reported only once for each function it appears in
drivers/macintosh/via-pmu-backlight.c:157:14: error: implicit
declaration of function 'backlight_device_register'; did you mean
'root_device_register'? [-Werror=implicit-function-declaration]
  157 |         bd = backlight_device_register(name, NULL, NULL,
&pmu_backlight_data,
      |              ^~~~~~~~~~~~~~~~~~~~~~~~~
      |              root_device_register
drivers/macintosh/via-pmu-backlight.c:166:19: error: invalid use of
undefined type 'struct backlight_device'
  166 |         level = bd->props.max_brightness;
      |                   ^~
drivers/macintosh/via-pmu-backlight.c:176:35: error: invalid use of
undefined type 'struct backlight_device'
  176 |                                 bd->props.max_brightness / 15);
      |                                   ^~
drivers/macintosh/via-pmu-backlight.c:179:11: error: invalid use of
undefined type 'struct backlight_device'
  179 |         bd->props.brightness = level;
      |           ^~
drivers/macintosh/via-pmu-backlight.c:180:11: error: invalid use of
undefined type 'struct backlight_device'
  180 |         bd->props.power = FB_BLANK_UNBLANK;
      |           ^~
drivers/macintosh/via-pmu-backlight.c:181:9: error: implicit
declaration of function 'backlight_update_status'; did you mean
'pmu_backlight_update_status'? [-Werror=implicit-function-declaration]
  181 |         backlight_update_status(bd);
      |         ^~~~~~~~~~~~~~~~~~~~~~~
      |         pmu_backlight_update_status
drivers/macintosh/via-pmu-backlight.c:136:37: warning: unused variable
'props' [-Wunused-variable]
  136 |         struct backlight_properties props;
      |                                     ^~~~~
drivers/macintosh/via-pmu-backlight.c: At top level:
drivers/macintosh/via-pmu-backlight.c:108:35: error: storage size of
'pmu_backlight_data' isn't known
  108 | static const struct backlight_ops pmu_backlight_data = {
      |                                   ^~~~~~~~~~~~~~~~~~
drivers/macintosh/via-pmu-backlight.c:108:35: error: storage size of
'pmu_backlight_data' isn't known
cc1: some warnings being treated as errors
make[5]: *** [scripts/Makefile.build:244:
drivers/macintosh/via-pmu-backlight.o] Error 1


Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>



> Michael, if this is fine by you, ack to merge via the drm subsystem
> along with the regressing commit?
>
> BR,
> Jani.
>
> > ---
> >  arch/powerpc/include/asm/backlight.h | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/powerpc/include/asm/backlight.h b/arch/powerpc/include/asm/backlight.h
> > index 1b5eab62ed04..275d5bb9aa04 100644
> > --- a/arch/powerpc/include/asm/backlight.h
> > +++ b/arch/powerpc/include/asm/backlight.h
> > @@ -10,6 +10,7 @@
> >  #define __ASM_POWERPC_BACKLIGHT_H
> >  #ifdef __KERNEL__
> >
> > +#include <linux/backlight.h>
> >  #include <linux/fb.h>
> >  #include <linux/mutex.h>
>
> --
> Jani Nikula, Intel

--
Linaro LKFT
https://lkft.linaro.org
