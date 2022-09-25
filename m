Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 726A3C6FA82
	for <linux-fbdev@archiver.kernel.org>; Sun, 25 Sep 2022 13:30:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbiIYNa4 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sun, 25 Sep 2022 09:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbiIYNaz (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sun, 25 Sep 2022 09:30:55 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7406F11450
        for <linux-fbdev@vger.kernel.org>; Sun, 25 Sep 2022 06:30:54 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id fv3so4132572pjb.0
        for <linux-fbdev@vger.kernel.org>; Sun, 25 Sep 2022 06:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=OXxSODFo5RK1OPiZcfwmMGXOMnQSVIgwzDG1rWTmuVw=;
        b=C9bQCUb+Y41Skk2wQZQ1Xed0T91ahIyTlOmiDqwrtxQyInznN/QNI9VGaJCWgeerIQ
         zdjXSFs26RRdYQS7d2UmUBIA7JeoLdMqKyIa7zkFlgutlPL6RIR5fkDya8manVG5f7hd
         czjgnnKI8TFLNnhIwYtZhPr3U08JIcQZK3rqafMojUHFhAmZYMo0H/uooORKeyMjyWPD
         xGPt2itEmWZkhfN0U+z278z1ppxdHQMXK/MyY/Iu0/1mhGRkpzBiktLYZNFgc23I7YC6
         9346WoALD4FhHWHWEyEKUVvGIeMpfZfmPzF6UewfRu2lRx+sL6FsU0wlGJbSN8wtgGtQ
         mErg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=OXxSODFo5RK1OPiZcfwmMGXOMnQSVIgwzDG1rWTmuVw=;
        b=4YgD87fUBrfZmPfx8YbvCm0rT7iWyCeOL+omdj5wYWh3w3uCuV+n+PRmV7O8zL5SPQ
         Lqr91sSeEBGYolZUJWvSxARlCEHarED+S5nLBwgWPoMTkTODIMt2oiegHTy4841934O+
         pspmqX6rhx2vA+16UoQpDhSmiOP92u8782R5uA3I1MT8prKTrFn3EtCkp4Nq7EM48A7e
         mAv5wgmO0etJ1iwFppsbm+VCgD5IJ6EAC4OQ6z58nsoZ8Dz/DMBine7uBe3/pDUbIHVX
         Rk7S6t6ao/N346CMqM4bJlJHNj4mIyCRTn83I3PDh5MPW6nF/t/nweHVlSlVPFQIHpb9
         IK+g==
X-Gm-Message-State: ACrzQf24yGcuHQ7G61rSnP3FbmDt8183u0vG0Nehq/NvzmABxFyPHgOg
        3aF+78F6Jw3Qs12yvbJ9Zl8=
X-Google-Smtp-Source: AMsMyM7oesfI6+F4qbnHvAbqem7Bln+U6g36IhQpAQbnJfCp61ufSpIr7/ydcq0VdtR7DY7H8uQpBg==
X-Received: by 2002:a17:90b:380e:b0:202:d747:a044 with SMTP id mq14-20020a17090b380e00b00202d747a044mr20134917pjb.170.1664112654027;
        Sun, 25 Sep 2022 06:30:54 -0700 (PDT)
Received: from ubuntu ([175.124.254.119])
        by smtp.gmail.com with ESMTPSA id p9-20020a654909000000b0043bf861008fsm3161855pgs.90.2022.09.25.06.30.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Sep 2022 06:30:53 -0700 (PDT)
Date:   Sun, 25 Sep 2022 06:30:49 -0700
From:   Hyunwoo Kim <imv4bel@gmail.com>
To:     Helge Deller <deller@gmx.de>
Cc:     steve.glendinning@shawell.net, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, imv4bel@gmail.com
Subject: Re: [PATCH v2] video: fbdev: smscufx: Fix use-after-free in
 ufx_ops_open()
Message-ID: <20220925133049.GA383810@ubuntu>
References: <20220925123253.GA381917@ubuntu>
 <3eedfafb-f0ea-2d94-ae6e-fcf827e17378@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3eedfafb-f0ea-2d94-ae6e-fcf827e17378@gmx.de>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Sun, Sep 25, 2022 at 03:09:47PM +0200, Helge Deller wrote:
> it seems user and console don't need to be protected by the lock.
> Does it make sense to move them out of the lock?

you're right. Since both variables are not related to a race condition, 
it is better to get them out of the lock.

I will submit a v3 patch.


Best Regards,
Hyunwoo Kim.
