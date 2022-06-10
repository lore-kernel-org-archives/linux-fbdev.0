Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECBB9C43334
	for <linux-fbdev@archiver.kernel.org>; Fri, 10 Jun 2022 09:50:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244063AbiFJJuG (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 10 Jun 2022 05:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244610AbiFJJuE (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 10 Jun 2022 05:50:04 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24F42674E4
        for <linux-fbdev@vger.kernel.org>; Fri, 10 Jun 2022 02:50:00 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id bg6so32630448ejb.0
        for <linux-fbdev@vger.kernel.org>; Fri, 10 Jun 2022 02:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=GM7d3E0tduZqRYf2e+s3dbuLzIr4Mw1YJSMLDAOVaMI=;
        b=mPsDPC8Jc7T4BUqovcJHh9X9aOrAhrclaAa/mhdil1CMSWhn30imVTqNFRV+0HRuZR
         9clubq9kS7nPcWWq0+jUK/ZXeKuiFGzZDvtFDwXEp2uxKkZ+j2tw+p6oTgwkJY+ubiyC
         fNpq3+oeKLsbInyhxMt0RU7rnoLmgsm+qFbiG6K8ZL9ftfWRVogRMaCLYG0PEmOcWyxi
         Ej/gBPv4wGEs//8C5AqndzktP0qrzc314Ie0fAKrmlRueinVOKmVaBBtnVyEHYDDTkgY
         p8yH/z6bfp1mBhN+ixEyIEW0HoPZyP6dMU1cLXojoX9F8XKV/BwCrjhvbDch3r8LG4uz
         wQww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=GM7d3E0tduZqRYf2e+s3dbuLzIr4Mw1YJSMLDAOVaMI=;
        b=pFY8gzKYOlXO1epcfrjFZCAhWdbuDXNX9QaoAaQXZJ2M2UiN4G/Zqr+Nh6teGDH1OI
         rHPNAS8oSpQ0oysa1sP2VMsHWxVbXxDRYybbVCRqap4D1EvQM+5ZLLHdRq+qGUViK5Do
         NOlJc87mlsfsJ5D277WvdHZEZ88SnoqjnCoEeoOCYHTxnsp2K/4DJQ7XWjcFAgnFpIKN
         i7caPXFsdYO1zjJaxS4HFM22pyMV+uLmqZ0PtucBGVOvyIMjgV4b3RY2mVZ8D8ibjCzg
         dFVNnXBls0apRDwQGvsOEkODjernfqfQrKpq5FgKTK+gJqlXjCmAHxKxk9gcXYqqARNt
         W2yA==
X-Gm-Message-State: AOAM533D5c1HiDoCzCPf1v7st/7p+xSWjnYQwInl/iefvG9zw79fgvRb
        mCUcy2uFhx+NtvLohN9USKtEcQ==
X-Google-Smtp-Source: ABdhPJyCD/klApB8VX8jrzmpF60V4CVF43i+O2miGAxeX9trvWXvTRU8uZ81PMBn+YHe3kzoGb0iXQ==
X-Received: by 2002:a17:907:3f08:b0:711:d61d:e10 with SMTP id hq8-20020a1709073f0800b00711d61d0e10mr21666615ejc.11.1654854598989;
        Fri, 10 Jun 2022 02:49:58 -0700 (PDT)
Received: from ash.lan (82-132-215-210.dab.02.net. [82.132.215.210])
        by smtp.gmail.com with ESMTPSA id o13-20020a17090608cd00b006fedcb78854sm11931009eje.164.2022.06.10.02.49.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jun 2022 02:49:58 -0700 (PDT)
Date:   Fri, 10 Jun 2022 10:49:55 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Stephen Kitt <steve@sk2.org>
Cc:     Sam Ravnborg <sam@ravnborg.org>, linux-fbdev@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Helge Deller <deller@gmx.de>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] fbdev: atmel_lcdfb: Rework backlight status updates
Message-ID: <20220610094955.cy53ujicaplr7aw7@ash.lan>
References: <20220608205623.2106113-1-steve@sk2.org>
 <20220609095412.fccofr2e2kpzhw4t@maple.lan>
 <YqIuUYUXzxeSgZ/o@ravnborg.org>
 <20220609194511.4e0bc3e6@heffalump.sk2.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220609194511.4e0bc3e6@heffalump.sk2.org>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Thu, Jun 09, 2022 at 07:45:11PM +0200, Stephen Kitt wrote:
> Hi Sam, Daniel,
>
> On Thu, 9 Jun 2022 19:30:57 +0200, Sam Ravnborg <sam@ravnborg.org> wrote:
> > thanks for taking care of all these backlight simplifications - this
> > really helps to make the code simpler and more readable.
>
> You’re welcome! I noticed fb_blank was deprecated and near enough unused, and
> started digging...

I saw Sam's comment and kinda wished I'd thought to say that... definitely
good to see these things being tidied up.


Daniel.
