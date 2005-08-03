From: James Simmons <jsimmons@infradead.org>
Subject: Re: Optimizing bitblit.c / fb_pad_*
Date: Wed, 3 Aug 2005 18:34:08 +0100 (BST)
Message-ID: <Pine.LNX.4.56.0508031832350.2330@pentafluge.infradead.org>
References: <42EB46AB.1010005@t-online.de> <42EB7A10.4080601@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E0N8G-0006Hy-Nw
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 03 Aug 2005 10:34:20 -0700
Received: from pentafluge.infradead.org ([213.146.154.40])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1E0N8F-0001GJ-Fw
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 03 Aug 2005 10:34:20 -0700
Received: from jsimmons (helo=localhost)
	by pentafluge.infradead.org with local-esmtp (Exim 4.52 #1 (Red Hat Linux))
	id 1E0N84-0000gN-8l
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 03 Aug 2005 18:34:15 +0100
In-Reply-To: <42EB7A10.4080601@gmail.com>
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


> why not make it to something like this?
> 
> 		for (i = cellsize; i--;) {
> 			*dstp = src[cellsize-1-i];
> 			dstp += pitch;
> 		}
> 
> This way, it will work with any fontsize, as long as the width
> is a 8-bit size-aligned.  You can do the same with
> fb_pad_aligned_buffer(), so the rest can benefit too.
> 
> The above is probably a bit slower than your version, but it's a
> good compromise -- bit_putcs is ugly enough, the price for
> the optimization.
> 
> Tony
> 
> PS: Next time you submit a patch, add a Signed-off-line. See this
> document by akpm:
> 
> http://www.zip.com.au/~akpm/linux/patches/stuff/tpp.txt

If you embedded everything then there is no reason to do massivce copies.
Right now this is not the highest priority. We have alot of other fixes 
that need to go in.



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
