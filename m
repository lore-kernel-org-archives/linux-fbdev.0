From: James Simmons <jsimmons@infradead.org>
Subject: Re: Fw: framebuffer blitting performance loss
 2.6.12 -> 2.6.13-rc3
Date: Wed, 3 Aug 2005 18:29:46 +0100 (BST)
Message-ID: <Pine.LNX.4.56.0508031828240.2330@pentafluge.infradead.org>
References: <20050715033912.1cd9b6c3.akpm@osdl.org>  <200507221158.23454.adaplas@gmail.com>
  <20050729001735.5934622f.akpm@osdl.org> <42EA430C.2010405@t-online.de> 
 <42EA4E6A.70907@gmail.com>  <Pine.LNX.4.56.0507292041110.17988@pentafluge.infradead.org>
 <9e4733910507291321609b4c48@mail.gmail.com> <42EAB177.6070808@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E0N4E-00067n-2t
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 03 Aug 2005 10:30:10 -0700
Received: from pentafluge.infradead.org ([213.146.154.40])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1E0N4C-0008HA-Pu
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 03 Aug 2005 10:30:10 -0700
In-Reply-To: <42EAB177.6070808@gmail.com>
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
Cc: Knut Petersen <Knut_Petersen@t-online.de>, Andrew Morton <akpm@osdl.org>


> Yes, the loop copies each row of a font character.  For an 8x16 font
> that's 1 byte. The maximum fontwidth is 32. A 12x22 font does not pass
> through this function because the width is not a multiple of 8.  So,
> currently, it's used mostly for 8x16 fonts. 
> 
> I already know people using 16x30 fonts. There are probably others bigger
> than that. 
> 
> Of course, we can always use Duff's version to loop-unroll that particular
> section, but even at 4 bytes, I don't know if it's worth the effort. Anyone
> knows people using 32 wide fonts?

The console system supports up to 32 pixel wide fonts. Even at that 
maximum size we only copy 4 bytes of data at a time. Unrolling the loop 
is right.



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
