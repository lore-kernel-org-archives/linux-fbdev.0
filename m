Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C477C0015E
	for <linux-fbdev@archiver.kernel.org>; Fri,  7 Jul 2023 13:43:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232181AbjGGNnl (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 7 Jul 2023 09:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232552AbjGGNne (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Fri, 7 Jul 2023 09:43:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAFA41FE8
        for <linux-fbdev@vger.kernel.org>; Fri,  7 Jul 2023 06:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688737370;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=I+owWNOWvEK7SZ1O/p9+BsoqrhRbp6l42ZVJTUZNbK4=;
        b=al24FDfIHIpwfIhJZ/GjyMRkqN6Ebtm6UIeOmij0IPwvVUa9gbYQxg3jGwRv8oqKixNFVL
        IKF1S4ezG1Yo0QTg3UFKKdp7vdk5VUjZCJGwBfgDGDLudN86CWLuzZ/olGqwVU63g6JHMN
        tbZ0JVjmEIfPfP4HkMMW7nJNGql5eLU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-r15ZWOOAM6mRLF4mUuNYfA-1; Fri, 07 Jul 2023 09:42:49 -0400
X-MC-Unique: r15ZWOOAM6mRLF4mUuNYfA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3f5df65f9f4so11352305e9.2
        for <linux-fbdev@vger.kernel.org>; Fri, 07 Jul 2023 06:42:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688737368; x=1691329368;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I+owWNOWvEK7SZ1O/p9+BsoqrhRbp6l42ZVJTUZNbK4=;
        b=LN7Fda6FeKe0rUTDC38GoTxBmgo6f6ABNMTpA/5oGUmGd14N6n/HLv3KvkYdcaEibM
         2b7Lxn9jJNN8qb/AJGbdyjvTaHieostCfZ5y/bAIIUdODX/konNx3qcSJNDom3wB3ch+
         iWO54EwMM5tlPUvOdr4cjQvLNPkw60YNPJ56eK2vAcmyLjBakhQyueTy3dgfRcIv2KRB
         kbG4grtrghN2BfboqjARQbQGbuk8/9+p5RM6J110ZEed9ewFtPLCU0FGMoBOtwepsVGF
         V8qb0Ecej2JRq+GQ8QUdZRKhsLNCJq7gjnq2SM4yO7TjkhBrIPXiccm9Nc1M0jt97ylG
         81yQ==
X-Gm-Message-State: ABy/qLaz1n6j/f8FnvcFdbf/StMhyIQVenTCsfWctddmcgpxGCysfwT0
        AuAp9/C+/IfFDZRIQwdeSAqInBmpcimn2JdB1pqX7WaYIis0dDvbNgh/NHFl1/ynAEBmAYBJ8RD
        LviJsHxygGy+FOq2uM11ZYC0=
X-Received: by 2002:a7b:cd85:0:b0:3fb:5dad:1392 with SMTP id y5-20020a7bcd85000000b003fb5dad1392mr3824010wmj.17.1688737367976;
        Fri, 07 Jul 2023 06:42:47 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEZxhfEH8UwFPHB4pXOYFja3GHddFsOU/EgTb58z7K38wBQ2x+vg0IaPSVH4aXqur2PYGn+xA==
X-Received: by 2002:a7b:cd85:0:b0:3fb:5dad:1392 with SMTP id y5-20020a7bcd85000000b003fb5dad1392mr3823993wmj.17.1688737367817;
        Fri, 07 Jul 2023 06:42:47 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id k12-20020a7bc30c000000b003fba92fad35sm2498874wmj.26.2023.07.07.06.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 06:42:47 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Arnd Bergmann <arnd@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc:     linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>,
        dri-devel@lists.freedesktop.org, Ard Biesheuvel <ardb@kernel.org>,
        Helge Deller <deller@gmx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Guo Ren <guoren@kernel.org>,
        Brian Cain <bcain@quicinc.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        "David S. Miller" <davem@davemloft.net>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH 4/4] vgacon, arch/*: remove unused screen_info definitions
In-Reply-To: <20230707095415.1449376-4-arnd@kernel.org>
References: <20230707095415.1449376-1-arnd@kernel.org>
 <20230707095415.1449376-4-arnd@kernel.org>
Date:   Fri, 07 Jul 2023 15:42:46 +0200
Message-ID: <87edljyh0p.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Arnd Bergmann <arnd@kernel.org> writes:

> From: Arnd Bergmann <arnd@arndb.de>
>
> A number of architectures either kept the screen_info definition for
> historical purposes as it used to be required by the generic VT code, or
> they copied it from another architecture in order to build the VGA
> console driver in an allmodconfig build.
>
> Now that vgacon no longer builds on these architectures, remove the
> stale definitions.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Nice cleanup!

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

