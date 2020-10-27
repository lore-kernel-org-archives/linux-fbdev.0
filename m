Return-Path: <SRS0=EV96=EC=vger.kernel.org=linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58BD8C55178
	for <linux-fbdev@archiver.kernel.org>; Tue, 27 Oct 2020 16:50:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0881E20790
	for <linux-fbdev@archiver.kernel.org>; Tue, 27 Oct 2020 16:50:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SloE/kKe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1813501AbgJ0Qub (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 27 Oct 2020 12:50:31 -0400
Received: from mail-pj1-f43.google.com ([209.85.216.43]:35323 "EHLO
        mail-pj1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1813496AbgJ0Qu3 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 27 Oct 2020 12:50:29 -0400
Received: by mail-pj1-f43.google.com with SMTP id h4so1041130pjk.0;
        Tue, 27 Oct 2020 09:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HptrGwBSY+SD+CDa0bd+3OxbTLi4hMQSBZc7Kms8AlM=;
        b=SloE/kKeI7PO02Z+h+wXGCAWMViSW6igjNsKi66UgTllzsf3Xo6lcfNN9TKzvnGz+O
         XdUGidI0SkH6IYKDAy6fCGH7p45ca7aCZPPpBs+hzcCKoaTXmYy1hRg1UxzuO9/Ir52v
         2GHeyuWwCB3PgNUJyCJ99aWZ19Ta+Swx/eL8cyS04LCr67nbMkcvk+AiQLkiCrXLtGaa
         1bI5nNiH/BumJ7Kfksftg+A48qlnMSXf91iRXxjciYyPK50SL8nGjswljjr+F3yUqq6G
         KX+R6b8X5fPOfTFGIOkwhGfPyjq22j391lukmuhQ5KjUA2gOJDoXLmpIoW+sDYulXSh3
         GqdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HptrGwBSY+SD+CDa0bd+3OxbTLi4hMQSBZc7Kms8AlM=;
        b=oSMoEGsIafUtj1LfXPxVZoAIDQ9GH0jk8OR2yvO3t1d0xhCbmw4hxjSplGYdeO1xbY
         NdyYd4fLi7VPXF9y1kb45m3c3nbTvUOeFWouccw+zHf55RFFEkI49oVjGW8DN1so7WEN
         sYCKXB435HROPKMiEowB/2xgCzj1VZ9FGKrGpJoqfc3cOubzqED8ZlnGa2k/0mTc9O1y
         D8WxoDgSsetXDlkXVe8pOEWY3ZNBwKYd0YvqtERUyuvtFUed4PvpbVJInUjbVcyQ8V33
         PU/q4tZFzRSKba8sqSzD5HMZVWNtflfJYzHfFBZjNyVQWhcMwqOhDZEKnVKKi1MhU4EW
         rR3Q==
X-Gm-Message-State: AOAM532ZJVIo9N4SkO0x7BW0iYDllaBOd1oiYPbkKbzFRwHOa9XmmCcQ
        1ANFAwZzPb/HM+X0uy2s4Q==
X-Google-Smtp-Source: ABdhPJzMTJ8Bn35UCTNCGA0/agh8C9PXo3qzw/+//DmpetLuoSxkefj3JCZmZuvgck6DNRGfBiwPoA==
X-Received: by 2002:a17:902:9a84:b029:d3:8b4f:50d5 with SMTP id w4-20020a1709029a84b02900d38b4f50d5mr3605768plp.48.1603817428057;
        Tue, 27 Oct 2020 09:50:28 -0700 (PDT)
Received: from PWN (n11212042025.netvigator.com. [112.120.42.25])
        by smtp.gmail.com with ESMTPSA id b3sm2840505pfd.66.2020.10.27.09.50.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 09:50:27 -0700 (PDT)
Date:   Tue, 27 Oct 2020 12:50:21 -0400
From:   Peilin Ye <yepeilin.cs@gmail.com>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Following up
Message-ID: <20201027165021.GA1178130@PWN>
References: <cover.1603788511.git.yepeilin.cs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1603788511.git.yepeilin.cs@gmail.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hi Daniel,

More about the 3 things we've discussed before:

  1. Cleaning up con_font_op():

(drivers/tty/vt/vt.c)
int con_font_op(struct vc_data *vc, struct console_font_op *op)
{
	switch (op->op) {
	case KD_FONT_OP_SET:
		return con_font_set(vc, op);
	case KD_FONT_OP_GET:
		return con_font_get(vc, op);
	case KD_FONT_OP_SET_DEFAULT:
		return con_font_default(vc, op);
	case KD_FONT_OP_COPY:
		return con_font_copy(vc, op);
	}
	return -ENOSYS;
}

On Tue, Sep 29, 2020 at 04:38:49PM +0200, Daniel Vetter wrote:
> I think if we change the conf_font_get/set/default/copy functions to not
> take the *op struct (which is take pretty arbitrarily from one of the
> ioctl), but the parameters each needs directly, that would clean up the
> code a _lot_.

    This is on my TODO list! One day I came up with some idea about
    fbcon.c, so I postponed this a bit...

  2. Removing dummy functions, like sisusbdummycon_font_set():
    
    Turns out, before c396a5bf457f ("console: Expand dummy functions for
    CFI"), they were just some macros:

-#define SISUSBCONDUMMY (void *)sisusbdummycon_dummy
+static int sisusbdummycon_font_set(struct vc_data *vc,
+                                  struct console_font *font,
+                                  unsigned int flags)
+{
+       return 0;
+}

    ...and they had been there for a very long (10+ years) time. Removing
    code like this makes me a bit nervous, and...

On Tue, Sep 29, 2020 at 04:38:49PM +0200, Daniel Vetter wrote:
> This actually does something. tbh I would not be surprises if the
> fb_set utility is the only thing that uses this - with a bit of code
> search we could perhaps confirm this, and delete all the other
> implementations.

    ...you mentioned code search, where & what should we look at, in order
    to confirm it's safe to remove them?

  3. Using `font_desc` in `vc_data`:

    Our plan for the gradual conversion was to use a helper function to
    set font for a vc, but after reviewing the 300-ish occurrence of
    `vc_font`, it seems like code doesn't usually set it as a whole:

(drivers/usb/misc/sisusbvga/sisusb_con.c)
	[...]
	c->vc_font.height = sisusb->current_font_height;
	[...]

    ...that's it! It only cares about the height. There are only 4 or 5
    places in fbcon.c that actually set all fields of `vc_font`, like:

    		vc->vc_font.width = font->width;
		vc->vc_font.height = font->height;
		vc->vc_font.data = (void *)(p->fontdata = font->data);
		vc->vc_font.charcount = 256; /* FIXME  Need to support more fonts */

    To make it even more complicated, `p` is a `struct fbcon_display *`,
    containing yet another font data pointer (`fontdata`) that I think
    should be replaced by a `font_desc *`...

    In conclusion, I think it's all about a few hard problems in fbcon.c.
    I'll keep trying and see how it goes.
    
Thank you,
Peilin Ye

