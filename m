Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C24D3B0582
	for <linux-fbdev@vger.kernel.org>; Thu,  1 Oct 2026 14:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790865987; cv=none; b=OJlYHTmLS4ek1v1yvMlzoN21gUGKVkE6JzVX3ikHamRbCIolW6vMsZ9+H3nMektK1R0DGsNCFkp5i+FCb/oPnyi3fadlgDV4AdqIVQ/Vhb2xhxVKW0UObTJ6DokX67yrTZYlRWb9we82E25kqeKQ5imF4XK6nbhDeHR53ohhexI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790865987; c=relaxed/simple;
	bh=y592cWDD7sh9JPJn4KeHW+g6gg94dBAe9nlpopS5a+I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WXXo5vq13jn1eJiimNsk+jEzSawcv0fcsAATkcd6hUskNm8hTC3i4n5I/b/6OF+kVoEF1tOHiOMp9+MZhcQNHSRbbG7bqDMODsunf2KedCcg15VwFsZpaBCN6LzKgrX1CUDLGEsNt78vpeDZV20Ds+pRc6ln++7iw94O6V28sWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bnu0cgts; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=PCYnnmso; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bnu0cgts";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="PCYnnmso"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790865984;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CuGmcOB5B7OU7vPcQ5Kxs9sP8F6GWHF+e8A0rz6DPVU=;
	b=bnu0cgtsDC7TTD+g9P2qdakhJ4ghf9AvIsR9zUYcPjpjlwY2dDe0IKvPlsR5FUZhmJ63hv
	DnN8QkTzQSCNKun2TwM0RzXrbKx+rwLmDAWpM61ah0Ycp5UdIHfHsRZ9UkSOsjVebobEQo
	2D+cBp6+Ec2871uYcMyi0tfZOeuzeqA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-2JxOgm6iOxiyHbgOfm0GXg-1; Thu, 01 Oct 2026 10:46:23 -0400
X-MC-Unique: 2JxOgm6iOxiyHbgOfm0GXg-1
X-Mimecast-MFC-AGG-ID: 2JxOgm6iOxiyHbgOfm0GXg_1790865982
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4a020cf06c3so5071715e9.3
        for <linux-fbdev@vger.kernel.org>; Thu, 01 Oct 2026 07:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790865982; x=1791470782; darn=vger.kernel.org;
        h=content-type:mime-version:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CuGmcOB5B7OU7vPcQ5Kxs9sP8F6GWHF+e8A0rz6DPVU=;
        b=PCYnnmsorPg98wW5Ez+Yfoh0MV/iI2II7jqSlJSQSfSLUWwlHDvOlyVgJdSdWzh1CL
         6kAAPyyXbT5gvpRHF5LoTDnKdVYbhYCHFPng4pH6rhfo6cHtw/oAX0m/WMwUiiI+3Fw+
         ZUZnS5nu1CbsQsmyyq+BWisgfqzDLEWen5IS3YVJwCUnahgTj45Gp9o+aBgTg26r4Iki
         eqkQMNQT9lCCbIo/dy7jl01RtAZ4L0ZtTCfvbUm6b+LvVPBas7QHPALsW2PgqxgwhQu7
         fYOEKMiPrYrdAnjrhQukVCU7MEBq1V5vc4HDLnFPHETmiDheXdmINYXcB32+7P9v+FIJ
         UkYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790865982; x=1791470782;
        h=content-type:mime-version:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CuGmcOB5B7OU7vPcQ5Kxs9sP8F6GWHF+e8A0rz6DPVU=;
        b=F9SICLH1Fx7dkQJIoRm9BpnY9CRxOiWRze31Vw/pUlit4P/0M610zKkyczhrQ6a4EM
         BRKPaWdY86F/iE5oB+VexbbX+Ns64TnAaZt/JCIHbs3jLoIlWRTvsYX2IWjnWcHkJY7j
         QV+SQMTzJoXIm4CwXfcUSF84pp+Lsai0khvFCdt/cSlFWKR6rvVY7vKpfZioe4yJ6JPR
         VGTpya7F8oJOv/8y0ol+4ZOaxoU9vA39/+sIxk6Jj0NCFrG2jpHzYXdIw9iKw49CPsiO
         KewXow6IB7lmjkCC51Pm/8j6F3EYmIZYu3Kb2tpAFaMfRgchwl3R3LdcRjy+9Fek71/x
         oV5w==
