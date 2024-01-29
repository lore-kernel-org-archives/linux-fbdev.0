Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810F160DFE
	for <linux-fbdev@vger.kernel.org>; Mon, 29 Jan 2024 11:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706529160; cv=none; b=b4ffifHHLTHaaFquDf5PSE5jLFL/A9YkdYLW+qP3V+IT47E28AuCCCThMaQ10Mq1rcYBOJHpmMWMnylPbJqcealuQSsMVt5N76OiL2SM8RzqVb4NDb/8mzp3f5umyeaC0OMCQ/fHAKNeEB7KEFTGRMHpeclapsSJPFyFR0xHG0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706529160; c=relaxed/simple;
	bh=AHIGyVmc+ESXhHuWhd3Obhywp31Tw0A7jidVMzfPy/k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Zl9txZWNkMs8y+9QwrAMo54XHftzzw34firlG/vETq+zZpLUcvwEG73db+upqNr/ue8NtYocTcckABtrfqK9/JeMx19VzzCITWSpYqX3ENLOBd6OKvI3iQ+BK5ukgIJyHkeoFzjoVjg/rcnfnOb5990QxtcXnXXbNEAA+HbunJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QW4ieqtE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QW4ieqtE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706529157;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=km+vTMTcwLTjSNtEd7zlwVkpw9kPugDzUR1x5Mu9N30=;
	b=QW4ieqtEKwr+TTcOe497kZW9Fu0eOKIk/7Il/EHo2UG8M163oNA/9YViuRkyU1U3JxPPOC
	aRGzwULWlj42Ti3ET4VXONh6ws9lFM4PfMHg3a1sf8e3AVdcvagEDno+CPnIdYac6ckto4
	vcJTFt0afhgbj9pdKwD6xaRwpT8Ts90=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-OMGO4LpCODGABjEPOgpjmg-1; Mon, 29 Jan 2024 06:52:36 -0500
X-MC-Unique: OMGO4LpCODGABjEPOgpjmg-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-40e4caa37f5so26440305e9.0
        for <linux-fbdev@vger.kernel.org>; Mon, 29 Jan 2024 03:52:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706529155; x=1707133955;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=km+vTMTcwLTjSNtEd7zlwVkpw9kPugDzUR1x5Mu9N30=;
        b=oGJe3D0+g14OMC22o++U75jT1J7kDE5pF80on3IhSpJv9yEmNI8BvTpeP8xtiXfbJt
         A84l5cAkhJfluX2JAWHMQfWkU8pfV0gAOEcPTpH6ZH7ssjQZ1fsGRp5/gL7AiAWn6MXe
         qsNa9kMBk3rIGBL9dONm0xKOGXqDmO5rixpFXy4SgPVCjMaKUrSyJqC74c610a78FMUA
         7s6JItumjZk+uTqArHSkhw76mNYlnlX95ZSVYKH4XxPVhpsWUxFu4LxsMJRmchJbiElc
         vnvhy0L+GRlfZXz4BUX97pBQQdHOHpZp3NlGgSA8AmunvUMm8ubpTtUldsh40T5F3Z0x
         Fh/w==
X-Gm-Message-State: AOJu0YzSRKz2AFcgc4zfPP7YmzIII2ItcTl4JSgVkc8oDVITWUQtCiFm
	Qa0O0AosSf/Zqk2jOxCOtAkO0WIrlYOdAtoYRdzHtQkzOa+CmwcFT35NfCRAJJjTL/ZYUqaoP6G
	JEtP3jUPYGcPdJbMnoMtJKB2yyPqQ4wFBk5r0DWI9A+6wja2oF0OSbAbRwjGO
X-Received: by 2002:a05:600c:3c9a:b0:40e:ccf8:7539 with SMTP id bg26-20020a05600c3c9a00b0040eccf87539mr4692026wmb.34.1706529155007;
        Mon, 29 Jan 2024 03:52:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF1tHCYmH4B+lu5im6PSKDlmApxTrUu46qQeJ24E7WbK/DRwXxTWziwLYE+4Th1tNcBlcBHvA==
X-Received: by 2002:a05:600c:3c9a:b0:40e:ccf8:7539 with SMTP id bg26-20020a05600c3c9a00b0040eccf87539mr4692017wmb.34.1706529154742;
        Mon, 29 Jan 2024 03:52:34 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id m3-20020a05600c4f4300b0040e89ade83fsm1940222wmq.1.2024.01.29.03.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 03:52:34 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, pjones@redhat.com,
 deller@gmx.de, ardb@kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, Thomas
 Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 7/8] firmware/sysfb: Update screen_info for relocated
 EFI framebuffers
In-Reply-To: <20240117125527.23324-8-tzimmermann@suse.de>
References: <20240117125527.23324-1-tzimmermann@suse.de>
 <20240117125527.23324-8-tzimmermann@suse.de>
Date: Mon, 29 Jan 2024 12:52:33 +0100
Message-ID: <87fryguzjy.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:

> On ARM PCI systems, the PCI hierarchy might be reconfigured during
> boot and the firmware framebuffer might move as a result of that.
> The values in screen_info will then be invalid.
>
> Work around this problem by tracking the framebuffer's initial
> location before it get relocated; then fix the screen_info state
> between reloaction and creating the firmware framebuffer's device.
>
> This functionality has been lifted from efifb. See the commit message
> of commit 55d728a40d36 ("efi/fb: Avoid reconfiguration of BAR that
> covers the framebuffer") for more information.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

[...]

>  #if defined(CONFIG_PCI)

Shouldn't this be && !defined(CONFIG_X86) ? Or maybe &&
defined(CONFIG_ARM64), although I don't know if the same
also applies to other EFI platforms (e.g: CONFIG_RISCV).

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

