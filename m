From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: ghosting with nvidia framebuffer (pci-e 6600), 1600x1200 and 12x22 font
Date: Fri, 22 Jul 2005 22:05:43 +0800
Message-ID: <200507222205.46777.adaplas@gmail.com>
References: <20050706190456.GA20251@amd64.of.nowhere> <200507221203.31810.adaplas@gmail.com> <20050722132954.GA2363@amd64.of.nowhere>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Dw0Jj-0005WX-RC
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 22 Jul 2005 09:24:07 -0700
Received: from rproxy.gmail.com ([64.233.170.203])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1Dw0Jh-0002MD-HI
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 22 Jul 2005 09:24:07 -0700
Received: by rproxy.gmail.com with SMTP id a41so246820rng
        for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 22 Jul 2005 09:23:25 -0700 (PDT)
In-Reply-To: <20050722132954.GA2363@amd64.of.nowhere>
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
To: jurriaan <thunder7@xs4all.nl>, adaplas@pol.net
Cc: linux-fbdev-devel@lists.sourceforge.net

On Friday 22 July 2005 21:29, jurriaan wrote:
> From: Antonino A. Daplas <adaplas@gmail.com>
> Date: Fri, Jul 22, 2005 at 12:03:31PM +0800

> My conclusion  would be the ghosting only happens at 1600x1200-32, and
> the underling happens in more than 8-bit deep displays. And it has
> something to do with acceleration, if I boot like this, nothing is
> corrupted:

Can you also try reducing RECT_EXPAND_TWO_COLOR_DATA_MAX_DWORDS in
drivers/video/nvidia/nv_dma.h from 128 to as low as 16?  If the corruption disappears,
let me know at what point it did.

Tony



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
