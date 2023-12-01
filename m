Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YAibrntE"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A6E8C4
	for <linux-fbdev@vger.kernel.org>; Fri,  1 Dec 2023 00:44:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701420283;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E9+lZ9dJzuRJeWqWpmk97tl9Rg+YFKszARGDD2A9j04=;
	b=YAibrntEOm2Xe6Vlut2CiXqGufoRRxWUG7EOrbXp0J95u//EroAALKNntme4ageAxVfHee
	B4R5t7SG/0GUKjJN1wBT127zM8ph7yQp+yJ+R/dHuQTbKmhv+fO4m/4JntG3YBZjasjADP
	5AGIkLYyDi0MOlqSLijhepFVTel01HE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-Dhe6HPzVMimnLR5xt2Ws-Q-1; Fri, 01 Dec 2023 03:44:42 -0500
X-MC-Unique: Dhe6HPzVMimnLR5xt2Ws-Q-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-40b2977d7c5so14210315e9.2
        for <linux-fbdev@vger.kernel.org>; Fri, 01 Dec 2023 00:44:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701420281; x=1702025081;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E9+lZ9dJzuRJeWqWpmk97tl9Rg+YFKszARGDD2A9j04=;
        b=GMvFwVpjjxs8PlDPThENvpE83li9hmFKPdNsPht6zcbyaMzxR+DSZxgAko/tUqTKQZ
         CWHkBs9dl2DHSwFmG8y3CcOMsAszhiFuvCR6M3pb2WBfdqdzV5wG/BlEDRhtalbobEt1
         ELjPuy9w+6pHs5u0HZE+NaeVkf3udPzP0XayHlwEatnW8CYAkLwDOrjq8k04bKPpgpV0
         9TLZXW9G9Vqj81HCN0dTebmenxtSKlZHKCFTeZknnWwFlEte+9KDgDJaW/bmUnasKpbN
         D3V4wXqKobTE7GovJHB0rEEASBYO7XSftIMG7i4xDgvWu+AkLfQaqx2u8dWxB93YMNKh
         Q6Ag==
X-Gm-Message-State: AOJu0Yz8d0wm0nhYGx2VYLTde2GMXVgBNVJpp91ixMr0mbs7P0UeZ8vs
	FihUWaMQ4F6i3AWAvWo2iS+vDZ9T8k4ALG4Z9OiK64Zw1WRWsLJszS71KFy8Ue526SI6Qi81ztT
	c33XskAew0bqTnPzqrURpN1E=
X-Received: by 2002:a5d:4404:0:b0:333:2aca:b07e with SMTP id z4-20020a5d4404000000b003332acab07emr542768wrq.12.1701420281479;
        Fri, 01 Dec 2023 00:44:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEKdO9V0B0zYgMzrduXD36LWz3S73oPmERbDFv76kI/ot9S5klbHgm+qC+otEWZosK2Nthdzg==
X-Received: by 2002:a5d:4404:0:b0:333:2aca:b07e with SMTP id z4-20020a5d4404000000b003332acab07emr542756wrq.12.1701420281151;
        Fri, 01 Dec 2023 00:44:41 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id i9-20020adffc09000000b00333083a20e5sm3589349wrr.113.2023.12.01.00.44.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 00:44:40 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, deller@gmx.de, pjones@redhat.com
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Thomas
 Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 1/4] fbdev/efifb: Replace references to global
 screen_info by local pointer
In-Reply-To: <20231129155218.3475-2-tzimmermann@suse.de>
References: <20231129155218.3475-1-tzimmermann@suse.de>
 <20231129155218.3475-2-tzimmermann@suse.de>
Date: Fri, 01 Dec 2023 09:44:40 +0100
Message-ID: <87y1eel3bb.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Get the global screen_info's address once and access the data via
> this pointer. Limits the use of global state.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

