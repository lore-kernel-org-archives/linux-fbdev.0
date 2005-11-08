From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH 0/8] fbcon: Console Rotation
Date: Tue, 08 Nov 2005 08:47:06 +0800
Message-ID: <436FF58A.4090506@gmail.com>
References: <436F33A2.6070107@gmail.com> <20051107162301.0f7d5bc6.akpm@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EZHeL-0005rb-Si
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 07 Nov 2005 16:47:45 -0800
Received: from xproxy.gmail.com ([66.249.82.198])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EZHeK-0001Fl-Qg
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 07 Nov 2005 16:47:46 -0800
Received: by xproxy.gmail.com with SMTP id s6so598323wxc
        for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 07 Nov 2005 16:47:44 -0800 (PST)
In-Reply-To: <20051107162301.0f7d5bc6.akpm@osdl.org>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@osdl.org>
Cc: linux-fbdev-devel@lists.sourceforge.net

Andrew Morton wrote:
> "Antonino A. Daplas" <adaplas@gmail.com> wrote:
>> This patch series implements generic code to rotate the console at 90, 180,
>> and 270 degrees.
> 
> I note that you have a bunch of fixes which are dependent upon these changes.
> 
> What's your priority on all this work?
> 

None are actually important, except for these 2 which are fixes of
real problems:

[PATCH 1/7] savagefb: X-panning fixes
[PATCH 7/7] fbdev: Framebuffer mode required for PowerBook Titanium

These 2 should apply cleanly.

The rest are cleanups and can wait.  If you have problems merging them,
I'll resubmit them on your next release.

Tony


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
