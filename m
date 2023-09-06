Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0CC4EB8FA5
	for <linux-fbdev@archiver.kernel.org>; Wed,  6 Sep 2023 10:14:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233957AbjIFKOL (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 6 Sep 2023 06:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbjIFKOJ (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 6 Sep 2023 06:14:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18819171A
        for <linux-fbdev@vger.kernel.org>; Wed,  6 Sep 2023 03:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693995199;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dSB+vCAalu3WUew7xxSbOR2TbNfeFmYmf0o3TX9uef8=;
        b=Pk8XQi3blkgqFS6R2N9h0UVvD+07IUEHQiM0REpHuU+zZOl4HbDBlHG8qNi/K/m/YuiusZ
        P3Nyb38nGcnsZ0I3JOY7fiD1B6L3IhST77LQBPAOUrYIXjJ2rwfIyE4sArmgL+JhAN68lC
        OoRLseyH8Gt+XWo9gJoQinxvtMTfyUU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-9-vIEwIcZUP7SiW7R5SIYMfg-1; Wed, 06 Sep 2023 06:13:18 -0400
X-MC-Unique: vIEwIcZUP7SiW7R5SIYMfg-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3fefea09bd0so21206275e9.0
        for <linux-fbdev@vger.kernel.org>; Wed, 06 Sep 2023 03:13:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693995197; x=1694599997;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dSB+vCAalu3WUew7xxSbOR2TbNfeFmYmf0o3TX9uef8=;
        b=fepbMW6MgjdLeZvYgPEEWVXdYd3cCnBLJfmq8aYOqU74y5SYnN2DIYslZ8X47er2sR
         fpCavqB0UuGRokVEm4/qkv0I1Ev6+4GVlCZy9xvmII+EapNirlx4vIRZzOOBrJX+5G2G
         NRVYcahe6juzFHtrPzqBNN5m9e9isrDnBii5u5TFK+Soy22OBJ1sWiUEs/owIxoL8GOO
         PgdPN2hHI5H/E5PUT3jn+WkO79VnAtgZBs9ouwEfG1N9u9dCiMvX36aISrrwvXRpX3nu
         oL/dVxmFxx1G6EUJ5dHCbnEFyuFIC3R6xp5ISffESZ0JeqK6f6PfRPgEWDaotaRh8ZN8
         gogA==
X-Gm-Message-State: AOJu0YzI3PxfsHJv1XmY+Px+oklDiyESCAOlPyiKcDb0Lo4H5zAwWTPp
        Q/RaU38KKxIDIOJH9Gxz9o0ZWyPj/SdyWMfr1Vf4mvAIMKLvVy2TKjJ38uV0mE+6958ZbUwdR6V
        Thp+j7hpZaXyfkAw6CvrFcNI65vjq8OU=
X-Received: by 2002:a05:600c:301:b0:3fc:60:7dbf with SMTP id q1-20020a05600c030100b003fc00607dbfmr1790116wmd.41.1693995196927;
        Wed, 06 Sep 2023 03:13:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnVKep36NTxhm2Uz+EzZ6XCQaju2TJOZj/zg0bqn2Adp/5Scn3RpkEDRfRw4uwyOH1UrQfNA==
X-Received: by 2002:a05:600c:301:b0:3fc:60:7dbf with SMTP id q1-20020a05600c030100b003fc00607dbfmr1790100wmd.41.1693995196613;
        Wed, 06 Sep 2023 03:13:16 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id z17-20020a7bc7d1000000b003fbdbd0a7desm22321298wmk.27.2023.09.06.03.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 03:13:16 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>, deller@gmx.de,
        daniel@ffwll.ch, sam@ravnborg.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 6/7] fbdev/core: Remove empty internal helpers from
 fb_logo.c
In-Reply-To: <20230829142109.4521-7-tzimmermann@suse.de>
References: <20230829142109.4521-1-tzimmermann@suse.de>
 <20230829142109.4521-7-tzimmermann@suse.de>
Date:   Wed, 06 Sep 2023 12:13:15 +0200
Message-ID: <87a5tz4nk4.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Remove the two empty helpers for the case the CONFIG_FB_LOGO_EXTRA
> has not been set. They are internal functions and only called once.
> Providing empty replacements seems like overkill. Instead protect
> the call sites with a test for CONFIG_FB_LOGO_EXTRA.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Acked-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

