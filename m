Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5440A16E863
	for <linux-fbdev@vger.kernel.org>; Fri, 31 Jan 2025 21:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738359084; cv=none; b=kzbhdo8XD+4Qu+bJSI0yR+MWdJZ/F6SuIgvJRuBJwZ8VHYqooIv4Tn+fCaLUpFnNkKVwcuXArgWNzOrqqN2KyNcJUd842ceKcJIR0myRapLBT+8BFaMaygkXMiaM3YXgXL4dd8KSsN98Ra5wuLnyr8OoLBFupg8MkPmN3hg0kh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738359084; c=relaxed/simple;
	bh=ftu7pmvGV2qr+jK4JxkhWrw+cRjCunxZf5kwDUQrlbc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HoUD0AxhJZkI1DOAGN28mxYun5q0ftsa5xp0X+zuLyQqoivpRZgjd4ZfAyltrfTOckdsMCJb488VYbvCLAxZEC0woUEZiNc6SO7nRARKJ02Xget8NM0Yvogah260AwZ4lPIumo5Fy6OV9NeTFI9jDc7WVP/OvT0gaGm5P9Fu6oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=sZjwYpSj; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="sZjwYpSj"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3ebbec36900so1293552b6e.1
        for <linux-fbdev@vger.kernel.org>; Fri, 31 Jan 2025 13:31:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1738359081; x=1738963881; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jDvnP9HNi8abDAufTXVzuVdU4XUJ2r6pu6gJGv0aC7A=;
        b=sZjwYpSj624x16hqUYRvl0jZxfCo+u3ddY+Jp6rOrkw8hilEtnKKaJGtYakV4g4Ma6
         jSKYcVBB1dNMUYAnE9o4JXUGSdbLh+hWNTAnaWEGlRDHxBHdSJpyjAfCYj3d4vJT89gS
         lxypHg3HkRll+qtM4E7fUmoCYg0+8YFoA7ZVAZR8LvPvrMYrsUX80wHhdZXIz8HP2rw/
         oPxAwlOE1nVpSALCPbW4wJc7bGAK8lPSVnhAQLpvNX5WH8BE8/LsQIvK/BiZeJX0azys
         K2UV7N06Fn7faUutooPJu/QGzfYScbWke0nXOXdFZy8l6bU7tuZM0Ela7AUZCU9mtahk
         r6sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738359081; x=1738963881;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jDvnP9HNi8abDAufTXVzuVdU4XUJ2r6pu6gJGv0aC7A=;
        b=IGcqyKz+ou/tBmqVXUnWnBGtrWy03agvsl7rwAz/vF7ikfz/aCCwWeZ+jQyuDmH0tu
         8Mfcnplli8irZ11uyoKEHlibr2Uf/L5b1ANGJogf4onOhZnT5Xw6aZoqZ/Y/ax8n1/bj
         IsvdVM5oopGLMAS7sFsUX1GeMzApdLuCKT4nWF8WVQg0WQazkOFzxocXOAyAeAEqZgp4
         bYT1uF2UHhxxJ0FaVbh4zskfyrLUgIZMQevg2ZVjKoQXb8puLRGb9lcULJ3a2A+XwFSJ
         0EUWZPnVPdo6kKOUhg8kofkneTPr3Zr/zonDCFK60dx811HINrJpep6m3uXJG7YqPIVm
         LFnA==
X-Forwarded-Encrypted: i=1; AJvYcCVfW95STqXA2NkXx+bLnB1anRf6ovsFKfvtiCiyDloL47gh3kaehwe+hNnqboFszsqPn4JA2QT6UMV8JA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyvbfhICzoLB84kSncAVH87MdvodKW/jky13v2CtuRTNKKbezLD
	pyROH+vZi2sexcI+3y90kzKAGKZYlrHzZU/dONDZGbDSXJ4NxTGIrhuQHnp01QQ=
X-Gm-Gg: ASbGncu0CWRRaOwQ98bdTqCPiEx3KMYlHyF2qmtPwvkqGCft5IjOYHC09dzkUejM07c
	wveReAoIbG+REin1BmLFEWr1IFrHnA8vfeB1/Ic4t313E/C1T73R568rC1RqZtctQzmAuPiqZBq
	Fu2NsQ6EnFuAR4O4lD4WEUsv0cswzSgbl4z+AufSRYclwkPtaWwpVYtSRscQDidamEDo2NRJQVx
	OUu2P73R8HH1BR3BonBzg0r7o7Yfj7EUZprX7FLX9bWw/Jm0Y0j3g9BsGtb2paM44hYCLdHpivo
	rcdzw/rd7Gu492FUlYCXVfyHFGzhAHS9F3Om9QnD72tihe/0JpwK
X-Google-Smtp-Source: AGHT+IHD853czjvUWSx2EKQmtEracV4UoohrB2SBmjKc282qQiCd0uVnsaL5aEELB96obJY4/Zxf8A==
X-Received: by 2002:a05:6808:2214:b0:3eb:3bcc:a9e7 with SMTP id 5614622812f47-3f323b74ce1mr9851115b6e.34.1738359081365;
        Fri, 31 Jan 2025 13:31:21 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5fc104e29b7sm1073975eaf.17.2025.01.31.13.31.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jan 2025 13:31:20 -0800 (PST)
Message-ID: <2f604280-f4dd-494f-9f54-83e8f613b64f@baylibre.com>
Date: Fri, 31 Jan 2025 15:31:18 -0600
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/10] iio: adc: ad7606: change r/w_register signature
To: Angelo Dureghello <adureghello@baylibre.com>,
 Michael Hennerich <michael.hennerich@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Alexandru Ardelean <aardelean@baylibre.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-fbdev@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Guillaume Stols <gstols@baylibre.com>
References: <20250129-wip-bl-ad7606_add_backend_sw_mode-v3-0-c3aec77c0ab7@baylibre.com>
 <20250129-wip-bl-ad7606_add_backend_sw_mode-v3-8-c3aec77c0ab7@baylibre.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250129-wip-bl-ad7606_add_backend_sw_mode-v3-8-c3aec77c0ab7@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/29/25 5:03 AM, Angelo Dureghello wrote:
> From: Guillaume Stols <gstols@baylibre.com>
> 
> The register read/write with IIO backend will require to claim the
> direct mode, and doing so requires passing the corresponding iio_dev
> structure.
> So we need to modify the function signature to pass the iio_dev
> structure.
> 
> Signed-off-by: Guillaume Stols <gstols@baylibre.com>
> ---
I don't think calling iio_device_claim_direct_mode() inside there reg_read/write
functions is the right place to do that. It should be done at a higher level (in
case we need to combine multiple reads/writes in an atomic operation). So I
think we should drop this patch.

