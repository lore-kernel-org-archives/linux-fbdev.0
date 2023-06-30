Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EF83EB64D7
	for <linux-fbdev@archiver.kernel.org>; Fri, 30 Jun 2023 17:39:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232632AbjF3RjD (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 30 Jun 2023 13:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232606AbjF3RjC (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 30 Jun 2023 13:39:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D2435AF
        for <linux-fbdev@vger.kernel.org>; Fri, 30 Jun 2023 10:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688146685;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kVYUQaLIlYzTkSSGVDZ9hVc8AmWln/G3KSgwkF5UBS4=;
        b=VHtxW9Jiz4MzjsWZNXiKDRqKIwGWTH3hed6tMQgxhU4gJrlF8HgwHhJO6iDXKLiXqn7LA2
        j6QLkBfTHnOksewQ7RiZkqDuy4tIdFej0DcBnND1QTPqJ8iiZVzuONaQv5Mijlu2Zlj8Mj
        5+ILuh6mtiNZx0CCvxRiys7Al6lZZVA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-X18ug8m0MGGT8wvfU6lmdQ-1; Fri, 30 Jun 2023 13:38:04 -0400
X-MC-Unique: X18ug8m0MGGT8wvfU6lmdQ-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-30793c16c78so2726821f8f.3
        for <linux-fbdev@vger.kernel.org>; Fri, 30 Jun 2023 10:38:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688146683; x=1690738683;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kVYUQaLIlYzTkSSGVDZ9hVc8AmWln/G3KSgwkF5UBS4=;
        b=RoirUr2jt/tbOj04tZJOUwgGjCwp5JlFqSt1ai/woO7f+x/Pt6LXpnwki7SytDPL9M
         042dLHVt0L6gvjvrE8sY4AbYw3p5T02nrEl6qeRrJ1i0EH6XSyyskVhYxpkt7kDLmVR5
         zTJQYM4M+5Z/QZOBVPraN7cJKK3eVT5WJXqXVUBEKjbdwCaXPgcMT9nFD3UBHTrXSL2q
         IQ90pt2JvoPh0wznPyQJJl+D2uMlrSqQ54KrbStm1DjHkGznYwa2hZ/l2p3tWa3Q6NOu
         G8NpcIAdek2ibhxa2No5LiV1fsLvPMp/LADc8BCJzZE3z6VLOfyJwzsYjo95gGfgTkfZ
         SiIg==
X-Gm-Message-State: ABy/qLaOVkmYuRClXdLUOLXhBYNnRnxa+NPYVeDw7j1iTmIUYWXY8tPk
        aMDoF5kiKssvh8HCAkTIOM3CueKp/PJmRMkyplzXelmhifJBQ8n/ZYyjJgy9Ke8Spd2rCXbDdJS
        tmgH6HVWnBs0D/tMimNwfyXE=
X-Received: by 2002:a05:6000:118b:b0:2fb:1d3a:93ff with SMTP id g11-20020a056000118b00b002fb1d3a93ffmr3144624wrx.61.1688146683306;
        Fri, 30 Jun 2023 10:38:03 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGNvUqGRtSpV8GYS4YvqUz/RSiCqQm8TkeXUu3ip49084GlOjfQ0N7UqSkJYBy9eyJgB2uFhw==
X-Received: by 2002:a05:6000:118b:b0:2fb:1d3a:93ff with SMTP id g11-20020a056000118b00b002fb1d3a93ffmr3144605wrx.61.1688146683015;
        Fri, 30 Jun 2023 10:38:03 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id c13-20020adfe74d000000b0030ae499da59sm3745589wrn.111.2023.06.30.10.38.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 10:38:02 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Helge Deller <deller@gmx.de>,
        Ingo Molnar <mingo@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        x86@kernel.org
Subject: Re: [PATCH 0/2] Allow disabling all native fbdev drivers and only
 keeping DRM emulation
In-Reply-To: <ZJ8RY7ZUlryrPB50@smile.fi.intel.com>
References: <20230629225113.297512-1-javierm@redhat.com>
 <ZJ8RY7ZUlryrPB50@smile.fi.intel.com>
Date:   Fri, 30 Jun 2023 19:38:01 +0200
Message-ID: <878rc0etqe.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:

Hello Andy,

> On Fri, Jun 30, 2023 at 12:51:02AM +0200, Javier Martinez Canillas wrote:
>> This patch series splits the fbdev core support in two different Kconfig
>> symbols: FB and FB_CORE. The motivation for this is to allow CONFIG_FB to
>> be disabled, while still having the the core fbdev support needed for the
>> CONFIG_DRM_FBDEV_EMULATION to be enabled. The motivation is automatically
>> disabling all fbdev drivers instead of having to be disabled individually.
>> 
>> The reason for doing this is that now with simpledrm, there's no need for
>> the legacy fbdev (e.g: efifb or vesafb) drivers anymore and many distros
>
> How does simpledrm works with earlycon=efi?
>

simpledrm isn't for earlycon. For that you use a different driver (i.e:
drivers/firmware/efi/earlycon.c). I'm just talking about fbdev drivers
here that could be replaced by simpledrm.

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

