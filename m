From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: FB_EVENT (blank and unblank?)
Date: Sun, 28 Nov 2004 06:43:14 +0800
Message-ID: <200411280643.14171.adaplas@hotpop.com>
References: <41A36DA5.8090200@fujitsu-siemens.com> <Pine.GSO.4.61.0411261010460.26681@waterleaf.sonytel.be> <010501c4d490$e9edee40$0f01a8c0@max>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CYDP1-0001eJ-DV
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 27 Nov 2004 16:58:59 -0800
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CYBHp-0003Cc-VO
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 27 Nov 2004 14:43:29 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id E9176A7B0AC
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 27 Nov 2004 22:43:12 +0000 (UTC)
In-Reply-To: <010501c4d490$e9edee40$0f01a8c0@max>
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

On Saturday 27 November 2004 22:53, Richard Purdie wrote:
> I've been looking at ways to solve a couple of code interdepencies I don't
> like with w100fb and its backlight  and touch screen drivers.
>
> I have two places where they need to talk. The first is for the touch
> screen to query the x resolution (and to know if the screen is blanked)[1].
> The second is to turn the backlight off when the console is blanked.

Can you adopt the backlight support infrastructure in powermacs?  See
arch/ppc/platforms/pmac_backlight.c  Currently, it's PPC-specific, but it
can be extended to other platforms.  A few drivers use this, rivafb is one of
them (drivers/video/fbdev.c), and aty.

Tony




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
