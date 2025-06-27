Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748CE294A1A
	for <linux-fbdev@vger.kernel.org>; Fri, 27 Jun 2025 09:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751017874; cv=none; b=qUnCXfjwH+MlVM8e9wVDd+9g6F8fT+PBWiAZzz+oX/LbAmY6ab+sHNKFS7s+DtxUkodH4MZq0booQnUw+1tTjSI8QA3LgFgM/aY04UqunXUGO5RTUJse44EO3IlScdpaKK/D86G6gnaDkJIVhfHrovSxa9Ti/TuTMI2q7fpOOJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751017874; c=relaxed/simple;
	bh=aWKcXpIWktZltEWw9bV+4dTcFYdfkePr8vQGnsvS0L8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=M3InwbwAywonh4/T2vs0JTSmTxnY6Mkw/lTCXfzosafo3baTlzklzLN7mV1zP2RaZk29hXamqL0YmL3DKfWZzGvX8dCg8m5BrGdd1Zg0OLx8IF05FSgUcynIe3dVcnTCdRvbrmEh2vCX1JgnvGc0LsG7NgHdNRkf8LCUUQKIfC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=b+s3++zS; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="b+s3++zS"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-60c3aafae23so6537536a12.1
        for <linux-fbdev@vger.kernel.org>; Fri, 27 Jun 2025 02:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1751017871; x=1751622671; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TAKHP6eBszL2hrHuqZ8PH7OxIF1g8NegvI8NrbNa5H4=;
        b=b+s3++zSepQ4S4cYgIbhk7yjxvsm6zEP77GL9A0UtH191upGTtno6/LVyRd7nsOcGX
         jcUx7PmJ752d5E59djEVPIAGTt6+JozAXSRKUqMYpFwTUVH3N7xkACYM481s5BDiWoSj
         aROfGSbvsQOtth9mA/4+VxiAn9QF7oQ++ZFcNbPMeVqr0RIwXajdIAbQxgIYxf5FiEQX
         JMRph+JlXaDwRm9+wWRCkGkMl1qXtXbAWRAUZR5josbCHvK43e1MeZcTBWuea5EmFfjt
         WZB6+sBAJAKx7+qc0xXz/K2IY0Z3CDPz8YpoJh2A59Y+WpE2ugj64uli5JkzbafwO42J
         eYQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751017871; x=1751622671;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TAKHP6eBszL2hrHuqZ8PH7OxIF1g8NegvI8NrbNa5H4=;
        b=d4t8Vt8Lu47qX5Jd8vhtb0WRPPRknFl0zYQh74UzbA7nL5ZlE8Lnn0GV5WxA+Xv8+7
         5e7ko4wB9NlVyQJzy+mZxqXphZGR/Weikn8fVEoEmyLDH/lMMRo3usupsNurf/BwUVs6
         3sMCvqd6U/+bS3YgMeT/YPQq8piTgdzQ+UR8+L3wwEYloZdGD3sETK+1PwfNYVqSZCxK
         c7HIeikzgu8qOq0U0VkrpS9vAwbuaA3WLXTK0liHPPig0vNSyyfV275i2rL4Ys8SYFaW
         pErAeGrPyJSIFyr9//Sf3QS9o/NZboj/VUAYApo/CGfbqhNvHjWyoUfNtI9ai03wsdzS
         4AYw==
X-Gm-Message-State: AOJu0Yz6DosYXfPEGrkqlpmcH5OYv1xzlAEs/VOY7M26VN3fHahWTAtn
	w2+H79gAD8dap8yE2TYKASgWoeqRTwipShWU99njvTOMm5IKibXX0N5VCGAqxlm71eM=
X-Gm-Gg: ASbGnctg26Tf+RRMqrV7jUsjEVSenLVrN0qCie1GMe/V9h8cA5ekz903cD9qnrcSnNJ
	3oUlktrgsZIuEBh0Ma/oLAkIJUgN1p5sQcl+29ViWbDQnP0KOjW9jVo4QMYaa44lNNJrVWthQFi
	GKXYwXXrol1Os0Zxm22IpgNDiDGpnJoZc1kc+L6ip5B4AtywZu0FVZyyZPQzRaOh2/RNHu6OPUY
	A7EEQL71S0L1Pna3Z2uqfeQPZxogAK773GTK/SKQQvwq3VYEoINd5p+EJDJel2dF1c+5C0z1qAe
	ZMR6n3jeKJgkCaP5601iKF3qel1lML6cRZQxfmPtRc86hO5xqjhX3hMQ0muO+SBeO/mOE9vkPNF
	WlXG/3HojPXSPaW9AzkA/UDzoAyppUGeHuf1w6qAKTQ==
