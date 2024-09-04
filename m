Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C1613A25F
	for <linux-fbdev@vger.kernel.org>; Wed,  4 Sep 2024 06:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725431823; cv=none; b=jLW6nIMz3LYJ/z/dke24u6JdYJfbE0kaeCRwDBNET2DUJoE+7swVSwXfI3dXwoGmabbtoX/DIou1JA2tLNtKHQ+7wI6Ofh4hQTZIXydgO2S8ec/3OFPUJ5Cd4n/ZA9V6lAeO/Tig/gR6JkadN6dp1zVv9dWOKO+D7HsPqZRK4SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725431823; c=relaxed/simple;
	bh=kNcSFIRz+4mhxZ0CnvW3qrplOy6c7xq4SvdJx8O1BQY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m1P/KWu6OK555HElvXVf+IkGvYufwvDr0iU54E9xC3ouY70XUQLu9ix17bza/aP/qfNgbDU9yWtJQfYXJ+/wet5FeW26qdhwF1aZh7LKkToq/f1Qm04IaF7JbaTu86AtL0csFcgsEG1Fq71GfftcGtsJd6YDYNoY+r0Ibw+4kEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rwguafT3; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rwguafT3"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-533488ffaddso7560118e87.1
        for <linux-fbdev@vger.kernel.org>; Tue, 03 Sep 2024 23:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725431819; x=1726036619; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=363mU4m3lLPvF7ATuhqmz9NXB63S6HLlYBsvwTXiiwc=;
        b=rwguafT3CSkatW5VV8a+JEppBZWwtoo+xKp2W5RwIdkPUlzRf5/Z3+S8KHVklbo+Bg
         zaoqEJeMpg0OpbC0bqgjzEd8mHeQb4ehpk4vETG5G7zGW0QRbeho7mV8m7fk/xZKW06j
         xCDhmX8k9KC/oSeHBGxcoEp3UsS+KBKm0DDghj0jfs/xwC5ZR/aUpqbtVfQ5eBqPX5Z+
         lHGWN9wSsUsZHDAvk2bq5rwbQgMuXQlhvqzonzjMK+BgU3kOXqaXorjtF64XpV7NEMiK
         WcyaCAiyuZ9lqi5SIo+2rH/fT+kSwiKHI/KnPs+aGHrNz54Nwbc37VDVOP7pdwa7KEhL
         mPYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725431819; x=1726036619;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=363mU4m3lLPvF7ATuhqmz9NXB63S6HLlYBsvwTXiiwc=;
        b=SAo7ooKe41+UYrVVyt5o2d2WiPQ3nr0kBYVcRtzioDUyRpUwZBeDVGC9ObmJKFFxkD
         dQ3sjKf2jXV1D9rb/02ctMp0FKmBgKgCNFwUSsLbGyJvPG2ILyXDOeCaZr8/G/hsPsCQ
         kORf32YwAAeeaWaj8j3LG0FGvUunMzWDosPhLJLs7Zg2lyJARvmaSG2OcFq8oR5uyfaS
         KbVtWr3PvV5s3JuYM6Y30kivClZznGOjdeiXOPpxtS9KpURl9d1RA/DNmXTbZNIiGphk
         bwVPxftrxuTyZyo4ec5VuJnlhtWkIgAT8nC4ei+LpGelDbZ+JHMxkLmJQUmx6OQqNoEV
         icRw==
X-Forwarded-Encrypted: i=1; AJvYcCVMHExCAx4JMrMirPHlUKjnI2jI3VhU+4PdKskm3ZpvuD2LTwc8jM7o1WaIhvFujHu2HuXYHVqeCXx6cQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzsii27+1jzWdySM8gYCkBNzArRlBkEPRj/0dq+MerR/xikzogi
	dSN3av3LzkjAl3bh2MSA4mp7hYwp2OAa6otQhl5yTBZ5M3u4/w/bYSHZmYv80YSLzz3JzvmmBFL
	7eVOdTlZ0stZCFNtir7c5YHd+9V2kzSut0hBlig==
X-Google-Smtp-Source: AGHT+IFANbFFIb2AE+3bD/mCPJSNcgwATi9WIJUaz/OV5LiTCV5RiZYF1CJAENDM7jd3rljQYOcJ7sOu//gFSmUsuSA=
X-Received: by 2002:a05:6512:6d2:b0:52f:cffd:39f9 with SMTP id
 2adb3069b0e04-53546b2c596mr11407999e87.24.1725431818339; Tue, 03 Sep 2024
 23:36:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240419083331.7761-1-tzimmermann@suse.de> <20240419083331.7761-22-tzimmermann@suse.de>
 <CACRpkdb+hb9AGavbWpY-=uQQ0apY9en_tWJioPKf_fAbXMP4Hg@mail.gmail.com> <12510239.O9o76ZdvQC@steina-w>
In-Reply-To: <12510239.O9o76ZdvQC@steina-w>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 4 Sep 2024 08:36:46 +0200
Message-ID: <CACRpkdbJEv7pV_LOZO_2s_otSth9EYM7=fH9VPgxUyPom_BZ4Q@mail.gmail.com>
Subject: Re: [PATCH v3 21/43] drm/fbdev-dma: Implement damage handling and
 deferred I/O
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org, 
	javierm@redhat.com, deller@gmx.de, airlied@gmail.com, daniel@ffwll.ch, 
	linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 8:09=E2=80=AFAM Alexander Stein
<alexander.stein@ew.tq-group.com> wrote:

> Can you please check in which memory zone this VRAM is located. In my cas=
e
> it's important CMA is located in Normal zone to trigger this problem.

dmesg says this:

Reserved memory: created DMA memory pool at 0x18000000, size 8 MiB
OF: reserved mem: initialized node vram@18000000, compatible id shared-dma-=
pool
OF: reserved mem: 0x18000000..0x187fffff (8192 KiB) nomap non-reusable
vram@18000000
cma: Reserved 16 MiB at 0xef000000 on node -1
Zone ranges:
  Normal   [mem 0x0000000080000000-0x00000000efffffff]
Movable zone start for each node
Early memory node ranges
  node   0: [mem 0x0000000080000000-0x00000000efffffff]
Initmem setup node 0 [mem 0x0000000080000000-0x00000000efffffff]
percpu: Embedded 15 pages/cpu s39052 r0 d22388 u61440

So at the top of the normal zone at 0xef000000 as I read it.

Yours,
Linus Walleij
