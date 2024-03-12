Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4527D406
	for <linux-fbdev@vger.kernel.org>; Tue, 12 Mar 2024 16:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710259700; cv=none; b=I+f3D/EdmOwE5RTlvwc4nV35IlxQNgPCayAiEWe5Mt7uy1+luo6x/NSP6Qzsw+T6Rc6GCA9A/Yb+TNwRwzpqppxTHTvwKXGyc4ymuFpxL2hDHcble3SvI8ojKF5NjThXDy0xCGfQa+YI/rBotBw5e4ES8xHAfqSwLqyUmSpHOPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710259700; c=relaxed/simple;
	bh=Az4ylA0pPHPMXNAXpe4V+gZrQIfIie5XU9giy6iYiPU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mdgmn+3b5n+pNc4bu0rIIug/dbteo/J8EePnP8JA/ECYIOeia8eLxRk4BiqrIMuaBTcX1pYteG2So0DpjXVrbkyacBBKXOA8kakAueMdDq0w4/CMu9hPpg9F8pkqW3ziW+KyAToo7c4BtmCs97mpK8kKBXA4Q5gB7e3lvABSp0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NY9ArJxr; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NY9ArJxr"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d3b93e992aso53436041fa.1
        for <linux-fbdev@vger.kernel.org>; Tue, 12 Mar 2024 09:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710259697; x=1710864497; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0X3bh6regalLfza/VqXtw3dY8qNGGSgfK0NBO0mq7Yo=;
        b=NY9ArJxrAg2qpZCMQBggtN6TTqSlxCGxUxdZkPz1Yf7xS01SHbxHbqgfRWFTtmbjOX
         uD1EnTSa+SsYdlknnc9N02t7NhAvXV9s05UfB6Shp/GKNpHkw14cV0sMNvdp7q3RmcCz
         VDwEaGwTD3lhM7Ug49LZR9NmAzXAt1sJLBNluDj+b373h2phPv05ch0mHoo1jSLiUQqN
         Ea3SQ0rGGHL/fUQ1YkwdcrkgoeUSjQhJKb5uX4Z99uxfW0fULGlsPp6hCrKeLWQhgb4H
         kzVx7IUa7U4L1dq7nEwgBNiWoGzndDXuwNrZh9DVaZ5VxaYtfuaRIYe3K5HDPt4eX4jf
         pjcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710259697; x=1710864497;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0X3bh6regalLfza/VqXtw3dY8qNGGSgfK0NBO0mq7Yo=;
        b=uIveKMxLgarh/0KBaYiZJ4fK/KlomTW8r2O8RQHFBUtiF+y3DD3ZpjLUrlyG2L75vU
         13Bro2Z7ukk1bBTv9uGEUJrgHZec2W+S5sO/MCdkEtHzyOOkO2MSnzs+zEt7Dh9aLcWz
         NbBhrF7J0NilPrIgedFgXJpiVvePUtTa8hX+/v0M3xdjHAVBz3llpov1WA++QnoP7+Sh
         pMDUV4Z2LPt2sD98ysbwgsdidaobD5BUEjh7Ip52FnZsY9+P1/wTpRfIE+grMe21pMA6
         cY+XwBTyDVWqDuczfg/vs+By+Xs5MzBFtUpacPxnoKZkaNvhytsakoiUmphVQuFKo3h9
         GxEg==
X-Forwarded-Encrypted: i=1; AJvYcCUUjc+28O5CJ57J5Ku6fLDy7PmJ8m8JBUSf7av2lFnnXcVBVDZ6J+YnW5+BThlQ1vnk425Y+L1plsEvtiXaJURi6x7PMGz2vrig43A=
X-Gm-Message-State: AOJu0Yxz8HBj7kNSE1jZchVReodwRBzva373PyBKDmrCRQptio3qQNSp
	btZq0B3k9Y4VNRymZtbg6YwSq6BjeePKBAFu8ekILXC6vifz+odapxTgoMb1YnwvY6j/tqwZ//4
	sfh+aLhi3/b5KO3ReXhMiPD+Ozzc=
X-Google-Smtp-Source: AGHT+IGYIvZqarMg5Vm2nKOnutiSU8XvApjVKUHqujlgz1UN8eZq3ic9oExfiZabCfDqH/yPYDlMcbT3eWthw0T2HO8=
X-Received: by 2002:a05:651c:2207:b0:2d4:4777:e2d8 with SMTP id
 y7-20020a05651c220700b002d44777e2d8mr3555811ljq.13.1710259697156; Tue, 12 Mar
 2024 09:08:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240312154834.26178-1-tzimmermann@suse.de> <20240312154834.26178-12-tzimmermann@suse.de>
In-Reply-To: <20240312154834.26178-12-tzimmermann@suse.de>
From: Deepak Rawat <drawat.floss@gmail.com>
Date: Tue, 12 Mar 2024 09:08:06 -0700
Message-ID: <CAHFnvW2-QYRCXdYe47txBvpj4N=NNLsPqS0pkRAiJBJMsE+Ksg@mail.gmail.com>
Subject: Re: [PATCH 11/43] drm/hyperv: Use fbdev-shmem
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: daniel@ffwll.ch, airlied@gmail.com, deller@gmx.de, javierm@redhat.com, 
	linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Deepak Rawat <drawat.floss@gmail.com>

On Tue, Mar 12, 2024 at 8:48=E2=80=AFAM Thomas Zimmermann <tzimmermann@suse=
.de> wrote:
>
> Implement fbdev emulation with fbdev-shmem. Avoids the overhead of
> fbdev-generic's additional shadow buffering. No functional changes.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Deepak Rawat <drawat.floss@gmail.com>
> ---
>  drivers/gpu/drm/hyperv/hyperv_drm_drv.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_drv.c b/drivers/gpu/drm/hy=
perv/hyperv_drm_drv.c
> index cff85086f2d66..ff93e08d5036d 100644
> --- a/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
> +++ b/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
> @@ -11,7 +11,7 @@
>  #include <drm/drm_aperture.h>
>  #include <drm/drm_atomic_helper.h>
>  #include <drm/drm_drv.h>
> -#include <drm/drm_fbdev_generic.h>
> +#include <drm/drm_fbdev_shmem.h>
>  #include <drm/drm_gem_shmem_helper.h>
>  #include <drm/drm_simple_kms_helper.h>
>
> @@ -149,7 +149,7 @@ static int hyperv_vmbus_probe(struct hv_device *hdev,
>                 goto err_free_mmio;
>         }
>
> -       drm_fbdev_generic_setup(dev, 0);
> +       drm_fbdev_shmem_setup(dev, 0);
>
>         return 0;
>
> --
> 2.44.0
>
