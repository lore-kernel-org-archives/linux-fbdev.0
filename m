From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: sysfs support for framebuffer
Date: Mon, 21 Feb 2005 17:15:35 -0500
Message-ID: <9e473391050221141525aea1ef@mail.gmail.com>
References: <9e4733910502181435f60371c@mail.gmail.com>
	 <Pine.LNX.4.56.0502211841580.13423@pentafluge.infradead.org>
	 <9e4733910502211133a8d7e59@mail.gmail.com>
	 <Pine.LNX.4.56.0502212117240.16017@pentafluge.infradead.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D3Lq8-0007Cx-Qd
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 21 Feb 2005 14:15:40 -0800
Received: from rproxy.gmail.com ([64.233.170.200])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1D3Lq7-0006tP-BC
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 21 Feb 2005 14:15:40 -0800
Received: by rproxy.gmail.com with SMTP id z35so648319rne
        for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 21 Feb 2005 14:15:36 -0800 (PST)
In-Reply-To: <Pine.LNX.4.56.0502212117240.16017@pentafluge.infradead.org>
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
To: linux-fbdev-devel@lists.sourceforge.net

On Mon, 21 Feb 2005 21:36:38 +0000 (GMT), James Simmons
<jsimmons@www.infradead.org> wrote:
> Now there is a problem to the above. If we have more than one graphics
> card it will get messy. I would guess the X server wants to know what
> things belong to what device. For example the matrox card supports dual
> heads. What if we have 3 graphics cards. Which two fbX devices belong to the
> matrox card. You could scan all the directories and organize a list for
> what belongs to what but that would be messy. Plus what if we plug
> a monitor in. We have to know which things (fb, mmio) effect its output.

I don't see a problem with the current structure. A two headed card
would show up as fb0 and fb1. The modelist for fb0 and fb1 would both
contain an entry for merged-fb. If you own both devices, then setting
the merged-fb mode will simply disable the other device. Same for
mirroring. If you don't own both devices the shared modes won't be in
the list. Device fb2 would list none of the shared modes. If you
really need to know then both fb0 and fb1 are linked to the same
device node in sysfs.

You are also pointing out a weakness in the fb_info structure. fb_info
is not designed for multiple heads. I can copy it like the matrox case
but this causes a lot of fields that should not be shared to be
copied. A much better design would be to break the structure up into
fb_device and fb_head. Then have an fb_head struct for each head. This
would also reduce the surface area of what fbcon is seeing since it
only needs to see the fb_head structure.

-- 
Jon Smirl
jonsmirl@gmail.com


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
