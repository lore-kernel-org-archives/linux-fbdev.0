From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: [patch][revision #2] Add w100 framebuffer driver
Date: Thu, 13 Jan 2005 19:39:34 +0800
Message-ID: <200501131939.37219.adaplas@hotpop.com>
References: <200501081837.08883.rpurdie@rpsys.net> <200501130822.26095.adaplas@hotpop.com> <03ba01c4f909$781fd330$0f01a8c0@max>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Cp3KS-00026V-0b
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 13 Jan 2005 03:39:52 -0800
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1Cp3KQ-00069W-C3
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 13 Jan 2005 03:39:51 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 8D07ACE72A6
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 13 Jan 2005 11:39:35 +0000 (UTC)
In-Reply-To: <03ba01c4f909$781fd330$0f01a8c0@max>
Content-Disposition: inline
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
To: linux-fbdev-devel@lists.sourceforge.net, Richard Purdie <rpurdie@rpsys.net>
Cc: kronos@people.it

On Thursday 13 January 2005 08:47, Richard Purdie wrote:
> Antonino A. Daplas:
> > On Sunday 09 January 2005 02:37, Richard Purdie wrote:
> >> +static void w100fb_clear_screen(uint32_t mode, long int offset);
> >
> > I'll submit the patch but would it be better to use u32/u32* and family?
>
> I seem to recall reading somewhere that uint32_t was the preferred form in
> the kernel. The code I was working from used a mixture so I made it
> consistent. If u32 is preferred, I'm happy enough to change it...

For the sake of consistency, yes (only gbefb uses uint32_t and family).
And, it would seem that Linus prefers (to put it mildly) u32 over uint32_t.
See

http://marc.theaimsgroup.com/?l=linux-kernel&m=110304822716805&w=2

>
> > BTW, I'm also submitting Andrew's backlight/lcd patch to akpm. Do you
> > think
> > you can port your backlight driver to this framework?
>
> I've been communicating with Andrew offlist and my backlight driver
> actually uses his framework already! It was me who put him onto the
> blanking event idea as that was the previous stumbling block for his patch.
> I was planning on submitting the corgi backlight driver as soon as the
> class is approved (the other code it depends upon has just been approved).

Great.

Tony




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
