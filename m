Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427901DE2C9
	for <linux-fbdev@vger.kernel.org>; Fri, 27 Jun 2025 09:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751017732; cv=none; b=X6sfLGtEEPZY6n0Ld/Phl9CCAnMQ1GsoCpvGBYWY7aYHFYGwbrLQ+Maw+B5GW5Pr+QvGI7TULDq0AE6l3U8tDyGGIXwhHf+GJST1nNEArg94igl80ckzc7Q2ja03AKcBy58HEcwwCAo8ImLZiqkJw/Gy6UhFMbqz1AP0FqBw3Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751017732; c=relaxed/simple;
	bh=jk2XiQuMfpRR7673S2qBhzwFnyhsfwKb+E//hNbwE/8=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=NGAXzM8Uuu9lsjm9Z+7m1mqV8d8TqJAk/06ErD3JPsoYg6Tn2YkNg2pPy79aVtsQIo8u4gVeTMCmgOM2De3ntXapfE/zE5krO2jj1dy6Tzo9I149GtbYQQLnqTvJ3I6KaJTMtHJbeLT9jp3zxwtpJhHRiXEjBgB3llbIVHiv8tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=DgnghXcj; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="DgnghXcj"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ae0dffaa8b2so258228566b.0
        for <linux-fbdev@vger.kernel.org>; Fri, 27 Jun 2025 02:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1751017728; x=1751622528; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DCDsaW+29dJd0Q/+M489tK44pMH2jQe/+cBTe7kaALo=;
        b=DgnghXcjsrotg8y7cMdF4zPAE5zzvSYpFtnjEJZXTdqYZxnl7KoLWQX0+Be9yZrs9M
         EMSjj9kbC/ZBATAlw6ajk+s9OHKhyssHXfUtVzgxOzuEbxf934Dn3PK4aKmvF7cRMNvx
         VtvANfhXNRv8+hTJ+e9v7pv7nBAr24RMzQlCW5cQAfwPOVKsU5EeCkuj3qaqjanZA5Uz
         YbPOBeD5Jbs1rp2jdh97zfdcSDCuUwXG9oRvtUqbeyfl2ltPOQYXStsKAXl90+BVegcp
         pzDp6JqulaX8w04KV7BkXB1TEm9vDH0xaiLWTKzlWyVLmnVrN9N6XK90D0YKiKtnaOR0
         tP5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751017728; x=1751622528;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DCDsaW+29dJd0Q/+M489tK44pMH2jQe/+cBTe7kaALo=;
        b=Vd3+YgMeJsnGh7dw0CKO1ijgGybmbhmHmdoQ8Racw1+qRLnKRNzKliur1WBpE84grh
         IXhMNddLcW1bC3OJ9seVhgsFpLPZXVQQQQmj1LVDyb0+oMFdycI1TF8VKZOqZkJnu8na
         PU8bY880m5dkWiV7LDgZ5wiBM0YCTttZFH5qJbU0afiisw/1d4DpMCrOSvV7VBapeWVz
         YUJWq6WlWlD710yIOu0uqvMDAvTiFifKoV0m4pVVIWA6hgXKYjVFzffa8E/26fKsI4X5
         O8BErsdn9FLvK/+u4qC6BSdNnE6KEY0hrw1E9DdoKWcHOSr8rBooM8wS37Aod3FhNbsZ
         tL7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXC5iFHD1Jxdkpg5QvmyAL98IQb2SSZfCMDvCIxrqp2DqyxNWlBfvqU4pbHG4OxlPbLftbn5tTXitEG4g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0YgwB8FYXvAI5ypyTa1llHoCMpT1Ro2IplvKB3rHyGmPCIQ/6
	aLWDvxaz6/IZyWHr/L4hFHWkZW6DNJ1XAJ11h6rWIPH2WGwaWyXnBwgpF0mQEht6/r4=
