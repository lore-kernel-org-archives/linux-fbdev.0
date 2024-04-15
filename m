Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FCDB823BF
	for <linux-fbdev@vger.kernel.org>; Mon, 15 Apr 2024 12:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713185619; cv=none; b=MfLjWEl/EVBIQSajoDuIJo0VzGJJDQW935PwHixhgMLXVXs0x6nWDWeU4NvYpbcGGpgIPvIj8hoU3rz+45JntK3Vx4ZItHysTbExCA+hhnhWZVdrMQ+V62BR3Da809bYgbwao2ZWONADq9pgIX2XhqeRIGuxWYTuWLtdITDU37c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713185619; c=relaxed/simple;
	bh=mHsCAGKbKeVfl1gaf61CGCnVc92+Gj0VNSeDerofu3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cT8gYbiFksNBEzA8hAdSHRzeIAo4N+5wJFy8ofQz9S+vQXoTWRQYIL0Q0STbvH/KTr5dzufNnr1yXKTEUuh2odGEZkOx9KkkEZ98plcmtzfW0OX3mn4TMIHatXdusIbSvPSQ0RKiMD5jhLXbiygkRu+iia1KDC9YjgtTr6EtfXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Lg3x65O8; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Lg3x65O8"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-41879819915so2737805e9.1
        for <linux-fbdev@vger.kernel.org>; Mon, 15 Apr 2024 05:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713185616; x=1713790416; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mHsCAGKbKeVfl1gaf61CGCnVc92+Gj0VNSeDerofu3E=;
        b=Lg3x65O8jqJXNBm2NS8j1qNs6jfUj5+ehqF6DIe4JKTzGtGfGnoDCacBuT6iDP2RtL
         d3n2ZzWIiit3WlwlmoVe5zHoA4JZDUVDtjU4HvQmpUjSvBzoYPzRJ13ickiIAkG/pJu8
         QCbujb2CgrOOjehcsi4+9pmbSQnT9Bd/E414P1Eu2dIrkrL8g6xrMkjKk8R67dMfqUuJ
         4DSKLkTULYIBxW9k7rRmjWtGv7YMemzb5FzbuLM6Efdr2LJSo4i7M8nyu6ko+pL8w99w
         TVe1PqygWWXE55VEhDLhQ5zlxmLLD7vjzIhMILgBIiM8gXyNW1TeT9wvKthBC9CEJEth
         fY3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713185616; x=1713790416;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mHsCAGKbKeVfl1gaf61CGCnVc92+Gj0VNSeDerofu3E=;
        b=J+GOi+6eiSFEng2EGK0CflHQK6gzp2M06pMrwOwpgm9m4KXx79fBC6Ba1d/HSEs5Wt
         OKfGH5ZcoEgjkWfodAMFhZFjQKc7igmDvyOARJS32/ZFZ5oktSG6YjjP3GN8m5KiisX7
         0pRHRMb6Orcv5cn0n0W3wrKFoB1ylzqpWJ2ZRPmDbM+p6JjMwoxTi//j40FEokEGllAs
         q9tkoTq6TwH+68iVNXdc68sR7mHToxA/5r/7DWPm8/gM5n4DtXL0sgrHFxnOr3m+WyCw
         PlagJ/Z8P13lzS43p9KzNOKBl+RCs9iknf6uFeB9tGT58qUVghG8WBTNwXLy2slGwCxG
         PDnw==
X-Forwarded-Encrypted: i=1; AJvYcCWtIS9aCir5EG1fIuTGtlHc4ZBRkASTeahuIHYBO6yYFTQNs98OgAuJHnFm2PenM7WYhtR+hdlg9hQtYKs11EoLjgSZ/HJi+t8tCEY=
X-Gm-Message-State: AOJu0YyonhCfMGbckMUOgfvv6uO+6pXswLzuT3+JADWA1uWxg2NiRBHc
	G/Day/x20tP5mntje1+V9NHDLP34RsKpgxoSmMTduxP6fG5zhDZubjogYWxWJ1A=
X-Google-Smtp-Source: AGHT+IEN14JC4aKAm6IoQEiJFrZ1mUtV2GIjZnWInAUAurGR00ImSNVfIpNW8YhhEhxbJzeTLcDKvw==
X-Received: by 2002:a05:600c:5114:b0:416:605b:584d with SMTP id o20-20020a05600c511400b00416605b584dmr7777987wms.3.1713185615753;
        Mon, 15 Apr 2024 05:53:35 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id bh11-20020a05600c3d0b00b004187e71bcd9sm681454wmb.30.2024.04.15.05.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 05:53:35 -0700 (PDT)
Date: Mon, 15 Apr 2024 13:53:33 +0100
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
Subject: Re: [PATCH 08/18] backlight: l4f00242t03: Constify lcd_ops
Message-ID: <20240415125333.GH222427@aspen.lan>
References: <20240414-video-backlight-lcd-ops-v1-0-9b37fcbf546a@kernel.org>
 <20240414-video-backlight-lcd-ops-v1-8-9b37fcbf546a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240414-video-backlight-lcd-ops-v1-8-9b37fcbf546a@kernel.org>

On Sun, Apr 14, 2024 at 06:36:06PM +0200, Krzysztof Kozlowski wrote:
> 'struct lcd_ops' is not modified by core backlight code, so it can be
> made const for increased code safety.
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
