Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF262F6565;
	Fri,  6 Mar 2026 14:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772806883; cv=none; b=L7hPGkLyPZHFaXbOjlFu4oQJh9ix0FCem1HIq1j4tIvV3ftss+t1ovLi4fXzMCssltAaWc7pEl2+s27Cm52b8u5cvGr3BuJlZ48da414YABNto+Pi3jUnmVkPvxdl9hWs9GrgsYi4lYU2yXdaPXz9QaobugRp8QFexXU/o8cAa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772806883; c=relaxed/simple;
	bh=AJ4Fp34dJBBgqCFPiW2mSkY8hyI/nJchFMKNTI/zAqE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=mrPyRajvj86FVSnfV8JoQTuaPHUMrBXFSzRntlq648h+8pBFCwaTle1fjbq+YGVL2B0sRkarHYOCUuZZNIpW6sgXeNm1vZ3DEb/yA2q4mn77/uAnWaxEMqvu9Tpya9VOIcv96+f1Xpa/Tx5xGKCOIXsZ7PcUlgHNmaOzhdhRhRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=irBUx9EK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="irBUx9EK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 208F6C2BC87;
	Fri,  6 Mar 2026 14:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772806883;
	bh=AJ4Fp34dJBBgqCFPiW2mSkY8hyI/nJchFMKNTI/zAqE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=irBUx9EKXRsw4wbrsBMW4fyjaFtlgjWLSBq8QCAeG8jMEw19b5zODEiWe3MmHX9TY
	 Owy0BFYgw9fX6W11TiODk4rZDL01rYAIa3x77X+2MCDDEJBKrz6j23ovEN8i+hTago
	 8CUv/MO/YM1MEWk78thWsLDoKWHwX4jSn1JMtt0H4oEzC8fJ2/GvskNbxWlsgGQCSF
	 xmTjkt5Cxcn2x51fn7r+iGUTSVOznVDnG1sOYHQbjCioyEPxN02HLIrhCaQmNdfUb5
	 owwZi2RuVoKyY9pWdHzTKJk4M5PyBjG7a9BhFGdZ7Ujb2+WXX+l3CoZ853b7dUTrEc
	 Zi8fNVZe0ONLw==
From: Lee Jones <lee@kernel.org>
To: daniel@riscstar.com, Chen Ni <nichen@iscas.ac.cn>
Cc: danielt@kernel.org, deller@gmx.de, dri-devel@lists.freedesktop.org, 
 jingoohan1@gmail.com, lee@kernel.org, linusw@kernel.org, 
 linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260203021625.578678-1-nichen@iscas.ac.cn>
References: <20260203021625.578678-1-nichen@iscas.ac.cn>
Subject: Re: (subset) [PATCH v2] backlight: sky81452-backlight: Check
 return value of devm_gpiod_get_optional() in sky81452_bl_parse_dt()
Message-Id: <177280688082.1070847.13297561633275253446.b4-ty@kernel.org>
Date: Fri, 06 Mar 2026 14:21:20 +0000
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-52d38

On Tue, 03 Feb 2026 10:16:25 +0800, Chen Ni wrote:
> The devm_gpiod_get_optional() function may return an ERR_PTR in case of
> genuine GPIO acquisition errors, not just NULL which indicates the
> legitimate absence of an optional GPIO.
> 
> Add an IS_ERR() check after the call in sky81452_bl_parse_dt(). On
> error, return the error code to ensure proper failure handling rather
> than proceeding with invalid pointers.
> 
> [...]

Applied, thanks!

[1/1] backlight: sky81452-backlight: Check return value of devm_gpiod_get_optional() in sky81452_bl_parse_dt()
      commit: 797cc011ae02bda26f93d25a4442d7a1a77d84df

--
Lee Jones [李琼斯]

