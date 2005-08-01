From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 2/2] tridentfb: Fix scrolling artifacts during disk IO
Date: Mon, 1 Aug 2005 10:08:30 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0508011007570.14342@g5.osdl.org>
References: <42EE4506.1000000@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DzdmV-0002Pu-7V
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 01 Aug 2005 10:08:51 -0700
Received: from smtp.osdl.org ([65.172.181.4])
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44)
	id 1DzdmT-0007Lm-PO
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 01 Aug 2005 10:08:51 -0700
In-Reply-To: <42EE4506.1000000@gmail.com>
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
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, Jochen Hein <jochen@jochen.org>, Knut Petersen <Knut_Petersen@t-online.de>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>



On Mon, 1 Aug 2005, Antonino A. Daplas wrote:
> 
>    Fix is to set the performance register (0x2f) with a more stable value.

Applied. However, the patch was whitespace-damaged, please don't do that. 
I fixed it up by hand this time.

		Linus


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
