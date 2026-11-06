Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793985023;
	b=B4BOTIA5hfIHhXqgv+/xLNby4DPoLqU63VsH4nu9Qzo89P7jRphjsNWEcWWdKW1n0Yb6
	 SGckH5kzQ/G7MNCBx0yRD6U09kugzjURcwW8cCgvfPJ3iIXW589Dh9veacc1pF9POVezo
	 oEBiLjXaaEvBTlAM2P32NFoPrdMu4XD/qSsit6dD8r8mqb2yMEWYnQ/5OYDeTFIei6d8C
	 cP07T2Q15LD8W8ZXa6r/IfbrwMqBPckBmXUtUaIx8N5nPfWQxeYEcJBnxjy6Zu78yPuSD
	 R0ORxkIF1Lke8GsJJ6YBcNJYF3V/KljoRMVkEzDLu7IwLLKpqGnGvteeEHAmOH/rQWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793985023;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:X-Mailer;
	bh=V9n1CV17mWoyinWHCGFvDxtvvBlrLNzZtRYoJJeVLOM=;
	b=UseLB4urB5Tf8vR8nDA48iZnOC/6+dPW7+atUxKtNkD8nR0E3Em7IwS5TGnhNGSoQQSr
	 JnDUEMMakLdenlB5xNBLaz3+2R83n9mZmRypRQoJa2eC5QPGNFLQA2/NHAAH7B1mN0VdN
	 9qB+d6MWsb7n7qcsCtQxVy203O/ZwyDpTAbZpQXWsnso5xbjvH+U4DTiOI8d6O+3xv2zA
	 cZYRt0vvtjwAE0mHMAvjuqL8DMvrQBezMiTUzgeAOHZAAJ0ATUzbIKia0xBOmc/Yq7pVd
	 CqkHBtWdX/A3t+S4GRBxTBjwvoUE1264m4H3qm1aBImj3VBm1bVNzeZX4vR2f0PNKew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JmCY9+dU;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6207606A326
	for <linux-fbdev@vger.kernel.org>; Fri,  6 Nov 2026 17:10:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D6207606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JmCY9+dU
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a214af2076so6265775e9.0
        for <linux-fbdev@vger.kernel.org>; Fri, 06 Nov 2026 09:10:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793985021; x=1794589821; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=V9n1CV17mWoyinWHCGFvDxtvvBlrLNzZtRYoJJeVLOM=;
        b=JmCY9+dUgxS5al2xR2i/XttbJnL8MfzEPMrncmnFAJnVL+gRl4itq+wpGv6Jzso3Yj
         lsk9opNlfH1q6cogTLxcMOr/jZwaFd4QymTJydkFSRwHxhBqO5bObfC5so48hHssFmrq
         sICMazWWuMHYi0vG8N6PXOEBpXAVQT9rLSS+ierixgnKOc2BfrhI3KS/yQhTLPPENp65
         t4QE/4ntdP5IOo0BlYwugM8vilNwIsuvetXiqAeqJsnjdvK1Nk6hiXO3yzYG3Iy/6PeL
         r1vVQNWfuH1vpSk1OE7ahsO4yut0wnGR1Np/teY+XPdds3Esv96rCGDLziZNRgq+sfZ3
         SXmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793985021; x=1794589821;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V9n1CV17mWoyinWHCGFvDxtvvBlrLNzZtRYoJJeVLOM=;
        b=1ReonEfrvcwHKV8k8Z49Rd519vcTePiYHGs14PNVCDlqVGbay04ccSzsuyOquJWxFD
         3CmyUICsYWIIq4jSVf64un3eFwlLR3WyGy5aiep8y38mXAFGmn6sEVNU8Mv8+X/TYAZ+
         NXATCIXg2eKdCEBwLhaQw5gjYfwpUpuF7w3uy6WJOoI+TUt6r8OBvJ5kShAtqVVlDAJe
         VpM1Gmy6ueMqNLizV4UG5fVKBfuSpLyKIVf5LH3o7waLDoixWd3Y+NNj0wGr6ZVl6qIc
         lAPxahR/B3cpY+RBBOnEsUyLWHJxvwzPnU8MQJSbvHUDBtyrYTgLnf1PvJiitZk1ug+L
         kDZw==
