From: James Simmons <jsimmons@infradead.org>
Subject: Re: Fw: framebuffer blitting performance loss
 2.6.12 -> 2.6.13-rc3
Date: Fri, 29 Jul 2005 20:52:45 +0100 (BST)
Message-ID: <Pine.LNX.4.56.0507292052090.17988@pentafluge.infradead.org>
References: <20050715033912.1cd9b6c3.akpm@osdl.org> <200507221158.23454.adaplas@gmail.com>
 <20050729001735.5934622f.akpm@osdl.org> <42EA430C.2010405@t-online.de>
 <42EA4E6A.70907@gmail.com> <20050729120250.3c8c1372.akpm@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DyavG-00009b-UO
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 29 Jul 2005 12:53:34 -0700
Received: from pentafluge.infradead.org ([213.146.154.40])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1Dyauk-0001MN-Mo
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 29 Jul 2005 12:53:35 -0700
In-Reply-To: <20050729120250.3c8c1372.akpm@osdl.org>
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: "Antonino A. Daplas" <adaplas@gmail.com>, Knut_Petersen@t-online.de


> "Antonino A. Daplas" <adaplas@gmail.com> wrote:
> >
> >     fbdev: Replace memcpy with for-loop when preparing bitmap
> 
> Whee, progress.  Please let me know if/when you want this sent to Linus.

Before you do I like to know memcpy is slower than byte by byte copying. 
This just seems to be wrong!


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
