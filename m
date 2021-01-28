Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F40F1C433DB
	for <linux-fbdev@archiver.kernel.org>; Thu, 28 Jan 2021 09:30:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8ECC64DE6
	for <linux-fbdev@archiver.kernel.org>; Thu, 28 Jan 2021 09:30:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbhA1J3b (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 28 Jan 2021 04:29:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232501AbhA1JZW (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 28 Jan 2021 04:25:22 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80BA6C061756;
        Thu, 28 Jan 2021 01:24:42 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id g3so3005773plp.2;
        Thu, 28 Jan 2021 01:24:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=mwV3/xQMhtiXtLZ+Mq1qTsQwALfHyXZpg4s1y6TXkNg=;
        b=ZGBv/LYhmLi4zaIKVJ9z9H+geH23aSQG0vsf8FRrIZ+UvcXjQ4lg4455ED6XHqcoP8
         sxJ/johTeXwaXkY6ypXhyJMw6laXAw9xbV0l80IPwKtNeH9UN2qjNg34cY1iu3Osh/Vn
         s/IjvUrgN1r15m+hjCLG5UxqF6aB08Ms82dobBq4x+dCbiVyG6XIGE5YsZL/XYIPGEuv
         57J+VDHvLnZ3MwozH5vvCKZX0dvLosotLjwrCe2cg7UDqDVJkY3mEfiHyVzTzmSmYu8s
         rJ0Kp5qBNKwmRRiHdWUB+BDLxywJdxyNgcSzcFG3mft66hCdL+jPLcEwksAlVppSvbyN
         5/Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=mwV3/xQMhtiXtLZ+Mq1qTsQwALfHyXZpg4s1y6TXkNg=;
        b=W66w7wGnmYr+i96YXuxKZbJRki46oK5TtoI5uHOCACas4gGnSxGt3NrJjwqXMfwm+w
         twSRymbUfX2DNMRKO2qIz3tttqyXTcPwnkmTIDRb8eUq9dCVJ9NuGIyJujY+VqslUBVF
         ZtnxNCUNHvvkgS87xlIolgg2yQfKbyEJuWDyOVVHAydQp1zPsJOiA3lBywgrVgkdcp3L
         +49e3pMH1Xu2ZmN6BI0LPBiGhd3Dv7a8Qvn0kyNtzxsxmpFUtPmfr5cauqLa9T+iYHQ1
         hwtwqVGXw8WxXJ3YJZaQeZ7yyTx08XRLZfnZs8JlRaPb3PHn8m1Ol+IXtTnOnkJcwGw3
         6xxw==
X-Gm-Message-State: AOAM532szy7ZIAczTULy6cqmHZcw7cSyukaDrL9iCIP92lCKp5PQWCJZ
        eRLSPkk/A9DwtlsPDgyC1Q0=
X-Google-Smtp-Source: ABdhPJwXdincjGRwU8pXhDOX0fgRkLCC4WVwa2zjx2UEI//tJEe1ofb7KgTuw5BL+mqEP1EP7HdgLA==
X-Received: by 2002:a17:90a:2f83:: with SMTP id t3mr10324593pjd.128.1611825882057;
        Thu, 28 Jan 2021 01:24:42 -0800 (PST)
Received: from localhost ([103.220.76.197])
        by smtp.gmail.com with ESMTPSA id gg22sm4538913pjb.24.2021.01.28.01.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 01:24:41 -0800 (PST)
Date:   Thu, 28 Jan 2021 17:24:35 +0800
From:   carlis <zhangxuezhi3@gmail.com>
To:     Kari Argillander <kari.argillander@gmail.com>
Cc:     gregkh@linuxfoundation.org, colin.king@canonical.com,
        oliver.graute@kococonnector.com, zhangxuezhi1@yulong.com,
        mh12gx2825@gmail.com, sbrivio@redhat.com,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10] staging: fbtft: add tearing signal detect
Message-ID: <20210128172435.00005643@gmail.com>
In-Reply-To: <20210128065233.ji4b7ea54ihyu2l5@kari-VirtualBox>
References: <1611754972-151016-1-git-send-email-zhangxuezhi3@gmail.com>
        <20210127223222.3lavtl3roc4cabso@kari-VirtualBox>
        <20210128094258.000012c3@gmail.com>
        <20210128065233.ji4b7ea54ihyu2l5@kari-VirtualBox>
Organization: Tyzmig-ryrjum-8kedto
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Thu, 28 Jan 2021 08:52:33 +0200
Kari Argillander <kari.argillander@gmail.com> wrote:

> On Thu, Jan 28, 2021 at 09:42:58AM +0800, carlis wrote:
> > On Thu, 28 Jan 2021 00:32:22 +0200
> > Kari Argillander <kari.argillander@gmail.com> wrote:  
> > > >  #include "fbtft.h"
> > > >  
> > > >  #define DRVNAME "fb_st7789v"
> > > > @@ -66,6 +69,32 @@ enum st7789v_command {
> > > >  #define MADCTL_MX BIT(6) /* bitmask for column address order */
> > > >  #define MADCTL_MY BIT(7) /* bitmask for page address order */
> > > >  
> > > > +#define SPI_PANEL_TE_TIMEOUT	400 /* msecs */
> > > > +static struct mutex te_mutex;/* mutex for set te gpio irq
> > > > status */    
> > > 
> > > Space after ;  
> > hi, i have fix it in the patch v11  
> > >   
> 
> Yeah sorry. I accidentally review wrong patch. But mostly stuff are
> still relevant.
> 
> > > > @@ -82,6 +111,33 @@ enum st7789v_command {
> > > >   */
> > > >  static int init_display(struct fbtft_par *par)
> > > >  {
> > > > +	int rc;
> > > > +	struct device *dev = par->info->device;
> > > > +
> > > > +	par->gpio.te = devm_gpiod_get_index_optional(dev,
> > > > "te", 0, GPIOD_IN);
> > > > +	if (IS_ERR(par->gpio.te)) {
> > > > +		rc = PTR_ERR(par->gpio.te);
> > > > +		dev_err(par->info->device, "Failed to request
> > > > te gpio: %d\n", rc);
> > > > +		return rc;
> > > > +	}    
> > > 
> > > You request with optinal and you still want to error out? We could
> > > just continue and not care about that error. User will be happier
> > > if device still works somehow.  
> > You mean i just delete this dev_err print ?!
> > like this:
> > 	par->gpio.te = devm_gpiod_get_index_optional(dev, "te",
> > 0,GPIOD_IN); 
> >         if (IS_ERR(par->gpio.te))
> > 		return PTR_ERR(par->gpio.te);  
> 
> Not exactly. I'm suggesting something like this.
> 
> if (IS_ERR(par->gpio.te) == -EPROBE_DEFER) {
> 	return -EPROBE_DEFER;
> 
> if (IS_ERR(par->gpio.te))
> 	par-gpio.te = NULL;
> 
> This like beginning of your patch series but the difference is that if
> EPROBE_DEFER then we will try again later. Any other error and we will
> just ignore TE gpio. But this is up to you what you want to do. To me
> this just seems place where this kind of logic can work.
> 
> > > > +		if (par->gpio.te) {
> > > > +			set_spi_panel_te_irq_status(par, true);
> > > > +			reinit_completion(&spi_panel_te);
> > > > +			ret =
> > > > wait_for_completion_timeout(&spi_panel_te,
> > > > +
> > > > msecs_to_jiffies(SPI_PANEL_TE_TIMEOUT));
> > > > +			if (ret == 0)    
> > > 
> > > !ret
> > >   
> > > > +				dev_err(par->info->device,
> > > > "wait panel TE time out\n");
> > > > +		}
> > > > +		ret = par->fbtftops.write(par, par->txbuf.buf,
> > > > +					 startbyte_size +
> > > > to_copy
> > > > * 2);
> > > > +		if (par->gpio.te)
> > > > +			set_spi_panel_te_irq_status(par,
> > > > false);
> > > > +		if (ret < 0)
> > > > +			return ret;
> > > > +		remain -= to_copy;
> > > > +	}
> > > > +
> > > > +	return ret;    
> > > 
> > > Do we want to return something over 0? If not then this can be
> > > return 0. And then you do not need to even init ret value at the
> > > beginning.
> > > 
> > > Also wait little bit like Greg sayd before sending new version.
> > > Someone might nack about what I say or say something more.
> > >   
> > hi, i copy fbtft_write_vmem16_bus8 from file fbtft_bus.c and modify
> > it ,just add te wait logic, i will take more time to check this
> > original function.  
> 
> It might be ok or not. You should still check.

hi, i will check more carefully, now i have a new problem, Is there a
way to clear the interrupt pending state before opening it again?



