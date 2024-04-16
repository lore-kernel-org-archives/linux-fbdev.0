Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE5D1292DE
	for <linux-fbdev@vger.kernel.org>; Tue, 16 Apr 2024 11:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713267424; cv=none; b=tyIObPAg47ZgH/dDScZpOTcViKNSy/ETk1MSnd5Dx1V66N+I/DM0wqdgzLxCc60+43E4nQwQfaaJszf1BdMgAZKeHYiW/Gb721YuvgWLIE/fLCtL6VQA/tTP8woSGgHEZ1Drrf7QXz691fhWMXyZWxn4p933nTTWReQamSLb01U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713267424; c=relaxed/simple;
	bh=RdFoJK8fAei/9FYNEyAQVArPFazeS/PWgiI3qvhvtYc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pHfnP88UE/SB9/kJtcWrGF1LcFxpa753fZMqHuGZ8Qbne7PCrdBS41FF++VoGNI6WoHe8+0HuxJjKPIX8oyD2yzaqrFYxQntW/Q2oRUwRN7La5WJU4Xc/eHd9gUcjoKQhCEV0lKcojxDUHpNlzu9LeEdyNTWM5ZJrhEHYkDpQRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YttUV1K/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YttUV1K/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713267421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s0SRjtUocGfTepjhhgwwKiOTwSYSr6bS/BAY3TsMEaY=;
	b=YttUV1K/PR+le1rajaFbNrBC2GUngtNR5oo873ie/TucFP/q0QU0ELb7loziFqaKB2qYDQ
	Z8sMV7M8TUxamUUrCLzrAtIi3AWL0X8CuHphWot9zA11u/8RDsAfwv7ppvu1C22PVpTjps
	X7OmS1tfFyyoctEJ+kPTikmDL7OqVFU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-279-ZtVGL_LrOGygJr4GzEeEIA-1; Tue, 16 Apr 2024 07:37:00 -0400
X-MC-Unique: ZtVGL_LrOGygJr4GzEeEIA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-416612274e7so18489865e9.2
        for <linux-fbdev@vger.kernel.org>; Tue, 16 Apr 2024 04:36:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713267419; x=1713872219;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s0SRjtUocGfTepjhhgwwKiOTwSYSr6bS/BAY3TsMEaY=;
        b=okfyXzlk+xnYFrMc+jEfrPiKbKurtQEJdNXQ8Fno9xazCmcuYWBYoU70ikeOboU3V1
         TzAifDnyN0tqYys/5NZwHS9YCSHEr3YZDoEclOC8APTLEmsRU3uOfN3NUEUGdbJ5vc4q
         ox1p6d80MlJZfAvDtwNzaieTax9x9WQgy1KV19c4Dbt8q+BaPXUvupEdvOb4STmt4AqV
         bbbG/E2NiVQsIsO5S3/OVmZQT5V23sO1HTjHzZ5beI5U+Uxlg+IL6E+pwth2W0MCq+l2
         VJyY/3e9lnHGD1yLpO8lznLQ2NmbMyh9LzVxTsKpQndBOMGtSIA/srjb9yLAPGr4CWJg
         pdOw==
X-Forwarded-Encrypted: i=1; AJvYcCXM1Is16O2ofwpyUap6+wW7Oa8u1wpPS9jw+cEdJHQaBavM61G0Nq+qNPiibfg0mG03jgUSd6Sxw/gIVsSYNvrAk08a4SQQoiDD+ls=
X-Gm-Message-State: AOJu0YzdfkVaTfLtgYna6fyARw6AvufGcbn5IzvCpoRdgextUDdkbh7j
	MOLPxnQHJdkBP1tyUOxFCX9r+DiobdCbNTZaG15VaIXuE7pMxjxnvesV0l/fMfQF+JE+KhFfZZA
	0WMykeLmigCJqUHF1A1mhUm+NQrMthh0sA6RHijm/+VAQPgAQvcI5XcWjHOJy
X-Received: by 2002:a05:600c:4711:b0:416:3e78:2a1e with SMTP id v17-20020a05600c471100b004163e782a1emr9304801wmo.10.1713267418968;
        Tue, 16 Apr 2024 04:36:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGTn6+1S1Mr4CCs28L9CfGd4/AzteV4U0iy+lT6BiBJMV862Lr8hpayNDeltaD1Msf7/4dW4Q==
X-Received: by 2002:a05:600c:4711:b0:416:3e78:2a1e with SMTP id v17-20020a05600c471100b004163e782a1emr9304785wmo.10.1713267418546;
        Tue, 16 Apr 2024 04:36:58 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id l41-20020a05600c1d2900b00418a02674edsm1000967wms.38.2024.04.16.04.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 04:36:58 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, deller@gmx.de,
 airlied@gmail.com, daniel@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, Thomas
 Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v2 14/43] drm/tiny/cirrus: Use fbdev-shmem
In-Reply-To: <20240410130557.31572-15-tzimmermann@suse.de>
References: <20240410130557.31572-1-tzimmermann@suse.de>
 <20240410130557.31572-15-tzimmermann@suse.de>
Date: Tue, 16 Apr 2024 13:36:57 +0200
Message-ID: <87frvl7d46.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Implement fbdev emulation with fbdev-shmem. Avoids the overhead of
> fbdev-generic's additional shadow buffering. No functional changes.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

