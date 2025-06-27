Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B02218AB3
	for <linux-fbdev@vger.kernel.org>; Fri, 27 Jun 2025 07:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751010988; cv=none; b=YyznaCEZyND50tXxQsDaoypeHws1neY5o7kIhskFd2Ueguyn2ixu8kuAZ4N4YFGL4NIk38VEGXQ8ooEwGXoFqoJ5PBM1Fa7oT/1pMZmZv+U0ZfO1vtEOA0WWNEP/yp/1acyF8HwnglcK/c4Dk+lJjhtGC57biSen3FnBm8xX+sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751010988; c=relaxed/simple;
	bh=1/dXrF5qShKtWLbrqfCXfJgKF3dZ+0lOoRA3MtB9gKs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bEXF3jKO8wgsWKLGYdVomvhLhBk5lHr94cPXSoJZ/O9bfLj0mwsgNdNpeTz8WFt/pb2LcdVnEgK5uyBRJzBrndAG9cuMw/zkk+uRyFuIbi8uO5sQmiYJmf/KkNKATgP8up2kZBABd4Jb49tgQyg7P2HxQ3fbYNeXCP2I0bMxS20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QYiNjsbI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QYiNjsbI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751010986;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1Q4VTKj0+5MdcqxZstilZbvd2GN92E1ID201HEkjPSU=;
	b=QYiNjsbI5t1GbDELSOG/o15ZIPTXQ6dJIjxN38a8T6wKe6HdNDrrTUSFs6WHnmTv9vAWLF
	UaUBBSEXEqNho7dWH+DzqRJ8eKkvk1QjdvdMIwKDeBUpnLRQHrmmJ2Sr094tjZL5VcoNVd
	SKrfJWToV3gugx3/tZFe+H5do4prtmM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-404-HIdiG14iMwOS5hgDS4dbkA-1; Fri, 27 Jun 2025 03:56:24 -0400
X-MC-Unique: HIdiG14iMwOS5hgDS4dbkA-1
X-Mimecast-MFC-AGG-ID: HIdiG14iMwOS5hgDS4dbkA_1751010983
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a4eb6fcd88so1132727f8f.1
        for <linux-fbdev@vger.kernel.org>; Fri, 27 Jun 2025 00:56:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751010983; x=1751615783;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1Q4VTKj0+5MdcqxZstilZbvd2GN92E1ID201HEkjPSU=;
        b=EQLMqxJucE2Yahgqyg4sRcM/RjlotPD/XW7RbKTyWAj/z4uNSeY5NMYsxSrhw6QdQ8
         6yoyHClcIqz3/gcEAbyPNMHd+vU7ac/mzoHAfVju3n2mug2PnQZ/jP0U5K2k7n3+qHwN
         QRqxvXVHYvwRhbAfYzHS/pXfdGvEka7UtGRYOSvZKy1F4K1Bvh5QX7XKfjeUmkt6JOZA
         LaSE1a5UJfvp9zDrf+UKOMhkueufZf+2fvKmkPYhjNfsbNQAw89zYNLMls8tZokis/Jw
         hkPtYgg6eJkwzPiNHWLRQ/86LtG3x2Q8829KkfQfOjvXIvAjlEBPKU7UuPxKiWX6os2p
         EfEg==
X-Gm-Message-State: AOJu0Yxo4tRTp41t9IE4tLNOTsbHB6W95lwp5GiT2YvEj5ZIZ/zTatl9
	JIQdQ0H+woOGJJUejbibW8hZyBcOyfwzHf3s/QRSCcEF1iOIK870L0zIKNAuulQTMo1R5f5LSa8
	YeuHiaTThp6lQAbiWTV/EdFHNBkA6c/LGzpYO7oJLempnyVojwGmTIJWEXbYEgXl+
X-Gm-Gg: ASbGncvwN5YywD7/DavfjlOeE8XphIm03JQQaMUf5xFHngcAzDXljjjjyaRGroykP7K
	c9gXeDJS/pIfhVOcaskSo7yGREI9TjFLeDIKE1hu9nE/PYak2irKEO+sIi3yMFWLAPlv3FeQXfa
	A/SxdZ+DDmLns3SsFT2lXs9lJ9VHF9vuZFsWaGQziTGzXDKbf6n5xkDEcAIOxEweXyuSrYuOEjO
	gDN4BBnXLKwu4y03W+66cL9NZvOIm99NsP3eJZgaBbQ3nVfkEGF2gyHMsJkSylCRfkYAkMK/pmc
	OJVPefblmACtoiaI99BMJwmuWbi5zQeAnoMj/rl3GwUJCjQ8GTq3XYV53gfmn6iYVPa0mkopKvn
	z3iR+
