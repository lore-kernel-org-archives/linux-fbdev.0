Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E865C433F5
	for <linux-fbdev@archiver.kernel.org>; Wed, 27 Oct 2021 13:33:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4893360EFF
	for <linux-fbdev@archiver.kernel.org>; Wed, 27 Oct 2021 13:33:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236535AbhJ0Nfb (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 27 Oct 2021 09:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230500AbhJ0Nfb (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 27 Oct 2021 09:35:31 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE70BC061570;
        Wed, 27 Oct 2021 06:33:05 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id w10so2898041ilc.13;
        Wed, 27 Oct 2021 06:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nZXycHElx2PvePSgfI8q1PAKzVhVZLWU+GWvzXGtf+8=;
        b=DYJlq8deziZIZJjqh4x3V7jJEU6eO+sS5sDmopsCFiuS7lFXanCQKm7N0VRVGZlg6g
         onIelYweU690jMcik5iRC2TwHiHzAg7ona9I/tBh4bR9r6PTVG3y3R88wq0wvbA4ZmFA
         secTWT0tynWT0EMD5Q/u6K4Q+1uEDddm6/DHXTYIovSHWX4PJk8WLq3SQtNB7YKX6ScW
         LEGlCgLH4REMcno9uWkwRwU2/awOTKygiKVLSA0wbAAlgggE01wcuTPUnLR9inBRF8QH
         CYdFu/YGwFIlpCL0Titjt6e00yi5B9+i8jJxrbggP2QfS6BYQjGyIGbOK0pqzGHQzNPu
         7wAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nZXycHElx2PvePSgfI8q1PAKzVhVZLWU+GWvzXGtf+8=;
        b=aL45cuQloXNcrXJ9bISAGYRmayx0od63J8RejH6yTzaopr/Rh1uKQfIgCo28N9j32Z
         bc5YevCXAwxFbvcOFrfY45oSYnJEJRg/hh7ssdQzatDWzkWHHEI3yxUTvXSegZRF2XRW
         8gF114AAoHJ1VkYJgWs+fOhes1Yxy7RjVCAJzb2hOvFd7+YLxez/tdpcU3cNl9sn9kyR
         m0e+YthgyPZfxKjcH1d/askZVo17ANd9WzCQ1VbyAiAZL2+DR6jwCsSu3hJ6bmSoQ38U
         NIBPbIeytXDz5HuUHrFlKbpqLFfx5O886QbBHiOv4hI5WzRx6J7KcdvqHpWnGUme/0ki
         Yr0A==
X-Gm-Message-State: AOAM533DJaN7fUgqIJGO3QJUINWrKnru4LqmUTBG2npm8i8C9Iqnd6T5
        qNyfV5Ffryt1o1kp3xibUtmweBqQGcdBMQo0NaU=
X-Google-Smtp-Source: ABdhPJyQM7nv4/L/+ZrHrxaFQWe4enGNCZfglV+MKpcO6gFgxgurDRXlVA2+RN1ozDoYfDM5GaAxiy3o0wvCISrJVMk=
X-Received: by 2002:a92:d08a:: with SMTP id h10mr17035457ilh.321.1635341585283;
 Wed, 27 Oct 2021 06:33:05 -0700 (PDT)
MIME-Version: 1.0
References: <20211027132732.3993279-1-arnd@kernel.org> <20211027132732.3993279-2-arnd@kernel.org>
In-Reply-To: <20211027132732.3993279-2-arnd@kernel.org>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 27 Oct 2021 15:32:54 +0200
Message-ID: <CANiq72=fkx0BNz0oPuvVA_uEcE1BF92reKtsCbK1fv-fwx2yNg@mail.gmail.com>
Subject: Re: [PATCH 2/3] fbdev: rework backlight dependencies
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>, Miguel Ojeda <ojeda@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jens Frederich <jfrederich@gmail.com>,
        Jon Nettleton <jon.nettleton@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Lars Poeschel <poeschel@lemonage.de>,
        Robin van der Gracht <robin@protonic.nl>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-staging@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Wed, Oct 27, 2021 at 3:28 PM Arnd Bergmann <arnd@kernel.org> wrote:
>
> Rather than having CONFIG_FB_BACKLIGHT select CONFIG_BACKLIGHT_CLASS_DEVICE,
> make any driver that needs it have a dependency on the class device
> being available, to prevent circular dependencies.

Acked-by: Miguel Ojeda <ojeda@kernel.org>

Cheers,
Miguel
