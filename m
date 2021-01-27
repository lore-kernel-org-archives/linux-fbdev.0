Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C63CC433DB
	for <linux-fbdev@archiver.kernel.org>; Wed, 27 Jan 2021 04:45:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 318A82070C
	for <linux-fbdev@archiver.kernel.org>; Wed, 27 Jan 2021 04:45:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239511AbhA0EpA (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 26 Jan 2021 23:45:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S317762AbhA0BQi (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 26 Jan 2021 20:16:38 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5E50C061574;
        Tue, 26 Jan 2021 17:15:56 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id l18so304649pji.3;
        Tue, 26 Jan 2021 17:15:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=KJ+yQ5bWaZ2enwzjx+4GHtaZjxc83d9TFtN5y4k2HgI=;
        b=i/yuys92Y5AzJRo1OemPBFbioTJmSuQ33639+tZ6prHwvFx51LOyZrVSO1E33i+8wh
         dEJHgrQ8sxZTiELoPu/HB5idN1Xr1ngd23fU7Q5qWKVITJs29r5uNEgiLJ+UF3eew7oh
         Te/siDN/xEQeEQxDBwRHsCc0asJLTkm6YLdAmJzmN6G5BtxF5PPok0bVMoyLAZ3KdEOI
         Iq/KGqEfFxJ8EHCQGitG/cuxLRRvin9iwNT0mDvewcCr0Gf/gUQc+rg3v6bY/LX+Q7bw
         v09GqAMKSqwIVfOdSE9AZRLH5lptxD2UA4smZNauFMOwPs6tZbLVbnqHk4lzlHnzj5FL
         mYJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=KJ+yQ5bWaZ2enwzjx+4GHtaZjxc83d9TFtN5y4k2HgI=;
        b=iPrIpZmJtnm4A/lBgvof7Ex0WrhPavph9v0axcfVChpD+iNYrEJsS3JbN7EQ1CN2DF
         N0/GkUURjM+MjEqrQw7WI3FI6YqOCFYhSN/4WnKv+l03vRM/tQnEkJyLQO6kRsmub0wl
         XJ80gJ6ky5s6xlcoqAyw/m/YsDKcovkwxAaVptP5NI9vHMAQQrnRBgGodIrsxbgGWwvk
         22RdouzIkNwCJLCkKXmCtZP59C4mgQ5m/+Z1qxnNEU3UpbYrWkJknBy/lzSivX4YZPvN
         SiuQqR3b096OFr1XqiYKXpBMLoEVHDRja70KdeNqJA468zNy3uUGvKYPzWiU2OoI/+FO
         k5qw==
X-Gm-Message-State: AOAM532dgHhLySFwjGe5FgXM0zIVWjftv/Fn27IdQDAiXNQnUvxkZckM
        xOHbB7AJhkfeMsqjPmI+OHI=
X-Google-Smtp-Source: ABdhPJwh8l3R0l+5Z0cCZw5Tw01gyH/2L5iZDeU27N+EyiLMmddVKlQ+fKoZdTxT07XrfYEndiiX9A==
X-Received: by 2002:a17:902:d64e:b029:df:e5b1:b7f7 with SMTP id y14-20020a170902d64eb02900dfe5b1b7f7mr8586928plh.10.1611710156278;
        Tue, 26 Jan 2021 17:15:56 -0800 (PST)
Received: from localhost ([103.220.76.197])
        by smtp.gmail.com with ESMTPSA id d128sm218943pga.87.2021.01.26.17.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 17:15:55 -0800 (PST)
Date:   Wed, 27 Jan 2021 09:15:49 +0800
From:   carlis <zhangxuezhi3@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-fbdev@vger.kernel.org, mh12gx2825@gmail.com,
        oliver.graute@kococonnector.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, sbrivio@redhat.com,
        colin.king@canonical.com, zhangxuezhi1@yulong.com
Subject: Re: [PATCH v4] fbtft: add tearing signal detect
Message-ID: <20210127091549.00005933@gmail.com>
In-Reply-To: <20210126175141.GZ2696@kadam>
References: <1611664835-150687-1-git-send-email-zhangxuezhi3@gmail.com>
        <20210126175141.GZ2696@kadam>
Organization: Tyzmig-ryrjum-8kedto
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Tue, 26 Jan 2021 20:51:41 +0300
Dan Carpenter <dan.carpenter@oracle.com> wrote:

> On Tue, Jan 26, 2021 at 08:40:35PM +0800, Carlis wrote:
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
> 
> I explained in my earlier review that devm_gpiod_get_index_optional()
> can return error pointers...  There was quite a bit of detail about
> how to handle this correctly in my earlier review, but I think you
> might not have noticed it.  Please read it again.
> 
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
> > +		pr_err("%s:%d, TE gpio not specified\n",
> > +		       __func__, __LINE__);
> > +	}  
> 
> regards,
> dan carpenter
> 
Thank you for your correction,i will change pr_err to pr_info in next
patch v5

regards,
dan carpenter
