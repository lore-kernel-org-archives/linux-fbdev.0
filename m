From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [patch] radeonfb: FB_WAITFORVSYNC
	implementation
Date: Sun, 13 Mar 2005 10:21:05 +1100
Message-ID: <1110669665.5787.44.camel@gaston>
References: <1110636406.5997.86.camel@atlantis.netenviron.com>
	 <9e473391050312073314dcb39f@mail.gmail.com>
	 <1110646984.5997.96.camel@atlantis.netenviron.com>
	 <1110648119.5997.100.camel@atlantis.netenviron.com>
	 <9e47339105031209566791e3b9@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DAFvS-0000R4-3d
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 12 Mar 2005 15:21:42 -0800
Received: from gate.crashing.org ([63.228.1.57])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1DAFvQ-0003XY-Do
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 12 Mar 2005 15:21:41 -0800
In-Reply-To: <9e47339105031209566791e3b9@mail.gmail.com>
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
Cc: Jon Smirl <jonsmirl@yahoo.com>

On Sat, 2005-03-12 at 12:56 -0500, Jon Smirl wrote:

> 
> 1) where is the list of valid modes computed? in-kernel or user space.
> Technically either will work but each has plus and minuses. Right now
> radeonfb can do both.
> 
> 1a) #1 is computing the mode list, not setting the mode. The mode is
> always set in the kernel.

At first, I would keep the current mecanism. After all, parsing the EDID
and building the modelist is quite simple. Let the kernel driver do it,
pick a default mode, and let userland optionally change that. That gives
us at least a working boot mode for splash/console before userland is
available. fbdev now has an API for userland to add/remove entries to
modelists, we can extend on that.

> 2) multiheads implies buffer management, this needs to be coordinated with DRM

Yes. That's the main issue with the merge imho. My initial version will
do like MacOS, and cut the framebuffer in 2 apertures split in the
middle. That's the simplest way to get 2 independant access swappers.
This is necessary if we want completely independant framebuffer accesses
to /dev/fbN and /dev/fbN+1 with different bit depth. It may not stay
necessary in the long run if we have some lock for fb access, like X
has, in which case we can just switch the swapper settings before each
access.
 
> 3) fbdev needs to implement hardware cursors

That isn't terribly difficult.

> 4) The fb_info struct doesn't work too well for multiple heads. It
> really should be split up into fb_device/fb_head.

Well, when I look at other OSes, they don't do that neither. They
basically behave like if there was one device per head. All we need, I
think, is the necessary infos to let userland know which heads are
"linked" to a given device, but I don't think the fbdev layer has to
care about the concept of "device". All it cares about is a "head" which
is what fb_info represents.

> 5) driver initiated secondary card reset needs to be implement via a
> user space helper.
> 
> 6) fbcon is tied way too closely to fb_info. There should be an
> interface instead of just letting it muck around in fbdev data
> structures.

It's been very significantly split already, but yes, it could probably
be separated a bit more, though there again, we can go step by step,
there is no need to rewrite the whole world at once.

Ben.




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
