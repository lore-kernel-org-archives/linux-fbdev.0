Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2E09C433DB
	for <linux-fbdev@archiver.kernel.org>; Fri, 29 Jan 2021 05:02:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7241764E02
	for <linux-fbdev@archiver.kernel.org>; Fri, 29 Jan 2021 05:02:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbhA2FCA (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 29 Jan 2021 00:02:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbhA2FB5 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 29 Jan 2021 00:01:57 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88F7BC061573;
        Thu, 28 Jan 2021 21:01:17 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id e19so5474018pfh.6;
        Thu, 28 Jan 2021 21:01:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=f9e8G3IwqWuGafA5/XSFTl4e3cu9PrEdROJH+eUMA3o=;
        b=WEAMVHCHvIX8nA5SK/PdoWaQBVIcjU9mdjQsGuPwnxofkv2WyiyU8JlgEh2fmmRr21
         2zEQIPxNDRrBg23yYOf1TYI5p/IkeG/+7/mheSOJ9ElCuCm3svDKzRoKmRuJ7dS0eS0p
         EIXL9Y5g5cyLpPwrfM5OxVzOKyrPTpuz63Q+yeMwDC8/rheXLuMum5FKtl3CC1jWybYs
         uEExlfcIn+JEeQbMWppUFyxJKdRA6v4u5LLWq/ImNOUz1A6OfIG//7tMimj30dV4oI36
         e5Lc2sviXrLft+TwlkS0U7GZcNX+CJtcV3MdR9oo47FqxlFiZRamH/yiFYyALB/fxUJv
         LxJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=f9e8G3IwqWuGafA5/XSFTl4e3cu9PrEdROJH+eUMA3o=;
        b=igHHMSPdlPZB3JzU3japB+yEn3EYa+d9JIJ5ykD8IF/H4qQ3H3T0tQGFLNrIXrOqR2
         /sV2bA+n87cJmW9c3ZV062NFSZcPvhp+hcAcL6rXNStX3TqQyxKLoL0gS55rwY/YMkca
         tB222wueM46j3h7QU+mQTaFPpCcDEJMSTi+h+aF8lppaI/8IprB8pycI4nGNrcaHKYQW
         ZHJPlUKCVca3VmRDI8Yyw9c8Crws68zevMDhL7+dTbH0MMNNzFdhL/pfUvh6TWbL4Efr
         twPJGAVm0yoLvanYE3HwRPYMbTjyJHo7skYmjZrmJs6HGDzFrZu4QYXht3tEqrL0gaE8
         6b/g==
X-Gm-Message-State: AOAM532T8ERerHHBrpNKEOLmFOGqXjI7KDgRINav2BoRE6fJ3h+WZNl3
        OCdnDcVzEZJqo53oa2MozoFcaBAiJPrD3jre
X-Google-Smtp-Source: ABdhPJxxD1mX64UCPglMRQvlheVx8Cpw50QQwWyNYmkoqMlg0Em7jgdx9MlwazFuEdWjQr+eEtSlGw==
X-Received: by 2002:a63:535a:: with SMTP id t26mr2966681pgl.433.1611896476781;
        Thu, 28 Jan 2021 21:01:16 -0800 (PST)
Received: from localhost ([103.220.76.197])
        by smtp.gmail.com with ESMTPSA id m18sm7197615pfd.206.2021.01.28.21.01.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 21:01:15 -0800 (PST)
Date:   Fri, 29 Jan 2021 13:01:10 +0800
From:   carlis <zhangxuezhi3@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Colin King <colin.king@canonical.com>,
        oliver.graute@kococonnector.com, zhangxuezhi1@yulong.com,
        Deepak R Varma <mh12gx2825@gmail.com>,
        Stefano Brivio <sbrivio@redhat.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>,
        "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v12] staging: fbtft: add tearing signal detect
Message-ID: <20210129130110.00003bb1@gmail.com>
In-Reply-To: <CAHp75Vd=ijxnamuSYuxNLeyhGMCod=HaXWrQ0W0+3QCsQAychg@mail.gmail.com>
References: <1611838435-151774-1-git-send-email-zhangxuezhi3@gmail.com>
        <CAHp75Vd=ijxnamuSYuxNLeyhGMCod=HaXWrQ0W0+3QCsQAychg@mail.gmail.com>
Organization: Tyzmig-ryrjum-8kedto
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Thu, 28 Jan 2021 16:33:02 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Thu, Jan 28, 2021 at 2:58 PM Carlis <zhangxuezhi3@gmail.com> wrote:
> 
> Thanks for your contribution, my comments below.
> 
> > From: zhangxuezhi <zhangxuezhi1@yulong.com>  
> 
> You probably have to configure your Git to use the same account for
> author and committer.

hi,you mean like below:
	Carlis <zhangxuezhi1@yulong.com>
?
> 
> > For st7789v ic,when we need continuous full screen refresh, it is
> > best to  
> 
> 'ic,when' -> 'IC, when'
> 
> > wait for the TE signal arrive to avoid screen tearing  
> 
> Decode TE for people who are not familiar with the abbreviation.
> 
> Missed period at the end of sentence.
> 
> ...
> 
> >  #include <linux/delay.h>
> >  #include <linux/init.h>
> >  #include <linux/kernel.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/completion.h>
> >  #include <linux/module.h>
> > +#include <linux/gpio/consumer.h>
> > +  
> 
> Good, but I would rather squeeze it above to be more or less ordered,
> like just after delay.h inclusion.
> 
> >  #include <video/mipi_display.h>  
> 
> ...
> 
> > +#define SPI_PANEL_TE_TIMEOUT   400 /* msecs */  
> 
> Useless comment. Instead use _MS suffix in the name of constant.
> Besides that please add a comment explaining why this value has been
> chosen.
> 
> ...
> 
> > +static struct completion spi_panel_te;  
> 
> As Greg said.
> 
> ...
> 
> >  static int init_display(struct fbtft_par *par)
> >  {
> > +       int rc;
> > +       struct device *dev = par->info->device;  
> 
> Keep reversed xmas tree order:
> 
>        struct device *dev = par->info->device;
>        int rc;
> 
> ...
> 
> > +       par->gpio.te = devm_gpiod_get_index_optional(dev, "te", 0,
> > GPIOD_IN);  
> 
> No need to have it requested for all time since you use it as an IRQ
> later on. The IRQ chip will call the GPIO library framework to lock a
> pin as IRQ anyway.
> 
> > +       if (IS_ERR(par->gpio.te))
> > +               return dev_err_probe(par->info->device,
> > PTR_ERR(par->gpio.te),
> > +                                    "Failed to request te
> > gpio\n");  
> 
> > +       if (par->gpio.te) {  
> 
> Instead you should probably do the following:
> 
> int irq;
> 
> irq = gpiod_to_irq(...);
> if (irq > 0)
> 
> > +               init_completion(&spi_panel_te);
> > +               rc = devm_request_irq(dev,  
> 
> > +                                     gpiod_to_irq(par->gpio.te),  
> 
> ...and here simply use irq.
> 
> > +                                    spi_panel_te_handler,
> > IRQF_TRIGGER_RISING,
> > +                                    "TE_GPIO", par);  
> 
> > +               if (IS_ERR(rc))  
> 
> This is wrong. rc is integer no IS_ERR() is required. Ditto for
> PTR_ERR(). Have you even looked for these macros implementations?
> 
> > +                       return dev_err_probe(par->info->device,
> > PTR_ERR(rc),  
> 
> Use your temporary variable and move...
> 
> > +                                            "TE request_irq
> > failed.\n");  
> 
> ...this on the previous line.
> 
> > +               disable_irq_nosync(gpiod_to_irq(par->gpio.te));  
> 
> Why do you call gpio_to_irq() twice?
> 
> 
> > +       } else {
> > +               dev_info(par->info->device, "%s:%d, TE gpio not
> > specified\n",
> > +                        __func__, __LINE__);  
> 
> Remove this noise (besides the fact that we don't use __file__ and
> __LINE__ in messages like this.
> 
> > +       }  
> 
> Taking all together you probably need to create a helper and use it
> inside init_display(), like
> 
> static int init_tearing_effect_line(struct fbtft_par *par)
> {
>   struct device *dev = par->info->device;
>   struct gpio_desc *te;
>   int irq, rc;
> 
>   te = gpiod_get_optional(dev, "te", GPIOD_IN);
>   if (IS_ERR(te))
>            return dev_err_probe(dev, PTR_ERR(te), "Failed to request
> te GPIO\n");
> 
>   irq = gpiod_to_irq(te); // this value you have to save in the
> driver's (per device) data structure.
> 
>   /* GPIO is locked as an IRQ, we may drop the reference */
>   gpiod_put(te);


 
> 
>   init_completion(&spi_panel_te); // should be in the (per device)
> data structure
>   rc = devm_request_irq(dev, irq,  spi_panel_te_handler,
> IRQF_TRIGGER_RISING, "TE_GPIO", par);
>   if (rc)
>                 return dev_err_probe(dev, rc, "TE IRQ request
> failed.\n"); disable_irq_nosync(irq);
>   return irq;
> }
>

hi, i have modified it according to your suggestion like below:

static irqreturn_t panel_te_handler(int irq, void *data)
{
	struct fbtft_par *par = (struct fbtft_par *)data;

	complete(&par->panel_te);
	return IRQ_HANDLED;
}

/**
 * init_tearing_effect_line() - init tearing effect line
 *
 * @par: FBTFT parameter object
 *
 * Return: 0 on success, < 0 if error occurred.
 */
static int init_tearing_effect_line(struct fbtft_par *par)
{
	struct device *dev = par->info->device;
	struct gpio_desc *te;
	int rc;

	te = gpiod_get_optional(dev, "te", GPIOD_IN);
	if (IS_ERR(te))
		return dev_err_probe(dev, PTR_ERR(te), "Failed to
	request te GPIO\n");

	if (te) {
		par->irq_te = gpiod_to_irq(te);
		gpiod_put(te);

		if (par->irq_te) {
			rc = devm_request_irq(dev,
					      par->irq_te,
		panel_te_handler,
					      IRQF_TRIGGER_RISING,
		"TE_GPIO", par);
			if (rc)
				return dev_err_probe(dev, rc, "TE IRQ
		request failed.\n");

			disable_irq_nosync(par->irq_te);
			init_completion(&par->panel_te);
		} else {
			return dev_err_probe(dev, par->irq_te, "gpiod
			to TE IRQ failed.\n");
		}
	}

	return 0;
}

/**
 * init_display() - initialize the display controller
 *
 * @par: FBTFT parameter object
 *
 * Most of the commands in this init function set their parameters to
the
 * same default values which are already in place after the display has
been
 * powered up. (The main exception to this rule is the pixel format
which
 * would default to 18 instead of 16 bit per pixel.)
 * Nonetheless, this sequence can be used as a template for concrete
 * displays which usually need some adjustments.
 *
 * Return: 0 on success, < 0 if error occurred.
 */
static int init_display(struct fbtft_par *par)
{
	int rc;

	rc = init_tearing_effect_line(par);
	if (rc < 0)
		return rc;



......
	if (par->irq_te)
	write_reg(par, MIPI_DCS_SET_TEAR_ON, 0x00);

......


/**
 * st7789v_write_vmem16_bus8() - write data to display
 *
 * @par: FBTFT parameter object
 * @offset: offset from screen_buffer
 * @len: the length of data to be written
 *
 * 16 bit pixel over 8-bit databus
 *
 * Return: 0 on success, or a negative error code otherwise.
 */
static int st7789v_write_vmem16_bus8(struct fbtft_par *par, size_t
offset, size_t len)
{
	struct device *dev = par->info->device;
	__be16 *txbuf16 = par->txbuf.buf;
	size_t startbyte_size = 0;
	size_t tx_array_size;
	size_t to_copy;
	size_t remain;
	u16 *vmem16;
	int ret = 0;
	int i;

	fbtft_par_dbg(DEBUG_WRITE_VMEM, par, "st7789v ---%s(offset=%zu,
	len=%zu)\n",
		      __func__, offset, len);

	remain = len / 2;
	vmem16 = (u16 *)(par->info->screen_buffer + offset);

	gpiod_set_value(par->gpio.dc, 1);

	if (par->irq_te) {
		enable_irq(par->irq_te);
		reinit_completion(&par->panel_te);
		ret = wait_for_completion_timeout(&par->panel_te,
						  msecs_to_jiffies(PANEL_TE_TIMEOUT_MS));
		if (ret == 0)
			dev_err(dev, "wait panel TE time out\n");

		disable_irq(par->irq_te);
	}




> Note, when you define proper fields for IRQ line and completion in the
> data structure the above can be amended accordingly.
> 
> ...
> 
> > +       /* tearing effect line on */
> > +       if (par->gpio.te)
> > +               write_reg(par, 0x35, 0x00);  
> 
> 0x35 is defined. use it and drop useless comments.
> 
> ...
> 
> >  /**
> > + * st7789v_write_vmem16_bus8() -  write data to display  
> 
> > + *  
> 
> Redundant blank line.
> 
> > + * @par: FBTFT parameter object
> > + * @offset: offset from screen_buffer
> > + * @len: the length of data to be written
> > + *
> > + * 16 bit pixel over 8-bit databus
> > + *
> > + * Return: 0 on success, < 0 if error occurred.  
> 
> ", or a negative error code otherwise"
> 
> > + */  
> 
> > +  
> Redundant blank line
> 
> > +static int st7789v_write_vmem16_bus8(struct fbtft_par *par, size_t
> > offset, size_t len) +{
> > +       u16 *vmem16;
> > +       __be16 *txbuf16 = par->txbuf.buf;
> > +       size_t remain;
> > +       size_t to_copy;
> > +       size_t tx_array_size;
> > +       int i;
> > +       int ret = 0;
> > +       size_t startbyte_size = 0;  
> 
> Reversed xmas tree order.
> 
> > +       fbtft_par_dbg(DEBUG_WRITE_VMEM, par, "st7789v
> > ---%s(offset=%zu, len=%zu)\n",
> > +                     __func__, offset, len);
> > +
> > +       remain = len / 2;
> > +       vmem16 = (u16 *)(par->info->screen_buffer + offset);  
> 
> > +       if (par->gpio.dc)  
> 
> Useless duplicate check.
> 
> > +               gpiod_set_value(par->gpio.dc, 1);  
> 
> > +       if (par->gpio.te) {
> > +               enable_irq(gpiod_to_irq(par->gpio.te));  
> 
> Here you should use the IRQ line rather than the GPIO descriptor. See
> above.
> 
> > +               reinit_completion(&spi_panel_te);
> > +               ret = wait_for_completion_timeout(&spi_panel_te,
> > +
> > msecs_to_jiffies(SPI_PANEL_TE_TIMEOUT));
> > +               if (ret == 0)
> > +                       dev_err(par->info->device, "wait panel TE
> > time out\n"); +
> > +               disable_irq(gpiod_to_irq(par->gpio.te));
> > +       }  
> 
> > +
> > +       while (remain) {
> > +               to_copy = min(tx_array_size, remain);  
> 
> > +               dev_dbg(par->info->device, "    to_copy=%zu,
> > remain=%zu\n",
> > +                       to_copy, remain - to_copy);  
> 
> Like in previous functions create a temporary variable to keep a
> pointer to struct device and use it here and everywhere else. It might
> save you LOCs and make code easier to read and understand.
> 
> > +               for (i = 0; i < to_copy; i++)
> > +                       txbuf16[i] = cpu_to_be16(vmem16[i]);  
> 
> If both of them are 16-bit wide, consider moving this to a helper
> which somebody can move to byteorder/generic.h in the future.
> 
> > +               vmem16 = vmem16 + to_copy;
> > +               ret = par->fbtftops.write(par, par->txbuf.buf,
> > +                                        startbyte_size + to_copy *
> > 2);
> > +               if (ret < 0)
> > +                       return ret;
> > +               remain -= to_copy;
> > +       }
> > +
> > +       return ret;
> > +}  
> 

regards,
Carlis
