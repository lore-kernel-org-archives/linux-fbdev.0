Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A438DC71153
	for <linux-fbdev@archiver.kernel.org>; Mon,  4 Sep 2023 15:29:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351104AbjIDP3N (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 4 Sep 2023 11:29:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236904AbjIDP3H (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Mon, 4 Sep 2023 11:29:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA84CC3
        for <linux-fbdev@vger.kernel.org>; Mon,  4 Sep 2023 08:28:22 -0700 (PDT)
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-240-iSByaj8nN3iJbbx70SgWkA-1; Mon, 04 Sep 2023 11:28:21 -0400
X-MC-Unique: iSByaj8nN3iJbbx70SgWkA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-401c4f03b00so11130255e9.1
        for <linux-fbdev@vger.kernel.org>; Mon, 04 Sep 2023 08:28:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693841300; x=1694446100;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zrkFFETteuVae/tXCmZrIh7LT8QUm9zk2gxUS8x5iBg=;
        b=Z7mMMPhKjThGs6aoPt21WG+aPj8nsX4lWg1Lftp51rLLOnbFq2eY4nIPiDS9KZ+HIK
         5KvdgxitEMQ56T9U9AuZLKzAR//WINm/jua/vT2DPdS07p2olhnxZAJPj894jmbdjDIN
         lh6zVSPBwzePdKWnWSUTg6PpM2tjY+dq4Udjy61LOfnoXRxOTooCL0YRxjUFhUvP4NtR
         UG6RxzZV3D9U20XP581a9+fDZE/IKxGIvw8hEOOa19n4l8HPLHx88i41uq4RRiLkqlDR
         jzCxxARJGY9UbZrGeknJFrfvZrSI2bpMKMDTIwaR0E86AHkf2j04m8L86PVR4DI9COou
         xXSw==
X-Gm-Message-State: AOJu0YzGprVVA2n6WBOnoU1GWSN4X6UZ9M9AzE6BzDhpB471y3lE6jOL
        XalVJargutym9EjAHC+UGg8rC+uIK7GdCg8vOSSwk5mITgaBjoQtriuq56ouj1vI+mt/QjzYddd
        pL8lKt3J+GaUhUGpF5TOGSRc=
X-Received: by 2002:a05:6000:151:b0:317:5d60:2fea with SMTP id r17-20020a056000015100b003175d602feamr8786748wrx.52.1693841299901;
        Mon, 04 Sep 2023 08:28:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEqr9n5OuCxsaX4v3hREg3LRHhHWX1kh5NPq1tl5TVMsK10UjE7B2EYUhMfWqJeDR4jr+Z45A==
X-Received: by 2002:a05:6000:151:b0:317:5d60:2fea with SMTP id r17-20020a056000015100b003175d602feamr8786735wrx.52.1693841299613;
        Mon, 04 Sep 2023 08:28:19 -0700 (PDT)
Received: from localhost (156.pool92-189-221.dynamic.orange.es. [92.189.221.156])
        by smtp.gmail.com with ESMTPSA id e12-20020adf9bcc000000b0031759e6b43fsm11564376wrc.39.2023.09.04.08.28.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Sep 2023 08:28:19 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>, deller@gmx.de,
        daniel@ffwll.ch, sam@ravnborg.org
Cc:     linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-hyperv@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Bernie Thompson <bernie@plugable.com>,
        linux-input@vger.kernel.org
Subject: Re: [PATCH 2/8] fbdev/udlfb: Use fb_ops helpers for deferred I/O
In-Reply-To: <37906737-5ca3-7f46-af30-85a117875eea@suse.de>
References: <20230828132131.29295-1-tzimmermann@suse.de>
 <20230828132131.29295-3-tzimmermann@suse.de>
 <874jka6qd7.fsf@minerva.mail-host-address-is-not-set>
 <37906737-5ca3-7f46-af30-85a117875eea@suse.de>
Date:   Mon, 04 Sep 2023 17:28:18 +0200
Message-ID: <87y1hm5565.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Am 04.09.23 um 15:05 schrieb Javier Martinez Canillas:
>> Thomas Zimmermann <tzimmermann@suse.de> writes:
>> 
>>> Generate callback functions for struct fb_ops with the fbdev macro
>>> FB_GEN_DEFAULT_DEFERRED_SYSMEM_OPS(). Initialize struct fb_ops to
>>> the generated functions with fbdev initializer macros.
>>>
>>> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
>>> Cc: Bernie Thompson <bernie@plugable.com>
>>> ---
>> 
>> Acked-by: Javier Martinez Canillas <javierm@redhat.com>
>> 
>> [...]
>> 
>>> +static void dlfb_ops_damage_range(struct fb_info *info, off_t off, size_t len)
>>> +{
>>> +	struct dlfb_data *dlfb = info->par;
>>> +	int start = max((int)(off / info->fix.line_length), 0);
>>> +	int lines = min((u32)((len / info->fix.line_length) + 1), (u32)info->var.yres);
>>> +
>>> +	dlfb_handle_damage(dlfb, 0, start, info->var.xres, lines);
>>> +}
>>> +
>>> +static void dlfb_ops_damage_area(struct fb_info *info, u32 x, u32 y, u32 width, u32 height)
>>> +{
>>> +	struct dlfb_data *dlfb = info->par;
>>> +
>>> +	dlfb_offload_damage(dlfb, x, y, width, height);
>>> +}
>>> +
>> 
>> These two are very similar to the helpers you added for the smscufx driver
>> in patch #1. I guess there's room for further consolidation as follow-up ?
>
> Maybe. I had patches that take the rectangle computation from [1] and 
> turn it into a helper for these USB drivers. But it's an unrelated 
> change, so I dropped them from this patchset.
>

Great and yes, I meant as separate patch-set, not as a part of this one.

> Best regards
> Thomas
>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

