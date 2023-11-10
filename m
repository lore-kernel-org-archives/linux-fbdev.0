Return-Path: <linux-fbdev+bounces-4-linux-fbdev=archiver.kernel.org@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 420C4C05021
	for <linux-fbdev@archiver.kernel.org>; Fri, 10 Nov 2023 17:48:47 +0000 (UTC)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAA411C20E0C
	for <linux-fbdev@archiver.kernel.org>; Fri, 10 Nov 2023 17:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F33B38DD6;
	Fri, 10 Nov 2023 17:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BtDnA1vf"
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30603B79A
	for <linux-fbdev@vger.kernel.org>; Fri, 10 Nov 2023 17:46:49 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECBA4328BE
	for <linux-fbdev@vger.kernel.org>; Fri, 10 Nov 2023 04:11:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699618265;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7fCuXz89goAk8Vt7qNUZu+b7kKfusXy0WvYDR11XmRk=;
	b=BtDnA1vfr4LpOiKWP73xgnG7lO91XjkBAmLrqZ6j1LzTc8tJxFLXw2jH8cvbBTAB6v2LLa
	3ocIG6gE59g4ng4AA+QZN+NDaI/LowhE2yRgD6OqBvSQeymmtwckfAOOh9tIyW8dA8+nOD
	KNesiZCjGKI7XB9lQY+QdhZgIuvFG/c=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-571-gVKEyLWVMPaQYwOx_Mo2JQ-1; Fri, 10 Nov 2023 07:11:03 -0500
X-MC-Unique: gVKEyLWVMPaQYwOx_Mo2JQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-408524e2368so12751025e9.0
        for <linux-fbdev@vger.kernel.org>; Fri, 10 Nov 2023 04:11:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699618262; x=1700223062;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7fCuXz89goAk8Vt7qNUZu+b7kKfusXy0WvYDR11XmRk=;
        b=dUr4AECI1EGNEZBhZT4XrxL1+Qk4giBLorz7MrpxSNLJw/PY9uv9iNJdIzA/ZLiWLn
         rn4CWkS/mzS3qew+imE8hnFXWzuaV9FKNBZe3rnmmmOjx93u6dLetzx9dkuRPMh8rz8p
         LcbnVs5QW6r1Qi3k4GEalw+WUYU0P5c2FUX1fwEaCJ/towfNRhw0Mn4e4qtBhGerhej1
         F/uu01E9xstZZ5f+87PDRRyVG7mWgjxP2fomyaoBqFEjZM0xBx9BiV913uVuAQEMPMFx
         Glo2HfzdhW9VJ6cEdtBq8QU7gtRrwH1gOtYZey8cugwY/RaxuZi09E5LTWNvIRiAQTx9
         E4kA==
X-Gm-Message-State: AOJu0YzJ+E8kdezABYyz8xFlLwWDnVzodr9RFKBl1g74Dc8kuDZUEcpW
	lTm8N0V+3/Us2xT2sIQfFp9ofO+0oRB3VZ+/edI5yAMeyU2s8hr9AXSa79A6jCfiU0ltd/k692G
	pV9Ps/o/hgvTGiWa2K71qyVU=
X-Received: by 2002:a05:600c:190d:b0:408:4d0e:68b2 with SMTP id j13-20020a05600c190d00b004084d0e68b2mr6677893wmq.36.1699618262547;
        Fri, 10 Nov 2023 04:11:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHnQ+ojOf2ajiSmBmN3mG/STAgZbDHejKyB0rLbX5CDgW3NWQYnPG6aNRfVTdkRaPHIh/mwvQ==
X-Received: by 2002:a05:600c:190d:b0:408:4d0e:68b2 with SMTP id j13-20020a05600c190d00b004084d0e68b2mr6677880wmq.36.1699618262272;
        Fri, 10 Nov 2023 04:11:02 -0800 (PST)
Received: from localhost ([90.167.86.3])
        by smtp.gmail.com with ESMTPSA id j10-20020a05600c300a00b0040773c69fc0sm4867955wmh.11.2023.11.10.04.11.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 04:11:02 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Lukas Bulwahn <lukas.bulwahn@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Helge Deller
 <deller@gmx.de>, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Cc: Lukas Bulwahn <lukas.bulwahn@gmail.com>,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vgacon: drop IA64 reference in VGA_CONSOLE dependency list
In-Reply-To: <20231110114400.30882-1-lukas.bulwahn@gmail.com>
References: <20231110114400.30882-1-lukas.bulwahn@gmail.com>
Date: Fri, 10 Nov 2023 13:11:00 +0100
Message-ID: <87v8a9ajvv.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lukas Bulwahn <lukas.bulwahn@gmail.com> writes:

> Commit e9e3300b6e77 ("vgacon: rework Kconfig dependencies") turns the
> dependencies into a positive list of supported architectures, which
> includes the IA64 architecture, but in the meantime, this architecture is
> removed in commit cf8e8658100d ("arch: Remove Itanium (IA-64)
> architecture").
>
> Drop the reference to IA64 architecture in the dependency list of the
> VGA_CONSOLE config definition.
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


