Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8207DC433E9
	for <linux-fbdev@archiver.kernel.org>; Wed, 27 Jan 2021 10:26:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C74A2064B
	for <linux-fbdev@archiver.kernel.org>; Wed, 27 Jan 2021 10:26:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235887AbhA0K0i (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 27 Jan 2021 05:26:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235746AbhA0KYn (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 27 Jan 2021 05:24:43 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF403C061573;
        Wed, 27 Jan 2021 02:24:02 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id jx18so1066922pjb.5;
        Wed, 27 Jan 2021 02:24:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=xRcgTb91tK28anYqrlC++wtp+Am92iHcjy/4eSWbMUs=;
        b=ZVd0VPHkqckjxZmYv4/v2cboiZSDr8qUPwHMzMlYHsy0Hu3sK1Sh2jfHizwSenYTig
         AhejQOWtpeZ6dqXMdwqVaZLcgU4eRtnJIhzFAUjdHqTxQdJOLRaJM3nA+QMX5DBrFf0l
         FEjo16QriDvnD/40PuuhCJfhDE37wGRKgRZgqGdh1w7ZQLl9zmuB+/UpKLSRkCkeKgbs
         Qtk5QufgvK8Hdz7om32gkQZ8rOPszKZnTwGaPCHTaZEIe4VlQxkTHRQOdObfncNdfbww
         lF8aItGo2wKUlFFRS9qH3RqjWY4t4aWl5oWjSJIMHSSUnpgu4Nyk5kTyPImZSSTwvPIk
         129g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=xRcgTb91tK28anYqrlC++wtp+Am92iHcjy/4eSWbMUs=;
        b=sHnyJIMr2LB26quLykEue5ScEauT/BaGBl78jj3lC5bRSPkDIu7Ycrj+MNjy2lAT+h
         9oRv8hf7tkAFqCwcqR2+xvAJ/5HdKSbNTRyLK3409GLewquiisGHWtHiA/P7LmO1Nttx
         qt23sa42EMLg5KerU10/tvWmqvb+7pmW2S5VNKX31FNsUv8XFJrDuEpCACgtnJGxqkG5
         qX5X6WRnsrr3uX3TKhbAWhrhw1YUPZZ7qk+lWPoUxNkM2zdpVH7ajtjDQ1ZBEgloDswZ
         Z9EpqNr3QTUl38Gr0a3YO8UsT0na/i5Cdulf7e+U8WXUxct8zDHtczTr1btGEJwxW7VY
         ZHxg==
X-Gm-Message-State: AOAM5326cRiCc08KsI9U0XCSpq3FaDY0LqdFgGAMXf6T7E917Gb5hcK7
        UBafnJBbXBe75Ie2cicHHPU=
X-Google-Smtp-Source: ABdhPJzTgP2xJ9TiEus/lM8X6G6P4az0ohaUTLuqRAbnoOTXq0i9h7FnZEwNwwYqWfTlv5yT/U1Epg==
X-Received: by 2002:a17:90a:3f82:: with SMTP id m2mr4895955pjc.235.1611743042596;
        Wed, 27 Jan 2021 02:24:02 -0800 (PST)
Received: from localhost ([103.220.76.197])
        by smtp.gmail.com with ESMTPSA id d128sm2152572pga.87.2021.01.27.02.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jan 2021 02:24:01 -0800 (PST)
Date:   Wed, 27 Jan 2021 18:23:55 +0800
From:   carlis <zhangxuezhi3@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-fbdev@vger.kernel.org, mh12gx2825@gmail.com,
        oliver.graute@kococonnector.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, sbrivio@redhat.com,
        colin.king@canonical.com, zhangxuezhi1@yulong.com
Subject: Re: [PATCH v6] fbtft: add tearing signal detect
Message-ID: <20210127182355.00007300@gmail.com>
In-Reply-To: <20210127085951.GE2696@kadam>
References: <1611732502-99639-1-git-send-email-zhangxuezhi3@gmail.com>
        <20210127085951.GE2696@kadam>
Organization: Tyzmig-ryrjum-8kedto
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Wed, 27 Jan 2021 11:59:51 +0300
Dan Carpenter <dan.carpenter@oracle.com> wrote:

> On Wed, Jan 27, 2021 at 03:28:22PM +0800, Carlis wrote:
> >  static int init_display(struct fbtft_par *par)
> >  {
> > +	int rc;
> > +	struct device *dev = par->info->device;
> > +
> > +	par->gpio.te = devm_gpiod_get_index_optional(dev, "te", 0,
> > GPIOD_IN);
> > +	if (IS_ERR(par->gpio.te)) {
> > +		rc = PTR_ERR(par->gpio.te);
> > +		pr_err("Failed to request te gpio: %d\n", rc);
> > +		par->gpio.te = NULL;
> > +	}
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
> 
> #SadFaceEmoji
> 
> > +		}
> > +	} else {
> > +		pr_info("%s:%d, TE gpio not specified\n",
> > +			__func__, __LINE__);
> > +	}  
> 
> regards,
> dan carpenter
> 
Sorry,i will delete this log in patch v8
regards
zhangxuezhi
