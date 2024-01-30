Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C46765BC3
	for <linux-fbdev@vger.kernel.org>; Tue, 30 Jan 2024 10:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706610237; cv=none; b=Mf3K5pk0JVVytT6V2uXkUW1qvo62vlbtNH8xdpkyDR6mcWZr4W58r9sjituGMH5/hnQFedLjFGsbCY3UfmvAVYryF/0i5MXKz+HiN+/lZwM5wr7fEU5woU7NaXeK/3xjQPv0IVOHeC554LduOBPUEZ5MpD0WJigu29pEyCb63vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706610237; c=relaxed/simple;
	bh=V33WuqeNSSZiEnAUBIIEPNvVHm80UNGC12ozs7ygRP8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ulAoAD7pjOjbP6M6Mix5j8XTiEoPgVr/RX/1Cz6Axjc/FceZksnAJU+FlbA1JjNjWmLwydQF69jRBjjod1n1Kr9Z/Sj8Nf70r9af8B4YOSOgj8lxHfDRQSRT7/Nlp5x7xpM+CQUgKFIdzJXrrAIQNeuJ9MK5ipuwHY4/HePYYRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PF3niMba; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PF3niMba"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706610234;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jt4gc9cNMGeGEZd3+mcsp9v3Xj41BvVXchDqDl7Wcr8=;
	b=PF3niMbaSF87Eu9H6KNcUuFTiiLdHjOW/Lda7yruCIqERod0p4HuhP0QwFt6pjaYdInl/Z
	s4bIZTc1nZefFg4dd4dilhTYtzwdtIb4osjVWUM6wIT8WO5rMAbqDRCDMjN7P5T0dGN4U2
	L5hoMpunhVOxTLz7aIiL9sKGgXgvWH8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-374-MbUa0GhQNxiCLf43Mf5VhQ-1; Tue, 30 Jan 2024 05:23:53 -0500
X-MC-Unique: MbUa0GhQNxiCLf43Mf5VhQ-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-33afdb0eb4fso56140f8f.2
        for <linux-fbdev@vger.kernel.org>; Tue, 30 Jan 2024 02:23:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706610231; x=1707215031;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jt4gc9cNMGeGEZd3+mcsp9v3Xj41BvVXchDqDl7Wcr8=;
        b=Pr3GfkwlyRt6qTQQ7x7Eh5bkzaDIgg/DoKgJCvB3DltybK9hXzxf5FEHmBK+XmqJJw
         2gJ0e4N0OIkCbcr3c5EcxT/GVeWjVDNKWlRADNX+v0XMa1RxovApgDdXEZdDarV3+Hhk
         /LHlO9afs2K0rwUdBnFGl7oP41qaBesQ3bS1ACj2D3u6Ct2DacYCNV49RvCa/xfdV/iM
         1F3LfBEUYj7pwRSAWZe29b6lGVJTZRfYsPB1a0NVd37PIcugo4RDd5/r+E2qHZ49jtNd
         clY9W7tmr0x/5FPi2ddfdq2gL17Fv6OpSvTqm4xjB7PktLEoeSRG67Pp1M5LNg9kgroc
         qxsQ==
X-Gm-Message-State: AOJu0YxroSUJvI35CLUwScpb6/V0UGAgDnTTEP2TB+dH09Q8VfT2njDg
	Ub3LAqeOe5sa5iNtUAmF3x2qpNRlsGxPvLHQhzSsLH/nOv88j5uyfGgdd5HFmZpoqN2TCDkFFkT
	8uj9DL3Pj/uDwcOF4yZIHYSNyoB1FbEJoVrqO4qOfM+tpPB5UMisAhv1xYh5jYPK9vqVO
X-Received: by 2002:adf:ead2:0:b0:337:c730:d7e3 with SMTP id o18-20020adfead2000000b00337c730d7e3mr5555570wrn.57.1706610231614;
        Tue, 30 Jan 2024 02:23:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF70eoaY+VIa4GGUoctQafkQSI2W9UAxj/xfOjdA+e8CALa0W7RU/iiJwjoHpdQk0U/hsjOhw==
X-Received: by 2002:adf:ead2:0:b0:337:c730:d7e3 with SMTP id o18-20020adfead2000000b00337c730d7e3mr5555558wrn.57.1706610231331;
        Tue, 30 Jan 2024 02:23:51 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id bu9-20020a056000078900b0033af35a024csm3694820wrb.12.2024.01.30.02.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 02:23:51 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, pjones@redhat.com,
 deller@gmx.de, ardb@kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH 2/8] video: Provide screen_info_get_pci_dev() to find
 screen_info's PCI device
In-Reply-To: <7c33dd4c-d178-4b46-b859-f228391e4d44@suse.de>
References: <20240117125527.23324-1-tzimmermann@suse.de>
 <20240117125527.23324-3-tzimmermann@suse.de>
 <87ttmwv1ry.fsf@minerva.mail-host-address-is-not-set>
 <7c33dd4c-d178-4b46-b859-f228391e4d44@suse.de>
Date: Tue, 30 Jan 2024 11:23:50 +0100
Message-ID: <877cjrunk9.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Hi
>
> Am 29.01.24 um 12:04 schrieb Javier Martinez Canillas:
>> Thomas Zimmermann <tzimmermann@suse.de> writes:
>> 
>>> Add screen_info_get_pci_dev() to find the PCI device of an instance
>>> of screen_info. Does nothing on systems without PCI bus.
>>>
>>> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
>>> ---
>> 
>> [...]
>> 
>>> +struct pci_dev *screen_info_pci_dev(const struct screen_info *si)
>>> +{
>>> +	struct resource res[SCREEN_INFO_MAX_RESOURCES];
>>> +	size_t i, numres;
>>> +	int ret;
>>> +
>>> +	ret = screen_info_resources(si, res, ARRAY_SIZE(res));
>>> +	if (ret < 0)
>>> +		return ERR_PTR(ret);
>>> +	numres = ret;
>>> +
>> 
>> I would just drop the ret variable and assign the screen_info_resources()
>> return value to numres. I think that makes the code easier to follow.
>
> The value of ret could be an errno code. We would effectively return 
> NULL for errors. And I just noticed that the function docs imply this. 
> But NULL is also a valid value if there is no PCI device. I'd prefer to 
> keep the errno-pointer around.
>

Yes. I meant making numres an int instead of size_t (SCREEN_INFO_MAX_RESOURCES
is only 3 after all). That way you could just return ERR_PTR(numres) if is < 0.

No strong preference, just think that the code is easier to read in that case.

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

