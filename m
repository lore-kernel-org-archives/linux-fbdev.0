Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BDBCC433DB
	for <linux-fbdev@archiver.kernel.org>; Tue, 16 Feb 2021 15:49:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 064C864D9E
	for <linux-fbdev@archiver.kernel.org>; Tue, 16 Feb 2021 15:49:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbhBPPss (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 16 Feb 2021 10:48:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbhBPPsr (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 16 Feb 2021 10:48:47 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57835C06174A;
        Tue, 16 Feb 2021 07:48:06 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id o7so6482831pgl.1;
        Tue, 16 Feb 2021 07:48:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yKpUz4pp/u/PHJPYKcG1YaVfe5CKl2imPNvR4JyBFYE=;
        b=bfsYo575GoJd041ok+laM4Ze2S7KyjHJf0Srx5FyNMReJb74sZo75MjvzAVGc1anAQ
         6lgCnMT+leWn3V8hJesoG9eeQ93b7XrMlXcfyIXEc3idRL1auUm4wDo0TsTVBoPN0joV
         ou/TaTydMyNYRMIVv2ppEyXf0drLwBGQReum0gV/fhojLcA2Haz4I/f4RTFJldjbOrrI
         RyQ/mWRqnDQPSQMFjrvvhR//MY5L5O9CdzXq8v3nDW4Zb0x5GI7djRS8aWRV05sP8UKB
         yaX/6fsnhdA08FPa5rKljfhsuRJza+x8f/ZvF7c8VL5S4TOUIqfgsa16dah9NO2dMSr3
         QRkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yKpUz4pp/u/PHJPYKcG1YaVfe5CKl2imPNvR4JyBFYE=;
        b=P/bnM5H1rbb+JMzCsE4AkhjPVyoNKG/pvtTSX/A8zae/MSLHWUh29G1kfHj5h6CE1n
         Vt0XK6VGc5nA64+PoKAtBJHVDx/aV1IJePUSHig13zM+9kpHBUArBBqslsFz/Kt4D0zO
         IsrXgxcJMbvwgokKhkiRy6O7scsC912O0biBO/qc2CQi9m2tla2iu5IkpkqzJ4yu9NfY
         sqSKx7wue59x040wAo44ZQUrP0QtDe3Ip6NpRz43yHMb85lGtve9TtgKRQgAC2AOpSHD
         hLmPrd2CHCBO1m/tICpzc/Uha1WwU4nIZ+s5EgVnFtsOLZYsDLLJgmqv/O2YRiy5hiFN
         cYNQ==
X-Gm-Message-State: AOAM5339+vHp5wUnCrEvkuAb5+UZ2ZZpKS++xWCUoQybxFwYm4kYtI/b
        sF9jwh6dshG77ufNxA1efFo=
X-Google-Smtp-Source: ABdhPJwaooUaIKDd1k8p39TS9r9FEuHlOTnCnoBBnatGbzSGokeWf0RqRcRmZatTM6RlcbYYacdx4w==
X-Received: by 2002:a63:c1d:: with SMTP id b29mr19918863pgl.9.1613490485842;
        Tue, 16 Feb 2021 07:48:05 -0800 (PST)
Received: from localhost ([2402:3a80:11ea:c83a:a2a4:c5ff:fe20:7222])
        by smtp.gmail.com with ESMTPSA id n142sm22804138pfd.82.2021.02.16.07.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 07:48:05 -0800 (PST)
Date:   Tue, 16 Feb 2021 21:18:00 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Alex Elder <elder@ieee.org>
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Ioana Radulescu <ruxandra.radulescu@nxp.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Vaibhav Agarwal <vaibhav.sr@gmail.com>,
        Mark Greer <mgreer@animalcreek.com>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Marc Dietrich <marvin24@gmx.de>,
        Jens Frederich <jfrederich@gmail.com>,
        Daniel Drake <dsd@laptop.org>,
        Jon Nettleton <jon.nettleton@gmail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Teddy Wang <teddy.wang@siliconmotion.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        William Cohen <wcohen@redhat.com>,
        Mike Rapoport <rppt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Robert Richter <rric@kernel.org>, greybus-dev@lists.linaro.org,
        ac100@lists.launchpad.net, linux-tegra@vger.kernel.org,
        linux-fbdev@vger.kernel.org
Subject: Re: [PATCH 02/13] staging: greybus: Switch from strlcpy to strscpy
Message-ID: <20210216154800.jg24ahfj52t6qgbd@apollo>
References: <20210131172838.146706-1-memxor@gmail.com>
 <20210131172838.146706-3-memxor@gmail.com>
 <b565bdae-10a9-9b6c-ae60-dcee88f7dedd@ieee.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b565bdae-10a9-9b6c-ae60-dcee88f7dedd@ieee.org>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Tue, Feb 16, 2021 at 08:24:59PM IST, Alex Elder wrote:
> This is a good change.  But while you're at it, I would
> appreciate if you would convert a few spots to use
> sizeof(dest) rather than a fixed constant.  I will
> point them out below.
> 
> If this is the *only* request for a change on your
> series, please tell me that and I can sign off on

So far, this has been the only request.

> this without you implementing my suggestion.  But
> if you post a version 2, please do what I describe.
> 

I will incorporate these if I end up sending a v2.

Alternatively, would a separate patch with your suggestions applied on top of
this be acceptable, if I don't?

-- 
Kartikeya
