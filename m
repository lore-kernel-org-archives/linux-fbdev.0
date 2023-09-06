Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5C89EB8FAD
	for <linux-fbdev@archiver.kernel.org>; Wed,  6 Sep 2023 09:54:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234830AbjIFJy5 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 6 Sep 2023 05:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234358AbjIFJy5 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 6 Sep 2023 05:54:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DDF01982
        for <linux-fbdev@vger.kernel.org>; Wed,  6 Sep 2023 02:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693994044;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4tzibQVke0hKt8IOTav8MFtlZQ2trxpBqLxq9f+UJCg=;
        b=DZqbRuUv+SPvtnAMaMjts4/10xZzY942HPltd0Bx0Zn6Ld42v0IwC751dUVMO7KRz9NgHI
        qG9F8J3SCtY9i8MC0+IBGx/lpUtxH9hhwIQcQuCHBqRhbb59N48evAJQqAExSUG5d6Lq35
        nDn0057OHeHBsiA0oJzd92YUnpwgSM4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-505-JEzG8wDpM5uO0G3jB19uDA-1; Wed, 06 Sep 2023 05:54:03 -0400
X-MC-Unique: JEzG8wDpM5uO0G3jB19uDA-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-31adc3ca07aso1796659f8f.2
        for <linux-fbdev@vger.kernel.org>; Wed, 06 Sep 2023 02:54:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693994042; x=1694598842;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4tzibQVke0hKt8IOTav8MFtlZQ2trxpBqLxq9f+UJCg=;
        b=IiR9pjoCvkZdC/8oWWXHUwPh+rkg/134EFDJvWGbBUTOlUW0qb4lkAuzzkTZwk5oKV
         9k3AEMROHuRUdwhAM6T+n+gFZ/38hFKNoheT3noxs9YKirbPciYzp/hYBTepW2/zZfWF
         WvTAG4bSrwwUMhiwn8jwNnzM+NAzmCZGglyRAtIKwOKZOjDgKn9FOe4CbPNE6l1DRLdI
         emgaGuBXN2MI5kUwi4cwG9NfTgDbK884rhhFIy32nYYpE6PlCM/KllpwSwjEQnafGSnM
         OTHWs59kkyQQKaAZaK8lELq+6AmRNCDKN83kxBqp7WZnwHmEQFKnyDjSvnXlqs39HM0W
         sOCg==
X-Gm-Message-State: AOJu0Yw/c07/lSyuPK4nAFLHP6OXu3CI0WeMBqVQcGD7J1Et8Ab4rqx7
        j2LS3FNGmhiTFMxpIGfy2HuBLwYLc1glavlWpv7gfu3UFGyggNQN5UAKhgEKygc8wRXqMFCMbrY
        1poFGA0ZUlIKEWlwSYv1/r1c=
X-Received: by 2002:adf:f512:0:b0:31a:d871:7ae7 with SMTP id q18-20020adff512000000b0031ad8717ae7mr1954039wro.29.1693994042095;
        Wed, 06 Sep 2023 02:54:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHgP7ciy8RiRDljW7l6SGuO/N0itwoSv2n3TNrlmpxaanZjeoaWxrwp9lqX4hZlX6Ivt08wqQ==
X-Received: by 2002:adf:f512:0:b0:31a:d871:7ae7 with SMTP id q18-20020adff512000000b0031ad8717ae7mr1954025wro.29.1693994041793;
        Wed, 06 Sep 2023 02:54:01 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id bt12-20020a056000080c00b0031433443265sm14238423wrb.53.2023.09.06.02.54.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 02:54:01 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>, deller@gmx.de,
        daniel@ffwll.ch, sam@ravnborg.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 2/7] fbdev/mmp/mmpfb: Do not display boot-up logo
In-Reply-To: <20230829142109.4521-3-tzimmermann@suse.de>
References: <20230829142109.4521-1-tzimmermann@suse.de>
 <20230829142109.4521-3-tzimmermann@suse.de>
Date:   Wed, 06 Sep 2023 11:54:00 +0200
Message-ID: <87ledj4og7.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Thomas Zimmermann <tzimmermann@suse.de> writes:

> The fbcon module takes care of displaying the logo, if any. Remove
> the code form mmpfb. If we want to display the logo without fbcon,

s/form/from

> we should implement this in the fbdev core code.
>

The commit message says the same than patch #1 but the driver will behave
differently right? That is, won't only show the logo when fbcon is not
enabled but unconditionally? So the logo will be duplicated when fbcon is
enabled?

If I understood that correctly, probably you should mention that in the
commit message since removing the fb_show_logo() will make the driver to
behave correctly.

> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Acked-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

