Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08354C433EF
	for <linux-fbdev@archiver.kernel.org>; Tue,  8 Feb 2022 23:06:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234097AbiBHXGg (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 8 Feb 2022 18:06:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233640AbiBHXGf (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Tue, 8 Feb 2022 18:06:35 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 72D09C061577
        for <linux-fbdev@vger.kernel.org>; Tue,  8 Feb 2022 15:06:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644361594;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9Hq44IoeTfJkZkwVY9Vl9iSJryds5VqEFOHSRWPT7XY=;
        b=QiUhzl8g5640Obe+GZgf0gNwBjbtgl8qFFwRmRNEgNQ6PeWIgE7zIavZ62MjPaOMc2b/aL
        tHnJE/6qy+uvgX8UwlXRTjGspIzauy2m2bXAflHuo8mImsdNyc3qgqbPcXu8Eik/5vH4Nz
        7lwHEdauqDWQUdfJ13FqmsRhDGdcv8w=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-673-ikm4f-frMPClY3__X3R41w-1; Tue, 08 Feb 2022 18:06:33 -0500
X-MC-Unique: ikm4f-frMPClY3__X3R41w-1
Received: by mail-wm1-f69.google.com with SMTP id 129-20020a1c0287000000b0037bedbc7e87so414585wmc.8
        for <linux-fbdev@vger.kernel.org>; Tue, 08 Feb 2022 15:06:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=9Hq44IoeTfJkZkwVY9Vl9iSJryds5VqEFOHSRWPT7XY=;
        b=fVjUhz5/voT+BXNH4JgmxSv12i1/PF7uj7gj8HEV7FMZwh7OHubbESD1LuL8Xvtieb
         EQATRePRrvjaQp0EYqnnHif8HSaG0tA+YzXWrcbiHOXd3XRX3RsckrwJpnF7QQoLowXf
         JBUPHSBLTDP5aTokKo8Z/QpeQsprdbL2uF+sLH4Jvq2dU8//bhs/OXUWTFNCLNwrSz0e
         7eIiE+ckZ3+d+2y+4OGBxdnvDSIjh9OVNKEyT58X2Bgo4keeKCvq280WTRSs16o4PDIh
         NwQWjf0gwZoojJ2/QpLZP3aJyt2OhOZdONNOk1L4ZTYQM3QboO3U0MtrHdGn2f+9mVtN
         2SVg==
X-Gm-Message-State: AOAM532VhoMX5Yn4Tx6YCr2tq0UyzcmOZIdZwWMFJtbZ55WuCVo/LXxP
        q0GYa8UAnQrjg7ySsc9O4ORvSKHBiHQUpvTnkdHA0r4ryV0/IwUdSCI+YUpxhSnjdDvuJcP33JC
        cUwS1ngGFty41DxdB0tuq1bY=
X-Received: by 2002:a05:600c:1f06:: with SMTP id bd6mr188792wmb.98.1644361591950;
        Tue, 08 Feb 2022 15:06:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwmNuGMQwcN6QexrJL10FFKZYDdF5TN06r7ebrBGFi7sK9RD4aMR2dVzQHHgAbW45sC7ClvFg==
X-Received: by 2002:a05:600c:1f06:: with SMTP id bd6mr188768wmb.98.1644361591694;
        Tue, 08 Feb 2022 15:06:31 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id l26sm2975339wmp.31.2022.02.08.15.06.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Feb 2022 15:06:31 -0800 (PST)
Message-ID: <4f5a94f9-404f-e803-1b61-41653c9de388@redhat.com>
Date:   Wed, 9 Feb 2022 00:06:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 02/19] fbcon: Move fbcon_bmove(_rec) functions
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
        Daniel Vetter <daniel.vetter@intel.com>,
        Helge Deller <deller@gmx.de>
References: <20220208210824.2238981-1-daniel.vetter@ffwll.ch>
 <20220208210824.2238981-3-daniel.vetter@ffwll.ch>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20220208210824.2238981-3-daniel.vetter@ffwll.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 2/8/22 22:08, Daniel Vetter wrote:
> Avoids two forward declarations, and more importantly, matches what
> I've done in my fbcon scrolling restore patches - so I need this to
> avoid a bunch of conflicts in rebasing since we ended up merging
> Helge's series instead.
> 
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat

