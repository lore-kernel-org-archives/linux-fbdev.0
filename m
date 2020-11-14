Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4F9EC5519F
	for <linux-fbdev@archiver.kernel.org>; Sat, 14 Nov 2020 08:10:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BE6122254
	for <linux-fbdev@archiver.kernel.org>; Sat, 14 Nov 2020 08:10:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IGiUSEBZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbgKNIK2 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sat, 14 Nov 2020 03:10:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbgKNIK2 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sat, 14 Nov 2020 03:10:28 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C05AC0613D1;
        Sat, 14 Nov 2020 00:10:28 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id f38so8895813pgm.2;
        Sat, 14 Nov 2020 00:10:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UjoM/Jb9YzMDUNLXPrC2c7aiTcht0/xGNSfdesVAVqI=;
        b=IGiUSEBZx9/TmLfHHpK3pQ7GSrhfMQFNSfGAC1pbY2Ge/tO189H8uPBwgsjiUksNnA
         j8Ndu+iaMovK3CgVOmlPYgIj7a2okENhx0LNMOjoJ9I49pmMbyrGBLDrvnzipOKZszP+
         5m9NTEoCxkjkCEznH0MTgdqoqEYERxY36mFXnGHG4SJQsLogUrAbkT4p8CdUO8XPBrR/
         2AQERdbw1QMl7UijRsIkesKRf96Xe3T7FiPOnUy0Dslpsvy4lxQm6m8btQMU0Ij1CY+c
         Mz1wpWy4yLvc5zXBIHwW2N7c85QpN90wx4Eb8minXiKj7+IAqJWA6yyEFXGmMawl7GWT
         4qCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UjoM/Jb9YzMDUNLXPrC2c7aiTcht0/xGNSfdesVAVqI=;
        b=ptXLjLJzXZOkCypx2pctB531mQj+Uvecj9DJnYBVLcDngXZixI5P+U5Y6eaiuIMim+
         ptrNoXSu+4DRb0rgVqLzWe/pgIzLfMbcPAlbssllQys/ssE6n/nxj2VWpEKhST5sxfee
         EJlVZX36HgAT54vVXLP0/wlYKpKszlxz/w0wqgUpEcb+kirCrHzS0v6CXpN++F8by5Ew
         uRYnQLNRvL42TR2Om53ycgOKz8rpKowIsgvw1AaERTixwVgo2zWQDXErHBJc8HIgm1Og
         gUnzl0dY7zTcPQk8gRQNOWpinXzSfZE0Y7K0jvGvBamObvvIdMJDSM3Tg8cHY5Z0OOFC
         K7kA==
X-Gm-Message-State: AOAM5320lNrIbBkDHUdrg7mCwC61T5cE07jRco9v9hEOn5dWv+v5PU3z
        3IBYLGmK0lKI9tdpRxSLog==
X-Google-Smtp-Source: ABdhPJwBZoL847JBlahwrxY8TlcxOqmdTrJsXnzO985GLU/rubIRHIugmq6wYmm4RUzNOKzyfzkQ7A==
X-Received: by 2002:a62:1c47:0:b029:18b:9e22:593e with SMTP id c68-20020a621c470000b029018b9e22593emr5691287pfc.42.1605341427792;
        Sat, 14 Nov 2020 00:10:27 -0800 (PST)
Received: from PWN ([221.124.243.27])
        by smtp.gmail.com with ESMTPSA id t32sm11314155pgl.0.2020.11.14.00.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2020 00:10:27 -0800 (PST)
Date:   Sat, 14 Nov 2020 03:10:21 -0500
From:   Peilin Ye <yepeilin.cs@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v3 0/5] console: Miscellaneous clean-ups, do not use
 FNTCHARCNT() in fbcon.c
Message-ID: <20201114081021.GA11811@PWN>
References: <cover.1605169912.git.yepeilin.cs@gmail.com>
 <20201113211633.GY401619@phenom.ffwll.local>
 <X68NFzaAuImemnqh@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X68NFzaAuImemnqh@kroah.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

> On Fri, Nov 13, 2020 at 10:16:33PM +0100, Daniel Vetter wrote:
> > On Thu, Nov 12, 2020 at 07:02:21AM -0500, Peilin Ye wrote:
> > > Peilin Ye (5):
> > >   console: Delete unused con_font_copy() callback implementations
> > >   console: Delete dummy con_font_set() and con_font_default() callback implementations
> > >   Fonts: Add charcount field to font_desc
> > >   parisc/sticore: Avoid hard-coding built-in font charcount
> > >   fbcon: Avoid using FNTCHARCNT() and hard-coded built-in font charcount
> > 
> > Patches all look good to me, if Greg is ok with me applying the entire
> > pile to drm-misc-next I'll do that next week.

On Fri, Nov 13, 2020 at 11:47:51PM +0100, Greg Kroah-Hartman wrote:
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Thanks for reviewing!  Questions about the last patch [5/5] though, it
depends on the following assumption:

"""
For each console `idx`, `vc_cons[idx].d->vc_font.data` and
`fb_display[idx].fontdata` always point to the same buffer.
"""

Is this true?  I think it is true by grepping for `fontdata`.  I also
noticed that fbcon.c is using `vc->vc_font.data` and `p->fontdata`
interchangeably, see fbcon_get_requirement():

		vc = vc_cons[fg_console].d;
		[...]
			p = &fb_display[fg_console];
			caps->x = 1 << (vc->vc_font.width - 1);
					^^^^^^^^^^^
			caps->y = 1 << (vc->vc_font.height - 1);
					^^^^^^^^^^^
			caps->len = (p->userfont) ?
				FNTCHARCNT(p->fontdata) : 256;
					   ^^^^^^^^^^^

If it is true, then what is the point of using `fontdata` in `struct
fbcon_display`?  Just for the `userfont` flag?  Should we delete
`fontdata`, when we no longer need the `userfont` flag?

In this sense I think [5/5] needs more testing.  Do we have test files
for fbcon, or should I try to write some tests from scratch?

Thank you,
Peilin Ye

