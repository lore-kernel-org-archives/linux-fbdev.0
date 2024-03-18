Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F8354F8E
	for <linux-fbdev@vger.kernel.org>; Mon, 18 Mar 2024 17:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710781479; cv=none; b=hdQEkaJVEIDFICHo/TNUKfuQDhrD0KXk8q1AeGl+N3EGO34xFcsrbiWnnkDrSuDrqrxlGnM/DAOLYuAMlw9pNk0BuJXI4OzmvEc7Q40vBT61Z+qoNFcoQyBw4w+fU42xO7yx8J71YQzp/Nc9UqyNHCywjDkVJlUXJf6x6IgP77k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710781479; c=relaxed/simple;
	bh=nDe41bjVWu09AIpI4KAsUOlvNzB0frTmnVTI/YN1Y3M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=d6tGjxjNwJ67/GDnruY4M0twlzS1ERcxmCFli4YgIXODisJdAKgIp9CpQL47n3ICTlBfd+eHjGOwJlaDvrdR4MSIOp+1Un7vovOMzwUe8lQrbQTajIOWdX9ldtQPHl3FJDiVlVZGxq79nOaSOwjS+uSWk3UWqB1OONj+1MLkVsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gEELyxcF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gEELyxcF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710781475;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2Ft26s8DeLb5OoGn9UtyEk5lh1rI2qsUcl1cS7Zp6Cc=;
	b=gEELyxcF9o1uSvxEfBhfP8ffE17voiFQcK0GuJknKxla79T4nLqYI7Ov1dwsVwvNM/QQVt
	9lR+gWNt4W3CVpXnCDJEo3ox584ir4JgIp/Q2/7irnJMu7mBMHPLUL1m9muJnCpF5OQC5T
	2qaRskUOwIFIDmuatxbQ3z+4NiQeWXE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-9VU9RLleMs2SAST_3KsPZw-1; Mon, 18 Mar 2024 13:04:34 -0400
X-MC-Unique: 9VU9RLleMs2SAST_3KsPZw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4132cf7b23aso21808945e9.1
        for <linux-fbdev@vger.kernel.org>; Mon, 18 Mar 2024 10:04:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710781473; x=1711386273;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2Ft26s8DeLb5OoGn9UtyEk5lh1rI2qsUcl1cS7Zp6Cc=;
        b=VfpMD6LjPfPkKXD3P0fAq0ciu+65wJCvv2+f68VFQm7ehj3PTRQ0CBkB3vAHR1Fbk6
         2aoQAgpFtLuS1MLJ+UFkuPzt3WT9UACnDGPcgfjmO+x2ERbPdS+9Focc24IqT23Q0Rb+
         w3VY/3pWLMMZpPAAn426uii26k8GtZBNaKtuNtVxr4sz8TXDDLWljvrcHSMRoigHCNtB
         UldnIAg248AJ4AEuDsa31sPOUUhbgHZCZEwNG9I4nHaRy5ffX7QQ4f5pWywb8ojX4w/T
         HNH+ppKj95o/17nQTWqwaHCz1jOhTsYUzmRI2Jn4VW+f1KJqb7SpKdZyHh6l05H3FMOR
         HMsA==
X-Gm-Message-State: AOJu0YxJjQieUrPcX2KxKqMsa6LZWpi4vlX8JiTQk5IFG3GICe1Z/XVv
	6/4EIDBK/sHQpZ/BnbuGuc4LKAPmSEmQgu/nIP5Ln9jwWALCYpeCi/Y4dHaBzkYGgYDzcQVrdGP
	I8UXj0Xkmig++V6isffNrjb4GmpP8vmWNGBCXqTTsI3PJ5Anmvtb8WaCL38HK
X-Received: by 2002:a05:600c:4594:b0:413:fc09:7b19 with SMTP id r20-20020a05600c459400b00413fc097b19mr7956413wmo.40.1710781472896;
        Mon, 18 Mar 2024 10:04:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFFpz8rw3Vm3P8fHHmgq5SqnYJ0Z8VtX3WpKFJXPoxMtawtCQx73DL9mwoNSNZZJc5Jb5NMjQ==
X-Received: by 2002:a05:600c:4594:b0:413:fc09:7b19 with SMTP id r20-20020a05600c459400b00413fc097b19mr7956392wmo.40.1710781472466;
        Mon, 18 Mar 2024 10:04:32 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id u10-20020a05600c00ca00b0041404efa323sm3379084wmm.0.2024.03.18.10.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 10:04:32 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
 airlied@gmail.com, deller@gmx.de
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Thomas
 Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 06/43] fbdev/deferred-io: Always call get_page() for
 framebuffer pages
In-Reply-To: <20240312154834.26178-7-tzimmermann@suse.de>
References: <20240312154834.26178-1-tzimmermann@suse.de>
 <20240312154834.26178-7-tzimmermann@suse.de>
Date: Mon, 18 Mar 2024 18:04:31 +0100
Message-ID: <87msqvfp40.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Unconditionally call get_page() after looking up a page from the
> framebuffer memory. Guarantees that we always hold a reference.
>
> This change also refactors the code such that it can support a
> driver-supplied get_page helper. This will be useful for DRM's
> fbdev emulation.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

