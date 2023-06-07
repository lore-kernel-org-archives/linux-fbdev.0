Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6B9BC7EE2E
	for <linux-fbdev@archiver.kernel.org>; Wed,  7 Jun 2023 09:05:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234315AbjFGJFQ (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 7 Jun 2023 05:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233837AbjFGJEW (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 7 Jun 2023 05:04:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5EE619BF
        for <linux-fbdev@vger.kernel.org>; Wed,  7 Jun 2023 02:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686128529;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mH0V+GQH9u3hTOintFl8kIUIu94Srk8ZL012Xjzg5pc=;
        b=M1sD8BqDNNXyoyna4sw5l0Ry+8hFfSj1fdSSHNZzeMQzl9aH4oUuzF1HTAgeAqGRty9Bnx
        9xhTUrbgfoxc7cclGkInR63Ojw2FKpbSnKLhnmJnuKyF867vGtuKPsx8It8jvigIXbw2qO
        0/pJyTm9nPJbeEromm1XB9jh4Du1FMg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-173-v3wvOM8ZOwO384P_r8yjpQ-1; Wed, 07 Jun 2023 05:02:08 -0400
X-MC-Unique: v3wvOM8ZOwO384P_r8yjpQ-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-30b218c0bbbso3037052f8f.3
        for <linux-fbdev@vger.kernel.org>; Wed, 07 Jun 2023 02:02:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686128527; x=1688720527;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mH0V+GQH9u3hTOintFl8kIUIu94Srk8ZL012Xjzg5pc=;
        b=ZBTAaF9pzfXyFe9oIBFXUzhF5p4n0BktIFId/a/zqVXaFIVdmhyeRVOG9IU/N1AtMA
         FABoI0QAdtDQR9+9hlxnvu0aeac62r8tH3Ca4lR2YRfH7igQbSdnVSipZsBrayshmz/R
         /NQQkUPKA9SZWjGSMeYbPB25u6ER7CHcWBY7AdKfS6ytmzSn/OuqLkblDGc8qA9fZzIO
         WtaMhSVciz+V9SzA3+fREB4lbdCD9ujgRyrBycVcRmUeaODvCWUhHKprUtqnx8DTrZ+Y
         sdSZqClyG8eMCsZLKdkURJNOjCGMdJDmmNxbYoLOewFuR0sMeNswJ+DbEppiTBIR7OnT
         RpcA==
X-Gm-Message-State: AC+VfDytSS9NgAlG/zCzbq00ipVeN/EB0tEZV0HcSEMDD7Z6OlUgLUwO
        t+eoVx9OyZ6sEh5/+hK1mMRjtDS04qRs6mFA3R2I2EsM10bKXtyMT1L9SesI7CjGgpXlNsl7pH3
        VSEL1Ck9Xkpls/yUkfy1SYtM=
X-Received: by 2002:a5d:5642:0:b0:307:bd64:f5a4 with SMTP id j2-20020a5d5642000000b00307bd64f5a4mr4077061wrw.52.1686128527753;
        Wed, 07 Jun 2023 02:02:07 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6+RtLt6z9BsPsahZF3tzNThAhq9O2T1soohVRASzXnOQHusHmP/yNJTyZBUwoEWLT/tzAX+w==
X-Received: by 2002:a5d:5642:0:b0:307:bd64:f5a4 with SMTP id j2-20020a5d5642000000b00307bd64f5a4mr4077038wrw.52.1686128527482;
        Wed, 07 Jun 2023 02:02:07 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id v10-20020a5d4b0a000000b0030789698eebsm14921477wrq.89.2023.06.07.02.02.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 02:02:07 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
        sam@ravnborg.org, deller@gmx.de, geert+renesas@glider.be,
        lee@kernel.org, daniel.thompson@linaro.org, jingoohan1@gmail.com
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-sh@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-staging@lists.linux.dev,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Antonino Daplas <adaplas@gmail.com>
Subject: Re: [PATCH 14/30] fbdev/nvidiafb: Reorder backlight and framebuffer
 init/cleanup
In-Reply-To: <20230605144812.15241-15-tzimmermann@suse.de>
References: <20230605144812.15241-1-tzimmermann@suse.de>
 <20230605144812.15241-15-tzimmermann@suse.de>
Date:   Wed, 07 Jun 2023 11:02:06 +0200
Message-ID: <87a5xbfxwx.fsf@minerva.mail-host-address-is-not-set>
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
> Cc: Antonino Daplas <adaplas@gmail.com>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

