Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE99DC433E0
	for <linux-fbdev@archiver.kernel.org>; Wed, 27 Jan 2021 17:45:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7335464D9E
	for <linux-fbdev@archiver.kernel.org>; Wed, 27 Jan 2021 17:45:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236411AbhA0Ro6 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 27 Jan 2021 12:44:58 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:57856 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344122AbhA0Rou (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 27 Jan 2021 12:44:50 -0500
Date:   Wed, 27 Jan 2021 18:44:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1611769448;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=VIoN5TDvd5gewKoIsScVFfitrAXPVjTNHdpGwsh86Dw=;
        b=RF5EfPm4S/SNHK5FbLRlqPt1g8wPqMKZDcQgR7GZGTMLpC6H1DMe5+dCwh5RP5NYBhRJ0T
        aJwVpnxnkTgFWFH5ZhcC2wTY0cTQt8qIWByDl0OO0YqfVqO4WjN5yZ5uWcXyewERh94eL5
        v8/fK7ZIXd8xskhX9Z9TtrHLEI0lR3KaUfIKjgwJTW3+DG7UU8bk+fUr61b7XQN9BOz6oG
        ovEbh5PY5BCPJtnJSW7lfw7zS2FOvqlL+zcO+YDs4lfdazzamag3BqBCS/pSkC+xQzFL1c
        BvEW0MgF0P56CykIUmyXKRcdV12zy2x/VVh952C+3n1+Kw/gYFov8JcU1mWdCA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1611769448;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=VIoN5TDvd5gewKoIsScVFfitrAXPVjTNHdpGwsh86Dw=;
        b=ZBOiJsMm3c8gBrxw+xeIP93ALD7J6GpdSDUpyBfzyD6vKCwHfwK/+3aqvJt0BOxFfhZnIY
        kmJLUrXbqHc1akBg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-fbdev@vger.kernel.org, Peter Collingbourne <pcc@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        dri-devel@lists.freedesktop.org
Subject: [RFC] in_atomic() usage in amba-clcd.c / FB_ARMCLCD
Message-ID: <20210127174408.ududpwfrbg3dhyxj@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

The mba-clcd driver uses in_interrupt() in clcdfb_sleep():
| /*
|  * Unfortunately, the enable/disable functions may be called either from
|  * process or IRQ context, and we _need_ to delay.  This is _not_ good.
|  */
| static inline void clcdfb_sleep(unsigned int ms)
| {
|         if (in_atomic()) {
|                 mdelay(ms);
|         } else {
|                 msleep(ms);
|         }
| }

I traced it back to its initial merge:
    bfe694f833643 ("[ARM] Add ARM AMBA CLCD framebuffer driver.")
    https://git.kernel.org/history/history/c/bfe694f833643

The driver has been removed and added back in the meantime. 
I've been looking for the IRQ context as described in the comment and
couldn't find it. The functions calling clcdfb_sleep() also call
conditionally backlight_update_status() which acquires a mutex.

Is this part really outdated and now msleep() could be used
unconditionally?

Sebastian
