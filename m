From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: XGL/mesa-solo and fbdev
Date: Tue, 22 Feb 2005 18:22:36 +1100
Message-ID: <1109056956.5412.107.camel@gaston>
References: <9e47339105022111483136bd56@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D3UO3-0004yu-IL
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 21 Feb 2005 23:23:15 -0800
Received: from gate.crashing.org ([63.228.1.57])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1D3UO3-0002Sv-0F
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 21 Feb 2005 23:23:15 -0800
In-Reply-To: <9e47339105022111483136bd56@mail.gmail.com>
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
To: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>
Cc: Jon Smirl <jonsmirl@gmail.com>

On Mon, 2005-02-21 at 14:48 -0500, Jon Smirl wrote:
> XGL/mesa-solo is a project that has been going on for about a year and
> a half now to get X running on top of OpenGL instead of the existing
> 2D XAA drivers. XGL allows a vastly improved user experience as
> demonstrated at the recent X developer's conference. Removing the 2D
> drivers from X means that things like mode setting need to come from
> someplace else, like fbdev.
> 
> To make this project work XGL/mesa-solo needs support for these things
> at the minimum:
> 1) resetting of secondary cards
> 2) mode setting on all heads, not just the primary one
> 3) hardware cursor control
> 4) control of mode setting/cursor etc by users, not just root
> 5) DRM and fbdev need to not conflict
> 
> We are try to get everything in the stack working together before OLS
> this summer. I've posted code to implement some of these features and
> I'm seeking solutions for making the rest work. Does this look like
> something that can get finished in the next month or so? We also need
> time to get all of the layers above fbdev using the new support.

Finishing that in the next month or so is extremely optimist :)

I think we should do it the linux way, that is not take deadlines too
seriously, just do the stuff.

The first step is putting fbdev's and DRM driver together. I think it's
worth doing a stub right now rather than hacking radeonfb and the radeon
DRM together, because all other PCI card drivers at least will have the
same issues, and for various reasons, you may wnat to only use "half" of
it (that is not use the fbdev side or not use the DRM side), at least
for a while. (radeonfb doesn't always work 100% on all x86's)

The second step is to add video memory management & arbitration.

The third step is to add missing "features" like dual head etc.... and
the appropriate fbdev API changes to do it properly.

Ben.




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
