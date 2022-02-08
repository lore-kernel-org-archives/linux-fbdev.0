Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46103C433F5
	for <linux-fbdev@archiver.kernel.org>; Tue,  8 Feb 2022 23:59:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239046AbiBHX7i (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 8 Feb 2022 18:59:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239016AbiBHX7h (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Tue, 8 Feb 2022 18:59:37 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 65ED4C06174F
        for <linux-fbdev@vger.kernel.org>; Tue,  8 Feb 2022 15:59:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644364773;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1B+HhoEdav6Cob3bPb/BF6nu8D/2OQMn0TX9fIjaHGQ=;
        b=JBLMigW1qdr1WbmmPKfZ8LCBX2t07X9kupCEarIs9Tovv4bnnVp/6Ky3NT5TZgQOzwug3x
        Rok1upzPdyG+JaducDlNAURgD6ptDkj6v+908dn3sgiF0QIFxGlm1aG8RjAumZCf8C89lP
        YORougsxKToGsECR5ycV4gFdLlNHRak=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-653-LxznU1KHOyyk66pEEPZShg-1; Tue, 08 Feb 2022 18:59:32 -0500
X-MC-Unique: LxznU1KHOyyk66pEEPZShg-1
Received: by mail-wr1-f69.google.com with SMTP id e1-20020adfa741000000b001e2e74c3d4eso294881wrd.12
        for <linux-fbdev@vger.kernel.org>; Tue, 08 Feb 2022 15:59:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1B+HhoEdav6Cob3bPb/BF6nu8D/2OQMn0TX9fIjaHGQ=;
        b=VeadZKFbVzcjq4oQDm3osWc3E1iw2ka2DvF7VIztGubhF4d6CFxHK2+jjXBOZezAU+
         jXqzPu87fe1E6cFn/TsN0qijC4Ni9UdNMYnlvQcoLmKh6a/MQGqsdsH891ToC2RVhdow
         RFZziMHrQeHpbfvbcMW+lUVnkbXoIfX7xwlPSL3lhgaQJBsmQGpPZQErjaXW/S1WljCJ
         QzEG04oZ4/uR1hDxgCXCeyshU1GWf1ZIGzOCtxAHFcrMiMTOs5CEElCbTc2c3UvekRuN
         VoxSf5614MKA/SvSzgts3vMpuPpNqDbJpvbs5VQaFSFg70N8gX3xYV9Z5XZLMzXb4s9P
         X4Mw==
X-Gm-Message-State: AOAM531ZEDqJY2zi2dwoy0lBbZyYixrX/zCq+1oNxhaJ/pH1vRIz9yoj
        Y4/nIRodg89PTVGl6L0LKSNUUu3+Is/D2m+OCbDxMvt9nj86r/U2t0aH00PV18gtpZulQ95BP3w
        1McO9n6qLdt2C9yJ7Ek9HeGc=
X-Received: by 2002:a1c:4c19:: with SMTP id z25mr302723wmf.105.1644364764704;
        Tue, 08 Feb 2022 15:59:24 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwyxrdx5PAN39E9zDPgBt3t7VCZ+YkAG7VKuS1GxY71C3wn6MOzwm1KHjgao+aMLB+p3UZbTg==
X-Received: by 2002:a1c:4c19:: with SMTP id z25mr302707wmf.105.1644364764502;
        Tue, 08 Feb 2022 15:59:24 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id l24sm3859205wms.24.2022.02.08.15.59.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Feb 2022 15:59:24 -0800 (PST)
Message-ID: <c58f7b96-8d8c-030e-9fd2-358e259127e4@redhat.com>
Date:   Wed, 9 Feb 2022 00:59:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 06/19] fbcon: Use delayed work for cursor
Content-Language: en-US
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>
Cc:     linux-fbdev@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Du Cheng <ducheng2@gmail.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Claudio Suarez <cssk@net-c.es>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Vetter <daniel.vetter@intel.com>
References: <20220208210824.2238981-1-daniel.vetter@ffwll.ch>
 <20220208210824.2238981-7-daniel.vetter@ffwll.ch>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20220208210824.2238981-7-daniel.vetter@ffwll.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hello Daniel,

On 2/8/22 22:08, Daniel Vetter wrote:
> Allows us to delete a bunch of hand-rolled stuff. Also to simplify the
> code we initialize the cursor_work completely when we allocate the
> fbcon_ops structure, instead of trying to cope with console
> re-initialization.
> 

Maybe also make it more explicit in the commit message that the delayed
work is replacing a timer that was used before for the cursor ?

> The motiviation here is that fbcon code stops using the fb_info.queue,

motivation

[snip]

>     /*
>      *    This is the interface between the low-level console driver and the
> @@ -68,7 +68,7 @@ struct fbcon_ops {
>  	int  (*update_start)(struct fb_info *info);
>  	int  (*rotate_font)(struct fb_info *info, struct vc_data *vc);
>  	struct fb_var_screeninfo var;  /* copy of the current fb_var_screeninfo */
> -	struct timer_list cursor_timer; /* Cursor timer */
> +	struct delayed_work cursor_work; /* Cursor timer */

A delayed_work uses a timer underneath but I wonder if the comment also
needs to be updated since technically isn't a timer anymore but deferred
work that gets re-scheduled each time on fb_flashcursor().

The patch looks good to me and makes the logic much simpler than before.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat

