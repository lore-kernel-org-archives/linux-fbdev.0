Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0560EC433E6
	for <linux-fbdev@archiver.kernel.org>; Wed, 27 Jan 2021 06:31:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD664205CA
	for <linux-fbdev@archiver.kernel.org>; Wed, 27 Jan 2021 06:30:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbhA0GaG (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 27 Jan 2021 01:30:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbhA0GUP (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 27 Jan 2021 01:20:15 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 690BBC061574;
        Tue, 26 Jan 2021 22:19:35 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id my11so2487541pjb.1;
        Tue, 26 Jan 2021 22:19:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=+AVxzGfMqYMx9RPIgoRtcct2VE1ZRqZ1PBLR8znjyvQ=;
        b=jQGw6IpPbNt4L5SXLZ6/mKlNuFjt5RROmiIjibyXO+me3dqe6+J9AGUFDjNXYKkqjM
         qVqGmLPPpkmYWNenr063FwvG7ZWOeVOWPsTZKPLvvAlS9mEfSXmVJrMbXwrvbx10D90s
         SZve8a4DPC8Kw8nuQ8qXCH2yYbdXUJ6nnS9LIS3kggQWUWhBY9eY/LYZJa6HWIMJ3vw8
         02Yd6E8icfCEJ4S49jZK9N8X9c/T/rrT2u1yDMkPM5Psp9pW2PcI/eiDINV0f/FFuBAc
         VVNRbdC4Kph5tndKiflPXfs179eMyxaCC3Rb27VPIkTw7utVRzoeY+qg9h9ax+2gJ/f8
         xpQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=+AVxzGfMqYMx9RPIgoRtcct2VE1ZRqZ1PBLR8znjyvQ=;
        b=gkfaMy+7ynSNBe0kNXQFN5CRq2tMKIAJmjQLmrv1FU8kFAPyh/4vsGDD7SIH7dpLTb
         k3piliVGnEUEfzleI1y8HxxWDSPhjR01QNbjuX3FinCpFsuuj1Urxqj2dgLq/0TmL1QS
         ZMXp70I2crI0C4uL675kXhtoccqgZ1bbA8k3fPKu3/nkv3eMcsvH2XeevRavSuy1lDIA
         2PAa8XLkryYmS+d4OtIKcdPDTfOAcNVEwWpoGI+HfSQ+Mw/2Q/feRdwqp0mRsXnSDj5F
         J+Hdp785w0HKGpVdVT+IRSaA44d3PDH2cUwUafgDL3HA/1F9QixLLTyf/Ea7AXPESy7D
         xaqw==
X-Gm-Message-State: AOAM531OnvtQujHaY8e1Su6IH9TS4JetYiMvfa5m0dh4ihUbCjbQvU/r
        ss5tpybb6VA0b4jnAGpmT2A=
X-Google-Smtp-Source: ABdhPJw3xTWutH1s20TQixwXD6pOjBaO3Uam1zSz+Lc9n84CDHMRzzsMAr0X6sMA+/isS4YpBnlbFA==
X-Received: by 2002:a17:903:22c2:b029:dd:f952:e341 with SMTP id y2-20020a17090322c2b02900ddf952e341mr9583056plg.67.1611728374922;
        Tue, 26 Jan 2021 22:19:34 -0800 (PST)
Received: from localhost ([103.220.76.197])
        by smtp.gmail.com with ESMTPSA id i7sm1057917pfc.50.2021.01.26.22.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 22:19:34 -0800 (PST)
Date:   Wed, 27 Jan 2021 14:19:27 +0800
From:   carlis <zhangxuezhi3@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-fbdev@vger.kernel.org, mh12gx2825@gmail.com,
        oliver.graute@kococonnector.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, sbrivio@redhat.com,
        colin.king@canonical.com, zhangxuezhi1@yulong.com
Subject: Re: [PATCH v5] fbtft: add tearing signal detect
Message-ID: <20210127141927.00004472@gmail.com>
In-Reply-To: <20210127054523.GA2696@kadam>
References: <1611711140-68260-1-git-send-email-zhangxuezhi3@gmail.com>
        <20210127054523.GA2696@kadam>
Organization: Tyzmig-ryrjum-8kedto
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Wed, 27 Jan 2021 08:45:23 +0300
Dan Carpenter <dan.carpenter@oracle.com> wrote:

> On Wed, Jan 27, 2021 at 09:32:20AM +0800, Carlis wrote:
> > @@ -82,6 +111,29 @@ enum st7789v_command {
> >   */
> >  static int init_display(struct fbtft_par *par)
> >  {
> > +	int rc;
> > +	struct device *dev = par->info->device;
> > +
> > +	par->gpio.te = devm_gpiod_get_index_optional(dev, "te", 0,
> > GPIOD_IN);
> > +	if (par->gpio.te) {
> > +		init_completion(&spi_panel_te);
> > +		mutex_init(&te_mutex);
> > +		rc = devm_request_irq(dev,
> > +				      gpiod_to_irq(par->gpio.te),
> > +				     spi_panel_te_handler,
> > IRQF_TRIGGER_RISING,
> > +				     "TE_GPIO", par);
> > +		if (rc) {
> > +			pr_err("TE request_irq failed.\n");
> > +			devm_gpiod_put(dev, par->gpio.te);
> > +			par->gpio.te = NULL;
> > +		} else {
> > +
> > disable_irq_nosync(gpiod_to_irq(par->gpio.te));
> > +			pr_info("TE request_irq completion.\n");
> > +		}
> > +	} else {
> > +		pr_info("%s:%d, TE gpio not specified\n",
> > +			__func__, __LINE__);
> > +	}  
> 
> I'm sorry that I was not clear before.  This code will crash if
> devm_gpiod_get_index_optional() returns an error.  You *NEED* to check
> for error pointers and return the error code.  Write it exactly like
> this:
> 
> 	par->gpio.te = devm_gpiod_get_index_optional(dev, "te", 0,
> GPIOD_IN); if (IS_ERR(par->gpio.te))
> 		return PTR_ERR(par->gpio.te);
> 
> 	if (par->gpio.te) {
> 		init_completion(&spi_panel_te);
> 
> 
> regards,
> dan carpenter
> 

hi,i will fix it like below:
	par->gpio.te = devm_gpiod_get_index_optional(dev, "te", 0,
GPIOD_IN); if (IS_ERR(par->gpio.te)) {
		rc = PTR_ERR(par->gpio.te);
		pr_err("Failed to request  te gpio: %d\n", rc);
		par->gpio.te = NULL;
	}
	if (par->gpio.te) {
		init_completion(&spi_panel_te);
		mutex_init(&te_mutex);
		rc = devm_request_irq(dev,
				      gpiod_to_irq(par->gpio.te),
				     spi_panel_te_handler,
IRQF_TRIGGER_RISING, "TE_GPIO", par);
		if (rc) {
			pr_err("TE request_irq failed.\n");
			devm_gpiod_put(dev, par->gpio.te);
			par->gpio.te = NULL;
		} else {
			disable_irq_nosync(gpiod_to_irq(par->gpio.te));
			pr_info("TE request_irq completion.\n");
		}
	} else {
		pr_info("%s:%d, TE gpio not specified\n",
			__func__, __LINE__);
	}

regards,
zhangxuezhi
