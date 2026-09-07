Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D85426438
	for <linux-fbdev@vger.kernel.org>; Mon,  7 Sep 2026 11:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788781169; cv=pass; b=cSNrTeDiNkUbLrCmrGeABRcKq/1ClXmwqFTzZrQIofKo41xrpsjSrd7MxDy+jhLaB+/9wrHD7BZgVLyj1Mpd5vNH5T1pPA3BCPubx8wV+EaEwCWnhoVw9wU8MwGVvA9PMPhzOTFnFSoebNTiDjR6ODMgrFgeivX5IW7k2xWL6ys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788781169; c=relaxed/simple;
	bh=SSLE1OamutVwjBeXcbye/sSgz5m8gUlm7JyB9t3AKqQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lw+P9EJ7C+TVA32VByGPo40ZA/eLbY7wZP/C4C+o+VQ83oV5HKOXtK4jTL06dlit3DccM045rM098N1dodLcxvmMP6hv9BrcwH9l1Z1MiQdno1Z3vw0oUWZUITgu3ZmfvaWm2R4APNySVd77B5kNPR7eCRehmVa0XZbg1CV8vhI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pSFRquYQ; arc=pass smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pSFRquYQ"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-871c8a36fe3so32791887b3.1
        for <linux-fbdev@vger.kernel.org>; Mon, 07 Sep 2026 04:39:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788781167; cv=none;
        d=google.com; s=arc-20260327;
        b=hA6qq38tWwFVI9Nh/8NxjfprTRsjmZ5kPVqM2Td9T8NHc2uL+TCgwkeyUWeCCCOoB2
         TRt0bbDJkMTCeMiW/oJ2HrErDF5xRTPYDYph2Gsav/N4CdeXXB3ght6H0IjEGOvp2TFH
         tl4rfnHDWAPIfliw/kGy9PYXW17+tdjuy1Vjqd49K6xjW84UhRJUPs7iSpjSKyTkoRkK
         WeKPbXzGc03Ao2DLHmGAltvFX0s3mokrA0rmvhBGPlljjLJBQA/2eYT5QE3TYmj3tM14
         I8JE1p+FsyCaHOw7G7wBNggXR0CNPivv8F/a+BDM8jL1CggsUXhbp4bbzacVmHAHhhFj
         UVJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=gvn/5UwHYBqPMMFPFmFGu9hDeKbnn2ym8sNSpP3zJ9Y=;
        fh=liSyUFphafFDEunTL4uejJbyEXtARLxDqJq0q6xvubE=;
        b=heNEGJ/we18MkTc1qck8xSw3DZOWCeaWvVFJsKx4LgdvMHZTekWeHQU4Tb3uYNXLgN
         sVacezy3cbj9Y+4CfnCtsYElokjEbVWuzsutAcMBsQ68fzcEosRLhgXr7APsUGh1bT+C
         06BHiuwjy4oUDbcmYDlD8UQ/FUTsxkNzR+TE+yITjHjvxYXKGCgLCFN9R0nqdORai+07
         1lfd1bSj/cdjQDHU6VBy9tGsuOkkaLgpwqu/peCT1EJncrPM2wHbgeL0+w6u+ieBrHy0
         DWVEbmbCDeRTfQX/PXyP2Lb8+E0PucD0aM/w+tswHChQvH9o3UhKVvQyjvjIA1F72uaN
         mtVw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788781167; x=1789385967; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gvn/5UwHYBqPMMFPFmFGu9hDeKbnn2ym8sNSpP3zJ9Y=;
        b=pSFRquYQvOZDio31cXwAA8m1hVgyp0rUZEO7on4AZqgKwDPENkN5rzADmM7T6e0G1f
         viDvHJBcaDD8ybg7S5wAPj5m9VfRP2BAflJ9morZeJs6oEkrFhG/pD+EDLQxeAheVc5n
         7MSeiihikl1vD9ez2J9dnYbHPrQX04CuwDqjQ7qzL6tgBuqA0uPJ2bHyNZS6wPOrmG4U
         13ESO7cI8cc1krt+ftazDcElvTW81vTPjz53vUqZR9q4R++RLXc2jsx9UNuQFXDA48ym
         p/jvV9pVUrI3hdqJElMjJn3nMtK13x+6Qh+UrU9f452mK7Y/DpCwCGyGKOzUP9/sOhIi
         2zrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788781167; x=1789385967;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=gvn/5UwHYBqPMMFPFmFGu9hDeKbnn2ym8sNSpP3zJ9Y=;
        b=ir8NiSrvATQf1WS3gomVgfEVr2WLqrZsg3Qzglr7tKwRkpV3tZEGtX9GLTkVwnu31h
         AGndtVACf6tBip15FTpU4K3Gvq76EskP8DOkpb14mWztyeF+jLjr5JJ0W5odG4igzIEl
         Ohg110E+vwaMOCaONshNkdlGoJkpBiYeFlDS3zDL39LroKaB85PtiDpBNmwG8lEJQwAf
         4yneOR3QpAigNrMVB+PdATwv1JpmmHfzNOHtqPVoZ4JmJlf/K6/IJhtN10ZQCRSgBHHR
         Oa6QT0mP/3NOzzPLNvg+pPt9LwHdh4zIgTxk0DVK5AB2eWqmEvaFw/MVWj5KQwVcHTj6
         yOdQ==
