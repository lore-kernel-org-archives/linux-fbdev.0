Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5EA54BFA
	for <linux-fbdev@vger.kernel.org>; Mon, 18 Mar 2024 17:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710781403; cv=none; b=cq20rLHtJ9jzOxYm/pET1go3kkM8Swi8VEBRJfCdSMfQLfaYLJo3Xo7hjAKyYSHor7LxAMvsUJBaFmJkAvT92+SAihWKxZW4djMpzcnm49TC0qndktSCeVZpjG0EqU4tIkZssGiNoDulK/rWQDByIv7+TfeQUqRhn7ITDrMRfgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710781403; c=relaxed/simple;
	bh=SjhErBo/gjNOx6SunTc3Ck2gc22M52ZfrVZpLB7NRWM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MddE4uu0k5nbALJwxi/USomIKcjbFQVBjnUOGfCGLTo2y4SSozIHUZp06bqVcyofsvE0u/4mwCYfLm3zCv5Dm3djzmkmz1eHM1hILlZQbwf1GE/JE7jadaII3dk+VhavRVuIBDQHQeuwHsmbGsbavV4BzocTDbeBW1IxvUjsnPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XTNx+MaB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XTNx+MaB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710781400;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B7uD9tCcL5UMzFWwVdaPHucWFHqjdQjWPl2cOgnahzc=;
	b=XTNx+MaBwACNAT3Balt1r36KeOlc5NZrKzuRwi5fGFFgVB3Utt1B1ooGNlit/m/YDr+lFj
	xGJ6DYrb68Uf2hmif76rz5hEXaUFAGXrGMpL+UcCcA/Z0+pMpcfdH2xXdElljoXaEb9CA0
	r8wz6BDEpdaezVcAQJhA8F2bL3DO2Cw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-436-_lB8MuBTOASH3TYRLp-fZQ-1; Mon, 18 Mar 2024 13:03:19 -0400
X-MC-Unique: _lB8MuBTOASH3TYRLp-fZQ-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-33ed234bcb1so1308310f8f.0
        for <linux-fbdev@vger.kernel.org>; Mon, 18 Mar 2024 10:03:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710781397; x=1711386197;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B7uD9tCcL5UMzFWwVdaPHucWFHqjdQjWPl2cOgnahzc=;
        b=OFmejbjxWu+aTXq+oO7ts5vTPAq14zd+8CnWYH2QvLqtKOhCmO8JAYZCT4tlhjw76i
         ywMXNqK+343GKOWVnNEW4Q0pPY5HocFCnDWZwo0v3mdy4n4ypryTfXcCX09wWt5tul67
         dOvw+K3II5mRVeMyLLat9zrMWiaY3XXUaM/Lhxd5xzg/O3bG9J2SbEiv3+3Q9YcIFH0R
         dlq9xKrbcqZ6DjCZkG5EautHKr0X2HzA+VY5npkf9Qe1vQ1SE1ufGXEyc/+0zkwmEm8D
         dxGLE/wZsMCPCbNNiyz2yYIPH3GNucXj5YnrOq0gZQ6pEz3s5p81K8OePoejmIbbhFJN
         oqbQ==
X-Gm-Message-State: AOJu0YzLJRAKWEM4K1pLXX+fRfqhOju7fISounkqF164y7HeREIHaYQF
	j0pTp1+bU7piQqlszd3kNdyBESj+DNNVRQG8275bKnaYrvZ+JhQS1EiLgUPgPm+14yVts8NdX+R
	IzMobLG6rQcKYR7C6wX9BUJybSCqih3W/AhZWow4MOmXMIs37lkmF9YxgvfAS3si+4hXR
X-Received: by 2002:a05:6000:c82:b0:33e:d20:651c with SMTP id dp2-20020a0560000c8200b0033e0d20651cmr159703wrb.17.1710781397706;
        Mon, 18 Mar 2024 10:03:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8jsZcNWZc618FelFUJ5coAJsNdV/LuwV54MiWjO1BnXgoHyTKmi2EC3uPOAtP61yHsDM4/A==
X-Received: by 2002:a05:6000:c82:b0:33e:d20:651c with SMTP id dp2-20020a0560000c8200b0033e0d20651cmr159684wrb.17.1710781397299;
        Mon, 18 Mar 2024 10:03:17 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id q15-20020adff78f000000b0033e192a5852sm10223961wrp.30.2024.03.18.10.03.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 10:03:17 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
 airlied@gmail.com, deller@gmx.de
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Thomas
 Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 05/43] fbdev/deferred-io: Test smem_start for I/O memory
In-Reply-To: <20240312154834.26178-6-tzimmermann@suse.de>
References: <20240312154834.26178-1-tzimmermann@suse.de>
 <20240312154834.26178-6-tzimmermann@suse.de>
Date: Mon, 18 Mar 2024 18:03:16 +0100
Message-ID: <87plvrfp63.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Test smem_start before looking up pages from its value. Return
> NULL if it is unset. This will result in a SIGBUS signal.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

