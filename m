From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: [patch][revision #2] Add w100 framebuffer driver
Date: Thu, 13 Jan 2005 08:22:23 +0800
Message-ID: <200501130822.26095.adaplas@hotpop.com>
References: <200501081837.08883.rpurdie@rpsys.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CoslL-0002Bm-0M
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 12 Jan 2005 16:22:55 -0800
Received: from smtp-out.hotpop.com ([38.113.3.51])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CoslJ-0005JS-BC
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 12 Jan 2005 16:22:54 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 7E97970179
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 13 Jan 2005 00:22:40 +0000 (UTC)
In-Reply-To: <200501081837.08883.rpurdie@rpsys.net>
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
To: Richard Purdie <rpurdie@rpsys.net>, "adaplas@hotpop.com" <adaplas@hotpop.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, kronos@people.it

On Sunday 09 January 2005 02:37, Richard Purdie wrote:
> +static void w100fb_clear_screen(uint32_t mode, long int offset);

I'll submit the patch but would it be better to use u32/u32* and family?

BTW, I'm also submitting Andrew's backlight/lcd patch to akpm. Do you think
you can port your backlight driver to this framework?

Tony




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