X-Received: by 2002:a05:6000:64b:b0:3a6:d5fd:4687 with SMTP id ffacd0b85a97d-3a8f482bd31mr1975657f8f.18.1751010982942;
        Fri, 27 Jun 2025 00:56:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFcaHziqQErdzS3zBfEaj9TBNKZzm1QxKyX+r2W+yzOPLLnK2T4/8Tz2nVI+7oJ45W80EdV9Q==
X-Received: by 2002:a05:6000:64b:b0:3a6:d5fd:4687 with SMTP id ffacd0b85a97d-3a8f482bd31mr1975632f8f.18.1751010982567;
        Fri, 27 Jun 2025 00:56:22 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a892e5f44dsm1931370f8f.87.2025.06.27.00.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 00:56:21 -0700 (PDT)
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
Subject: Re: [PATCH v2 5/5] fbdev/simplefb: Add support for interconnect paths
In-Reply-To: <20250623-simple-drm-fb-icc-v2-5-f69b86cd3d7d@fairphone.com>
References: <20250623-simple-drm-fb-icc-v2-0-f69b86cd3d7d@fairphone.com>
 <20250623-simple-drm-fb-icc-v2-5-f69b86cd3d7d@fairphone.com>
Date: Fri, 27 Jun 2025 09:56:20 +0200
Message-ID: <87ldpdd3dn.fsf@minerva.mail-host-address-is-not-set>
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
>  drivers/video/fbdev/simplefb.c | 83 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 83 insertions(+)
>

[...]

> +static void simplefb_detach_icc(void *res)
> +{
> +	struct simplefb_par *par = res;
> +	int i;
> +
> +	for (i = par->icc_count - 1; i >= 0; i--) {
> +		if (!IS_ERR_OR_NULL(par->icc_paths[i]))
> +			icc_put(par->icc_paths[i]);
> +	}
> +}
> +
> +static int simplefb_attach_icc(struct simplefb_par *par,
> +			       struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	int ret, count, i;
> +
> +	count = of_count_phandle_with_args(dev->of_node, "interconnects",
> +							 "#interconnect-cells");
> +	if (count < 0)
> +		return 0;
> +
> +	/* An interconnect path consists of two elements */
> +	if (count % 2) {
> +		dev_err(dev, "invalid interconnects value\n");
> +		return -EINVAL;
> +	}
> +	par->icc_count = count / 2;
> +
> +	par->icc_paths = devm_kcalloc(dev, par->icc_count,
> +				      sizeof(*par->icc_paths),
> +				      GFP_KERNEL);
> +	if (!par->icc_paths)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < par->icc_count; i++) {
> +		par->icc_paths[i] = of_icc_get_by_index(dev, i);
> +		if (IS_ERR_OR_NULL(par->icc_paths[i])) {
> +			ret = PTR_ERR(par->icc_paths[i]);
> +			if (ret == -EPROBE_DEFER)
> +				goto err;
> +			dev_err(dev, "failed to get interconnect path %u: %d\n", i, ret);
> +			continue;
> +		}
> +
> +		ret = icc_set_bw(par->icc_paths[i], 0, UINT_MAX);
> +		if (ret) {
> +			dev_err(dev, "failed to set interconnect bandwidth %u: %d\n", i, ret);
> +			continue;
> +		}
> +	}
> +
> +	return devm_add_action_or_reset(dev, simplefb_detach_icc, par);
> +
> +err:
> +	while (i) {
> +		--i;
> +		if (!IS_ERR_OR_NULL(par->icc_paths[i]))
> +			icc_put(par->icc_paths[i]);
> +	}
> +	return ret;
> +}
> +#else

These two functions contain the same logic that you are using in the
simpledrm driver. I wonder if could be made helpers so that the code
isn't duplicated in both drivers.

But in any case it could be a follow-up of your series I think.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

