From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: radeon, apertures & memory mapping
Date: Sat, 12 Mar 2005 22:22:57 -0500
Message-ID: <9e47339105031219223e606a52@mail.gmail.com>
References: <1110677744.19810.80.camel@gaston>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DAKd0-0007k6-Ox
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 12 Mar 2005 20:22:58 -0800
Received: from rproxy.gmail.com ([64.233.170.202])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DAKd0-0007tg-AW
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 12 Mar 2005 20:22:58 -0800
Received: by rproxy.gmail.com with SMTP id z35so2147002rne
        for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 12 Mar 2005 20:22:57 -0800 (PST)
In-Reply-To: <1110677744.19810.80.camel@gaston>
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, dri-devel@lists.sourceforge.net, xorg@lists.freedesktop.org, Jon Smirl <jonsmirl@yahoo.com>

What about using the overlapped mode and dividing memory into four regions

FB0
PCI visible free mem
FB1
APER_SIZE
non-visible free mem

This way setting the mode on FB0 doesn't always bump into FB1.

The DRM could do this:
FB0
back0
depth0
aux0, etc
PCI visible free mem - textures priority 2
aux1, etc
depth1
back1
FB1
APER_SIZE
non-visible free mem - textures priority 1


On Sun, 13 Mar 2005 12:35:43 +1100, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> I could maybe use a single ioremap though, that is use a single
> aperture, and then switch the swapper on accesses. Though I should also
> be careful not to end up conflicting with a userland process relying on
> having the 2 separate aperture swappers stable for the mode on the 2
> separate framebuffer mappings... Like X would use fb0 while console
> would use fb1 with a different swapper setting. That would blow up for
> sure unless fbcon arbitrates accesses with X, which I don't see
> happening right away. I suppose we'll have to consider both heads linked
> as far as console ownership is concerned, at least for now, until the
> kernel console subsystem is overhauled significantly.

In the long term I was hoping to design thing such that the two heads
can be used by two independent users, each could be running X or
fbdev.

A user space console implementation also makes a lot of sense in the
multiuser case. User space console can be a DRI application instead of
fbdev reducing the need to map.

-- 
Jon Smirl
jonsmirl@gmail.com


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
