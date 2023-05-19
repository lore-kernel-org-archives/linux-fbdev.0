Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BB48C77B7A
	for <linux-fbdev@archiver.kernel.org>; Fri, 19 May 2023 15:42:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232125AbjESPmz (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 19 May 2023 11:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjESPmy (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 19 May 2023 11:42:54 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id C2C541A6
        for <linux-fbdev@vger.kernel.org>; Fri, 19 May 2023 08:42:52 -0700 (PDT)
Received: (qmail 42012 invoked by uid 1000); 19 May 2023 11:42:52 -0400
Date:   Fri, 19 May 2023 11:42:52 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Helge Deller <deller@gmx.de>
Cc:     linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        syzbot <syzbot+0e22d63dcebb802b9bc8@syzkaller.appspotmail.com>,
        bernie@plugable.com, linux-usb@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [fbdev?] [usb?] WARNING in
 dlfb_submit_urb/usb_submit_urb (2)
Message-ID: <c1cf7ff1-c204-4afc-aa9d-890e07d5ec72@rowland.harvard.edu>
References: <0000000000004a222005fbf00461@google.com>
 <ZGXVANMhn5j/jObU@ls3530>
 <4cd17511-2b60-4c37-baf3-c477cf6d1761@rowland.harvard.edu>
 <be824fbc-cde4-9a2a-8fb4-1ca23f498dca@gmx.de>
 <2905a85f-4a3b-4a4f-b8fb-a4d037d6c591@rowland.harvard.edu>
 <ZGZ3JPLqxCxA2UB6@ls3530>
 <c7b8e69a-cabe-4e17-a511-66179259d1d7@rowland.harvard.edu>
 <6e93305a-2d70-d411-3e36-c536449295dd@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e93305a-2d70-d411-3e36-c536449295dd@gmx.de>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Fri, May 19, 2023 at 12:38:15PM +0200, Helge Deller wrote:
> Patch looks good and survived the test.
> 
> Will you send a proper patch to the fbdev mailing list, so that I can
> include it?

Will do.

While you're working on this driver, here's a suggestion for another 
improvement you can make.  The temporary buffer allocations and calls to 
usb_control_msg() in dlfb_get_edid() and dlfb_select_std_channel() can 
be replaced with calls to usb_control_msg_recv() and 
usb_control_msg_send() respectively.

Alan Stern
