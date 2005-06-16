From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: [PATCH] iomove removal
Date: Thu, 16 Jun 2005 11:16:19 +0800
Message-ID: <200506161116.19278.adaplas@hotpop.com>
References: <Pine.LNX.4.56.0505132343580.14541@pentafluge.infradead.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Dil1x-00065g-9U
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 15 Jun 2005 20:27:01 -0700
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1Dil1v-0007qp-T7
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 15 Jun 2005 20:27:01 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id BE17612B8365
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 16 Jun 2005 03:26:50 +0000 (UTC)
In-Reply-To: <Pine.LNX.4.56.0505132343580.14541@pentafluge.infradead.org>
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
To: James Simmons <jsimmons@www.infradead.org>, Andrew Morton <akpm@osdl.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Saturday 14 May 2005 06:48, James Simmons wrote:
> Since no one is using the inbuf, outbuf of struct fb_pixmap I removed
> their use in the framebuffer console. The idea is instead move the
> pixmap functionality below the accelerated functions intead of on top
> as the way it is now. If there is no objection please apply. This is
> against Linus latestr GIT tree. Thank you.

Ok.

Tony




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
