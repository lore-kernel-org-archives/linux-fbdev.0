From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: Fw: [2.6.10-bk6] oops in load of atyfb
Date: Mon, 10 Jan 2005 05:16:20 +0800
Message-ID: <200501100516.20841.adaplas@hotpop.com>
References: <20050105165615.1f3bfd94.akpm@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CnkQX-0006we-LC
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 09 Jan 2005 13:16:45 -0800
Received: from smtp-out.hotpop.com ([38.113.3.71])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CnkQW-0000fF-5b
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 09 Jan 2005 13:16:45 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id A9B8313370B9
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun,  9 Jan 2005 21:16:29 +0000 (UTC)
In-Reply-To: <20050105165615.1f3bfd94.akpm@osdl.org>
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
To: linux-fbdev-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>
Cc: Bill Davidsen <davidsen@tmr.com>

On Thursday 06 January 2005 08:56, Andrew Morton wrote:
> Begin forwarded message:
>
> Date: Wed, 5 Jan 2005 16:24:02 -0500 (EST)
> From: Bill Davidsen <davidsen@tmr.com>
> To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
> Subject: [2.6.10-bk6] oops in load of atyfb
>
>
> After some hours of trying to get video to the atyfb instead of vga16, I
> got this. The video= boot option didn't seem to work, loading the module
> caused an oops.
>
> Something borked, out of time to fight with it.

Have you accidentally enabled CONFIG_FB_ATY_XL_INIT?  If you did, recompile
with this option off.

Tony




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
