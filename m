Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7547E296169
	for <linux-fbdev@vger.kernel.org>; Fri, 27 Jun 2025 10:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751018822; cv=none; b=iq7Pjmc//YhAPoFBWhkUufxqMWfeuzl7Z+Slqe7bcifYsh/R2GDATjAZw05q9jN++3Rx8TRL/TInriIwz0QfNAEGClDG/IogzXIL7BrqTbjlhiX6U3sJpJqxKcn6ufvy6NaG2erYC5K5oLK1QB/j8BOKrZXvj6iFX7fU77m8SpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751018822; c=relaxed/simple;
	bh=+IXYk0BLsk9VOjPdYK0JSoHlaBQmpqTb5SeExnFFEbc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UdVOhXr+W16R8jtYpUJYSYur2ckKom+DoP7jU6fzt1YhH8BzvVe5RLJR4neHkWXJ+KykOmmyIQb649iRb8zmKhwsXiHwfQ6/EQacNXsunge6hXUBSt327CA0NWLMhXRanfRPizZrAXPOo+qyhMDPDkwqv4MnAKnoSKFl43y/NsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Yw82fjHd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yw82fjHd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751018819;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uYXXAceZfrCUqpQ9OsgNrpmSa7NX1ldTsGlTcQdd5wI=;
	b=Yw82fjHdKZeVJITIOfPoC3f658ALuFkiTfn1kta0ioOv1oCCOvhzfnRHDh/p7hajlWsd0C
	D9445z93h9mOtl9GHX8obN2PhLXtKIZXzQsROqk87cyPrQPvznn9JqfWkhoAIUsf+37jUD
	/0w4anqvXzSzL459ql7xncK21CXniac=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-169-sldUKMH-M0aRkSW3mI2Jaw-1; Fri, 27 Jun 2025 06:06:58 -0400
X-MC-Unique: sldUKMH-M0aRkSW3mI2Jaw-1
X-Mimecast-MFC-AGG-ID: sldUKMH-M0aRkSW3mI2Jaw_1751018817
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4536962204aso7836925e9.3
        for <linux-fbdev@vger.kernel.org>; Fri, 27 Jun 2025 03:06:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751018817; x=1751623617;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uYXXAceZfrCUqpQ9OsgNrpmSa7NX1ldTsGlTcQdd5wI=;
        b=b3REXtcJLT5zJcbAIXP7yKTD0MH6RsfShGbm40ePbc0DuVetXtVaFI+cphnc7PTaQs
         QLC3sp2bA2bLJPP5tx9ZJ0SWIMs36ig89q9YN3sYHnJiljAj4iKmaUuH9azHxH/4Vm61
         LvFiEfSs8Td9vYKB8V0Mz0POl6bbDSDOT4aiVk1A/rl20RlaD65upNVxVgPG3dvzpdFf
         fnRd89Aru3TN5jcX0NmnjC412DMwJzF9olR5XMkQ7n4xqeHqJF4rM0XtYy65RCtqIzo5
         cvvt1c1/+5lCVXCRtmbEkIimpjXxI0Xg2tULGVVpxvtk4rscqkFcuGPvtbqOj0PAmKEj
         ZTYg==
X-Forwarded-Encrypted: i=1; AJvYcCWFt/QdUT71WaANlj+1GsSuScIQ4UTYCgNngwo6DsEKZwzcPxZ7IMV0tLOxEtVcrvs67Y7eNX0CQ7uckw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyAVQGH/4GV7buIO0n2f7SUWf+SCUoZ6peUTw6Ix2JxowELCOLN
	nKrPfrH6tQw82IP6CYdQy3HgeqK08K/frsSV0wrUZ9oXdzXkMShQYNSr62/I7pUxIb2H3FsksI5
	hymEs0RGeh1D44Z00jGNCGJJc/Oz0IdZTrGUYuWKyPXtfjmfFBSd0OCzJ0sDi2zxR
