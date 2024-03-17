Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C51C1B964
	for <linux-fbdev@vger.kernel.org>; Sun, 17 Mar 2024 13:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710681653; cv=none; b=qt468AUmlc5Dj7qdGdrmW4HVsqTL/tQgwlOdSNsG7P57n9whRw43lbdgr+zd7rTh9adbHG2yy6nbi1wc0N7RPCCRhgCAg2q63PM3J7iTPZ1idfeuRHdohdA2z9SaQjaoqOt5tjz4gSK7y+RbwBRwDXFXaFiSPyu8BdrsnKH/+VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710681653; c=relaxed/simple;
	bh=LWVAXer/+1j74V3sZndBd6bnq9zW0O2ibEEO8If826g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DSMxmrOjpwKiRjmAzfdurHyCch53ZYeOWck35QBpngLaZvySw4t5/6x89Vc52+1gcFezM1T4tnv6U3e03rdgiADspVd/xoqr5/XYgqYbt3UfHECKaLctMRwCN3YLlqNenuJOOE7p9l1D/UfjN5sDh4ARSnQA1HK/h+P/mgTq1ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O3NgMFpj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O3NgMFpj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710681650;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QwO1WNpY4kgJDb0WwGY+sqWsYzQhy8OfNcg3mH4HAjg=;
	b=O3NgMFpj21RyYgcbEbSKylVBtnHecuJDqGhO7DdevnUtF4yavZGT7NFl3Ypvqc0Y8Q8/cG
	9Z1tfJbBX4F73tBUkR/E8vM10VTZcknqFRSYxvomF2iD3Yd/ThOrEzJw3apBP4PeUq3tvT
	Tgh9bvt6BFqRS7Rhbp0wfF4+btaJz10=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-54-Y-2MJV0UN2i2T-MFIEM4lQ-1; Sun, 17 Mar 2024 09:20:48 -0400
X-MC-Unique: Y-2MJV0UN2i2T-MFIEM4lQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4140dd880b2so1744085e9.2
        for <linux-fbdev@vger.kernel.org>; Sun, 17 Mar 2024 06:20:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710681647; x=1711286447;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QwO1WNpY4kgJDb0WwGY+sqWsYzQhy8OfNcg3mH4HAjg=;
        b=NO8aOO6PQAN2ROoeCC3sUXuNBQ+GXSQAY4pz1y/HaCxzt/Mp/WFegQZ7ZYNPLLOyyF
         KFrN/WKwCczDj1rOZ0pjbS7PGk1ADCB5oZORzpcGIugcqFllArPy9MQzHoOYNEaWKc02
         5sVgP95IAHufrxNWpFkbYFrTceBbSqjGZHCPw99OULCcZMMZAgNnjlElyVhHHP3DtCDx
         n/ib4YG77bD94W9w2N6nbks9LqQABCuV3FyPWrIxbvaR0Cm2s5GpZMWluJTGUtzSTPwY
         wSQSj1GHumpKzfHB3R3pu1ho1igvmTziO1rmP2H/87Yw7K6MayIw9JmnpwqcNNcjvY9o
         1EcA==
X-Gm-Message-State: AOJu0YwTmF7QvYLTpAhIj1QOl+Ta2pYQqZab5z9Hlsxk2ml01JFJvBGn
	SPh9EKO1SrupFvgKTxDt1P8S7pY0OA/WPpcvevjWcvUwEBs3BSKaO9nqSs0ZaHlMbzRyEuJSKW5
	P6hx5lsL/8h55BT1WH4MtX/NoXOj32BwWMRD9zkx3bw+SvF6WPkXMKfUC63J+
X-Received: by 2002:a05:600c:a4c:b0:414:8d7:682f with SMTP id c12-20020a05600c0a4c00b0041408d7682fmr2341746wmq.10.1710681646725;
        Sun, 17 Mar 2024 06:20:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGp+q9l+i4tLdNP8KFivFrjXsPOLlFMcc5f5w5rWdLw81lrvt1KyPuMqCnXrg2wRf0UqNhVWA==
X-Received: by 2002:a05:600c:a4c:b0:414:8d7:682f with SMTP id c12-20020a05600c0a4c00b0041408d7682fmr2341736wmq.10.1710681646306;
        Sun, 17 Mar 2024 06:20:46 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id t15-20020a05600c198f00b0041312c4865asm14913638wmq.2.2024.03.17.06.20.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Mar 2024 06:20:46 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
 airlied@gmail.com, deller@gmx.de
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Thomas
 Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 04/43] fbdev/deferred-io: Test screen_buffer for
 vmalloc'ed memory
In-Reply-To: <20240312154834.26178-5-tzimmermann@suse.de>
References: <20240312154834.26178-1-tzimmermann@suse.de>
 <20240312154834.26178-5-tzimmermann@suse.de>
Date: Sun, 17 Mar 2024 14:20:45 +0100
Message-ID: <871q89gfki.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Framebuffers in virtual memory are available via screen_buffer. Use
> it instead of screen_base and avoid the type casting.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

