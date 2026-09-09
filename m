Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16D537C11F
	for <linux-fbdev@vger.kernel.org>; Wed,  9 Sep 2026 17:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788974824; cv=none; b=i7Mcuj5Dmf7KCOu7iDQDcwn/1MvfZ9WMuu8+am/p4BlJPnYYk0NNibQHdtoYB1qUctEldS3IfuICAns4cUETlbNMcOI5xbHCk4koQgIMCYRcAl9YN362Q6OqwhngJOKlwjei8KfmrtGaWh0WtPz2937wzuaIFYouoWtb7CviHP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788974824; c=relaxed/simple;
	bh=SUxP5gT1ZaOy4mmgP6chw0Cr8VRY83cgnbGtN/GeIrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LMyQ3CaPJmCZNkOB2qodaMH+vD9YsJzx47q46GV+Act0QWR/udvWtzcwtzttFmqLJaitqd6Udk1gc3D1z8L69bwqaF13y0G2rEwtk+L16cHSxMQSMHCIyfydh21Zs9s/zE2wBjpWS4gGJ1trMkRWsnY+07qvSyC1DZDNezfrQsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jI6Ly9NO; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jI6Ly9NO"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-86959a6f7f6so411009b3a.2
        for <linux-fbdev@vger.kernel.org>; Wed, 09 Sep 2026 10:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788974821; x=1789579621; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BxkJmMQiuFGLIVhYvP7iekSRoJyyqxrT2LFSLJP0a4Q=;
        b=jI6Ly9NOhS1CJVDcDoKjwgjST/iQVlVpolh/hifxBJGV2nz6t+8GlFWLZ4bzANtEHt
         /Gubm7aHSBwsXnEHDwS28/J38FGObVki5RAT4+MKtWxDxCzdeulLhOlDre6S80gl/1TC
         7EygHVvY8rB9EzbY4vuEGBvLIXgnThM7ofFVrmOOyUnxK3+Cw8/lUB1Qrw2zcQyD28sq
         aOwfF4Jak4nLrwlBRcrBmxMV3zq77fRSSDlQwIxXNAn/g3MvLudGjEbIzxRGELLjSs75
         zSMaaTiP34sWBjEuq0+gSjLhjHao2DyO1AI08J/NXT1fTMGf7TSzj1Dp3m+TJmQDgi3k
         TF6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788974821; x=1789579621;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BxkJmMQiuFGLIVhYvP7iekSRoJyyqxrT2LFSLJP0a4Q=;
        b=e3V2ujzGe8V4+YIjz258kSSxNtEfEHENljoKrCrDg42IxJW2tuVbhSva4D8tTSE9Xo
         kWx6oAYhWwfdITpPJQAOHgX67yFC7A4X+/EPu9zZQ9AjwMIfssUSfM+e3cBbJbI1SJk7
         CMpaC1uEZ2uSCc870RArDWcTsAxB1VGKbJbBk/pzf/kYP85tEplhJQpk5lFgm0lqTyaP
         KHm1paW6FxEreikrZrq44ki7AjAZdiqf2lXQqrSRzRHzmd0sNc9JpRIZbUv9Ep3/Xstl
         Lnbi/NVBZ8BTpdaU1aaOAOSNRWMeqviprJhfPDocmFXOPLACRFCTlIm8mChbIcEo/Wg7
         T+jw==
X-Forwarded-Encrypted: i=1; AKwUvBzVEVHydboPCH2L+w8BT5VhReMC4Ao33wXkmkzzM1+miRhDTpG/MOtgupYC8QdR+P2BIPBTYdV36Lte3A==@vger.kernel.org
X-Gm-Message-State: AFuF++n3gLh3434zYiv7RkbQ5tqoQveDTr6/+l0PVGZ5QsN/I1sjJuog
	1MYWoUrbJxDBFEUCoLR27JRozIGBB6NQRmwqblTTRRjVxxYUBCqprMVE