X-Forwarded-Encrypted: i=1; AKwUvBxCXeTblQJnFKbHHmG0A0j6/Pr1esI2EIg9IW2c17IjNWEvG2Srz20yczUQZ1RsrFWuY2Gwppg6TOceWw==@vger.kernel.org
X-Gm-Message-State: APuU4Z/YIYejyyc3PW0BQgWSy6avlHljioz/jpeOBq3gHk/Gm7rQ8VUf
	Oyo/K/4ZOkOxddzrFGbD2RUDMaplPJSDV6vU/pZo1qUbsn2AHRORmpne
X-Gm-Gg: AYBFou2X9UCMILTmo9IZI0/oe+bX/NPRt2ezEfTBsUMbYY/b8znzGyatwc4608+qbmP
	H8Z6LjEgRKB3w2RE/I6iNwcKBWLcZB7ADB6t97zhW5iJVLqygMUoBqvkn7+wtEiOcBm/DPTE4v+
	2zFjiqzvoN83n6JJ+kGwgVmtiZXMj0k7hpfFDh7rR/Tr66LabUBeCgrDLYq69fk8YrLDwUfcrR0
	kIz+RXE7TOwqiYs3Wmq+raEuYYBB3qAbuxsdu6mvSGN4jQ8MC6Gn4Ha9O1Hmc+xrDJ+/f7Y5Q8A
	30WjYWdGdTiOuPo3/HOhi9ajRbxMymih6m3wMuTv+cc8YmdVVQ8i2uw7CnXmWXL3Yiwx3gWBI/O
	UFcQ/yTzna+R8EPKCciwBeABQoldpwTFwqvjfS22Cz2HPoRzIjALV6eYBufPWg6FY0c4+4QOz+7
	8ytEsimIa7klxU0GokX8RyLdIvYz+SfUGmw3DpLDa2TaP+dz0w3Yd3j4o5kxzAOa1dbtEUaSIRr
	s1lYHVJstt1+paMIiUpfQY6PEfFL//sVFMDeyloeA1dAidCwlXMmyYuBXEM6oE/of0Xy1jUXWr+
	7uPisNN3P3Xz1APQOurSlaLzfTcv5vx0
X-Received: by 2002:a05:600c:64c5:b0:4b0:a7aa:843 with SMTP id 5b1f17b1804b1-4b6df4f1dfdmr55413875e9.25.1793985021160;
        Fri, 06 Nov 2026 09:10:21 -0800 (PST)
Received: from localhost ([82.77.126.113])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b57317cae5sm238886225e9.12.2026.11.06.09.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 09:10:20 -0800 (PST)
Date: Fri, 6 Nov 2026 19:10:19 +0200
From: Daniel Matyas <matyasdaniel006@gmail.com>
To: Nam Cao <namcao@linutronix.de>
Cc: dri-devel@lists.freedesktop.org, linux-staging@lists.linux.dev,
	Andy Shevchenko <andy@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alex Lanzano <lanzano.alex@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [RFC] staging: fbtft: Moving fb_ili9341 (and others) to DRM
Message-ID: <au4J-0GOUuueHLZe@rabbit>
References: <20261105201154.37294-2-matyasdaniel006@gmail.com>
 <874idv2bol.fsf@yellow.woof>
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874idv2bol.fsf@yellow.woof>
X-Mailer: mutt

On Thu, Nov 05, 2026 at 10:47:06PM +0100, Nam Cao wrote:
> Daniel Matyas <matyasdaniel006@gmail.com> writes:
> > Questions:
> >  a) Is removing fb_ili9341 acceptable, pointing users of other ILI9341
> >     modules to panel-mipi-dbi? The KD233 node would then have no driver.
> >  b) Or should KD233 panel support go into a DRM driver first? I don't have
> >     its init sequence or physical size, or the board...
> >  c) Is removal of all of fbtft already planned?
> >  d) Several other fbtft drivers have drm counterparts. Should I inspect those
> >  to see if removal is needed?
> 
> IIRC the main reason fbtft needs to stay is because it supports parallel
> interface which is missing in the DRM drivers.
> 
> Nam

Thank you for clarifying. However, the fb_ili9341 driver uses only the
SPI interface. Is it alright then to move (or remove) those drivers that only use
SPI interface and have DRM counterparts?

Furthermore, would there be a need to enable parallel interface support
in the DRM subsystem?

Daniel M
