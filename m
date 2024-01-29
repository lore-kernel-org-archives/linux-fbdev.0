Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F9D60241
	for <linux-fbdev@vger.kernel.org>; Mon, 29 Jan 2024 11:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706528169; cv=none; b=jC6sbCIHYa2XsO71LK2tBqA4j+7l5Kkl2aOHD4sH5VzOvMPlc+Axu1lEWTm9g1Rd3rzKYCw96BW6WDgOB1zDZATVYTIPbvE4mFurovKm/tDe+om6rIKEsfTiF+Z7KfNrm1V8Gh9LbKxcJxWlqN8nY9fgQt9h8NKueE1V6b2i2zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706528169; c=relaxed/simple;
	bh=Ut6/AALp3QlJqDlT65c2jiA53D5WM/pTl5ueuu75WpI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EYJFWjYNRD4xf/E7YwuwRf3fZmVGfq0WWdZQHmEuuiFWdHjh0hBS7kcAUbSFfIH/Az9sbYGnfJNmaW3va/mDaE66WlC5rWEb/RVxNt3LFuig2U90cMoEDRG4rNhS3+3tlZgllO+XYA2Khi0aiDyXawglM37V273hzYOKJ6szXrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ioHKdtuP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ioHKdtuP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706528167;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VSwAcK58hM0Z/l1Z5EfYbk6XVvLfJDSNPQjLmOSbPZ4=;
	b=ioHKdtuPg91pyNlo7GuoifUXNFVOPsLWeAI2dPy9OAAuhFqJJT0O9rnyzId9tkhscQ/+PC
	5S5eitSpI9Az1EJ/uaCbHRrY9h+q+7skATdTD835VR51jJ0Ato3an1lef+kYMEdIRKQm1E
	ODlGYRX+dVdPYM8gPcCPLjKqmn7yaJk=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-124-28hEJChJMhyii2VXl5cgvQ-1; Mon, 29 Jan 2024 06:36:05 -0500
X-MC-Unique: 28hEJChJMhyii2VXl5cgvQ-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a35247a5d8cso148177266b.2
        for <linux-fbdev@vger.kernel.org>; Mon, 29 Jan 2024 03:36:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706528164; x=1707132964;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VSwAcK58hM0Z/l1Z5EfYbk6XVvLfJDSNPQjLmOSbPZ4=;
        b=UdRZrqGEB2h8xJ6JiWh0uTBf8S0jqm/Z9TQ7Rr0UaMCngLW5CkpbUfOZxg2Cd1pq+G
         UFs3pEuXpWHq6n2TZM0/PX3QBOXG57DlwOlIF+eFT/H7peMTJ35X0BBGl/JRc+uS2dy3
         DDTyGFs5JexyOfg1YQWjz21I7zKamA68ixz8cWhFXnhB9o4YXtEeV303wSDI9qnokeKx
         Z+5cgF2BVXZZjQ95QF+vOpCExqDmsbqRNrb/lp58nbSiFzDfSf9uLfALWYrfoAvb2cg3
         Ffbot8mAelmXC1v0KYhS2hONlNU4FUNSikzKlttJtKApNQo9VdmUXyylFGw89R3Vqh4H
         /8uw==
X-Gm-Message-State: AOJu0YzPE/pN3tDtoctu4afP/60YWWGWnZFRcj4MEhO9dicEMUTi/IPb
	13Mtiwy91xs3BWNSqK7EKYKAwSIUFLTGiNNMCdZ/LCsQbqBUKtD/rgx9Mt1NaoqNSkqPIN7BsKW
	JtbXvgdcrJv9YxuzjdyuzV08N8AU/cKSg7Vlqn1LjC0yxzcZLBx9ZzGkYIop0
X-Received: by 2002:a17:906:3444:b0:a2f:46c7:4658 with SMTP id d4-20020a170906344400b00a2f46c74658mr4552861ejb.28.1706528164634;
        Mon, 29 Jan 2024 03:36:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFIZpOXEoPwROBF4E9qtZt60pik+8hvS2CQTLnSEDgdwAO5aGeS4xjRq4TaN6UUtSXwOCC1SQ==
X-Received: by 2002:a17:906:3444:b0:a2f:46c7:4658 with SMTP id d4-20020a170906344400b00a2f46c74658mr4552847ejb.28.1706528164306;
        Mon, 29 Jan 2024 03:36:04 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id eg13-20020a056402288d00b0055f02e1e83csm836471edb.21.2024.01.29.03.36.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 03:36:04 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, pjones@redhat.com,
 deller@gmx.de, ardb@kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, Thomas
 Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 5/8] firmware/sysfb: Create firmware device only for
 enabled PCI devices
In-Reply-To: <20240117125527.23324-6-tzimmermann@suse.de>
References: <20240117125527.23324-1-tzimmermann@suse.de>
 <20240117125527.23324-6-tzimmermann@suse.de>
Date: Mon, 29 Jan 2024 12:36:03 +0100
Message-ID: <87le88v0bg.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Test if the firmware framebuffer's parent PCI device, if any, has
> been enabled. If not, the firmware framebuffer is most likely not
> working. Hence, do not create a device for the firmware framebuffer
> on disabled PCI devices.
>
> So far, efifb tracked the status of the PCI parent device internally
> and did not bind if it was disabled. This patch implements the
> functionality for all firmware framebuffers.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

[...]

>  
> +static __init bool sysfb_pci_dev_is_enabled(struct pci_dev *pdev)
> +{
> +#if defined(CONFIG_PCI)
> +	/*
> +	 * TODO: Try to integrate this code into the PCI subsystem
> +	 */
> +	int ret;
> +	u16 command;
> +
> +	ret = pci_read_config_word(pdev, PCI_COMMAND, &command);
> +	if (ret != PCIBIOS_SUCCESSFUL)
> +		return false;
> +	if (!(command & PCI_COMMAND_MEMORY))
> +		return false;
> +	return true;
> +#else
> +	// Getting here without PCI support is probably a bug.
> +	return false;

Should we warn before return in this case ?

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

