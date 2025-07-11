Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFAB4279DC2
	for <linux-fbdev@vger.kernel.org>; Fri, 11 Jul 2025 09:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752225697; cv=none; b=agH0IwfYJhRvVbCIRviOWecmu7iQo6GhFBRHsyxGAyw0cqDWcFhOBRuZzfSbii9KQwj4LbccgJVjON7Mgs8RBOOGuPccWv2cKpbIBcKbA3q0N6J9Cf6u6FGgiE9IwjLb4JBC+ADuqHPMqivBgeZX5Ip7dpLQ3sL8DgyHMUYI9y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752225697; c=relaxed/simple;
	bh=J1+gY7OYN0kPR3TnuQRjcQzBegXWzAAyK2wtVtceRZU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BadTxuZTbMSUBsykFZ+4D2q9wP9iVKKW9W/LQYwK8PVe6Xw1cCJ2R+7MVIp5fRDoBklpCrxiVafva3Sd0oGNNoeimXzNHkChujkgLxDkyQEzXEKk/ccPDlGGvw/QLAqIbW+LXBAHCyXlc8b76jMQFfR8L1msGleT2+Fd3seMnwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MkX37sg/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MkX37sg/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752225693;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S0JDyIunfR5DTlK8KTu+Yf5amiLX77lLqYYzQS582qg=;
	b=MkX37sg/eL7Rmq+vbc3JTTudFR+OxxqGRpFqnX2iFIu6VLKogUCn4A3Msgai0dYO6o8Gr5
	HaMjpmMGzZuDwF7kWEI8MLIC1LQdfn4K/2VbgwYTYt8rtvtb8e6yS2Wvt6PfwGWNZxJgiI
	5L8SJ01BDzcV2Cxhff5bZpkVz6jdoCc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-44-PNcA419eMzinTpBUK-Zoiw-1; Fri, 11 Jul 2025 05:21:32 -0400
X-MC-Unique: PNcA419eMzinTpBUK-Zoiw-1
X-Mimecast-MFC-AGG-ID: PNcA419eMzinTpBUK-Zoiw_1752225691
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-451d2037f1eso11894015e9.0
        for <linux-fbdev@vger.kernel.org>; Fri, 11 Jul 2025 02:21:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752225690; x=1752830490;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S0JDyIunfR5DTlK8KTu+Yf5amiLX77lLqYYzQS582qg=;
        b=oBzpowFvxJbysFm+BpjQrthldYe3MTJ59KODQrVnQ3rmKShd61t3Q81y8zJvnIfT/X
         ObRcZyIB+cCizCJIEKfyq86Yn1yC/MF9kiF3MJ+vdeSVQNzs5tSrYn0FHvF4JYczTxvY
         79R4j2D2Pto16MsTfp3zguxyPCAgZYdUTdtsISP0IUjN1MzUho5pI1u0uL8qzrLbMn01
         X8qYWtM8aLEEdbFJSDVOHyIPitCH69Tvs3bh5rwqNHB1JgfErj48nnsCuKN5QUiVi9I+
         YjUGvm+pZ6d4do5SNJFCjoJQtkopUs5VzDwVCgs9gdm9fvGfCEOWl0g+nzmQc9Ghl9pm
         QLRQ==
X-Gm-Message-State: AOJu0YyGoSQ/LCR+JsKebXYNENOLwpl6diJa68hucaAEWHmDf8YCzDaQ
	Ffgc+zLSg6kO5PArked+YpD+R+ZkclP92V/5T+ChIkLigD/yekxRYXR9LW+hhyTlw22PK1BigAk
	NZzZVmfQcHTKU6p6C3u9JuKqtwh9vuJKkamD6sIJ+XaD1rYD3jTOUpbrMoFXWQMZU
X-Gm-Gg: ASbGncuPy1x9ZyK+GySauZtLR2WXRA6tbPSihRw7bcye2UL95cu07Bepr5OMPn3pHqy
	HWuFrGDczy4k9ezqKaFhWxnhUD069psXUAqcoAf+Cn6LyfVW8pY1LQZFgDY/N9c2C9ICY/3cvLl
	umFVtbkcdQ+LfE37MVsK16+uOcf56IwME45AWHcK3nLVPqKtNsOMfIw0ndLQDPXhW6M2DZRICQE
	iqBXv5pSN7NYh2v0MIyzcGPjWOfNMZ3csjOs9JJ56P3h33EfIhQOP9Xluwey+MVc+eJagkAkoim
	wV10EXKfL/eptQgII5gS6NR2ybbtBP1BBFZ0UdN7bFlEaOJvEG8jNL/5skamE0tTrYN0b8RSdv9
	4GsnD4Nxn5Bo/hmpyoXef5Q==
