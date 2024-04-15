Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB557EF0C
	for <linux-fbdev@vger.kernel.org>; Mon, 15 Apr 2024 12:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713185545; cv=none; b=t/ylI84qyvTZmLT/WD1vcP7wOUlb1yTTZgUGR6FHZ30ag0Pa8pgJYtUSOg5msQDt1rUDWlVIOnXrIcMx3G3BaLxFCPYU1xDAD+doe2YgrwyVsEDpcEt8SctBRx0Lvjo3dqYYLOsekDL4kkRKrGnlGHmNQQvvNaUfAHFoaV0HQuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713185545; c=relaxed/simple;
	bh=01ardidNL+/BeEuWA/146qtH9HDtmPA03ttD6ybAIEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sy0tntYLvwaEbcucJHrZy29VyjrLDqDZXU7+M2c774d7TqPaqTUTVSP6GVGdWRP8kxfOltc8uPpp76ScxfoScXiNdyVupKqZ49PFwkosPc2lFirTMprVOFQNA5lRDX0pbnCaV/VaQTu4821kOlrEQBhbV0X1LeEx1MVixz7XzkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jph51AAU; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jph51AAU"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d9fe2b37acso38997191fa.2
        for <linux-fbdev@vger.kernel.org>; Mon, 15 Apr 2024 05:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713185541; x=1713790341; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=01ardidNL+/BeEuWA/146qtH9HDtmPA03ttD6ybAIEs=;
        b=jph51AAUkoC2XzN7yiQsldhHJdozuIujSh6khifnB0s+1erYsE0me7JPQBHOq1Lm3i
         f7m3DPhY5UQ1zod+k0O0w/7nvklt6EbM3oJX8s4RC+6om1R5ozGxiMI3YRDg43/kW8ai
         +GH3/mAsCRgafiWoaAayF09ii4gu9bXBtgVlCu1V79NUIFObL+u1l71ibX2AVGNEbVFn
         b95M/cGr3WfA9XvRjIVlTO2dOPa7EXGrDSB04+gaFL5tcPJaIc8BfB6N2fe9HXVfwh1g
         yzn4OulXgVCHBYOGjJFRfQl/wK2GniLO9vFVcFynTdyy2SwH7ISf4C5R8hPSHNxS1tDz
         Ht7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713185541; x=1713790341;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=01ardidNL+/BeEuWA/146qtH9HDtmPA03ttD6ybAIEs=;
        b=AqAxXS0DqDW5jIZQNmedySsNcwQ21ZqD1j/iQll5LKijF1yOGXFKrunfmDr9uOhFNk
         AbevWiMjBIWWhQ2nrDPU8jXsSlUQhov+Of2UtEi5ptwSzz8bI9fpxKs1pEBgnbbtfAFG
         R5ejFhi+vSS3dHmbvorvMWw+lr0vV30vWVBiplbemL90vaTclb9sOrLE2EbqY5/wXaw+
         448f647yEdkOlDL2RqzgtYaubbOHr4Jk4qhSXK8Agq2G49LGGP7Y3kF1kdQfmVcSyNBx
         qvd+4PGEqwEAA86f6hvHztjVLisKGNDf5Mimt7OQUXzKy3B1MU1bCr+CaZfLHlXRIuh7
         w6LA==
X-Forwarded-Encrypted: i=1; AJvYcCXCrSoocMIPijMURt/0+WapWPpQCwmAj39N3obpYBdpjqRqEF8A8Z3Q0KjW8LDtlxgnHoLJDlDn1wo17UOyf5lYErr821I3kb8ZpQQ=
X-Gm-Message-State: AOJu0Ywu3KFzayJNrNP/S1AGwsVIUr9yGXqJYAW9gd9+i6IwnvTHKACy
	jkxb2HABs9iCZOTK92R/L6lsZ+XIP49YBj1li8OENVn1otYSYJ3tJNxMscmCiqE=
X-Google-Smtp-Source: AGHT+IHu5tfg7Nur6nUM4tRHPyjM2leUDl2jKt9o9nLqolr31cl2B0ZsT4h/TE6rznaVk74mXQEafQ==
X-Received: by 2002:a05:651c:1543:b0:2da:901f:6ebd with SMTP id y3-20020a05651c154300b002da901f6ebdmr1300658ljp.41.1713185540482;
        Mon, 15 Apr 2024 05:52:20 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id u17-20020a05600c139100b0041496734318sm19430320wmf.24.2024.04.15.05.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 05:52:20 -0700 (PDT)
Date: Mon, 15 Apr 2024 13:52:18 +0100
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
	Helge Deller <deller@gmx.de>,
	Bruno =?iso-8859-1?Q?Pr=E9mont?= <bonbons@linux-vserver.org>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Alexander Shiyan <shc_work@mail.ru>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>, Fabio Estevam <festevam@gmail.com>,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	linux-omap@vger.kernel.org
Subject: Re: [PATCH 07/18] backlight: jornada720_lcd: Constify lcd_ops
Message-ID: <20240415125218.GG222427@aspen.lan>
References: <20240414-video-backlight-lcd-ops-v1-0-9b37fcbf546a@kernel.org>
 <20240414-video-backlight-lcd-ops-v1-7-9b37fcbf546a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240414-video-backlight-lcd-ops-v1-7-9b37fcbf546a@kernel.org>

On Sun, Apr 14, 2024 at 06:36:05PM +0200, Krzysztof Kozlowski wrote:
> 'struct lcd_ops' is not modified by core backlight code, so it can be
> made const for increased code safety.
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
