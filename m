Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFF69C63798
	for <linux-fbdev@archiver.kernel.org>; Thu, 19 Nov 2020 08:33:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96909246AD
	for <linux-fbdev@archiver.kernel.org>; Thu, 19 Nov 2020 08:33:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="erzuebpF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbgKSIdK (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 19 Nov 2020 03:33:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726096AbgKSIdJ (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 19 Nov 2020 03:33:09 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 752A8C0613CF;
        Thu, 19 Nov 2020 00:33:08 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id i13so3566460pgm.9;
        Thu, 19 Nov 2020 00:33:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AWtaE3tXlX6KkF6SbACxjxmzIgZO2jw7wJIis4kxiFE=;
        b=erzuebpFnP6Gt2cVg+ear4rCVwZ7bV1TMmBphb8RKyD3jrIiAaNEYF/RsgesHqObP0
         He6fyxoxyGGmeUZVMu55DzEB7jcra6cRQnvkfN30U6IDH2AVMoZ3r4zz+yw4phczW/Jg
         5DjouAw+3mtdOjcmUn00gTai5TFmLOOALsNQjAMBdj0hv+RDsdHAH6LIu1vdCvwZuRvk
         ABxoG8DSqgG6cKZwCREawmItYpU4ofbFmo8XNIFaxMPJZ2Bz3RTZj4T3PbEz2A4i54tL
         vDc5j2p+cebrIwdKl0TAv9l5C1jvtPY8WU0arSK9KRm8+cU0n/85YEKbOOyC1USDLDGC
         ff+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AWtaE3tXlX6KkF6SbACxjxmzIgZO2jw7wJIis4kxiFE=;
        b=UTru85PJ+51NhWm+g+7vyk5yu7eP+C22Y/WKbxYhFSYvl2aJpVGXC61FryXM/byrP6
         tqQBAwItWE+nbuoiW7yn92uxIMFm1jRsAM1Y+QMl5AYFY8huFsT6mB49gIe+U/EZGPAa
         Doo1Ly1kH1zHVXMAp7/kXdKUGaqiXXhZQp4P2ECVxeh5OGloapHiXGRIV3H7KeUM7HGO
         /Vf4Jp0+d7bBIgLez3AjND0ltD05dujlZdb/b3s53KcGb3ih2o83BA+4087JhGYUWoEU
         NNgTd9BYrzzl/Y0Z4mXhegHpGfSuac+PgJvJH3TJ9doPJqRETOUP+ySUYWik1ml6bFlE
         u/Xw==
X-Gm-Message-State: AOAM533nYzIQIKsYDKDuLWDqrGZET8MwDJSrcKDmPILr9voEPOHQbOpM
        XGF0RdpSTFlGOGJXu4Uj3zcoy8UyixunGPg=
X-Google-Smtp-Source: ABdhPJw2SvWZ1XI9W5K8nt/BB7nN8YTnKz+xeBgYnSGTG7BKTqQH4kXyF10cnpjO+13wTWBoHwQsNw==
X-Received: by 2002:a63:c745:: with SMTP id v5mr11584885pgg.389.1605774787959;
        Thu, 19 Nov 2020 00:33:07 -0800 (PST)
Received: from PWN (59-125-13-244.HINET-IP.hinet.net. [59.125.13.244])
        by smtp.gmail.com with ESMTPSA id z5sm1626030pgi.27.2020.11.19.00.33.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2020 00:33:07 -0800 (PST)
Date:   Thu, 19 Nov 2020 03:32:57 -0500
From:   Peilin Ye <yepeilin.cs@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v3 0/5] console: Miscellaneous clean-ups, do not use
 FNTCHARCNT() in fbcon.c
Message-ID: <20201119083257.GA9468@PWN>
References: <cover.1605169912.git.yepeilin.cs@gmail.com>
 <20201113211633.GY401619@phenom.ffwll.local>
 <X68NFzaAuImemnqh@kroah.com>
 <20201114081021.GA11811@PWN>
 <X6/K/S9V7rj2hI5p@kroah.com>
 <X6/L/lE2pA7csBwd@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X6/L/lE2pA7csBwd@kroah.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Sat, Nov 14, 2020 at 01:22:22PM +0100, Greg Kroah-Hartman wrote:
> Ah, here's a hint:
> 	https://wiki.archlinux.org/index.php/Linux_console#Fonts
> 
> The setfont tool should help you out here.

setfont seems to work fine, I tried Georgian-Fixed16 (256 chars) and
Uni2-VGA16 (512 chars) under /usr/share/consolefonts/ in my Ubuntu box,
including setting all consoles to the same font:

for i in {1..6}; do
        sudo setfont -C /dev/tty${i} /usr/share/consolefonts/Georgian-Fixed16.psf.gz
done

Font rotation also seems to work fine:

for i in {1..4}; do
        echo $i | sudo tee /sys/class/graphics/fbcon/rotate
        sleep 1
done

One last thing I can think of is tile blitting, but I don't have the
hardware (e.g. a Matrox G400 card, see FB_TILEBLITTING in
drivers/video/fbdev/Kconfig) at hand, nor did I figure out how to
simulate it after searching for a while.  However based on the other
tests above I believe vc->vc_font.charcount is set properly.

Thanks,
Peilin Ye