X-Received: by 2002:a05:600c:4fc7:b0:450:d568:909b with SMTP id 5b1f17b1804b1-454ec14848amr22904775e9.14.1752225690320;
        Fri, 11 Jul 2025 02:21:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHopr/bZIg6PNEafq2nN27RiUQenQ7qTkGeKlIozsRqo7Tj0VZVvTn0sX8s4NUjyeT3MpW78Q==
X-Received: by 2002:a05:600c:4fc7:b0:450:d568:909b with SMTP id 5b1f17b1804b1-454ec14848amr22904355e9.14.1752225689892;
        Fri, 11 Jul 2025 02:21:29 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454dd537d12sm41439605e9.24.2025.07.11.02.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 02:21:29 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Luca Weiss <luca.weiss@fairphone.com>, Hans de Goede
 <hdegoede@redhat.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/5] drm/sysfb: simpledrm: Add support for
 interconnect paths
In-Reply-To: <DB9237QHOXRU.JRJB8SPUX8RO@fairphone.com>
References: <20250623-simple-drm-fb-icc-v2-0-f69b86cd3d7d@fairphone.com>
 <20250623-simple-drm-fb-icc-v2-3-f69b86cd3d7d@fairphone.com>
 <87qzz5d3le.fsf@minerva.mail-host-address-is-not-set>
 <DB9237QHOXRU.JRJB8SPUX8RO@fairphone.com>
Date: Fri, 11 Jul 2025 11:21:28 +0200
Message-ID: <874ivjf5gn.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Luca Weiss" <luca.weiss@fairphone.com> writes:

Hello Luca,

> Hi Javier,
>
> On Fri Jun 27, 2025 at 9:51 AM CEST, Javier Martinez Canillas wrote:

[...]

>>> +static int simpledrm_device_attach_icc(struct simpledrm_device *sdev)
>>> +{
>>> +	struct device *dev = sdev->sysfb.dev.dev;
>>> +	int ret, count, i;
>>> +
>>> +	count = of_count_phandle_with_args(dev->of_node, "interconnects",
>>> +							 "#interconnect-cells");
>>> +	if (count < 0)
>>> +		return 0;
>>> +

You are already checking here the number of interconnects phandlers. IIUC
this should return -ENOENT if there's no "interconects" property and your
logic returns success in that case.

[...]

>>
>> You could use dev_err_probe() instead that already handles the -EPROBE_DEFER
>> case and also will get this message in the /sys/kernel/debug/devices_deferred
>> debugfs entry, as the reason why the probe deferral happened.
>
> Not quite sure how to implement dev_err_probe, but I think this should
> be quite okay?
>

And of_icc_get_by_index() should only return NULL if CONFIG_INTERCONNECT
is disabled but you have ifdef guards already for this so it should not
happen.

> 		if (IS_ERR_OR_NULL(sdev->icc_paths[i])) {

Then here you could just do a IS_ERR() check and not care about being NULL.

> 			ret = dev_err_probe(dev, PTR_ERR(sdev->icc_paths[i]),
> 				      "failed to get interconnect path %u\n", i);
> 			if (ret == -EPROBE_DEFER)
> 				goto err;

Why you only want to put the icc_paths get for the probe deferral case? I
think that you want to do it for any error?

> 			continue;

I'm not sure why you need this?

> 		}
>
> That would still keep the current behavior for defer vs permanent error
> while printing when necessary and having it for devices_deferred for the
> defer case.
>

As mentioned I still don't understand why you want the error path to only
be called for probe deferral. I would had thought that any failure to get
an interconnect would led to an error and cleanup.

> Not sure what the difference between drm_err and dev_err are, but I
> trust you on that.
>

The drm_err() adds DRM specific info but IMO the dev_err_probe() is better
to avoid printing errors in case of probe deferral and also to have it in
the devices_deferred debugfs entry.

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

