Received: from mail-qt1-f195.google.com (mail-qt1-f195.google.com [209.85.160.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3E53E7BC7
	for <linux-fbdev@vger.kernel.org>; Mon,  8 Jun 2026 20:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.195
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780949662; cv=pass; b=BbPGOtiSvYDNV/Qut8tkYxhIoNOCsY/XU0fq5x1tBywDirUim792IOC4EtInaqfD79r4tBqAObrrgBu4cqfBSllxTV+O0mRSY9uzVUAMRCNCaNxpNyhZIcd3ZPwe10vsZBpCaBTYtw7nlmGjF2HS+qM2M4i147Joj6X4NKfRHKE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780949662; c=relaxed/simple;
	bh=/dA7nHtKDKNJB1xvn6tpMv3RRTNJP3ds6phR1G5KtzM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=peoXVdxFXi4EDIEAZ2MvBRqCiWyhM527UuEW82DnrZBa1wIfBgbVrHe1qSV1/OEWyqS0D31cz22MGIjBma4dsTqkdtm8QuLwgStvybF9RHdnqSjamRuZ/xiPyrCLOERoxZXQ6pYE6cXl+VG4/JQO0ObmzodUWKBQ02Q5lknXGGo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YQI2VJ3K; arc=pass smtp.client-ip=209.85.160.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YQI2VJ3K"
Received: by mail-qt1-f195.google.com with SMTP id d75a77b69052e-5175eab3a93so37428901cf.2
        for <linux-fbdev@vger.kernel.org>; Mon, 08 Jun 2026 13:14:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780949660; cv=none;
        d=google.com; s=arc-20240605;
        b=QkgWshH4LT7c474If0XpZZzMv66sP857CyJ35osczaFkU5vjgYNQPq9/Mc/ls7tt8Y
         qm07u3TBYGfB9pvHymkSgl5BQSD8TRkh3OZCgmkZKcpK/V56j6BL481AQKel5N4Pd03M
         naQKBmBj7XnQeuM9DeBCU+QChHuB9UHE0p1qX8n8I9isO+RoCXt03hKjerUxoDI0peqP
         nFH6bzS8uJ+QY7jcQ5m3pOQIK6fSSz8nciqpZAdI4xn8iw+DXlPVWVWMv0TbspaC7wiW
         QfRp77XIzRzoTkGK1efvOVYxYKKdy9aZ+sWA2/sVqJAlNSVgXds6v2JF2uIIhGC3gI3i
         itBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/dA7nHtKDKNJB1xvn6tpMv3RRTNJP3ds6phR1G5KtzM=;
        fh=FRYhts7jpeY8O49qB2i51PmymMQ1lUsGjjZysve1FjI=;
        b=L5hffAEh3RJKaqQB28he/LD3GA+JAYs/ZmaT8DnHDk/NGM9/itrzNy/Jgz+8BPtODb
         GwuB/LCx8SzIgNhx6RCSaYWHes1Bc8gmVqDgxiyk/QrPOrxDIMEpcZR2fGxAbU6SA1tr
         vtFljt9WawRxuzsUZM0G3p9ukoXga6Y7pXWwRdWv1UoBZvKodXWAF2iWiJDtS219uX7J
         ZlP0BIpBQ2N6GUi7GIMeu1c4bvogR/g5X/HL3G6Pk7ihIJgmEH7pEuCJ2mQKs0oJ8iva
         fHq88h3cXVbcQHWXHlBQHBy3fMtXtIYSF/NEhWxQ1ga9QbB6cb/6pQdAzuFHY/pi7w0h
         dQ8g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780949660; x=1781554460; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/dA7nHtKDKNJB1xvn6tpMv3RRTNJP3ds6phR1G5KtzM=;
        b=YQI2VJ3KHGPaSP7IFcwlGMPFx8LhR4Cl8n1aJkFn/6kASe+TzaImd33oZ+jkIJIxzy
         8Nm+v4dxVXMNQQj8GOeqDpa74mS1WXKbKyMKrKfIVS3AwJ4vCvgOoW4p6/5OHtL193NG
         dxwSBFaHPPm31MUJ1tjEwDQxfl6K5My2KLzpCz9r4RfUo+y5CSv6sZOcjHr9tJ96hbZh
         JeE78KfYFKaNcKTfOQHqTf+vwMdTiCBy9Ww1K4sBUaFIcGhKyQtrlcnQfiT0YQy1HIH6
         J84EPcohWazlUj40Y9h1UhLeCgvZqRRFwgV2WOEGJDAibhiWrIxs9TIMK914ySfdbtum
         CzFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780949660; x=1781554460;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/dA7nHtKDKNJB1xvn6tpMv3RRTNJP3ds6phR1G5KtzM=;
        b=gu85hl2tu4gpOeRe+bT83m5zSYLhGbkm+eDTQcBCSrDjZXPAFAT9AkzXuZvijaPCXv
         cacq/WWOIlO+Txi2wp7LXFq6fAEHMJgvfIcJoDyvN9HsA6FuIKOzdzil9ZOFa4x0mIkN
         fQQNRuiDoyQXRgPOVSFc2qeiCLmwcWww92qeqtWEq/iO2hLo/1i1MvmOMx+6Vmu+X0eX
         NqIjbm+TFAL4mFKDua/UfwuwkVDtQ7Cii4y3OmUso5a1KH11OyaUY9pDPtzWLO3QusHe
         jWjjClz/ZOZBHysFl6EDbXQhmhEzHy3tk/k3/lfe5ztAiYwmYGN3LV2iku6GparMpm1t
         ciZg==
X-Forwarded-Encrypted: i=1; AFNElJ8B47xLcD/YposN51Y56TlujBLIScN4TgZfspcAWW+cKBUa0Gby+JcoZb3FQmjG6Lqt7ASCfJZNwgHyrA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwNEjnyxrDHoIW2hFI8Yp01bjEd2TU6GZ9eWaI0YW8mEN1aj+ZU
	KZtcc8zWe8ZgnXPzBpSg8spSnQu8nE4utUa+U1+U8NAFAjLxkiQr6TA9MchjRX2Jxt7mkb9TLyJ
	GXRmHgWrsjP2BKWtGzzn0kLHknG78Poc=
X-Gm-Gg: Acq92OEwwWjX0Hi42ROkObz9mWB+s13GRTmfkX1LNVjYCgE9/nS/0IgcwlgX5nKBEHi
	yFB7cp3DmkG0GAPmdsE+ZptKU5vIFqDhowCrl286cLExF+QrrZJBSe4pOgMO7a8vvLUkuOlYwLi
	Hu5h/1Jl5fLbReVlVxjJIDdc4gqodnUF8F8JZm9S/fKVkVxnx5aVm1KqV2B6aWHQBoZPPL6ZrDD
	xhTfaeRRVUmejqXO4mwNhSsUBLtdRrtSyuBnMCKVE1OM5a+5LvCpPNALvQBkpgTZi1dcZTyw6Im
	RA1KyuaUAgSI+f9EmweDVuGEY4qoLVoEUyvIiiWS1OIHqhFNmc/yFEbsOdIrcrL1hzafHs6Iqck
	lpdUM8O+JSKrTJLD0muQQAQMpRZa+frgtmAwBbQAk3aWD5len
X-Received: by 2002:a05:622a:4c0a:b0:516:e0bc:f485 with SMTP id
 d75a77b69052e-51795bccd78mr250053541cf.30.1780949659407; Mon, 08 Jun 2026
 13:14:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260607210203.229613-1-deller@gmx.de> <b80a379d-87e4-45c4-a078-09e84a840895@suse.de>
 <1492766a-c349-4cca-932e-bf608b922b6b@gmx.de>
In-Reply-To: <1492766a-c349-4cca-932e-bf608b922b6b@gmx.de>
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Date: Mon, 8 Jun 2026 13:14:08 -0700
X-Gm-Features: AVVi8CfEV3v0auRJTkRcEi93MvfSHRgJyvHshN0YpjCioQG4b_F1xB7AGV74yp8
Message-ID: <CADkSEUg948W-XT3_ODe_6p4i5Y8AKEcP=rmJ+7qJq30Uq0d_EQ@mail.gmail.com>
Subject: Re: [PATCH] lib/fonts: Avoid unncessary 64-bit math in font code
To: Helge Deller <deller@gmx.de>
Cc: Thomas Zimmermann <tzimmermann@suse.de>, linux-fbdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Helge and Thomas,

On Mon, Jun 8, 2026 at 12:58=E2=80=AFPM Helge Deller <deller@gmx.de> wrote:
>
> On 6/8/26 13:25, Thomas Zimmermann wrote:
> > Why is there a 64-bit division at all?
>
> Not sure. Might be platform specific.
> Maybe, because you add two integers and divide by an integer, that the
> compiler then chooses to use 64-bit integer division by 32-bit integer.

Actually, I think the real issue is that
arch/arm/boot/compressed/Makefile defines "static" to nothing when
compiling its copy of lib/fonts/font_acorn_8x8.c (via font.c), so that
the font array is available outside of the object file. I assume that
this causes various unused static inline functions in the headers it
includes (such as <linux/math.h>) to be included in the object file
because they become normal inline functions.

Ethan
