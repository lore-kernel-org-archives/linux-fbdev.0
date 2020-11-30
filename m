Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E519C5519F
	for <linux-fbdev@archiver.kernel.org>; Mon, 30 Nov 2020 07:57:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0163D20709
	for <linux-fbdev@archiver.kernel.org>; Mon, 30 Nov 2020 07:57:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbgK3H5l (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 30 Nov 2020 02:57:41 -0500
Received: from asavdk3.altibox.net ([109.247.116.14]:51638 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbgK3H5l (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 30 Nov 2020 02:57:41 -0500
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 4557C20026;
        Mon, 30 Nov 2020 08:56:47 +0100 (CET)
Date:   Mon, 30 Nov 2020 08:56:45 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Peilin Ye <yepeilin.cs@gmail.com>
Cc:     linux-fbdev@vger.kernel.org,
        Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        dri-devel@lists.freedesktop.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Florian Tobias Schandinat <FlorianSchandinat@gmx.de>,
        Evgeny Novikov <novikov@ispras.ru>,
        Lee Jones <lee.jones@linaro.org>,
        Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Thomas Winischhofer <thomas@winischhofer.net>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Aditya Pakki <pakki001@umn.edu>,
        Xiaofei Tan <tanxiaofei@huawei.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Alex Dewar <alex.dewar90@gmail.com>,
        Jason Yan <yanaijie@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Qilong Zhang <zhangqilong3@huawei.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Gustavo Silva <gustavoars@kernel.org>,
        George Kennedy <george.kennedy@oracle.com>,
        Kristoffer Ericson <kristoffer.ericson@gmail.com>,
        Alexander Klimov <grandmaster@al2klimov.de>,
        Jingoo Han <jingoohan1@gmail.com>,
        Joe Perches <joe@perches.com>, Peter Rosin <peda@axentia.se>,
        Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH v2 02/28] video: fbcon: Fix warnings by using pr_debug()
 in fbcon
Message-ID: <20201130075645.GA1442147@ravnborg.org>
References: <20201128224114.1033617-1-sam@ravnborg.org>
 <20201128224114.1033617-3-sam@ravnborg.org>
 <9fbdaff8-18af-223d-6cec-4b44aeb94fec@suse.de>
 <fe2a56cd-10bd-962c-4f65-96c23a78cdd7@i-love.sakura.ne.jp>
 <20201129111836.GA1094053@ravnborg.org>
 <20201130063805.GA21500@PWN>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201130063805.GA21500@PWN>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=Ibmpp1ia c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=1bFr7IoaHJKwnvFcCG0A:9 a=CjuIK1q_8ugA:10
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hi Peilin,
On Mon, Nov 30, 2020 at 01:38:05AM -0500, Peilin Ye wrote:
> Hi Sam,
> 
> On Sun, Nov 29, 2020 at 12:18:36PM +0100, Sam Ravnborg wrote:
> > On Sun, Nov 29, 2020 at 07:28:08PM +0900, Tetsuo Handa wrote:
> > > But replacing printk(KERN_DEBUG) with pr_debug() prevents __func__ from being printed
> > > when FBCONDEBUG is defined. Is such change what the author of this module expects?
> > 
> > When someone goes and enable DEBUG for fbcon they are also able to
> > recognize the logging, so the printing of the function name is redundant
> > in this case.
> > 
> > There is likely limited to no use for these few logging entries, but if
> > they should be dropped then I expect Peilin Ye to do so as he is the
> > only one doing active maintenance of fbcon lately.
> 
> Sure, I will take another look at them. Also sorry for the delay in that
> printk() -> dev_*() patch you suggested, overwhelmed by some other
> things this week. Sometimes fbcon.c accesses dev structs in a pretty
> weird way (e.g. registered_fb[con2fb_map[vc->vc_num]]->dev), I will get
> back to it when I understand this better.
Please just keep up the good work cleaning up fbcon and related stuff.
This is an area that needs some love and care and there is work for many
long nights yet to do.

	Sam
