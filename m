Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF0B6C83F37
	for <linux-fbdev@archiver.kernel.org>; Thu, 31 Aug 2023 17:40:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345099AbjHaRkJ (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 31 Aug 2023 13:40:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344685AbjHaRkI (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 31 Aug 2023 13:40:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F298CF3
        for <linux-fbdev@vger.kernel.org>; Thu, 31 Aug 2023 10:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693503555;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AtJ/xu3bwCImw2coTT6CdE5L9VMjGKy3wVeoWmhJJx8=;
        b=U5MFPxx//nXZcyM4OLoE2Q1mpJeyQbl5livX+gWUl78jsHHCBPDiIe4JgJ5GKOFZQwM+dw
        I5tfPOigzFORMCnJuNYSXYg49Cqlx5n3AfcL3E4epgdpdHh8je8hsqap9TiL1LkH+Nzy3N
        IcmY8KxQIm+Ot0qSjPkOCJSVmrFxP7s=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-jodjl8-fP_mcOAnyNdrk_A-1; Thu, 31 Aug 2023 13:39:14 -0400
X-MC-Unique: jodjl8-fP_mcOAnyNdrk_A-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3fe1dadb5d2so7873935e9.1
        for <linux-fbdev@vger.kernel.org>; Thu, 31 Aug 2023 10:39:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693503552; x=1694108352;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AtJ/xu3bwCImw2coTT6CdE5L9VMjGKy3wVeoWmhJJx8=;
        b=jc5LxZWCHEB7nzKAlvAKqvrH+hmsOgm9p4NETHjV+CGGPQqwttL3shbxjR7Nx6miuP
         /HTEbhfzFPIbhMSRm0tsNBsSo8q9OTHTHpZ7ryIddL3YcqtIYt1k1ZEx5YEXlGGgg8UX
         3mC+LrCEAxoqgfC5/lP7M4a9efVgKwqR9Mjz3ncg525zxRfZSWWmARoynQgPKGPRMWn1
         08boBFCf+RnaQ/9l2FTo1IKofOCjwyZ2RmCAv19t1GmT7dF9HEspAWoBwEmBXApNHOCR
         MsUEZO+vPfbyqVnDQ1C7nQA2GI0HPHYUPZmaEQRaJtynr3P9LLHkXr6iTuCKY8Kq2HaK
         ejlQ==
X-Gm-Message-State: AOJu0Yw58KLKup20CNoO0cH5gVSFDPOK+Edtn04AoaWXzT0LY7LVP8AT
        DmWz8xE/AtL3JIVdZ5B2LrR75pTNqHbxouFH0+4t5Ahqblp1cLQ9p0DdZrPqeEXOXvYJGd8IoWy
        z+janoTGwGnuXyyypS4rGBX6LaD0nhBY=
X-Received: by 2002:a05:600c:c2:b0:401:bf56:8ba6 with SMTP id u2-20020a05600c00c200b00401bf568ba6mr4496wmm.28.1693503552781;
        Thu, 31 Aug 2023 10:39:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEivxTh4Rq8dPVE35ney4tz4ygOX1lBKSZsUkTZIjeqJXTZbZCqBVjVM7uY5scHsqy1MGfxAQ==
X-Received: by 2002:a05:600c:c2:b0:401:bf56:8ba6 with SMTP id u2-20020a05600c00c200b00401bf568ba6mr4482wmm.28.1693503552430;
        Thu, 31 Aug 2023 10:39:12 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id e4-20020adfe7c4000000b0031c6581d55esm2861784wrn.91.2023.08.31.10.39.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 10:39:12 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Helge Deller <deller@gmx.de>
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] fbdev: ssd1307fb: Use bool for ssd1307fb_deviceinfo flags
In-Reply-To: <303bb1a5012862f0003d3246a0c8120b97ea995b.1693483416.git.geert+renesas@glider.be>
References: <303bb1a5012862f0003d3246a0c8120b97ea995b.1693483416.git.geert+renesas@glider.be>
Date:   Thu, 31 Aug 2023 19:39:10 +0200
Message-ID: <87o7inaz7l.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Geert Uytterhoeven <geert@linux-m68k.org> writes:

> The .need_pwm and .need_chargepump fields in struct ssd1307fb_deviceinfo
> are flags that can have only two possible values: 0 and 1.
> Reduce kernel size by changing their types from int to bool.
>
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---

Acked-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