X-Gm-Gg: ASbGnctStSUrlT/Km2QOR5ZxROmcHA5YeqteqVoNshZ2bPLZHjbSIEhCmxuxqqalTSo
	yTyrxHPpPB5tz+lv/kfZgCvqzr77zwlkb2ahWDI5cgGMKBpVe+qRTwmnrz4ldd9gFsJsatxlwVq
	ribNpdMuxpISRG4A18tNGvzTN+0MEkC291lutcO8boHeSya7Vl6EcE4DlERVMqpUCF/SaMCtU+N
	zHZ4ntMZ6mylvlpcD0o3kfyfYmj8RWEDrnqgrKmBLdSM2FvtoBimmy1hCDbby6X50SEf4o9hqLl
	E3Vov98aniMIFHWrsBeWX57qck1+dz2K2ynVIUgIxwJJxnitzn1vjWSZ1w+Z10Prz5meK4XABgM
	Z//ul
X-Received: by 2002:a05:6000:23c8:b0:3a4:eef9:818a with SMTP id ffacd0b85a97d-3a8ff51fb85mr1792631f8f.27.1751018816823;
        Fri, 27 Jun 2025 03:06:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGjPZ2YyzP07UvUHeXF1IowQrFwAxVkZWw/RrEy4ehDzyrnnvfw0IfiYAn/CtAHUzPqxVhAtQ==
X-Received: by 2002:a05:6000:23c8:b0:3a4:eef9:818a with SMTP id ffacd0b85a97d-3a8ff51fb85mr1792609f8f.27.1751018816340;
        Fri, 27 Jun 2025 03:06:56 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a892e5f918sm2247895f8f.100.2025.06.27.03.06.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 03:06:55 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Luca Weiss <luca.weiss@fairphone.com>, Krzysztof Kozlowski
 <krzk@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Helge Deller <deller@gmx.de>,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] dt-bindings: display: simple-framebuffer: Add
 interconnects property
In-Reply-To: <DAX7ZB27SBPV.2Y0I09TVSF3TT@fairphone.com>
References: <20250623-simple-drm-fb-icc-v2-0-f69b86cd3d7d@fairphone.com>
 <20250623-simple-drm-fb-icc-v2-1-f69b86cd3d7d@fairphone.com>
 <20250627-mysterious-optimistic-bird-acaafb@krzk-bin>
 <DAX7ZB27SBPV.2Y0I09TVSF3TT@fairphone.com>
Date: Fri, 27 Jun 2025 12:06:54 +0200
Message-ID: <87o6u9birl.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Luca Weiss" <luca.weiss@fairphone.com> writes:

> Hi Krzysztof,
>
> On Fri Jun 27, 2025 at 10:08 AM CEST, Krzysztof Kozlowski wrote:
>> On Mon, Jun 23, 2025 at 08:44:45AM +0200, Luca Weiss wrote:
>>> Document the interconnects property which is a list of interconnect
>>> paths that is used by the framebuffer and therefore needs to be kept
>>> alive when the framebuffer is being used.
>>> 
>>> Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
>>> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
>>> ---
>>>  Documentation/devicetree/bindings/display/simple-framebuffer.yaml | 3 +++
>>>  1 file changed, 3 insertions(+)
>>> 
>>> diff --git a/Documentation/devicetree/bindings/display/simple-framebuffer.yaml b/Documentation/devicetree/bindings/display/simple-framebuffer.yaml
>>> index 296500f9da05e296dbbeec50ba5186b6b30aaffc..f0fa0ef23d91043dfb2b220c654b80e2e80850cd 100644
>>> --- a/Documentation/devicetree/bindings/display/simple-framebuffer.yaml
>>> +++ b/Documentation/devicetree/bindings/display/simple-framebuffer.yaml
>>> @@ -79,6 +79,9 @@ properties:
>>>    power-domains:
>>>      description: List of power domains used by the framebuffer.
>>>  
>>> +  interconnects:
>>> +    description: List of interconnect paths used by the framebuffer.
>>> +
>>
>> maxItems: 1, or this is not a simple FB anymore. Anything which needs
>> some sort of resources in unknown way is not simple anymore. You need
>> device specific bindings.
>
> The bindings support an arbitrary number of clocks, regulators,
> power-domains. Why should I artificially limit the interconnects to only
> one?
>

I agree with Luca here. There are device specific bindings for the device
specific drivers. But this is about the generic drivers that are able to
scan out using a system provided framebuffer.

The display controller is setup by the firmware but it might need a set
of clocks, power domains, regulators, etc left enabled in order to work.

It's true that the "simple" is a misnomer, probably these drivers should
had been named sysfb and sysfbdrm, or something along those lines.

> The driver code also has that support added in this series.
>
> Regards
> Luca
>
>>
>> Best regards,
>> Krzysztof
>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

