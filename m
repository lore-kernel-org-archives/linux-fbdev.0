Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2DC395276
	for <linux-fbdev@vger.kernel.org>; Mon, 17 Aug 2026 09:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786959584; cv=none; b=u23LdQB1ZkkjP+idzLYlzXil+Hwn69BW68Nf3F4ynaKsrwV7tccQF6V0MufCnTOIyfdkO5Npe4422UUGCy0Yf53opAzgRMD2Zev8VKIh3vjdt9bQUpZdteuRRsXPsy5UhBIO/U5ropBPTMbbeXEZwZZd1ge6S4OvXOEWJhilyhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786959584; c=relaxed/simple;
	bh=dtk6e7DXkab0Wi6uKJ4HjHzWIAKxI0jK8NztSrr+wKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u4P7CqSvs/He3BTf+Ajxl4sZ57/dz6BFR+Ft3TLfUhtz4UEH9A/wsAINNgJndSagbWHtKrnDT7RSX1cZRC3Dm5nw9xweORYd+WNLvRR1QvUWlzJCOEMBciZ2TOKm+U6UJERXGEHsXPorSWJn7I1LhZRP/mgdIBFCpiYsw7rXbaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=hDHFMeiv; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="hDHFMeiv"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4921eed3fa2so25569755e9.0
        for <linux-fbdev@vger.kernel.org>; Mon, 17 Aug 2026 02:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1786959579; x=1787564379; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dtk6e7DXkab0Wi6uKJ4HjHzWIAKxI0jK8NztSrr+wKk=;
        b=hDHFMeivnqgaKc+0lZ93f98BgXbzgnxU3Ky/WbFz1oZPuM93N2vbfUSzt7WX7xQNZ4
         IJc7twCldleo7/B430+SRGv34cEn9G834h7wlUXuQXGkyozNDRowruON2bS8FQwesTp1
         jxY+ox2LQy6qF+0z/RyxRHKl+sBVwkdtK4oebDRIuueFloW4Jw/OxostUmk1SPyfxVZ1
         Or9GM2v3mTfzqv9VATtVzpbgn39+vkAMKrlo6Z458IKTXsTZ2qhoHzbFWgGEqEeJbJm/
         jDOxRdBbimbQBqz/0nQlvmMWUMlS/CpnEdHMEsY1t+5F6upQp9HKhXGq/CQPUzOT8/FR
         Fp9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786959579; x=1787564379;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dtk6e7DXkab0Wi6uKJ4HjHzWIAKxI0jK8NztSrr+wKk=;
        b=FfygIFt+36VG2SAJpu1fDyQveNO0imnymds2JsMwZEKL5S/KiivblhZuaaxDivbiLL
         cCpd3+OhvWNsJc1r1qmeCuhF9W4sZWiNQA53BHA5bYkt90Y+3xggg0rxtYspYZ8pLOF7
         3UTC9zwpx5EizDKyC53iRDMpcpYzpjmE2fFdJg4pVU+U9/0jPNhT+90KAA8TG6UyDWtx
         5SaZUdS9Tjfmd5s/B92yjF6lIAi8mIMAoyTkdyPnyZfCOjqis6Sml7n8MLPxnpuEQLW7
         2Iu3ZOlMCJK2oq3aaBBZ8l6l534Ybpb6hovSmxD9r3ADjnmkkafh4Se8u7ce5q2X602c
         b6iQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro9Ax86waHis1kEsmLsfK+WdTZ/SxejdoO5n9BtC17oU4F3Bw3fnEYh9kORbpCVRvm5mD1naQeiRviBDg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1cQJBzSyD7ug6sKUr9QoS6XHfUe/Zm+05lbhwka028A1gacl4
	gumefR1y/N3UpeZGV6lyQZA3x8nDEGq9ykvo+Rlnw0V/VqTbxuND+1pW4bpvBy8xCS4=
X-Gm-Gg: AR+sD11pdk7MdS4Ox5CKMpfHlZ5mlIB9/glA0YCRjKf4NBrI98N4T1O51Y5eg37XOhP
	aptZS8zSM3jLUV7NFOISCaw9Tx5XDzbwRDdXedzboNifNkk/VP1c3czse+A7TlFz8OTQdwE3DE5
	1gLXygCnUbQ7vOaDtawPja9WzV5K/yg8OFPPvvFyFfPtJ6S5h3AQixz5VjD3rAhAgEIgmeEyvQR
	O4hjADlkS01f4kJlOQyHpmFsq/jQ+ROTUffHWXijM9KEnBLRIGBTYzn9g0FQ7L+z8abQX/8+R59
	QGgK2ueqw4GM06n3fLUXExEfJls90JBddEwZGbJFYqsgt/rUKRS9koXb8G2T/jTCVARMKo+Ht8c
	3q0mkoj5yjynCko/opgraN/fnBtyV8lKz30vBG88mr0hcJNRkoOVnq4FngTSjV2npa1e545Y1vc
	gZXkRWCSm1MUIPrITJC6UTBfAIj5ZJ4r+lJgNcKP8TReWxBnQVPCIjiYCEqKG/s16qhpyzUFMWd
	EHxU9tvOhEWvBrdPy1qErQkXl1Vqq/aDlpCroztUUe3GCLRkPJmMfzFmD042OXIuK9DCQoUUOmi
	1mwhEVbsnw7Au7Jc4RWZ9VxCv2PQnvln3AskwHFADJ9U6A==
X-Received: by 2002:a05:600c:4f12:b0:499:491e:4b0d with SMTP id 5b1f17b1804b1-499879c627bmr387093535e9.19.1786959579385;
        Mon, 17 Aug 2026 02:39:39 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4999610ed6dsm169142985e9.8.2026.08.17.02.39.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 02:39:38 -0700 (PDT)
Date: Mon, 17 Aug 2026 10:39:36 +0100
From: Daniel Thompson <daniel@riscstar.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>, Lee Jones <lee@kernel.org>,
	Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Helge Deller <deller@gmx.de>,
	Johan Hovold <johan@kernel.org>, dri-devel@lists.freedesktop.org,
	linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	mfd@lists.linux.dev, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v6 04/14] mfd: lm3533: Pass only regmap and light sensor
 presence to child devices
Message-ID: <aoLW2Lo7LDD-OcWF@aspen.lan>
References: <20260731113632.158440-1-clamor95@gmail.com>
 <20260731113632.158440-5-clamor95@gmail.com>
 <20260815025203.2618cf8f@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260815025203.2618cf8f@jic23-huawei>

On Sat, Aug 15, 2026 at 02:52:03AM +0100, Jonathan Cameron wrote:
> On Fri, 31 Jul 2026 14:36:22 +0300
> Svyatoslav Ryhel <clamor95@gmail.com> wrote:
>
> > Instead of passing the entire lm3533 core data structure, only pass the
> > regmap and the light sensor presence flag to child devices.
> >
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> Acked-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com> #for-iio
> (I didn't read the rest on this one)

... and it looks like I overlooked that there were backlight changes in
this one:
Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org> #for-backlight


Daniel.