X-Google-Smtp-Source: AGHT+IE99Ck1XKmW0mBEtookC0EaO8U9aF4JHALURpPgmU1+B2UobnemydphVmXY2CO9mnSZo3zaVg==
X-Received: by 2002:a17:907:940d:b0:ae0:da61:71fc with SMTP id a640c23a62f3a-ae0da617483mr523043866b.10.1751017870669;
        Fri, 27 Jun 2025 02:51:10 -0700 (PDT)
Received: from localhost (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae35417b9d8sm91937666b.184.2025.06.27.02.51.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jun 2025 02:51:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 27 Jun 2025 11:51:09 +0200
Message-Id: <DAX814DZF6AT.31N8TZWL5LMDT@fairphone.com>
Cc: <linux-fbdev@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 5/5] fbdev/simplefb: Add support for interconnect
 paths
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Javier Martinez Canillas" <javierm@redhat.com>, "Hans de Goede"
 <hdegoede@redhat.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Rob Herring"
 <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, "Helge Deller" <deller@gmx.de>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250623-simple-drm-fb-icc-v2-0-f69b86cd3d7d@fairphone.com>
 <20250623-simple-drm-fb-icc-v2-5-f69b86cd3d7d@fairphone.com>
 <87ldpdd3dn.fsf@minerva.mail-host-address-is-not-set>
In-Reply-To: <87ldpdd3dn.fsf@minerva.mail-host-address-is-not-set>

On Fri Jun 27, 2025 at 9:56 AM CEST, Javier Martinez Canillas wrote:
> Luca Weiss <luca.weiss@fairphone.com> writes:
>
>> Some devices might require keeping an interconnect path alive so that
>> the framebuffer continues working. Add support for that by setting the
>> bandwidth requirements appropriately for all provided interconnect
>> paths.
>>
>> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
>> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
>> ---
>>  drivers/video/fbdev/simplefb.c | 83 +++++++++++++++++++++++++++++++++++=
+++++++
>>  1 file changed, 83 insertions(+)
>>
>
> [...]
>
>> +static void simplefb_detach_icc(void *res)
>> +{
>> +	struct simplefb_par *par =3D res;
>> +	int i;
>> +
>> +	for (i =3D par->icc_count - 1; i >=3D 0; i--) {
>> +		if (!IS_ERR_OR_NULL(par->icc_paths[i]))
>> +			icc_put(par->icc_paths[i]);
>> +	}
>> +}
>> +
>> +static int simplefb_attach_icc(struct simplefb_par *par,
>> +			       struct platform_device *pdev)
>> +{
>> +	struct device *dev =3D &pdev->dev;
>> +	int ret, count, i;
>> +
>> +	count =3D of_count_phandle_with_args(dev->of_node, "interconnects",
>> +							 "#interconnect-cells");
>> +	if (count < 0)
>> +		return 0;
>> +
>> +	/* An interconnect path consists of two elements */
>> +	if (count % 2) {
>> +		dev_err(dev, "invalid interconnects value\n");
>> +		return -EINVAL;
>> +	}
>> +	par->icc_count =3D count / 2;
>> +
>> +	par->icc_paths =3D devm_kcalloc(dev, par->icc_count,
>> +				      sizeof(*par->icc_paths),
>> +				      GFP_KERNEL);
>> +	if (!par->icc_paths)
>> +		return -ENOMEM;
>> +
>> +	for (i =3D 0; i < par->icc_count; i++) {
>> +		par->icc_paths[i] =3D of_icc_get_by_index(dev, i);
>> +		if (IS_ERR_OR_NULL(par->icc_paths[i])) {
>> +			ret =3D PTR_ERR(par->icc_paths[i]);
>> +			if (ret =3D=3D -EPROBE_DEFER)
>> +				goto err;
>> +			dev_err(dev, "failed to get interconnect path %u: %d\n", i, ret);
>> +			continue;
>> +		}
>> +
>> +		ret =3D icc_set_bw(par->icc_paths[i], 0, UINT_MAX);
>> +		if (ret) {
>> +			dev_err(dev, "failed to set interconnect bandwidth %u: %d\n", i, ret=
);
>> +			continue;
>> +		}
>> +	}
>> +
>> +	return devm_add_action_or_reset(dev, simplefb_detach_icc, par);
>> +
>> +err:
>> +	while (i) {
>> +		--i;
>> +		if (!IS_ERR_OR_NULL(par->icc_paths[i]))
>> +			icc_put(par->icc_paths[i]);
>> +	}
>> +	return ret;
>> +}
>> +#else
>
> These two functions contain the same logic that you are using in the
> simpledrm driver. I wonder if could be made helpers so that the code
> isn't duplicated in both drivers.

I believe most resource handling code (clocks, regulators,
power-domains, plus now interconnect) should be pretty generic between
the two.

>
> But in any case it could be a follow-up of your series I think.

To be fair, I don't think I'll work on this, I've got plenty of Qualcomm
SoC-specific bits to work on :)

Regards
Luca

>
> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

