Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 851EFC6FD18
	for <linux-fbdev@archiver.kernel.org>; Tue, 25 Apr 2023 16:40:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234465AbjDYQkc (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 25 Apr 2023 12:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234551AbjDYQkb (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 25 Apr 2023 12:40:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72F3913F99
        for <linux-fbdev@vger.kernel.org>; Tue, 25 Apr 2023 09:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682440793;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aQSLc7zBWM0xayJpXB/UQ+q0RauQF+XOpc5CopilIa4=;
        b=QdWAW8n2UEiP986Znp+IOzqSw2j4A2Jsib2Qbew139jPco2on6iu+ylQJKMNWyY8bOZCyM
        533iLKDKZSkM31zXE7x0SOwlPd+fHcU2JWbJ66mPYMMsDrBhxoTOU+evL6XpygZfEeymEa
        g9ZUNIKq3X8QEksqYCXJvyWY2z3XbmE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-7PQN3r7OMk-VfXBqu9EdNg-1; Tue, 25 Apr 2023 12:39:51 -0400
X-MC-Unique: 7PQN3r7OMk-VfXBqu9EdNg-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3f18c2b2110so21312535e9.3
        for <linux-fbdev@vger.kernel.org>; Tue, 25 Apr 2023 09:39:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682440790; x=1685032790;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aQSLc7zBWM0xayJpXB/UQ+q0RauQF+XOpc5CopilIa4=;
        b=QdCMQ332Dv/pnL5lxjkx//YSgU/+fdKd+1BF+kGfR1B8PLHuv8nTEyrAdg0o+dXoxD
         xkdiC3bFs974fnKuRK0CQ+UStZPwftFdD5HCBdvnn5Rx6uqzaJIEDxKcumd5g+F56MbT
         ZAcZ8Zqn0j3Wm6GCHlDo61cyoYJcVpO0DFRTaeJctjgeyJgimdHI6C7+KKHzIsw6t05F
         u/T0vYQ+NadztLBJlqR6zzIa26K2FZ4ueaJ+vBC2CZPUYzC6f/Gfbcu1+qn/5ARCy+vc
         4YB34cgTOhm08UuKSFYxa5YJU6Zj9vQbh6wZhHSvD+y2A/6vft3QNWeYzUv4aH5uEtdU
         qJ0A==
X-Gm-Message-State: AAQBX9e5TNY5al5hMHI0TuaQn/at11k3eoPncurcqBX+ynIYPCgxRKL0
        qJ54iH+Ln+UMjgrf1xOd331WxwM4Y/tPLa1jJj3hUtiqg7dXDunGXevtLio2Xp8fFp3cTCjtbt3
        x5xfNgu3SAxJP5qSEfyxmF5M=
X-Received: by 2002:a5d:62c3:0:b0:301:81f8:765f with SMTP id o3-20020a5d62c3000000b0030181f8765fmr12742607wrv.38.1682440790636;
        Tue, 25 Apr 2023 09:39:50 -0700 (PDT)
X-Google-Smtp-Source: AKy350ayoBeId+nwPqxZP/k4nmmKYESyexlvpxVG1csM3TSUzvaMhsq/0BUDHIZjBYsDwov+L8b1ug==
X-Received: by 2002:a5d:62c3:0:b0:301:81f8:765f with SMTP id o3-20020a5d62c3000000b0030181f8765fmr12742594wrv.38.1682440790330;
        Tue, 25 Apr 2023 09:39:50 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id z3-20020adff1c3000000b002fb9e73d5e5sm13471416wro.60.2023.04.25.09.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 09:39:50 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        airlied@gmail.com, daniel@ffwll.ch, deller@gmx.de,
        geert@linux-m68k.org, sudipm.mukherjee@gmail.com,
        teddy.wang@siliconmotion.com
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 4/6] fbdev: Validate info->screen_{base,buffer} in
 fb_ops implementations
In-Reply-To: <20230425142846.730-5-tzimmermann@suse.de>
References: <20230425142846.730-1-tzimmermann@suse.de>
 <20230425142846.730-5-tzimmermann@suse.de>
Date:   Tue, 25 Apr 2023 18:39:48 +0200
Message-ID: <874jp3j4q3.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Push the test for info->screen_base from fb_read() and fb_write() into
> the implementations of struct fb_ops.{fb_read,fb_write}. In cases where
> the driver operates on info->screen_buffer, test this field instead.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

