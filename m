Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD3FBC64ED6
	for <linux-fbdev@archiver.kernel.org>; Mon, 27 Feb 2023 16:45:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbjB0QpG (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 27 Feb 2023 11:45:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjB0QpF (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 27 Feb 2023 11:45:05 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2720F941;
        Mon, 27 Feb 2023 08:45:03 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id az36so4666072wmb.1;
        Mon, 27 Feb 2023 08:45:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FeOcTqXDkf0doKsprZO7fxvXxR/92ra2xU2rS73dpcc=;
        b=N1OuYy7nsQ5OY3PZLh6lT9+FHQdTlvdZDP8GDtlTUNgnOwNTFQt7tOo3wv7yL5Ts9F
         DPkFbelV+lIWaakHs5dPEL82nMCQlRW82iWwEYGe9fSvLEEKpn4w8JDyzopc2Wy0TS8U
         agNNWNdy28WaZ27DqQYSH49e3wyvRviIxw7HeueW+jyu8jKhdm04d74rILX7LHlxI57C
         5f3ai0AVdCThBRFJeH4PXh7j9haHSOccftRuBkBlRdnHeGWQLp+E6FWo1BmTiC0pH90z
         687Z9Zedbw7yPM00fCk8M9/r3HnRH3uUObz0qsMH21WFpWUqgxfQPDQA+bSATQTCLhaD
         PgRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FeOcTqXDkf0doKsprZO7fxvXxR/92ra2xU2rS73dpcc=;
        b=MAQmHjMQ9o+cJLTWfj/tU+quxj4I+CnBSXdRvaEppYvUfuZk0bXMHnTMUuO3xcz68H
         sq0ccQwOT+4TeMbDuUf75xq6asxOiBO47/NJTfgXTg5TzLmSqrMOVj2gEXgpeSQvwVcq
         xjOD5M0v7UUqTG6csWv/CIPyVeVuGxTkMqPGuhoWcLLN+z8GjU8SNZ9te8UY3rCRwyPk
         tKSiefLmx34ETzA1hu19V6ogqq7vRI7kVK+LWhnPx2YGuGWzjtNQUcoQOLlVdBQCY7un
         H0tCNph840EecnbVXDiguEXHPWwR44IVhUexKALKJAxmA2Dn3SMkYUszvpctON4yIsWs
         PJ7A==
X-Gm-Message-State: AO0yUKVinndaw5sACoRq6E6lJBUWcXkayBzh9HOvdmT/0T7B+MmyPNOo
        fXJT3znYhsTA6dteveAbTd8=
X-Google-Smtp-Source: AK7set8HnVjiWkfm607XdfjPyYQyWoO811MLCbol1ln1f8JVz2wkg1XtQo2q9iMxPx0Avd+r1QUrfQ==
X-Received: by 2002:a05:600c:a4c:b0:3ea:e582:48dd with SMTP id c12-20020a05600c0a4c00b003eae58248ddmr9905860wmq.34.1677516302316;
        Mon, 27 Feb 2023 08:45:02 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id t23-20020a1c7717000000b003daf672a616sm9546376wmi.22.2023.02.27.08.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 08:45:01 -0800 (PST)
Date:   Mon, 27 Feb 2023 13:27:53 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] fbdev: chipsfb: Fix error codes in chipsfb_pci_init()
Message-ID: <Y/yFqWWbw7RsCN4v@kadam>
References: <Y/yA53V/rW8g1Zlm@kili>
 <2673f515-9516-de13-3e59-4d473165010d@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2673f515-9516-de13-3e59-4d473165010d@suse.de>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Mon, Feb 27, 2023 at 11:13:19AM +0100, Thomas Zimmermann wrote:
> Hi
> 
> Am 27.02.23 um 11:07 schrieb Dan Carpenter:
> > The error codes are not set on these error paths.
> > 
> > Fixes: 145eed48de27 ("fbdev: Remove conflicting devices on PCI bus")
> > Signed-off-by: Dan Carpenter <error27@gmail.com>
> 
> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
> 
> with the comments below addressed.
> 
> > ---
> >   drivers/video/fbdev/chipsfb.c | 14 ++++++++++----
> >   1 file changed, 10 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/video/fbdev/chipsfb.c b/drivers/video/fbdev/chipsfb.c
> > index cc37ec3f8fc1..98398789528a 100644
> > --- a/drivers/video/fbdev/chipsfb.c
> > +++ b/drivers/video/fbdev/chipsfb.c
> > @@ -358,16 +358,21 @@ static int chipsfb_pci_init(struct pci_dev *dp, const struct pci_device_id *ent)
> >   	if (rc)
> >   		return rc;
> > -	if (pci_enable_device(dp) < 0) {
> > +	rc = pci_enable_device(dp);
> > +	if (rc < 0) {
> >   		dev_err(&dp->dev, "Cannot enable PCI device\n");
> >   		goto err_out;
> >   	}
> > -	if ((dp->resource[0].flags & IORESOURCE_MEM) == 0)
> > +	if ((dp->resource[0].flags & IORESOURCE_MEM) == 0) {
> > +		rc = -EINVAL;
> 
> I think ENODEV is more appropriate. And it's the default value from the
> original code.

Sorry, I read the original code and my mind saw -EINVAL where it was
actually -ENODEV as you say.  Will resend.

regards,
dan carpenter

