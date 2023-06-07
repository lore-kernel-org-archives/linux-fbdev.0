Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2910EC7EE23
	for <linux-fbdev@archiver.kernel.org>; Wed,  7 Jun 2023 07:39:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237454AbjFGHjd (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 7 Jun 2023 03:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233837AbjFGHjJ (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 7 Jun 2023 03:39:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D02FA273E
        for <linux-fbdev@vger.kernel.org>; Wed,  7 Jun 2023 00:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686123402;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VCpM3n9uxiNBqWYphesbEdJfBdCBdNVjlNpr9KooViE=;
        b=eTNOS/CW/h7cwwoVW6FQdzTwdN/zYqblEjEBR6ZJfZ40vBnW9XiEZffbhAe+91ONj7vW79
        5KxVYveS9N/Hgfq40jD+PMEhJghv3vM+1/Q9Xi0Xlw0s9KPjj+RTfYvE6EqCKEZsQd1L1K
        U5x7mSXYEpGlCjWz9qMbDc3BoBQ489U=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-z48hkJOAN32MVzXDAtFf9A-1; Wed, 07 Jun 2023 03:36:40 -0400
X-MC-Unique: z48hkJOAN32MVzXDAtFf9A-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-3f7eb414fcbso6566015e9.2
        for <linux-fbdev@vger.kernel.org>; Wed, 07 Jun 2023 00:36:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686123399; x=1688715399;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VCpM3n9uxiNBqWYphesbEdJfBdCBdNVjlNpr9KooViE=;
        b=IR/RXI8LeliBlRgMev5KvDMyyBHmVObjer/IOGi77J+1hYrv7/Z3pl8v44hSzteZr3
         l53cBoW/DPvbQLFoOuI+heLATc/sGrp/KCkkQW27PE4+nstscFaBOMkZGFAmMK/lxRaD
         blc4N4Ff0wsHac3bZ0clpBJJsjzD+pIuNhZqjdzvLT/koI7BlaJHVFT3eVRppeNfc8G4
         FPMmt4IdEi4dOiQpR1u8Hy9ypUWlxCXGHy5i7qPXHkSgoThnzn5jnFOXQ38F4pCzg29C
         7inbylBL2PSQQOXu2aEC/4RgIq/tTJSVbLs2afRPvIPNqL0e+foL0/XpQ0TPQ8KfYdgt
         U2iQ==
X-Gm-Message-State: AC+VfDwOQmeSe3MMmlGEry//kwL4DRp5cVyVb984tijwvFrtr2IS14qT
        wPIOUowsLzV/TKAMpTHDflrIK3T8WpE0OOFP2dWxXXhmwqV9c1lwmBiAh8VxiR1jmm2IYCwt401
        o10SVFp/UOZh5bSJXl5J5YqY=
X-Received: by 2002:adf:fc48:0:b0:30a:f0fd:dca4 with SMTP id e8-20020adffc48000000b0030af0fddca4mr3438819wrs.3.1686123399229;
        Wed, 07 Jun 2023 00:36:39 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4QHTJetA/ydYNcZpnkz18WI9SIVhHJpnswtj0+WuXSdy2RjUolx7XRR0vsMR7cmSEWXP1qKQ==
X-Received: by 2002:adf:fc48:0:b0:30a:f0fd:dca4 with SMTP id e8-20020adffc48000000b0030af0fddca4mr3438803wrs.3.1686123398984;
        Wed, 07 Jun 2023 00:36:38 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id t7-20020a1c7707000000b003f6cf9afc25sm1125337wmi.40.2023.06.07.00.36.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 00:36:38 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
        sam@ravnborg.org, deller@gmx.de, geert+renesas@glider.be,
        lee@kernel.org, daniel.thompson@linaro.org, jingoohan1@gmail.com
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-sh@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-staging@lists.linux.dev,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 04/30] fbdev/atyfb: Reorder backlight and framebuffer
 init/cleanup
In-Reply-To: <20230605144812.15241-5-tzimmermann@suse.de>
References: <20230605144812.15241-1-tzimmermann@suse.de>
 <20230605144812.15241-5-tzimmermann@suse.de>
Date:   Wed, 07 Jun 2023 09:36:37 +0200
Message-ID: <873533hgfu.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Thomas Zimmermann <tzimmermann@suse.de> writes:

> The driver's backlight code requires the framebuffer to be
> registered. Therefore reorder the init and cleanup calls for
> both data structures.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