X-Gm-Gg: AYBFou2wjgFjvhp/lhrjPITJ8KHO7vUhJ7Uvt6Tu3YuWqAu6vPK6nMGU5RooyUowP9E
	bcDMFd0ICA+NR8ESC4vB6fWCY6k48ekelFqGUz0sbnxSuATaqvOyYYN9xodZvbsZg4Yf0xMo207
	0OQzXJMesSiwtwdJa1gX/yBanYMF2J1IDAoKbVbKPHeRl8aZLWwdZDbh41v+QdXtCOfksmn/b/h
	B7a34ac47NxEzn/hV5u9vmGcSvdjZc+LKKQ/Bi3j7OMYlEtymHNPUu2EPObOVSzIsKEc56c342w
	gqagjso8fT53X0i3+isyh0zfgCFTHtJvOO1gQBTq+yKsxVXhGpwoX8pE0M3+XW36hB+rz4K9Wvs
	WrI54t/+7BKAZajox3ukeOWU76pphW6isbnJvWtN3AyYbVNDWnS5j1g7VvrzOc46ACKrV8G7v54
	weRLFS3NCoQfZECQ9cE3vW+ghRXwKdl7p247QxxMV/3PQaWaid3rAlrRL1Hml+wWOSMDPzhqF/w
	F+y8Gat30HNrxOllZSycx3ATD3QTMLxxlzXPN3Pha6tlFcnPmul
X-Received: by 2002:a05:6a21:9d84:b0:3d3:af85:eb98 with SMTP id adf61e73a8af0-3da3a16a579mr57975715637.26.1788974820346;
        Wed, 09 Sep 2026 10:27:00 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:2d43:5153:5c50:643e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339a534df1sm52422943eec.7.2026.09.09.10.26.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 10:26:59 -0700 (PDT)
Date: Wed, 9 Sep 2026 10:26:55 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Lee Jones <lee@kernel.org>, mfd@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Arnd Bergmann <arnd@arndb.de>, Daniel Thompson <danielt@kernel.org>, 
	Jingoo Han <jingoohan1@gmail.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Guenter Roeck <linux@roeck-us.net>, Linus Walleij <linusw@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
	Pavel Machek <pavel@kernel.org>, Michael Hennerich <michael.hennerich@analog.com>, 
	Support Opensource <support.opensource@diasemi.com>, Sebastian Reichel <sre@kernel.org>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org, 
	linux-doc@vger.kernel.org, linux-media@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-hwmon@vger.kernel.org, patches@opensource.cirrus.com, linux-watchdog@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-iio@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-leds@vger.kernel.org, linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org, 
	linux-fbdev@vger.kernel.org, linux-sound@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	llvm@lists.linux.dev
Subject: Re: [PATCH 00/14] mfd: unused driver purge
Message-ID: <aqGWjAuGXq_JHvxk@google.com>
References: <20260909132153.1596191-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909132153.1596191-1-arnd@kernel.org>

On Wed, Sep 09, 2026 at 03:21:37PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> As part of my cleanup of old platforms, I had a look at all drivers that
> may have become unused because the last platform_data or DT definition
> was removed, or because of unmet Kconfig dependencies.
> 
> These are all the mfd drivers I found. The first ten in the list
> actually turned out to have been unusable long before my series, and
> I have added explanations on how I determined this in each patch. The
> last four patches are still in use in linux-7.3 but become unused after
> my series [1] that I hope to get merged for 7.4.
> 
> Somewhat unorthodox, I took a shortcut here and remove both the mfd drivers
> and the corresponding subsystem drivers (gpio, hwmon, iio, input, led,
> media, power, regulator, rtc, video, watchdog, asoc) in a combined patch,
> to simplify the interdependencies: removing just the mfd driver would
> leave unselectable or broken drivers in other subsystems.  I also have
> additional patches for each of the other subsystems, currently a total
> of 300 patches, many of which still need better testing or proper
> changelog texts.
> 
> Please let me know if you all think this approach is ok, or if I should
> explode this further and turn these 14 patches into 70 individual ones
> by splitting them per subsystem.

Sounds good to me, especially if Lee makes an immutable branch from this
pull so we can all pull it in...

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com> # for input

Thanks.

-- 
Dmitry