X-Gm-Gg: ASbGnctrSFsqIh3nh1DG+8Vzg9lCaknsq+EbDyPpU3B1DKD3ubD+X8uWqTjnd3oEQsL
	Tpl5aLDIMMRRKk7ldWLIoqVo6J05bO9Q4orKkzOAkmXAZBi2276GakClz3PnTapzCyuybTrG4Gz
	DDeeoxV1/OJDuJk49cIzrI75RdBHW73ppRuJ6bXG9Fp+BitaMW/ikvdK7BFZNPMIkGP6ScIAJNL
	3epgdyNVT9PE6GI199AZGZV19XfX6MClsL+I4loS70zAU/wGVPsgbHOw8nMJw+fSRJgezqZt06v
	tChgLA96Fizi7CAYOYsWvjCZsPorALLdGZwB3iTX5+xcVXipQJTMnEQN4qdrRcRnO+XZbA3H1DZ
	Wdd6w+HJT29qzP/bIvDbx1nf7AAX3wgI=
X-Google-Smtp-Source: AGHT+IFvxLKtOUHTAM6IaJNk+LxRIz+Sbrpu2XNC5tbYBRY8piKKH2knwTobMqopOBPkPqKUqvHZeA==
X-Received: by 2002:a17:907:1c0b:b0:ae0:6dab:1a83 with SMTP id a640c23a62f3a-ae34fd0783bmr221032566b.7.1751017728509;
        Fri, 27 Jun 2025 02:48:48 -0700 (PDT)
Received: from localhost (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae353c0427bsm92425166b.84.2025.06.27.02.48.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jun 2025 02:48:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 27 Jun 2025 11:48:47 +0200
Message-Id: <DAX7ZB27SBPV.2Y0I09TVSF3TT@fairphone.com>
To: "Krzysztof Kozlowski" <krzk@kernel.org>
Cc: "Hans de Goede" <hdegoede@redhat.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Rob Herring"
 <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, "Javier Martinez Canillas"
 <javierm@redhat.com>, "Helge Deller" <deller@gmx.de>,
 <linux-fbdev@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/5] dt-bindings: display: simple-framebuffer: Add
 interconnects property
From: "Luca Weiss" <luca.weiss@fairphone.com>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250623-simple-drm-fb-icc-v2-0-f69b86cd3d7d@fairphone.com>
 <20250623-simple-drm-fb-icc-v2-1-f69b86cd3d7d@fairphone.com>
 <20250627-mysterious-optimistic-bird-acaafb@krzk-bin>
In-Reply-To: <20250627-mysterious-optimistic-bird-acaafb@krzk-bin>

Hi Krzysztof,

On Fri Jun 27, 2025 at 10:08 AM CEST, Krzysztof Kozlowski wrote:
> On Mon, Jun 23, 2025 at 08:44:45AM +0200, Luca Weiss wrote:
>> Document the interconnects property which is a list of interconnect
>> paths that is used by the framebuffer and therefore needs to be kept
>> alive when the framebuffer is being used.
>>=20
>> Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
>> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
>> ---
>>  Documentation/devicetree/bindings/display/simple-framebuffer.yaml | 3 +=
++
>>  1 file changed, 3 insertions(+)
>>=20
>> diff --git a/Documentation/devicetree/bindings/display/simple-framebuffe=
r.yaml b/Documentation/devicetree/bindings/display/simple-framebuffer.yaml
>> index 296500f9da05e296dbbeec50ba5186b6b30aaffc..f0fa0ef23d91043dfb2b220c=
654b80e2e80850cd 100644
>> --- a/Documentation/devicetree/bindings/display/simple-framebuffer.yaml
>> +++ b/Documentation/devicetree/bindings/display/simple-framebuffer.yaml
>> @@ -79,6 +79,9 @@ properties:
>>    power-domains:
>>      description: List of power domains used by the framebuffer.
>> =20
>> +  interconnects:
>> +    description: List of interconnect paths used by the framebuffer.
>> +
>
> maxItems: 1, or this is not a simple FB anymore. Anything which needs
> some sort of resources in unknown way is not simple anymore. You need
> device specific bindings.

The bindings support an arbitrary number of clocks, regulators,
power-domains. Why should I artificially limit the interconnects to only
one?

The driver code also has that support added in this series.

Regards
Luca

>
> Best regards,
> Krzysztof

