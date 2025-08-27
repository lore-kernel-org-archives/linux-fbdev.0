Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com [209.85.208.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F69E33A023
	for <linux-fbdev@vger.kernel.org>; Wed, 27 Aug 2025 08:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756284142; cv=none; b=AfYmrthGK8//kqCEYNLSRL7NE63kn5FCwvRJK2LL6kTElXs3Jxwz/KtUiTl9q/MLtvi4z+PiT9yTqwKExIseF/8ln/to19uaJaJcbQ7CAng0+aTQZ8KHamVykJiDi7proNOdipKYFIi5uy6/iKflC/5i5+tQsHCo5N8wvD5ZFx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756284142; c=relaxed/simple;
	bh=C3J5F98SUq/XbJdI5mkH/BowXWLNgIYkLopDpGLXpXI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=VLANtwyjcDy2x45EzxviIcw5OuajuxFpladUewa/yCRZdc9jWUCAy2/hM8rPjAMt2iLDXv3Z5Ctn5n+XH8b9HjqnNfhkIKKjjDFTYSypmrljo672TMV/HzwriHXKvN2U5SE51l70psz5W6u0Nqms4wpZYmzyAlCuLiQOoBR8SV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=eEc25c3x; arc=none smtp.client-ip=209.85.208.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="eEc25c3x"
Received: by mail-ed1-f66.google.com with SMTP id 4fb4d7f45d1cf-61c325a4d18so7176005a12.0
        for <linux-fbdev@vger.kernel.org>; Wed, 27 Aug 2025 01:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1756284138; x=1756888938; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ru399StOWX0y3ow8u4rjjmb8WPAPqnIEt4F7fasIcxE=;
        b=eEc25c3x5PXcT1AHnb/dd/pK0kjfUbP9sm+mbeau8SUzBSmQAFsDjgICcXFHWkCasF
         CEJRrex62BkT3As7pW65RpznQk6trJexK/QcyJPPoaxomyHKKkjI/PNbOVGnmpfIb8BH
         auofQ2V/WJi55gqWSb06bITRix7V0pbcrxchJES+jYAlAMh7kqyspAC73bam1RKcYucG
         w2IoXhXz6KB27jTSfHXmQjFsBR7lfDjWp+Rgr3EPkrPa1QzLnoYo0DRGdV1Pke367wS9
         VYUFYGGOudjo4onhgVI1wDgcO3esXjZMRoVbSaszfYkj2zM+nQvbOdgN2nGDIl0cavoK
         KEOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756284138; x=1756888938;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ru399StOWX0y3ow8u4rjjmb8WPAPqnIEt4F7fasIcxE=;
        b=k3kLzePcXNtWGj6SN8/+YI2WkJ5EQj5IDK+u8lGrEi/qNXzA1mt6DZWqmANqBMuZXs
         CHrswS4KkIz/Jq2Za+CUcFeVVYdvwX8z9rPwbrDzOBgv4QRqXErmCvPADlZnCgDK3v2v
         pCcIhkfnZ7UZRm/suqtjG9180SdmCLpzK64rOcxbbNJP9rpFvRElFwDx3/gTKDiZ3VpE
         5Z4fqrnlDbiOKEXo/A+LAmkOLqSc3xBWVc/OAmtkoaHuV3SGbVcj2X00dqcfdwYlNhK6
         4m/UVz7JBQmDn7Kf32PdfcfEbKZrKiM3Wx7xvKbGi/SRBsb2OGAAV3jwN7VI9EVaK+RH
         X4Wg==
X-Gm-Message-State: AOJu0Yxk2LB9yuwXUXIafzA4B3Z1JEq0s9+cajYYedI6ziYXxJKTPoij
	LU8AtQcJTYrCs1U2azHOWcqtQKFh7gDqIkXyYlEq607RpTffoBwajH3fdD+tUDvL6kE=
X-Gm-Gg: ASbGncsWf3LoDAUjhj3DoAgE9W2OJzVInosDMicT/rHBXd6ylCBPjbv2/I772aPZGSZ
	XGthTn+up3qMy9YStGqIhElzaL5nITWLWQ6bepiwiH0nnZvhozXo6w/C8gQzPc7OR8zKxg2HVrw
	G41lDtD42JjhxnXIAepPl5OLyboNUwSNPtWSTO4TUDVITsOs1Pqq0pJyjtxGCZGH2Q0DLdxl28Z
	/WE3S9m8WCiMH+v3rCDyBIlGebeKLzIn64vKYpxvfDvQjOUXNFv8xDkMdmSMugr8aFDEkJq3Qtg
	lbfiZcQc+e+v8nb8ePPrKLfEH5mGr641vGtgEhIKxlgDTvAuN0AxJmz85syBPG2LFDYwGCRcLp2
	wFoHW9aSGHBao7L3C+XYFSvXrK3NgfMs33TgPD7E31HIVC9jsZ04T4qKcg5Q=
X-Google-Smtp-Source: AGHT+IE7qHCUmyrseOQu74QlBZCIEPNa9QZI/28Loh0vgbPoaePjhaimKbaEW3VRUGcYdoYW86lRtw==
X-Received: by 2002:a05:6402:2554:b0:61c:5d76:3a8b with SMTP id 4fb4d7f45d1cf-61c5d7640b7mr8937360a12.32.1756284137573;
        Wed, 27 Aug 2025 01:42:17 -0700 (PDT)
Received: from localhost ([213.244.170.152])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61caeb5e77bsm1411780a12.35.2025.08.27.01.42.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Aug 2025 01:42:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 27 Aug 2025 10:42:16 +0200
Message-Id: <DCD2RLZO62P6.MNAOWRUWVFHK@fairphone.com>
Subject: Re: [PATCH v2 3/5] drm/sysfb: simpledrm: Add support for
 interconnect paths
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Javier Martinez Canillas" <javierm@redhat.com>, "Hans de Goede"
 <hdegoede@redhat.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Rob Herring"
 <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, "Helge Deller" <deller@gmx.de>
Cc: <linux-fbdev@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250623-simple-drm-fb-icc-v2-0-f69b86cd3d7d@fairphone.com>
 <20250623-simple-drm-fb-icc-v2-3-f69b86cd3d7d@fairphone.com>
 <87qzz5d3le.fsf@minerva.mail-host-address-is-not-set>
 <DB9237QHOXRU.JRJB8SPUX8RO@fairphone.com>
 <874ivjf5gn.fsf@minerva.mail-host-address-is-not-set>
In-Reply-To: <874ivjf5gn.fsf@minerva.mail-host-address-is-not-set>

Hi Javier,

On Fri Jul 11, 2025 at 11:21 AM CEST, Javier Martinez Canillas wrote:
> "Luca Weiss" <luca.weiss@fairphone.com> writes:
>
> Hello Luca,
>
>> Hi Javier,
>>
>> On Fri Jun 27, 2025 at 9:51 AM CEST, Javier Martinez Canillas wrote:
>
> [...]
>
>>>> +static int simpledrm_device_attach_icc(struct simpledrm_device *sdev)
>>>> +{
>>>> +	struct device *dev =3D sdev->sysfb.dev.dev;
>>>> +	int ret, count, i;
>>>> +
>>>> +	count =3D of_count_phandle_with_args(dev->of_node, "interconnects",
>>>> +							 "#interconnect-cells");
>>>> +	if (count < 0)
>>>> +		return 0;
>>>> +
>
> You are already checking here the number of interconnects phandlers. IIUC
> this should return -ENOENT if there's no "interconects" property and your
> logic returns success in that case.

We shouldn't error out in case there's no interconnects defined for this
simple-framebuffer though? That'd break all other usages of it?

>
> [...]
>
>>>
>>> You could use dev_err_probe() instead that already handles the -EPROBE_=
DEFER
>>> case and also will get this message in the /sys/kernel/debug/devices_de=
ferred
>>> debugfs entry, as the reason why the probe deferral happened.
>>
>> Not quite sure how to implement dev_err_probe, but I think this should
>> be quite okay?
>>
>
> And of_icc_get_by_index() should only return NULL if CONFIG_INTERCONNECT
> is disabled but you have ifdef guards already for this so it should not
> happen.
>
>> 		if (IS_ERR_OR_NULL(sdev->icc_paths[i])) {
>
> Then here you could just do a IS_ERR() check and not care about being NUL=
L.

But checking also for NULL shouldn't hurt either, in case the compile
guards get removed in the future or something?

Quote:
> * Return: icc_path pointer on success or ERR_PTR() on error. NULL is retu=
rned
> * when the API is disabled or the "interconnects" DT property is missing.



>
>> 			ret =3D dev_err_probe(dev, PTR_ERR(sdev->icc_paths[i]),
>> 				      "failed to get interconnect path %u\n", i);
>> 			if (ret =3D=3D -EPROBE_DEFER)
>> 				goto err;
>
> Why you only want to put the icc_paths get for the probe deferral case? I
> think that you want to do it for any error?

This is the same logic as e.g. for the regulator code in simpledrm. The
idea seems to be that in case some regulator (or here interconnect)
doesn't probe correctly, we still try anyways. Just for EPROBE_DEFER we
defer and wait until the supplier is available.

So defer -> defer simpledrm probe
So error -> ignore error and continue probe

>
>> 			continue;
>
> I'm not sure why you need this?

For the above behavior.

I guess there were some original design decisions behind handling it
this way, so I don't see a reason to handle it differently for
interconnects.

>
>> 		}
>>
>> That would still keep the current behavior for defer vs permanent error
>> while printing when necessary and having it for devices_deferred for the
>> defer case.
>>
>
> As mentioned I still don't understand why you want the error path to only
> be called for probe deferral. I would had thought that any failure to get
> an interconnect would led to an error and cleanup.

See above.

Regards
Luca

>
>> Not sure what the difference between drm_err and dev_err are, but I
>> trust you on that.
>>
>
> The drm_err() adds DRM specific info but IMO the dev_err_probe() is bette=
r
> to avoid printing errors in case of probe deferral and also to have it in
> the devices_deferred debugfs entry.

