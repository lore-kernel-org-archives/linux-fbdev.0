Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8D330B53A
	for <linux-fbdev@vger.kernel.org>; Fri,  2 Oct 2026 12:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790945447; cv=none; b=T6POi1LliZQmR41WLAwIu8OLlALY57QGeWYMIkv9/35NsypuOaOTOeX+ahXxin3X8/TCfd979Nz32IdgDqEcILoTVDPWI0IPIJXy4Y6YwiY60l+Dk4KBYIjoCMGlslPz7o7Fz/k/lxAJiTt8l3bVV71E00M7aGDx8B+t2uKW5t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790945447; c=relaxed/simple;
	bh=8LkjODUjCX5ThUzoqVO6sm9iNDH6/CxQcTpugXdKuOc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=E1RxRT1WEt7Cb81s+5fw7XfxH1ddF32HDraMC2rjZcvA1tQ3FpONditLoXTydBHK9h6b6ugeQYEodwEqr4SQYXttQJd4TeOsSVZj4yj7dV+aO4HDG1M1LDaQ/mRmtJusqUqjm/5kb/F+HpnwBMdKkClE8kpq4lRuyLxo5qNsNpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AkJrYX4A; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=L69ATRQ5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AkJrYX4A";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="L69ATRQ5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790945445;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bgkxJeBOF/HSWVBaDgnuL2peb+Evry2VYAsjv931SDI=;
	b=AkJrYX4ADw+O1qseUd9EMxK9VQSF7IAbLLusEQxFaIfn3P6FPjgjFUICeS1e8mYgY4t/oG
	pbd4YKp9/9oePVYiaMZLFfijCwn6tSncP9Hsu0gBGRvv9ghdLSJEdKu4UBNLs08mh1tJdG
	MvPlVPeZ0/oOd4NJtwOGt9UhiOhofXg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-nvqV0M7HOr2X-rMPWQplYA-1; Fri, 02 Oct 2026 08:50:41 -0400
X-MC-Unique: nvqV0M7HOr2X-rMPWQplYA-1
X-Mimecast-MFC-AGG-ID: nvqV0M7HOr2X-rMPWQplYA_1790945441
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-4870142f030so5342937f8f.2
        for <linux-fbdev@vger.kernel.org>; Fri, 02 Oct 2026 05:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790945441; x=1791550241; darn=vger.kernel.org;
        h=content-type:mime-version:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bgkxJeBOF/HSWVBaDgnuL2peb+Evry2VYAsjv931SDI=;
        b=L69ATRQ5qL90Ce7doEQCsqYIQlT/pgZY6rcfv8f3almuJDE0EVSg1HI6wXN8jNxVsy
         W34YAmg76udROoMerfNcdvlm5Mu868r8a5lOaljuosiZtdKRuxdtXdsAcn/QXUO6ntmo
         0c9/vFokG8ikR//SB6UfI6qxc8wbYpVxfHt6pSBFFPKfEyZLAeZ1zG6qvO6ZG57IUX/L
         CkUL6vI+SUZ8v7dnQGecaFj8CcUE9MnYg4o4opMZOPzeqbH1VLH0Uj0cZpWV/YR9cNWQ
         Mb4hLtnhzb7FKmYDOrVFA3CXHQ0uU8fQ+tkfFJK5cfmJtm31bTDx4Jkm1/5EKo0tBGmK
         /M1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790945441; x=1791550241;
        h=content-type:mime-version:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bgkxJeBOF/HSWVBaDgnuL2peb+Evry2VYAsjv931SDI=;
        b=fYmXg/qm3qpfwCN4SG75UWzOOg6enUylPGhmPxdn1Cfcl9VkTZv0xY1o9q55f7jeex
         zvN0VrhR9nfghyZUHK3qwyNCeoKnDefvuyYjTjqJCYGpBmlTi9FWNwzEs6A0mrnnsG1W
         1WuXNJ6SWhPiUHHeVmrJRMhOTjkXVChXxEHq6KbNayxxCeXHv8H9a44vdaT3YW+SHruq
         O+8vnmV2HYuYC3Odw67nXy8NbxfRtKjWMPK0WEylj4XdYnLlNpYZtr/Lnac8cyt4dwtB
         gKWeGWbU5Bv+zI9DIhOS2eFcmRfIOYZusHtv093pluikHNmfqownWPd7pjoNTs0vG4Wn
         4H8A==
