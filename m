Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 064F5EB64DD
	for <linux-fbdev@archiver.kernel.org>; Wed,  5 Jul 2023 08:25:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbjGEIZv (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 5 Jul 2023 04:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231751AbjGEIZs (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 5 Jul 2023 04:25:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 839351A2
        for <linux-fbdev@vger.kernel.org>; Wed,  5 Jul 2023 01:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688545502;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eZJh75bw9w7BaC88TjfKOAwS7yZRgwUVKM0cKS0Ap4c=;
        b=Ujn27va/xvPLdjORjttVscDzLDHxcHw3dasz+aH5smNzvD29x9qvpSxgYAkuK1MdwmIg9U
        BhFMyqlsBezPC25k71tOhu6Ccc7g/7ldGMm9++XP2ZipmlJ/N6wRG0542bt9KpVIKGFXM1
        lkfmDdkMbTQbaPhhW5TG/dR18hYfeW8=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74-GZcgZfeXMb-tju1EOEt4kg-1; Wed, 05 Jul 2023 04:24:59 -0400
X-MC-Unique: GZcgZfeXMb-tju1EOEt4kg-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-4fb76659d54so6193429e87.1
        for <linux-fbdev@vger.kernel.org>; Wed, 05 Jul 2023 01:24:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688545498; x=1691137498;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eZJh75bw9w7BaC88TjfKOAwS7yZRgwUVKM0cKS0Ap4c=;
        b=klmnCZ8sTLw8ZkxHNE6UdfgkmeTuwx7xzJAhp5esr69GNXolRVuU7+1xzdACWuvvpH
         R5jAXhPGb+O/evolM23fzeaUJDccSsW5XLbkahW9pxEP9aNWcLPVc/7UHVoxfGf5uwBp
         W2lH82BxPLfj19GqXJP7s3D/6N5PLZM++SeMEvuXJs/ti3Cwe0Qii52SwdtR252hpPVD
         bSiLVNe+inss2z2MKpMHKuXKdUigsJkjxF9TyjZJJMDfH2IvHgDYN/dBkTcCiBl9CM76
         qzB3CmdMLC7PRGTNuMTCxtf+9bLRajyL+wOuldUFL5VAjDxifdYtRp+8SuqR7XJgdSpj
         qkyQ==
X-Gm-Message-State: ABy/qLYf9bwlXQItPkkbZAjk/SS+NK8khu3rhUR1XpDy5i2qIWT57yh2
        TVCfT8TdeeQ4HfPYlCBXwt9/Kl8Q2eWz6YUd8z58mbqn1h963j+J7U9LgaPNDcJycXiXCFib5xt
        9X0hsavESdLXcBKBrvM1qG/A=
X-Received: by 2002:a05:6512:214a:b0:4f9:710f:f3a9 with SMTP id s10-20020a056512214a00b004f9710ff3a9mr8987198lfr.58.1688545498073;
        Wed, 05 Jul 2023 01:24:58 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGmVl6rLLB6OUt7bROr01892dqkjNHI5vlj2R/On3xPNUheSZKZaL6NJ+PF67CBojymc/sLhQ==
X-Received: by 2002:a05:6512:214a:b0:4f9:710f:f3a9 with SMTP id s10-20020a056512214a00b004f9710ff3a9mr8987187lfr.58.1688545497921;
        Wed, 05 Jul 2023 01:24:57 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id s11-20020a5d69cb000000b00313f07ccca4sm26118306wrw.117.2023.07.05.01.24.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 01:24:57 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-fbdev@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Mikko Perttunen <mperttunen@nvidia.com>
Subject: Re: [PATCH 03/10] drm/tegra: Use fbdev DMA helpers
In-Reply-To: <20230704160133.20261-4-tzimmermann@suse.de>
References: <20230704160133.20261-1-tzimmermann@suse.de>
 <20230704160133.20261-4-tzimmermann@suse.de>
Date:   Wed, 05 Jul 2023 10:24:57 +0200
Message-ID: <87zg4arciu.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Use fbdev's DMA helpers for fbdev emulation. They are equivalent to the
> previously used system-memory helpers, so no functional changes here.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Mikko Perttunen <mperttunen@nvidia.com>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

