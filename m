From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: Re: 2.6.12-rc1-mm2 -- nvidiafb driver gives black screen
Date: Fri, 15 Apr 2005 11:07:49 +0800
Message-ID: <200504151107.49810.adaplas@hotpop.com>
References: <a44ae5cd0503242023233dc23f@mail.gmail.com> <200504141351.42971.adaplas@hotpop.com> <20050414191323.10d7d435.khali@linux-fr.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DMHCG-0001Eg-7Z
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 14 Apr 2005 20:08:44 -0700
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DMHCF-000503-QS
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 14 Apr 2005 20:08:44 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id E9597101FFC9
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 15 Apr 2005 03:08:35 +0000 (UTC)
In-Reply-To: <20050414191323.10d7d435.khali@linux-fr.org>
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
To: Jean Delvare <khali@linux-fr.org>, "Antonino A. Daplas" <adaplas@pol.net>
Cc: linux-fbdev-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>, Miles Lane <miles.lane@gmail.com>

On Friday 15 April 2005 01:13, Jean Delvare wrote:
> Hi Tony,
>
> > This patch will always limit the amount of video RAM to remap at
> > 128 MiB.
>
> I don't much get the idea. What are you trying to prevent?

I'm preventing ioremap failures when the driver tries to remap a large
chunk of the graphics aperture.

>
> 128 MiB seems a rather low limit. Graphics adapters with 256 MiB, 512
> MiB or even 640 MiB exist, and I see little reason why it would stop
> increasing.

For fbcon use, such a large amount of RAM does not help significantly
with performance.  Also, nvidiafb cannot use the entire video RAM as
framebuffer space since it's 2D drawing functions are limited by the
clipping coordinates which is set at 0x7fff, x and y, ie, one can only do
blits within the range of 0x0-0x7fff.

Tony




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
