From: Ian Molton <spyro@f2s.com>
Subject: Re: Fw: Initialisation sequencing.
Date: Fri, 04 Mar 2005 00:03:26 +0000
Message-ID: <4227A5CE.4050008@f2s.com>
References: <200503031438.48357.adaplas@hotpop.com> <4226D649.4000408@f2s.com> <200503040407.11449.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D70ID-0006sH-Ko
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 03 Mar 2005 16:03:45 -0800
Received: from outmail1.freedom2surf.net ([194.106.33.237] helo=outmail.freedom2surf.net)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1D70Hw-0006Ru-Ol
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 03 Mar 2005 16:03:45 -0800
In-Reply-To: <200503040407.11449.adaplas@hotpop.com>
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
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: adaplas@pol.net
Cc: linux-fbdev-devel@lists.sourceforge.net

Antonino A. Daplas wrote:

> Are you using the backlight architecture in drivers/video/backlight?
> Shouldn't the backlight driver pull the video driver first?  I think
> you can do that if you make the backlight driver depend on the video
> driver.


IOW make it a child of it?

I asumed that would work but I cant actually build a modular kernel for
some reason I havent had time to look into yet.

that said, does load order have *any* bearing on probe order ?

since both devices are platform devices, both drivers can be loaded and
dormant and brought up at any time by their devices becomming available
from (another) module...


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
