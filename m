Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1408A22A4EB
	for <linux-fbdev@vger.kernel.org>; Fri, 27 Jun 2025 07:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751010709; cv=none; b=g4MLSOZlf92qEs7l5iXmp5VF9D+9F/n1UhSlnmtvO0jTiNPHOH2LMDQKwbSnqw9tVPXB6JAVllzqPnOdRQX2xvqj1Y6O29xTkUS/XXDeNEAcUEDeWzkL9V3jOHEye4C5SKbWKSHyNRR93DCYhPQXAdyxF+Xn/BOkllpuRLQ6DGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751010709; c=relaxed/simple;
	bh=CmJByLtbVpwLLdyZCpUwCmCAxS6jbpT0as7eKt5fi5w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=K7Ud1rKh4p8W0h8/x68BlqO0UwLcMjiivFcDgWsXWwse0wz7mEUPvb3DJmNGv5JsIygiTFuvWVyCjvZj18cENWxoFmpi2m4mI9fGfE+sLQ3RUKR75XGe/nMx19JF15dLnIvs6OFhN+ShaoHpe6T2VRwgRkFAlk2dkuXkBMMusl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Tqceywah; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tqceywah"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751010707;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ri0+PoGBbyLJmIsWOHAGRErY0fpNzrIikLK+X0yMjKY=;
	b=Tqceywahhd8Ot3vMnmdndl6IDZecqwHEUHTLkg+0xwWr/eSBhZX2ImwChaTs8Pq9/kAm+P
	UDjUfMG9Qs5wyRBuLn/Hy9+JNjPXXsdp22tThVH2mnBCTUFBBSLtUILvqmcsBVQ8ugCTY3
	zxP2R9mgZfmL9W3ekm0oDM502EiBouM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-znJEIw_0OVuzVdxnlRbMDA-1; Fri, 27 Jun 2025 03:51:45 -0400
X-MC-Unique: znJEIw_0OVuzVdxnlRbMDA-1
X-Mimecast-MFC-AGG-ID: znJEIw_0OVuzVdxnlRbMDA_1751010704
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4535d300d2dso14709385e9.1
        for <linux-fbdev@vger.kernel.org>; Fri, 27 Jun 2025 00:51:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751010704; x=1751615504;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ri0+PoGBbyLJmIsWOHAGRErY0fpNzrIikLK+X0yMjKY=;
        b=hCilu/dMtxCK/2C6mvqv21pyNlNd8DprQL31iSbJzwqYwEX9H2TkLls/R1NCm38Ym+
         9mxFlB18rVBDzgLOiTr9VT9Ts7yuS13v+htxcsuAD77c3lrs1yybHqs+FyvuHoPlt7EY
         Hyak2SZ8Q3toQtiN7nAsqZFgj9uuX/7nGjcD91NkXngbtAaqutdHxPaSjVRdAYVX1NVR
         uHhblTJNjypZy9h8Ig1kUK16a7642zGVmCOv0AbnKzcB5N9v/PJ0JimFyLDOh/ggO23r
         dCEWVPOZrX1WNGhzkJ7QaJQc7LG/cuP7DFN6EIYAgHRsRCmhhr74oDo935c3ipvFtfkD
         gxFw==
X-Gm-Message-State: AOJu0YwzN7Witk6yu2FEXSXoBeZesRQJBC16sH8KYxClSoQ/187pGaT3
	no26i0+8JxnDznVrnZ+QKQ/Bxx1wamTleuAP7LLtw+Zp67RDwbP55ohywCcVB6ZdeAJ5IdmOj9i
	jk/R8ZcQqOC946Nd/jVifiIp8QQl4y/uPu246vzwl27Ql7+EFFqG5N4lENMNOx+5OeH+kgvAq
X-Gm-Gg: ASbGncsLnXsVaTQpGWyU8fKYbv3fGNC3W+ZrHCModbY8iblmsJvg0PN8t5yY/xq8/if
	8uO0VfMHq3Il70nAlTYZwYqe5Ok6D6ppk8oGVO/o6f8XSqRK+yDq5L0uNxSNBzvuASt8dJdhhZz
	KK/ZmX1gopf3Le7zeS6mVTsHeta3WhV+F1JdGZDPejcJY0tx7Lx16AOMacAHjsGUjTD6oiHTYf1
	60UhAmHBDPCOsVxaW4pf2xjlpxHf+X2zoocZnRpF2j0AdQ5zVip8etGnAJeKsMMDilNajQklTlX
	mwtrkYrEG20hwSEcmTK4nNaZa8GefPTS8ntPrbhvv/5qQhqA5U8IIMMh3FfT/N0wVctI2vPohNO
	gUPM9
