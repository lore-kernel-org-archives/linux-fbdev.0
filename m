From: jurriaan <thunder7@xs4all.nl>
Subject: Re: ghosting with nvidia framebuffer (pci-e 6600), 1600x1200 and 12x22 font
Date: Wed, 20 Jul 2005 20:33:53 +0200
Message-ID: <20050720183353.GA15993@amd64.of.nowhere>
References: <20050706190456.GA20251@amd64.of.nowhere>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DvJOl-0000Sx-7D
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 20 Jul 2005 11:34:27 -0700
Received: from smtp-vbr9.xs4all.nl ([194.109.24.29])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.44)
	id 1DvJOj-0003Or-Oh
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 20 Jul 2005 11:34:27 -0700
Received: from zeeotter.xs4all.nl (zeeotter.xs4all.nl [80.126.31.149])
	by smtp-vbr9.xs4all.nl (8.13.3/8.13.3) with ESMTP id j6KIYKrN014201
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 20 Jul 2005 20:34:20 +0200 (CEST)
	(envelope-from jurriaan@rivierenland.xs4all.nl)
Content-Disposition: inline
In-Reply-To: <20050706190456.GA20251@amd64.of.nowhere>
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
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net
Cc: adaplas@hotpop.com, adaplas@pol.net

From: jurriaan <thunder7@xs4all.nl>
Date: Wed, Jul 06, 2005 at 09:04:56PM +0200
> I've bought myself a fine new s939 motherboard, which meant another
> videocard as well. Since I couldn't get an Ati X600 running reliably
> under X.org (#@#$*$ FIFO timed out errors are very frustrating, and the
> only solution I found was to shut down all acceleration, which didn't
> make me happy), I'm now running an Nvidia 6600.
> 
> I'm running at 1600x1200 resolution with the 12x22 font, and a
> 2.6.13-rc1-mm1 kernel.
> 
> A strange effect is noticeable: often characters from the left of the
> screen are ghosted on the right of the screen. Not all of the pixels
> that form a character, but enough to be visible. To my best knowledge,
> the ghosting starts at column 85, and 85 * 12 = 1020, which may mean
> some sort of erroneous wrap-around at pixel 1024 is taking place?
> 
Any others experiencing this? I cc'ed mr Daplas, the maintainer, and I
haven't heard anything.....

Thanks,
Jurriaan
-- 
"From there to here, from here to there, funny things are everywhere."
        Dr. Seuss
Debian (Unstable) GNU/Linux 2.6.13-rc2-mm1 5149 bogomips load 0.49


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
