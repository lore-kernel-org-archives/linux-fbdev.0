Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F02191
	for <linux-fbdev@vger.kernel.org>; Mon, 18 Aug 2025 09:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755508534; cv=none; b=gVHOAjrPkfOaFLvIn8Ojwf0BW/wDd/uJmo4aGGjIDVlzGCckrZqAK7T9pK19YKOxgFbODFbVB7rPBRxbeVYAmpy5akvCsc+3swfkIn+Rwdx7MaJdprKAlU/XBcuV8bBNSUTRdqdhAGKl86dHhK5VcYgskjUweatYbuoldBcw0jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755508534; c=relaxed/simple;
	bh=Pk6MPUvzo+wcFgJnv7cQuSp/8wQRoxoagPFiRotgY0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uj3ugy2TNxbqYjXrwCJybPtx4kF19hG+U98QuwFAMlH6vRu54fQtNPG8Vdv8WMiIZ+SAmaYegnnrzyl23XRA4gDWb+WzcE5pX/VSDAEDi+jWm/6RiHfLLO5nCdy7ill1S7//zk9Lw367epqexyXb77IkdanEg8iYVLpY2qaCheU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=MCg2b38v; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="MCg2b38v"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3b9a342e8ffso2787511f8f.0
        for <linux-fbdev@vger.kernel.org>; Mon, 18 Aug 2025 02:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1755508531; x=1756113331; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Pk6MPUvzo+wcFgJnv7cQuSp/8wQRoxoagPFiRotgY0k=;
        b=MCg2b38vdIzTsa29f954afgx2G/ZeJA+dmFWYqJut0f2DcqNleBQ2ygnSoGtDLG06r
         K+DnSNNIo/CayqtmHKWycnQ5OCtfqirM8K9KqvPSyyYgU6Yo5gLfvDkRpKOADN2K9ZM4
         TDDmV8txsstzwzBXCjME26YCMPBk/0ppfC8e8/5lSrSsyP4AFmCUHqPtWxjOIfUgYi8+
         UgUM0G1mdKqUGRd2Pfc8egeKdNrhy9yUXV83lyL32PoB50DVyAc1UJAyey7jizaTK0aC
         oOxAqELOhFEPHLJEoslDeDwHTSzCTi3XATFLVVV9+8UyjZ9E21t/Ba+PAvIlijBz7PVT
         U/NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755508531; x=1756113331;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pk6MPUvzo+wcFgJnv7cQuSp/8wQRoxoagPFiRotgY0k=;
        b=DBCIJcRD9n9OUJst/yma4qC81MInlFO7qI5xvoaN/Qe/1tN0eeziisbNZ5IpaCjUL0
         0Q2wwzjDSNJTcOlzBzF+fyDjEBcuq0w+iT3l7vRv7P0qpG1SmzcSQDEVXJULldMOaGXW
         LJnySMuf77wxMNwHwj1tgeagHwK7j8vj6b3ZPfLmKYRbQd5ygbpVsqz5gRbW8PAYH2pf
         aGic3ORaDOTOGTpMJ/4nAcbkIj2WDb1oZFpd9ddFrSQHZ+6U5Q01LysPA9aUCX4fyaR1
         6wOgEGQ3IiGszllpenj03c6Er9FY/x0+dOvf9svAmYuoLPIdprTUyjI7ubKbk/9jPeaW
         WiAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXyKnSTXtGw0SdgKzSUSihYBCD7RMhqtBaomOjVyuND/94M16vorVtuFzSiFV5kK93deod4KTvW7yj0PQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyT9GEe/zHSBVm5b/0sRVVoXCTeEeD5BQxqEdvm9FU+YRwG9Ckq
	kFUX1z75kNZlUPauqRei0r3kmlp8NjN6LtjEJUyhylpV3s1oLXBRz/o7xqF4FuSjzwM=
X-Gm-Gg: ASbGncvZXb54Ggd5McxUl+aeI0fzqVnJuUx52z3Vkh6ScmjeU85OwgJigxwsGBIXXxU
	GbIj1woVmy7XAuT1lBKU2DjV/WUHQU6Zx6zfqA3KtmL0e1K0BbwacUTBER+N5LxBxaiBubPS4WR
	dQxG4e0mT4F2xforktKvl4gHoTL8ZkacMYOZqdHuylu7e++m3/U6VVQZviDYra+2PczYB1FYjNP
	1FrpFCm59j+0uDACWlT55V7vSfbwWwe+DYdi5nRRvA/sNxMOMT1fID9dicBZ71pBRwG9V1K20Rp
	7ols9KRVcWbcfU6EhxTS96gtMb1GLRXeSqs39Dswib6RLBg8QU7Y47zn6jua9eQfsiCI+sciDWb
	3G9l8hhRSKlSjWRkUxiOURdHFumkcvbWgaArwrBxtQBbtrHXvcXnVAsgaZQNxcSIaZdrcTJNaZu
	JISmT2Cg==
X-Google-Smtp-Source: AGHT+IGb+Ck2Rc/beS4ZD2JAeOcF9Yx9/6P72Atsg9LKeyqqmAyuWKj+8gCMCQDmjg/gyjl81iEkpw==
X-Received: by 2002:a05:6000:3113:b0:3b9:53b:ee91 with SMTP id ffacd0b85a97d-3bb4c5b8043mr8984345f8f.17.1755508530770;
        Mon, 18 Aug 2025 02:15:30 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3bc5aba02e2sm9753021f8f.3.2025.08.18.02.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 02:15:30 -0700 (PDT)
Date: Mon, 18 Aug 2025 10:15:28 +0100
From: Daniel Thompson <daniel@riscstar.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: Flavio Suligoi <f.suligoi@asem.it>, Lee Jones <lee@kernel.org>,
	Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-pwm@vger.kernel.org
Subject: Re: [PATCH 1/2] backlight: mp3309c: Drop pwm_apply_args()
Message-ID: <aKLvMLgZJ4fVLjph@aspen.lan>
References: <cover.1751361465.git.u.kleine-koenig@baylibre.com>
 <2d1075f5dd45c7c135e4326e279468de699f9d17.1751361465.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2d1075f5dd45c7c135e4326e279468de699f9d17.1751361465.git.u.kleine-koenig@baylibre.com>

On Tue, Jul 01, 2025 at 11:22:36AM +0200, Uwe Kleine-König wrote:
> pwm_apply_args() sole purpose is to initialize all parameters specified
> in the device tree for consumers that rely on pwm_config() and
> pwm_enable(). The mp3309c backlight driver uses pwm_apply_might_sleep()
> which gets passed the full configuration and so doesn't rely on the
> default being explicitly applied.
>
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>

Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org>

Sorry for the delay. I lost track of the review on this one so Lee didn't
hoover it up!


Daniel.
