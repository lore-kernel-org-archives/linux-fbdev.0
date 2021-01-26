Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 011F5C4332E
	for <linux-fbdev@archiver.kernel.org>; Tue, 26 Jan 2021 12:45:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBCF82313C
	for <linux-fbdev@archiver.kernel.org>; Tue, 26 Jan 2021 12:45:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404244AbhAZMpI (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 26 Jan 2021 07:45:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390929AbhAZMoI (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 26 Jan 2021 07:44:08 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EABB9C0611C2;
        Tue, 26 Jan 2021 04:43:27 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id kx7so1908849pjb.2;
        Tue, 26 Jan 2021 04:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=CHwpeu6c09qFT/nfW/FBTV0Yt+7M8XMevwcf8rehKEQ=;
        b=eD3KrY6q3kL0Z7cbxL5H58fCRrHFbXpyoFi/RGW1iW7yT+x5WZezW9L7EOw/jPCDJW
         LjhUlg8aZK68v/9v5ONg9Ccea6udrN2VrDkvjtgty6rl6bxPEKbtZOOU/yYdyVFdvrs+
         CSl4cF6wzhU8b5RcW4gVPpvyfa9n7DfTfEDztoIvMR5M/ffhgoqV6B1CCt8zLWeA/Gld
         OIhWruHwNOocX8WW8wUB+8343I1akuAnbiKPvyX8PMDhEIetk5oyk7QDm9QU1GWYCnk0
         WkBkkYFiYe22x4Hp+cqAK/05xAjanbzBxaGieMbBNE5MAgoajRpA1ypBaJ0kVyLKyPgu
         iLMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=CHwpeu6c09qFT/nfW/FBTV0Yt+7M8XMevwcf8rehKEQ=;
        b=N/uVuicFQlkgdVlPr/zBl0b8cUHw12+EcAwDPlmhNTqJyCmjG8FXjPxg32FefxmHXz
         mb/XOOp/BitVGv5/pvKt+le/gl2KFVtmtpNi2Gok9vEjtEtacCIxyGUALqPmrCmtPPRr
         OkQ0GmfNJBLgyAgVQzSb8Edxf9nr7IPYhunPSNZCbVHSypn4Yg8UbFVHwqg5Q9U1bb9G
         bw24pkrlAmrTvLcYrXEKKbBR1eomjYzJlKy4y54DQbJoNvdcOkFtnOEnwzNc1oQfxbpW
         gQa2DZ4bQg+2blYvhDoKvUfZMFW8J4fTxzkvCCVdLYsNtBQvHNUVO35s7bWNlDIf93iG
         frEw==
X-Gm-Message-State: AOAM530zKMm0Ej78eWU59FkGQdiQataSUmbpwSCo8kdNRi6Esb8dP9lr
        beIfhYZLJx1I2LhMvwd0Od4=
X-Google-Smtp-Source: ABdhPJwZExaVBsb2ZGPi510vn+4fu00M6Cx7MkTAObnaU9LpVFjMKikRVVYkyoVW4oWazlbjduOrWA==
X-Received: by 2002:a17:902:348:b029:df:fa69:1ef0 with SMTP id 66-20020a1709020348b02900dffa691ef0mr5820828pld.41.1611665007446;
        Tue, 26 Jan 2021 04:43:27 -0800 (PST)
Received: from localhost ([103.220.76.197])
        by smtp.gmail.com with ESMTPSA id l14sm2274300pjy.15.2021.01.26.04.43.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 04:43:26 -0800 (PST)
Date:   Tue, 26 Jan 2021 20:43:16 +0800
From:   carlis <zhangxuezhi3@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-fbdev@vger.kernel.org, mh12gx2825@gmail.com,
        oliver.graute@kococonnector.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, sbrivio@redhat.com,
        colin.king@canonical.com, zhangxuezhi1@yulong.com
Subject: Re: [PATCH] fbtft: add tearing signal detect
Message-ID: <20210126204316.00004cff@gmail.com>
In-Reply-To: <20210126075441.GW2696@kadam>
References: <1611502537-80668-1-git-send-email-zhangxuezhi3@gmail.com>
        <20210126075441.GW2696@kadam>
Organization: Tyzmig-ryrjum-8kedto
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Tue, 26 Jan 2021 10:54:41 +0300
Dan Carpenter <dan.carpenter@oracle.com> wrote:

> On Sun, Jan 24, 2021 at 11:35:37PM +0800, Carlis wrote:
> > +static irqreturn_t spi_panel_te_handler(int irq, void *data)
> > +{
> > +	complete(&spi_panel_te);
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +static void enable_spi_panel_te_irq(struct fbtft_par *par, bool
> > enable)  
> 
> It quite confused me that enable actually disables.  I always feel
> like it's clearer to write these as two separate functions.
> 
> > +{
> > +	static int te_irq_count;
> > +
> > +	if (!par->gpio.te) {  
> 
> This is always checked in the caller.  And it's when it's NULL that
> means it's deliberate so don't print a message.
> 
> > +		pr_err("%s:%d,SPI panel TE GPIO not configured\n",
> > +		       __func__, __LINE__);
> > +		return;
> > +	}
> > +
> > +	mutex_lock(&te_mutex);
> > +
> > +	if (enable) {
> > +		if (++te_irq_count == 1)
> > +			enable_irq(gpiod_to_irq(par->gpio.te));
> > +	} else {
> > +		if (--te_irq_count == 0)
> > +			disable_irq(gpiod_to_irq(par->gpio.te));
> > +	}
> > +	mutex_unlock(&te_mutex);
> > +}
> > +
> >  /**
> >   * init_display() - initialize the display controller
> >   *
> > @@ -82,6 +117,28 @@ enum st7789v_command {
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
> devm_gpiod_get_index_optional() can return NULL or error pointers.  If
> it returns NULL then don't print an error message.  NULL reports are
> deliberate.
> 
> 	par->gpio.te = devm_gpiod_get_index_optional(dev, "te", 0,
> GPIOD_IN); if (IS_ERR(par->gpio.te)) {
> 		pr_err("%s:%d, TE gpio not specified\n", __func__,
> __LINE__); return PTR_ERR(par->gpio.te);
> 	}
> 
> 	if (par->gpio.te) {
> 
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
> > +			par->gpio.te = NULL;
> > +		} else {
> > +
> > disable_irq_nosync(gpiod_to_irq(par->gpio.te));
> > +			pr_err("TE request_irq completion.\n");  
> 
> Why is this printing an error message if devm_request_irq() succeeds?
> 
> > +		}
> > +	} else {
> > +		pr_err("%s:%d, TE gpio not specified\n",
> > +		       __func__, __LINE__);
> > +	}
> >  	/* turn off sleep mode */
> >  	write_reg(par, MIPI_DCS_EXIT_SLEEP_MODE);
> >  	mdelay(120);
> > @@ -137,6 +194,9 @@ static int init_display(struct fbtft_par *par)
> >  	 */
> >  	write_reg(par, PWCTRL1, 0xA4, 0xA1);
> >  
> > +    /*Tearing Effect Line On*/
> > +	if (par->gpio.te)
> > +		write_reg(par, 0x35, 0x00);
> >  	write_reg(par, MIPI_DCS_SET_DISPLAY_ON);
> >  
> >  	if (HSD20_IPS)
> > @@ -145,6 +205,76 @@ static int init_display(struct fbtft_par *par)
> >  	return 0;
> >  }
> >  
> > +/*****************************************************************************
> > + *
> > + *   int (*write_vmem)(struct fbtft_par *par);
> > + *
> > +
> > *****************************************************************************/
> > + +/* 16 bit pixel over 8-bit databus */
> > +int st7789v_write_vmem16_bus8(struct fbtft_par *par, size_t
> > offset, size_t len) +{
> > +	u16 *vmem16;
> > +	__be16 *txbuf16 = par->txbuf.buf;
> > +	size_t remain;
> > +	size_t to_copy;
> > +	size_t tx_array_size;
> > +	int i;
> > +	int rc, ret = 0;  
> 
> Delete one of these "rc" or "rec" variables.
> 
> > +	size_t startbyte_size = 0;
> > +
> > +	fbtft_par_dbg(DEBUG_WRITE_VMEM, par, "st7789v
> > ---%s(offset=%zu, len=%zu)\n",
> > +		      __func__, offset, len);
> > +
> > +	remain = len / 2;
> > +	vmem16 = (u16 *)(par->info->screen_buffer + offset);
> > +
> > +	if (par->gpio.dc)
> > +		gpiod_set_value(par->gpio.dc, 1);
> > +
> > +	/* non buffered write */
> > +	if (!par->txbuf.buf)
> > +		return par->fbtftops.write(par, vmem16, len);
> > +
> > +	/* buffered write */
> > +	tx_array_size = par->txbuf.len / 2;
> > +
> > +	if (par->startbyte) {
> > +		txbuf16 = par->txbuf.buf + 1;
> > +		tx_array_size -= 2;
> > +		*(u8 *)(par->txbuf.buf) = par->startbyte | 0x2;
> > +		startbyte_size = 1;
> > +	}
> > +
> > +	while (remain) {
> > +		to_copy = min(tx_array_size, remain);
> > +		dev_dbg(par->info->device, "    to_copy=%zu,
> > remain=%zu\n",
> > +			to_copy, remain - to_copy);
> > +
> > +		for (i = 0; i < to_copy; i++)
> > +			txbuf16[i] = cpu_to_be16(vmem16[i]);
> > +
> > +		vmem16 = vmem16 + to_copy;
> > +		if (par->gpio.te) {
> > +			enable_spi_panel_te_irq(par, true);
> > +			reinit_completion(&spi_panel_te);
> > +			rc =
> > wait_for_completion_timeout(&spi_panel_te,
> > +
> > msecs_to_jiffies(SPI_PANEL_TE_TIMEOUT));
> > +			if (rc == 0)
> > +				pr_err("wait panel TE time out\n");
> > +		}
> > +		ret = par->fbtftops.write(par, par->txbuf.buf,
> > +
> > startbyte_size + to_copy * 2);  
> 
> Line break is whacky.
> 
> > +		if (par->gpio.te)
> > +			enable_spi_panel_te_irq(par, false);
> > +		if (ret < 0)
> > +			return ret;
> > +		remain -= to_copy;
> > +	}
> > +
> > +	return ret;  
> 
> Shouldn't this be "return len;" or something?
> 
> > +}
> > +  
> 
> regards,
> dan carpenter
> 

OK,i will fix in patch v4

regards,
zhangxuezhi


