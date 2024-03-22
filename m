Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8FB3B2A4
	for <linux-fbdev@vger.kernel.org>; Fri, 22 Mar 2024 10:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711104221; cv=none; b=hzPvMFgcofjeFNgiNHZeltx4S53C7fXvOZkVBPmT9FNPom+yJv6xPzUMHE7hWhqAERlT3znUDK10m6KN45en3b/I8DlU4aayu1R5Pu+kjviE6+glUEjI3LNRQZzSLMLOwkPw1U+dIRrqqwn4vV+/7rtZxYDJU5eBccO0Z+kJhfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711104221; c=relaxed/simple;
	bh=S8Z7aChjuflwNhwZ9CR9vs1643uDXcQF3L3Qw+I+IUk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lHcNSQbFGks055bEOtdEqVcmHojMYNh5A+Y89Sskip7nf42+SJiwKYyRQVBtkaXuODNgC96112QWfeUqeWHzQrtn/xV55s8HexvJD4Dv8cCTg6rDkBoaRI3G8TZJJZ8U5VPAYleBeqg539+CCCOZoysWw2B3wxkUqQkPaq5+XfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cOf7Awtl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cOf7Awtl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711104218;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e4hqr5sqga/uu4OSt9i/tA6ZdLVrKguR4cLu3EI2g3Y=;
	b=cOf7Awtlm66/grHI/GtbzfU3c1FKuTshw8yAvxFfro6uWZREYmkxt1oRD8q51PyqLfwfBB
	RYFNEeHcdkFTPqyn/tARoplktR+5lxjr2No1pZzu0sEMnbF/vwu+AAolUqH2fbO602EEpV
	fG5nxqQuG0CpiTSXZm9DVZJzvDHPAGE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-538-s4uGTBPdOIes_AG9FwyOEQ-1; Fri, 22 Mar 2024 06:43:37 -0400
X-MC-Unique: s4uGTBPdOIes_AG9FwyOEQ-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3418f237c0bso893637f8f.3
        for <linux-fbdev@vger.kernel.org>; Fri, 22 Mar 2024 03:43:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711104216; x=1711709016;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e4hqr5sqga/uu4OSt9i/tA6ZdLVrKguR4cLu3EI2g3Y=;
        b=AjA7IAaMWy8xUDn2eOyIgnJc1W1/XuQVWBVaidZr5by4xBhrpJnKSNZzZ3uaB8qoSC
         vDGBX3tpGglhNNUvDQMEz65OlG1F9G8pYg64lypBLqfLF7jVGZh7fu5c1Vfe4dSoLjU/
         147JNMr4gm1n3WByW4e0zFOlFpbU09AdmUIoPog0/BfrVZOgaS6ZJOiK1PpQG5zS6CSp
         EbygjO7dlnl66CyES/BuZkM6nEzJM72zBNWUClL9qkstAGwHFZzC2wxanA3kyc7TbkUE
         PGDpNNj9nqdKZS5aNA5eZv+mVWxes3B36snlTrWtzFp3wZqkbxiZlNN16ROeoMV90qUY
         Fh0g==
X-Gm-Message-State: AOJu0Yw40fmxdAJRuTXUG6+9NNl7Vov0vRfdaju8lhro9+BiLaanOFkI
	WQvzaYtqV+u2L8BBe1gjq2hN+nGzTnwZ9P0dVnUYg1ZLG6YgrCZztca0G3lTGn/sGAqjRFdvnSu
	IevKz9G3gshOmlNd9Zl0gekoE46MYoEAziB2u/B/ZCAFFEVCqLoeh4qRCSf/q
X-Received: by 2002:a5d:4145:0:b0:33e:9451:c299 with SMTP id c5-20020a5d4145000000b0033e9451c299mr1237987wrq.26.1711104216097;
        Fri, 22 Mar 2024 03:43:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFsAkU+2jK4kRfvDnw8i0oVWh6n19VVa3BIi69kxPxPYLEkn3rIbnPUV1SFTkGh0njd+owt8g==
X-Received: by 2002:a5d:4145:0:b0:33e:9451:c299 with SMTP id c5-20020a5d4145000000b0033e9451c299mr1237971wrq.26.1711104215672;
        Fri, 22 Mar 2024 03:43:35 -0700 (PDT)
Received: from localhost ([90.167.87.57])
        by smtp.gmail.com with ESMTPSA id n10-20020adfe34a000000b0033de10c9efcsm1771312wrj.114.2024.03.22.03.43.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 03:43:35 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, nbowler@draconx.ca, deller@gmx.de
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>,
 Daniel Vetter <daniel@ffwll.ch>, Sam Ravnborg <sam@ravnborg.org>, Arnd
 Bergmann <arnd@arndb.de>, Geert Uytterhoeven <geert+renesas@glider.be>,
 stable@vger.kernel.org
Subject: Re: [PATCH] fbdev: Select I/O-memory framebuffer ops for SBus
In-Reply-To: <20240322083005.24269-1-tzimmermann@suse.de>
References: <20240322083005.24269-1-tzimmermann@suse.de>
Date: Fri, 22 Mar 2024 11:43:31 +0100
Message-ID: <877chu1r8s.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Framebuffer I/O on the Sparc Sbus requires read/write helpers for
> I/O memory. Select FB_IOMEM_FOPS accordingly.
>
> Reported-by: Nick Bowler <nbowler@draconx.ca>
> Closes: https://lore.kernel.org/lkml/5bc21364-41da-a339-676e-5bb0f4faebfb@draconx.ca/
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Fixes: 8813e86f6d82 ("fbdev: Remove default file-I/O implementations")
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Javier Martinez Canillas <javierm@redhat.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Helge Deller <deller@gmx.de>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: linux-fbdev@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: <stable@vger.kernel.org> # v6.8+
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

