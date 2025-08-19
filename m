Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CFDC33EB13
	for <linux-fbdev@vger.kernel.org>; Tue, 19 Aug 2025 13:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755609627; cv=none; b=s/Lw+RZbPuHHCOpVXrEMGrZ+Qq6jyQFIqzeHyX0r2th6WiB3vOxxVi7rNntNMrAd2oCmYFG8Fd0YBLKAo5CCBvNbtcnxDSsv1d1R5KOH5j4fGHl43W3zLz2aHFSHnrDDp63k/ApupHnZ+Q0fsOOBnZ/9QiffWVD8dAybcZIjlPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755609627; c=relaxed/simple;
	bh=iK+PjU319NF3+63SA/e/ZLM4YA51y7lBBdjgoAhh/gc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iIz3C8P3ChnfQwkMjI5bOVVMhJ6Z38WA6exItor2sLWB4b2Ion5QHk1xC/Iu08PUCypTNWdSUkWeJR9BDfTK1iNElFldugp2i4y6TmD9j1qhG1lia9NAHR1H38r1mnScomsEvNdBysXPgGv0pzAaX+C2gpRn+9w0UrbeHl6HUNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=OF47WIY9; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="OF47WIY9"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3bb2fb3a48aso2034461f8f.1
        for <linux-fbdev@vger.kernel.org>; Tue, 19 Aug 2025 06:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1755609623; x=1756214423; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iK+PjU319NF3+63SA/e/ZLM4YA51y7lBBdjgoAhh/gc=;
        b=OF47WIY95Bd3rodEReMTosRNnvV5dmAPo1yOi0C9zAja0OXcgWKoerWwDHT2D/PfXh
         9Smu8yE/8hTyC4edlb4xHAXyfARpr4BV/VW3qq8uELNKVyPOXa+FqSscNkDNDP2rzlL7
         w7sH6CNtSzCI7Fw0YSSPK4jLYGxpWz/GIc3o3+GH12VLGPV+icNuSH5npnr+E7z7A9nL
         0A0k/YW09o0njEAXbqRL8RtKOdR31dkuzuTWByu/VAMu5Jh4j8BA4NCkKHm57ZFL4R4V
         xrQTrN9odW9wINLlkVUR+Edle44pi3W+06edLBqTOUyc26syZLHSXBRcAyBtq7lxjLt5
         jx3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755609623; x=1756214423;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iK+PjU319NF3+63SA/e/ZLM4YA51y7lBBdjgoAhh/gc=;
        b=R3OO+FWC+cQUjV4AFj/QSCZKDd2o/IGtUkEGN9dFQmab04cCBr3XvM82d8RXDeHDr6
         h+uGj1lhDhH7x/g7jDioFh3PgDweY2Z75chbISRA7mt5Pe4RfU6j3eTveXrQ0Dr9LkeM
         GnD19k6Dd4qQU16/ke86nbeLlikzodQ6Vp2ZbZBoP8YqA+q2x80RDUXWfIYEL/RA60Cb
         MJ7tk8J/eePSVF055wsQxJiYD2r7QfyOOY7amLvlsv4HH4O1MD+KU9R5rcFKjbUsGPmB
         JfEKiLdq800yN5JutYWj+9RVVMLEFd/0sIOMKi7QbRBRHDviSrERiBQtZB1R2ACEVX9/
         kYmA==
X-Forwarded-Encrypted: i=1; AJvYcCXYpWQdPUVIDMWsplb7BjKHyaDGuezlDUVKH7/m/360jo7D9OjBFVru42O20pqIZjzRhu16+RyzWnVk1g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwPK57z1HBjAp4zmCN+m5V41+Gp3/+RZiDuom1krgxjTxhsZYmr
	jWOWCP3aiAzf3g5YjkNE7DlNvnoGV7uY+bO1bHWsoLLjfrcmcA5KYcteSBkwm+ZP1M8=
X-Gm-Gg: ASbGncu16yH/dSMQ8EHDd4vsa/kDPzbcMDUFcBkC6ZVtBd8StSzX84TB9Vvpeg/+O3a
	ymuNcp/y9Q8GZlIwvgohSap+j7fplzpdKoR/KHgtImZI9uG77YmMzTiZONsnWSq+yNFhQW+4t7v
	BfVLBAObutq8QrUPmNcSnJclQyM/ybWhi+jOzrR+Nb8OU+TMVshF4FD/5sXWRyNNw42q6svZdeq
	QK7zxcAotKjOGda/tLRBKte2P++8YtqdfsLMfRm2Iye1iAEoju9c37NA1PZPib/wI3DFM9j1r+z
	GvcJNsxSR5P+pyAslrzAhRiABvf+Q1BSsgP1BbV0AKvsVK38uEswxH1jJrwAShFhJgYZ66fH+y2
	lbzTEN09l0YQ3/dmz0zmTToN59BJ1wK7rSaCv/UJWe9oGU5nhoOV+QDQDIZ6A5h4Sv/JHCs7nmR
	JV1ukQTw==
X-Google-Smtp-Source: AGHT+IFAFNd/RoQaRD/TbbBTaHuoGyv0Q+NnN05rjh0d94CuTJBBUxpriDjYGFCYgFp1Qcx/lqW/Hw==
X-Received: by 2002:a05:6000:2204:b0:3c0:4f30:acde with SMTP id ffacd0b85a97d-3c0ed6c4504mr1917448f8f.55.1755609623300;
        Tue, 19 Aug 2025 06:20:23 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c0771c1636sm3673176f8f.43.2025.08.19.06.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 06:20:22 -0700 (PDT)
Date: Tue, 19 Aug 2025 14:20:20 +0100
From: Daniel Thompson <daniel@riscstar.com>
To: Qianfeng Rong <rongqianfeng@vivo.com>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] backlight: led_bl: Use devm_kcalloc() for array space
 allocation
Message-ID: <aKR6FAYDrNDhY6Af@aspen.lan>
References: <20250819035804.433615-1-rongqianfeng@vivo.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819035804.433615-1-rongqianfeng@vivo.com>

On Tue, Aug 19, 2025 at 11:58:03AM +0800, Qianfeng Rong wrote:
> Replace calls of devm_kzalloc() with devm_kcalloc() in led_bl_get_leds()
> and led_bl_parse_levels() for safer memory allocation with built-in
> overflow protection.

>
> Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
> ---

I assume you scanned drivers/video/backlight to look for similar code
patterns in other backlight drivers? If you did it would have been
really helpful to say so in this part of the patch (because in it's
absence I had to do that myself).

However, the code changes are fine:
Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org>


Daniel.