X-Forwarded-Encrypted: i=1; AKwUvBzezDQwV15pp4ofQHfNfOEjo8DKJCiS/K5oTIa9rP9yiYVM1TJIlkzkhXK5AUJcDtKlDFigP50WbR0hSg==@vger.kernel.org
X-Gm-Message-State: AFuF++lqNWkCC+Nkmhn3YIcYP6+mHO4Fkz1HchZe9xeiZGR//PvQwYoX
	2SQ3B7SMtbswBYBomGvWXc3gHWxNStRYhDCDOtwAMWX/lgcIXsab0z8mWGToweR/nP1bdBW5cs5
	2ZMVkbSAWeCqbnOzJMHtPMoNuEGzuUF69V1rlM8ENOtAriqQG/dHegKUXLzn/rkEA
X-Gm-Gg: AYBFou1/Ar7QQtni2DPPkTORPN6aj9OTqHkrhrwFyDWu05eTG8454e4iGS+HPZYU1i1
	37mIcuMaiWovvMiXcEhreJloex8o8KqtZTsJx8hIOVv3LUn81n2ilFLLb2Fq90AtWCHCVu6x9lx
	NswrZK+5+3Yj0WjtQjZEGz+O2u1njpgM0pphgPhRBOGG21l5YTvtB8MfjE0pjzOhznfmNMjLHUH
	Er40p2bzafO5075dcErLplCeyOMo6JARmFvxEJ43KW0HE8Gddc7XvhtuY2RNlfeFz8pOWevQzIX
	Ou7rQw2Z2IH2p+bOiSzrJU/yuxtOIswVc+uqAiCZtLmcNR6EoZn3fRQm6MYJ1CiXJqTlUR+X5du
	G/V53gIMftLiYn22LxDB5ikE3Bh5s67e7Zeqa1aV25s5Cm+A+2ijMBXWBm78ZwPpVFA==
X-Received: by 2002:a05:600c:3501:b0:4a0:1723:2d8e with SMTP id 5b1f17b1804b1-4a0274f3bcdmr48922435e9.2.1790945440658;
        Fri, 02 Oct 2026 05:50:40 -0700 (PDT)
X-Received: by 2002:a05:600c:3501:b0:4a0:1723:2d8e with SMTP id 5b1f17b1804b1-4a0274f3bcdmr48922205e9.2.1790945440249;
        Fri, 02 Oct 2026 05:50:40 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a162e867e8sm30310575e9.15.2026.10.02.05.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 05:50:39 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com,
 simona@ffwll.ch, decui@microsoft.com, ssengar@linux.microsoft.com,
 andy@kernel.org, gregkh@linuxfoundation.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
 sashiko-reviews@lists.linux.dev, Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v2 1/7] drm/hyperv: Add missing include statements
In-Reply-To: <20261002124456.741011-2-tzimmermann@suse.de>
References: <20261002124456.741011-1-tzimmermann@suse.de>
 <20261002124456.741011-2-tzimmermann@suse.de>
Date: Fri, 02 Oct 2026 14:50:38 +0200
Message-ID: <xlv1jyo06zc1.fsf@fmartine-thinkpadx1carbongen12.rmtes.csb>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:

Hello Thomas,

> Hyperv-drm gets a number of headers via <drm/drm_simple_kms_helper.h>.
> Include the files directly so that the simple-kms header doesn't have
> to.
>
> v2:
> - remove simple-kms include statements (Javier)
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Reviewed-by: Andy Shevchenko <andy@kernel.org>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

