Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C805B5D5
	for <linux-fbdev@vger.kernel.org>; Mon, 29 Jan 2024 11:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706527814; cv=none; b=DPF5CpqNpXlLv8P7nsW5H/z3lYpGgQ58jHJ3wrim79nTeFfMezUe2Rdn8yFowrNWmHzOdD/EsR2Wx82zat99FcA0esA7+ikw2bPYCqnBIqsq9DH4Taq7U5PrHW1rbYjJuxg4U4YfNSsqD2JeKHClkrgsBeG+AdfjN7gPgoYhiQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706527814; c=relaxed/simple;
	bh=cOgJXqhGY26XLrBkYFqzpUrrcnz3Pq6NjdXulh0ZWvc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ca9poV5NWYoaRX1NBHKqn2hSJrpYRMalHHX0crOqKm1rmEFYG2+kDYsKF0bfvNFtQYEpKJOD6CNfFigyk8WWufvoNP+5s8WfUzI3WeIfSsJH2OFqGySi4LqKlMbnyAyuDqwlSVZrQVNOiUcyyi9HJl9RlglGC1TE9UTnYJjAY00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ddI5tWUz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ddI5tWUz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706527811;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oAQHhgY3bhk3lCCm6pW4wBVOcijj8B+AfYWYuBRpPy8=;
	b=ddI5tWUz716QNPEVQHWG8fUi/vn5Jg08byfzbU78GyyUGD1AwVN0mNPXRgqJYee0sK68WJ
	wKquw3jBcccgOC8hZtJHd6bzvqZBna780+JxkL+8bCIxl1vzHhobUD36lql6F79J5fEBoo
	EWHEHYX7Oxg5KWvERv94CpvBSwLA+Dg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-319-ghFtmA_nMuKKmbcYXd3dxw-1; Mon, 29 Jan 2024 06:30:09 -0500
X-MC-Unique: ghFtmA_nMuKKmbcYXd3dxw-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-33ae6433d55so746547f8f.0
        for <linux-fbdev@vger.kernel.org>; Mon, 29 Jan 2024 03:30:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706527808; x=1707132608;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oAQHhgY3bhk3lCCm6pW4wBVOcijj8B+AfYWYuBRpPy8=;
        b=KmlBqNHgnpATSaglCBvOSpyaTOE0J8YegPy4vboupVRhAMK0fnw56Px6OWPCa6Fc4I
         0NJIB8R8Tccrmq0ak8ARpgZERHT4cnRukgAdBpdujr8PS2OoJ6/DKh90fCmLbzh6+d6q
         1IcO+VlUBrLr7h8r60J8n4+EKD0m8jrli0J3cdA/1UCb5IkjKzGb/dqxeT5vtD241nop
         vqnIz1CzPGxuyQgCB3mNJ9xPOZAs6IS5M8a/kMds/5kB9VsHRdWpgSkhV3LHu+Xbe8P6
         hrP6aYR0S51cUswDIvhcFTGgSHUDcedV6+chtEc0AFLNy2CKKYaMzrF4p6rzUwB2nQA6
         Xz3A==
X-Gm-Message-State: AOJu0YxqOO8RgHgwEg0Qyo6CfYQm0J2IfKdsxhdKf7l3BN0Tx8duCKCH
	/Gpmg1cLudHlSpic0xHb1kAMDtB5Qc4ltht5z0RJZQzv0QY4ZvUTW/vUc2kfp7KN+cMer7ifeDk
	h8QIgNxIZONRrdGwDPOp8/8HY+yb2dTAsDpdG65ryeb82rJNETOlGSFv518gI
X-Received: by 2002:adf:e40b:0:b0:338:8892:fbdd with SMTP id g11-20020adfe40b000000b003388892fbddmr5290359wrm.4.1706527808694;
        Mon, 29 Jan 2024 03:30:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGQbw5w4a/4TyAcBBeYk/Pe3VyTIMvNtN6tYlEqip81Ik/6OpW6GBciAT0rhHoSWh//+3YkiA==
X-Received: by 2002:adf:e40b:0:b0:338:8892:fbdd with SMTP id g11-20020adfe40b000000b003388892fbddmr5290338wrm.4.1706527808366;
        Mon, 29 Jan 2024 03:30:08 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id h15-20020a05600016cf00b0033aedfc5581sm2291652wrf.32.2024.01.29.03.30.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 03:30:08 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, pjones@redhat.com,
 deller@gmx.de, ardb@kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, Thomas
 Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 4/8] fbdev/efifb: Remove PM for parent device
In-Reply-To: <20240117125527.23324-5-tzimmermann@suse.de>
References: <20240117125527.23324-1-tzimmermann@suse.de>
 <20240117125527.23324-5-tzimmermann@suse.de>
Date: Mon, 29 Jan 2024 12:30:05 +0100
Message-ID: <87o7d4v0le.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:

> The EFI device has the correct parent device set. This allows Linux
> to handle the power management internally. Hence, remove the manual
> PM management for the parent device from efifb.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