X-Forwarded-Encrypted: i=1; AKwUvBxym1tFRHTghcYcpGp1BRpxUvBokV8D7G0CAw7ukW+p8IPClJh48GMrQ4a7p4AFwnVgB9DtTUs3zreHkQ==@vger.kernel.org
X-Gm-Message-State: AFuF++npwao+NwLbjbNRE80eb05rZVFM5DPsp+dzJ9f3rpJoYlU6FFzH
	QCQVkF98FvxbbiFbixsrLHCtpOfcpittmft70GhP1FPtVstrOMMVylI6+J3Lec0azACenUELC2t
	x8pXIh1jsPI100q3KO35Tm1WUKWxsXg8=
X-Gm-Gg: AYBFou26N4lPCBfP91KqQNjaVVpMXi3QTtDTf9aqyrfbfWPcNiuEIrZ6jJ3nO0HZoUr
	tm4iqK3UB7DLF+Hw/utQVpoPhlWGiUmq7wQjnCmuHgyI+bcbgR8GjeN9gOn+f+nTemGbEPYgLMP
	n/jEPCUm5cq4wqBeqAYPhOkpxc0CdTmrXkkJMU4wMFi8o/NUJggd+U0r1RmM5cWTocD70NHiC6Q
	pMeCYQk0nESxYEEHcO4JRRWbS1tHTviGCLTktyG/qkZbtEV8I/nWXk/RWYXksuIoiWUvQFXnRjP
	rBeY1oiYiQYzZEb2Ku7l8vlju89qVjZMezHE5c0s2fGtHJyuQQ2Y6J5UMTsozGp7Lp/APBG4D4D
	J8hoyl0cyr9Fh99bxE0OELwIjjyi7sGohvEswKsEcU9Vsf6WlVjzFWa4wFhVpmMnEJM66jYwjbO
	eHRG8ATFkyR3u5SPJj354tNAwzVQn0B9dsMRvvHfLEG10=
X-Received: by 2002:a53:d013:0:b0:66f:d272:86b2 with SMTP id
 956f58d0204a3-66fd2728ac5mr1496947d50.43.1788781167393; Mon, 07 Sep 2026
 04:39:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260819222838.21256-1-schmitzmic@gmail.com> <20260819222838.21256-3-schmitzmic@gmail.com>
 <aa508c70-ccd3-4fc0-86fc-e45746e68405@gmx.de>
In-Reply-To: <aa508c70-ccd3-4fc0-86fc-e45746e68405@gmx.de>
From: =?UTF-8?B?TWlybyBLcm9ww6HEjWVr?= <miro.kropacek@gmail.com>
Date: Mon, 7 Sep 2026 21:39:10 +1000
X-Gm-Features: AcwNN1VSWytA-tif6c_qAbMCo0wAQKVoGCOmnNw88oy-w9j4YCde-07QmOf5PAk
Message-ID: <CAN5rfbSkLxZ79LasvCXPsg+HoXzU+xZALZBgxuor4Rc5YjNVhA@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] fbdev: Give atafb proper parent
To: Helge Deller <deller@gmx.de>
Cc: Michael Schmitz <schmitzmic@gmail.com>, linux-m68k@vger.kernel.org, geert@linux-m68k.org, 
	linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Helge, hi Michael,

On Fri, 21 Aug 2026 at 07:52, Helge Deller <deller@gmx.de> wrote:
> I fixed this comment up to become:
> + * int (*detect)(struct fb_info *info)
>
> Other than that I've replaced the latest patch series by this series in
> the fbdev for-next git tree.

I ran the reworked version on a Falcon (CT60, SuperVidel). The console
comes up on the external path at 1920x1080 in 16bpp and 32bpp,
/sys/class/graphics/fb0/device is there and Xorg fbdev starts, so no
regression here.

-- 
http://mikro.atari.org
