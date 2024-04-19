Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7762B15C3
	for <linux-fbdev@vger.kernel.org>; Fri, 19 Apr 2024 07:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713510244; cv=none; b=eKM66Iz09A9sXVF2VEyCq0I62CLf6F2K6KOVtse0VqbNrKc12X3/BExOkAqSYqdE1t0Z8K7KXvTTmqhe75f7ReSxWJTcn2XlEukr+ZwxMbUyvHKwKhDKi52SEMCRwLcivQLkJfMOuQKfP+T/yN11Dk7bTQfsg0GJW3sHUMgT6EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713510244; c=relaxed/simple;
	bh=BAa4wawhDWUl0nCtwxTmpPWGZIV+q0xujdGe7IsH9ZY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qD4Oa4m7VkaarSOgR8LovYVtRaKmTOygyC2U8NTFGU/0Ntfc3gpkEbEyD5WbMGIn93cL963p7VIQMd6IR1efPhZ4QrvG4/PydyK9Z2pyiCUL0XnGsrSXEC3io6Ina9m6/IaxK5UTx1dxJSgpp0PZHLIuTJOvI6wIAfes240GCOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TbwQhZxF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TbwQhZxF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713510241;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sHuEH/8T8ho9ggnTIrjh4+mWTVgr/tS94Z/G4jbQNR0=;
	b=TbwQhZxFsQja4h8bwnGyquDkrhxGe2GmeekRHqvKfFEa6vrMOLaKE4y4qK6gFP+RVRVMwj
	JY68IVQOTdypJZD3+lFZdxWX0lnCXglSx3KHbRntvWk6Pl0o83riMsDC8/6cbr5mhXa9eH
	bGIBUue40yu54t8VkmTcRtBikDBb25M=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-9WjjMijwPEmh08od8z_MDg-1; Fri, 19 Apr 2024 03:03:59 -0400
X-MC-Unique: 9WjjMijwPEmh08od8z_MDg-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-347ddb973dcso1036036f8f.2
        for <linux-fbdev@vger.kernel.org>; Fri, 19 Apr 2024 00:03:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713510238; x=1714115038;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sHuEH/8T8ho9ggnTIrjh4+mWTVgr/tS94Z/G4jbQNR0=;
        b=gWixK/AIT9JXandeeJz8/vfGQHUSe2tmNpELdI0DFdLDee1aw3ze9xGBl+I995Nvs1
         qUTBB0Trt2kXMXsPLiehdj0ORzTqlToBoj+VIhduXo1xAuvtUcrag2XxYZWMFkJHViuO
         LvayTInwt7ko2PDqPvWD71aYItWor7wEhes+lPSrgnXdfLNVstHWgLIDmNg3SKFDARlL
         JfnOcWr7swiLPb7Exw+Yb5BM8hnrcw2xhLd1kbXPe9JlqjeHKS4+PGjBr6gDjVx9G2Dq
         qmIUKkshzfus/cOZyy8cZlnoBjqKmX/z9eTRt7RWz1z5C6/HMMALUIPHqEZs1zAPyySx
         J9Jg==
X-Forwarded-Encrypted: i=1; AJvYcCVvU9mmiiRk7TrM3wLB+lFjlaVhSse2VooAALEk8U33CIPgtioR0/IsGZ9CY9Tooza+F3rkz/Y0D7CYm+Qzo60qql6332L6ATxhQEw=
X-Gm-Message-State: AOJu0YylnnRoJdjgmDR5iMiTf/u7ZelrOnvetHtAeN8Dc4Mrd67wRFM0
	G0l/8v9zpAxZGxnIvCUvmfs5e78XCwdZ66M75Hivgne+eeNo1H/K086YZ1e5I55YonkkvfdvXzg
	P5HEeFnoqSqLp7gMybOuWOB6IDG837thfMvPiC5moTKDxmFMMtaheFrT8HAMm
X-Received: by 2002:adf:eed0:0:b0:33e:c410:a1cd with SMTP id a16-20020adfeed0000000b0033ec410a1cdmr607073wrp.69.1713510238210;
        Fri, 19 Apr 2024 00:03:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGhqZub95bPXvsIY1tEqRueopWbhOus1raU6vUAD6cUmDrmcejh0jPcsNh/gyKe2VFyuLRWsA==
X-Received: by 2002:adf:eed0:0:b0:33e:c410:a1cd with SMTP id a16-20020adfeed0000000b0033ec410a1cdmr607052wrp.69.1713510237664;
        Fri, 19 Apr 2024 00:03:57 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id cp37-20020a056000402500b00341de3abb0esm3703659wrb.20.2024.04.19.00.03.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 00:03:57 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, deller@gmx.de,
 airlied@gmail.com, daniel@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, Thomas
 Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@redhat.com>, Gerd
 Hoffmann <kraxel@redhat.com>, Gurchetan Singh
 <gurchetansingh@chromium.org>, Chia-I Wu <olvaffe@gmail.com>, Dmitry
 Osipenko <dmitry.osipenko@collabora.com>
Subject: Re: [PATCH v2 19/43] drm/virtio: Use fbdev-shmem
In-Reply-To: <20240410130557.31572-20-tzimmermann@suse.de>
References: <20240410130557.31572-1-tzimmermann@suse.de>
 <20240410130557.31572-20-tzimmermann@suse.de>
Date: Fri, 19 Apr 2024 09:03:56 +0200
Message-ID: <878r19esv7.fsf@minerva.mail-host-address-is-not-set>
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
> Cc: David Airlie <airlied@redhat.com>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Gurchetan Singh <gurchetansingh@chromium.org>
> Cc: Chia-I Wu <olvaffe@gmail.com>
> Tested-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

