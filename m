Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D046443747C;
	Wed, 12 Aug 2026 12:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786536946; cv=none; b=gXDFRZiDwm1DN4MbmIOBZbZQZ7LR/Xlfvw8r9epHl5nF2WB/NpTJmHfN5tdaDXtUZjcMSi6QnkPysrUg1h+qERVVfe12cijjd0EJhQhYWj/XnZBzmDd1B5cAX6eETfqZYIhggthP8mnmiCWrLY7qYLLZnMV61tXI0IzLm4tEINc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786536946; c=relaxed/simple;
	bh=dbIskxIk+vzCqK1sa2KWPuZW/pFVQD04yshjRL8UtwA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=L8856cQXt2hta5Kmolxij78VxrPwD81RY6DwO9HXAeoLkEKtb7iP/6ibVJjHQ84VRl5aJezW+FUuYmHQIhd4h9/CKaVP3BqSmiWL7d6yf1fJtzHMb533TE47wOLQ4GB2HBnbQM0PmUs8GZvuLxItSKUNhRTYmtE4sUVyoPXqKag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M8yTDeHW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M8yTDeHW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71D451F00A3A;
	Wed, 12 Aug 2026 12:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786536945;
	bh=m/lTjthowLY5myN4clGgpfitq6Wa5xz4eSQd6Fu/Ldc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=M8yTDeHWu1YFX0IDtQAcTjaqf2VVVGfSd9iIDMnPgvgB0ZWKZufzqkUdbfbWgKJy8
	 UkLrNT72w/F9PEGYZir5TKN4C4VFL4udfm5ondDRT111hmYYP1scyG0NheKOvP8rMy
	 25RDLAB4yABmnvGQ/HTEOLLp2+gKEHlt/DiJZ31tGpwg0ycRhc9TSnqhzFGU1nCEEu
	 S69bB6uscEykIU4xIW4fxuVAGxnxfVGRhjavGLlSXWRF6rmDZsBy0CXBsiNDgB8Nwp
	 EKRz75ewgtj+KTg0QmPpJeC8JSCdGXQzHHV1i4pqOKnWNhPWWA/Pmx6LirQN21s0dT
	 AJZq0o+9Z/Mnw==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org, danielt@kernel.org, jingoohan1@gmail.com, deller@gmx.de, 
 Julian Braha <julianbraha@gmail.com>
Cc: rdunlap@infradead.org, duje@dujemihanovic.xyz, 
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, arnd@arndb.de
In-Reply-To: <20260719024902.151710-1-julianbraha@gmail.com>
References: <20260719024902.151710-1-julianbraha@gmail.com>
Subject: Re: (subset) [PATCH] backlight: ktd2801: fix unmet dependency on
 GPIOLIB
Message-Id: <178653694321.1389451.7114353733646459636.b4-ty@b4>
Date: Wed, 12 Aug 2026 13:15:43 +0100
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16-dev-ad80c

On Sun, 19 Jul 2026 03:49:02 +0100, Julian Braha wrote:
> LEDS_EXPRESSWIRE depends on GPIOLIB, so its selector, BACKLIGHT_KTD2801
> also needs to ensure GPIOLIB is enabled. Otherwise:
> 
> WARNING: unmet direct dependencies detected for LEDS_EXPRESSWIRE
>   Depends on [n]: NEW_LEDS [=n] && GPIOLIB [=n]
>   Selected by [y]:
>   - BACKLIGHT_KTD2801 [=y] && HAS_IOMEM [=y] && BACKLIGHT_CLASS_DEVICE [=y]
> 
> [...]

Applied, thanks!

[1/1] backlight: ktd2801: fix unmet dependency on GPIOLIB
      commit: 5859fa79c7d85d0c242a9a1ffb40bab9732d4ef1

--
Lee Jones [李琼斯]

