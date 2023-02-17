Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C15DC636D4
	for <linux-fbdev@archiver.kernel.org>; Fri, 17 Feb 2023 09:02:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbjBQJCr (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 17 Feb 2023 04:02:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjBQJCr (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 17 Feb 2023 04:02:47 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EABDF60A50
        for <linux-fbdev@vger.kernel.org>; Fri, 17 Feb 2023 01:01:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676624518;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iX/V/ayuIBSrZtIRFg5DW3vDK9omTeaZk0P2mOKN4MI=;
        b=A75Ov2ugRSzbTB+LWJPVoBDX3VE1OW/obTJ1JclzTYYpgq+kmyvldT4BAJXU5Q/vNYyjsh
        sltXBVjPYqbmwuQJSER/DxB+4tDaq2oi94GacZ2A1jIEKDaxD/x8k43fZNeQeDGX+eczsj
        ELXw8Rxov+wRT5r4RXpgxlMDzNxfSUw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-414-40eOUWrmOVy-lpqpq0sZng-1; Fri, 17 Feb 2023 04:01:56 -0500
X-MC-Unique: 40eOUWrmOVy-lpqpq0sZng-1
Received: by mail-wm1-f69.google.com with SMTP id m18-20020a05600c3b1200b003dc5dec2ac6so394041wms.4
        for <linux-fbdev@vger.kernel.org>; Fri, 17 Feb 2023 01:01:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iX/V/ayuIBSrZtIRFg5DW3vDK9omTeaZk0P2mOKN4MI=;
        b=3+tg71uhlkSnLjrE6j4JSzg78otLI1vBqp5XNlLVg3DiHTkklMhubrmav9OdXuKSb0
         AuOT25hS28Sujvfi0nYkkVYgAEK43kXOP3gnjISbMhygnwiRVFamfFn1ClklQ7ri7PmO
         ntmyEY9laQaZqwtQytfS66t4T5pDFtnxI1yeKGwTAiIKLgKVthBnyI13QMYYKXhm6kiM
         X71Hqi524YhCO/OxRBJfjQjGB9cpQtpDrqvSTcH9p7o+jskrWVMACi/GbyKNKS6XWTEl
         kB+rG1pBAmHUbaTOkFsUqrb/8zPd8H6gSH3gLtsTCdA+kiyqT3EhODhtbVCMwUrRbrrS
         YVjw==
X-Gm-Message-State: AO0yUKWdeTZVEMbm3gx972+QTGrA3csSRPb5uFwJPJjDUzbPzQM7pNtA
        DnTKQlwW3Wgbf/iP4wrWU5hMUItVY3+daNS0kfty+Zu9eZjMWq+ZGE+jt3jwh5Gb8UqYjjuc3+x
        dJt4rGkfgYJ5Vk/DmvkOg+ZE=
X-Received: by 2002:a05:600c:1656:b0:3e0:c75:7071 with SMTP id o22-20020a05600c165600b003e00c757071mr607296wmn.5.1676624515354;
        Fri, 17 Feb 2023 01:01:55 -0800 (PST)
X-Google-Smtp-Source: AK7set/6LO81+kz9vV6QLUhodmDEJr26PzK9QZHVy10kd0C6ka1mmiRMz10jyhAUjwG0w24sNhK/BQ==
X-Received: by 2002:a05:600c:1656:b0:3e0:c75:7071 with SMTP id o22-20020a05600c165600b003e00c757071mr607280wmn.5.1676624515102;
        Fri, 17 Feb 2023 01:01:55 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id c190-20020a1c35c7000000b003e21558ee9dsm3933693wma.2.2023.02.17.01.01.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 01:01:54 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
        airlied@gmail.com, deller@gmx.de,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        geoff@infradead.org, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 09/11] driver/ps3: Include <video/cmdline.h> for mode
 parsing
In-Reply-To: <20230209135509.7786-10-tzimmermann@suse.de>
References: <20230209135509.7786-1-tzimmermann@suse.de>
 <20230209135509.7786-10-tzimmermann@suse.de>
Date:   Fri, 17 Feb 2023 10:01:53 +0100
Message-ID: <87mt5cwtq6.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Include <video/cmdline.h> in ps3av.c to get video_get_options() and
> avoid the dependency on <linux/fb.h>. The replaced function
> fb_get_options() is just a tiny wrapper around video_get_opions(). No
> functional changes.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

Best regards,
Javier