X-Forwarded-Encrypted: i=1; AKwUvBww7dYXCnlNxRdPxYGZxeblxZ4h+PDF2DcwN97Y5WBKcsGDIAGsp9IcFKejpjkHb2C4ZastfV0eqPDJeA==@vger.kernel.org
X-Gm-Message-State: AFuF++lRJrdvK9VwWkUEauogHpm9IAu5e1JiD0QwpDth+c2UQJOzvVfA
	BnEh8ASyHy3jN/U2x22CEolb/N6IZo9p65v7I9Q2yRxYnNKyhuIdH0fu1mLUF8sPSPqmHry6Gmv
	kLYPUa88bJYnAtsG62hjRne87SKItgW9eZWRugH6K7KsW7APk/GutnC+Otio/T/eV
X-Gm-Gg: AYBFou0HDhl7YdRm9FTvgIQTf+0auRtVay9sLSAHsJ7hLz/X5o4IK4Nygpg5AjiTS7+
	XaQhZgZ+3FvjAaOuIUIC+viFo9YBxeoddsaW96SsaG356XF+7rOVoZL7bCordChDldEC6ZbCpxQ
	BNPathYB8Pbbn3GB49Aa2vKyRp+fnQNeewr22o3ryKW9uHFJeZ/6ApcFcopNB40/EnBPBuSvpWV
	EdDox+PNB9XsBG31VcWZaN0owWIp2DyeWc7OGp6uKvb8TkEuVuUklERZtuKFvsd51Ov7Z8+OVGe
	JR04CLzn3p4+KhM4+OSXUsztCcjeIzdzYfWWklo/vBnodsmRDpHFZZ5EhbZmm0sjtkafrJK798W
	SBUE5+Bp3dcYeJDEMM4QiB2qZlT0gIuZrgkKRm2LFEpANu81gzFAdO/k7AF1+xf2kyw==
X-Received: by 2002:a05:600c:4e41:b0:4a0:c01:1902 with SMTP id 5b1f17b1804b1-4a01ad9e5d2mr78126235e9.2.1790865981676;
        Thu, 01 Oct 2026 07:46:21 -0700 (PDT)
X-Received: by 2002:a05:600c:4e41:b0:4a0:c01:1902 with SMTP id 5b1f17b1804b1-4a01ad9e5d2mr78125495e9.2.1790865981098;
        Thu, 01 Oct 2026 07:46:21 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0226201aasm59955425e9.6.2026.10.01.07.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 07:46:20 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com,
 simona@ffwll.ch, decui@microsoft.com, longli@microsoft.com,
 ssengar@linux.microsoft.com, andy@kernel.org, gregkh@linuxfoundation.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
 sashiko-reviews@lists.linux.dev, Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 2/2] drm/kms-helper: Remove struct
 drm_simple_display_pipe and helpers
In-Reply-To: <20261001133736.802604-3-tzimmermann@suse.de>
References: <20261001133736.802604-1-tzimmermann@suse.de>
 <20261001133736.802604-3-tzimmermann@suse.de>
Date: Thu, 01 Oct 2026 16:46:19 +0200
Message-ID: <xlv1jyo1fphg.fsf@fmartine-thinkpadx1carbongen12.rmtes.csb>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:

Hello Thomas,

> There are no drivers using struct drm_simple_display_pipe. Remove
> the data type and all related helpers.
>
> The idea behind struct drm_simple_display_pipe was to provide an
> easier way for writing DRM drivers besides regular atomic helpers.
> It turned out to be more complicated. With all drivers being updated
> to use atomic helpers, it's time to remove simple-pipe. Also clean
> up the related TODO items.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>  Documentation/gpu/todo.rst              |  17 --
>  drivers/gpu/drm/drm_gem_atomic_helper.c |  92 -------
>  drivers/gpu/drm/drm_simple_kms_helper.c | 328 ------------------------
>  drivers/staging/fbtft/TODO              |   6 +-
>  include/drm/drm_gem_atomic_helper.h     |  28 --
>  include/drm/drm_simple_kms_helper.h     |  56 +---

There are no more users of struct drm_simple_display_pipe but still some
drivers include the drm_simple_kms_helper.h header. Latest drm-misc-next: 

git grep "drm_simple_kms_helper.h" -- drivers/gpu/drm/*/ | wc -l
21

So it seems you need more  preparatory patches. For this patch though:

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