X-Received: by 2002:a05:600c:3ba2:b0:441:b00d:e9d1 with SMTP id 5b1f17b1804b1-4538ee15a09mr27052115e9.2.1751010703341;
        Fri, 27 Jun 2025 00:51:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG84NMS43tLU4/bepm0RU/vh1jVbKdij5j7ryp5JJCNaNfJj8+Z/Tw54L4wr9lRRNPbvhEdWQ==
X-Received: by 2002:a05:600c:3ba2:b0:441:b00d:e9d1 with SMTP id 5b1f17b1804b1-4538ee15a09mr27051735e9.2.1751010702905;
        Fri, 27 Jun 2025 00:51:42 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4538233c5fasm74208765e9.8.2025.06.27.00.51.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 00:51:42 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Luca Weiss <luca.weiss@fairphone.com>, Hans de Goede
 <hdegoede@redhat.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Helge
 Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Luca Weiss
 <luca.weiss@fairphone.com>
Subject: Re: [PATCH v2 3/5] drm/sysfb: simpledrm: Add support for
 interconnect paths
In-Reply-To: <20250623-simple-drm-fb-icc-v2-3-f69b86cd3d7d@fairphone.com>
References: <20250623-simple-drm-fb-icc-v2-0-f69b86cd3d7d@fairphone.com>
 <20250623-simple-drm-fb-icc-v2-3-f69b86cd3d7d@fairphone.com>
Date: Fri, 27 Jun 2025 09:51:41 +0200
Message-ID: <87qzz5d3le.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Luca Weiss <luca.weiss@fairphone.com> writes:

> Some devices might require keeping an interconnect path alive so that
> the framebuffer continues working. Add support for that by setting the
> bandwidth requirements appropriately for all provided interconnect
> paths.
>
> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  drivers/gpu/drm/sysfb/simpledrm.c | 83 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 83 insertions(+)
>
> diff --git a/drivers/gpu/drm/sysfb/simpledrm.c b/drivers/gpu/drm/sysfb/simpledrm.c
> index 349219330314e3421a6bb26ad5cf39a679a5cb7a..47d213e20cab1dd1e19528674a95edea00f4bb30 100644
> --- a/drivers/gpu/drm/sysfb/simpledrm.c
> +++ b/drivers/gpu/drm/sysfb/simpledrm.c
> @@ -2,6 +2,7 @@
>  
>  #include <linux/aperture.h>
>  #include <linux/clk.h>
> +#include <linux/interconnect.h>
>  #include <linux/minmax.h>
>  #include <linux/of_address.h>
>  #include <linux/of_clk.h>
> @@ -225,6 +226,10 @@ struct simpledrm_device {
>  	struct device **pwr_dom_devs;
>  	struct device_link **pwr_dom_links;
>  #endif

Can you add a /* interconnects */ comment here? Similarly how there is one
for clocks, regulators, power domains, etc.

> +#if defined CONFIG_OF && defined CONFIG_INTERCONNECT
> +	unsigned int icc_count;
> +	struct icc_path **icc_paths;
> +#endif
>  

...

> +static int simpledrm_device_attach_icc(struct simpledrm_device *sdev)
> +{
> +	struct device *dev = sdev->sysfb.dev.dev;
> +	int ret, count, i;
> +
> +	count = of_count_phandle_with_args(dev->of_node, "interconnects",
> +							 "#interconnect-cells");
> +	if (count < 0)
> +		return 0;
> +
> +	/* An interconnect path consists of two elements */
> +	if (count % 2) {
> +		drm_err(&sdev->sysfb.dev,
> +			"invalid interconnects value\n");
> +		return -EINVAL;
> +	}
> +	sdev->icc_count = count / 2;
> +
> +	sdev->icc_paths = devm_kcalloc(dev, sdev->icc_count,
> +					       sizeof(*sdev->icc_paths),
> +					       GFP_KERNEL);
> +	if (!sdev->icc_paths)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < sdev->icc_count; i++) {
> +		sdev->icc_paths[i] = of_icc_get_by_index(dev, i);
> +		if (IS_ERR_OR_NULL(sdev->icc_paths[i])) {
> +			ret = PTR_ERR(sdev->icc_paths[i]);
> +			if (ret == -EPROBE_DEFER)
> +				goto err;
> +			drm_err(&sdev->sysfb.dev, "failed to get interconnect path %u: %d\n",
> +				i, ret);

You could use dev_err_probe() instead that already handles the -EPROBE_DEFER
case and also will get this message in the /sys/kernel/debug/devices_deferred
debugfs entry, as the reason why the probe deferral happened.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

