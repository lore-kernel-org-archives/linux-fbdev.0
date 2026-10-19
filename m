Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5120C3F44C5;
	Mon, 19 Oct 2026 07:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792393338; cv=none; b=J539u8/NorgVHpYcdMJCAH2NqBwLvSkYjdfxozmZXzk4mALXZhmtpI3/Zekwfj5DvS03mYmP2huHNaz8+hzwxuOB+q4l1CTgy5fI5KVEuWjMi26nxlIpu/DrTnkEa5zGYrktl/02jZVzQXwp7LDIgnk3f04gpIGo6s2QnvYlh10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792393338; c=relaxed/simple;
	bh=G5zyuZwUszjkflbA9GIpUL/VmlaFvAFNS+ivsNBXpyg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GttLL9XXarZUmrLJQH4O2OZKLO2v2NwAzBAVZmjszwd4e3fU2tyBQ+5p1a/tz/Lyp0VSyeXP0SyrjvGJ6mA2RZ5ePn8x07x7wGuBtUP+kAnOh+G3HwzCI4sLy96E1D9a56hOBW1q4PZga46SYwVojRK3p0NSQ5sFcBxccG5uOPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nci/PhmV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nci/PhmV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73FD41F000C4;
	Mon, 19 Oct 2026 07:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792393337;
	bh=AvFFWNmZRE1kNnhqOhbeBX1SA9rS1msS3gKtfIW3E/4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Nci/PhmVOv10UWF2MX6pCNgm2WmI89Ztm+P40jTp3e5W7jg83i/8RbhoWiyLWab6e
	 NMxpm7/SrdqZma/bKaosd5KZWJ65xq98XIFswAyaaaQVwKHER70wCv8ZFu+WNiiAPw
	 VJjYmkVQ2yOVQz0oWHMv2RoSY9em3SMkJUPk6ETDUJIXxqDCrlhhOLQNids98wNo0X
	 JyiqLAz69PxEu8MF+xYtLcdevIpXrS5gvCNyAlMYtVteTiu5rgSTMygUqvQ4kfUB/0
	 EHEOIfCbN4PO2M0Ogsq3Hrt5QmxEI+fPS5f6Lg8NCgkyJsxQv0Hkmq3iFhiiJpbifG
	 pK4RQ/V+BceuA==
Date: Mon, 19 Oct 2026 09:02:14 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Luka Panio <lukapanio@gmail.com>
Cc: lee@kernel.org, danielt@kernel.org, jingoohan1@gmail.com, 
	pavel@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	deller@gmx.de, dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: leds: backlight: Add Awinic AW99703
 backlight
Message-ID: <20261019-yak-of-subtle-protection-8ed0da@quoll>
References: <20261016162912.64581-1-lukapanio@gmail.com>
 <20261016162912.64581-2-lukapanio@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261016162912.64581-2-lukapanio@gmail.com>

On Fri, Oct 16, 2026 at 06:29:11PM +0200, Luka Panio wrote:
> +  awinic,iled-max-microamp:
> +    description:
> +      Full-scale current of each LED string, reached at the maximum
> +      brightness code (and 100% PWM duty cycle if PWM dimming is used).
> +    minimum: 4800
> +    maximum: 29600
> +    multipleOf: 800
> +    default: 20000
> +
> +  awinic,ramp-on-time-us:
> +    description: Current sink ramp-up time when leaving standby.
> +    enum: [512, 1000, 2000, 4000, 8000, 16000, 32000, 64000, 128000,
> +           256000, 512000, 1024000, 2048000, 4096000, 8192000, 16384000]
> +    default: 8000
> +
> +  awinic,ramp-off-time-us:
> +    description: Current sink ramp-down time when entering standby.
> +    enum: [512, 1000, 2000, 4000, 8000, 16000, 32000, 64000, 128000,
> +           256000, 512000, 1024000, 2048000, 4096000, 8192000, 16384000]
> +    default: 8000
> +
> +  awinic,pwm-trans-time-ms:
> +    description:
> +      Transition time between brightness levels set by the PWM input,
> +      for a change over the full duty cycle range.
> +    enum: [2, 4, 8, 16, 32, 64, 128, 256]
> +    default: 2

Feels like you are re-implementing triggers. Several properties actually
feel duplicating standard LED ones.

> +
> +  awinic,i2c-trans-time-ms:
> +    description:
> +      Fixed transition time between brightness levels set over I2C,
> +      independent of the size of the change. When absent the brightness
> +      ramps with a fixed slope of 1 us per brightness code instead.
> +    enum: [128, 192, 256, 320, 384, 448, 512, 576, 640, 768, 1024, 1280,
> +           1536, 2560, 4096]

Best regards,
Krzysztof

