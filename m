From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [patch] radeonfb: FB_WAITFORVSYNC implementation
Date: Sat, 12 Mar 2005 12:56:33 -0500
Message-ID: <9e47339105031209566791e3b9@mail.gmail.com>
References: <1110636406.5997.86.camel@atlantis.netenviron.com>
	 <9e473391050312073314dcb39f@mail.gmail.com>
	 <1110646984.5997.96.camel@atlantis.netenviron.com>
	 <1110648119.5997.100.camel@atlantis.netenviron.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DAAqq-0001Qw-L6
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 12 Mar 2005 09:56:36 -0800
Received: from rproxy.gmail.com ([64.233.170.204])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DAAqp-0005vw-75
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 12 Mar 2005 09:56:36 -0800
Received: by rproxy.gmail.com with SMTP id z35so1906636rne
        for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 12 Mar 2005 09:56:33 -0800 (PST)
In-Reply-To: <1110648119.5997.100.camel@atlantis.netenviron.com>
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

On Sat, 12 Mar 2005 17:21:58 +0000, Torgeir Veimo <torgeir@pobox.com> wrote:
> On Sat, 2005-03-12 at 17:03 +0000, Torgeir Veimo wrote:
> > On Sat, 2005-03-12 at 10:33 -0500, Jon Smirl wrote:
> > > You can't do this without coordination from X and DRM.
> >
> > > Because of these issues WAITFORVSYNC in radeondb has to wait for
> > > merged DRM/fbdev to be implemented.
> >
> > It's a bit hard to track the merge-dri-and-db work,
> 
> ^^ merge-dri-and-fb

Merging DRM and fbdev is happening in bits and pieces in both DRM and
fbdev. I've already tried once at building it as a separate project
and the political hassles of getting it merged made me stop. The new
approach is to add the various bits to both drivers until they will
merge with each other. A big piece of getting fbdev ready for DRM was
getting the extended sysfs and module support that just went in.

BenH is working on a new version of radeonfb with support for both
heads. I've stopped working on radeonfb until this lands since it
changes 90% of the code.

Once the foundation is in place I'll modify DRM to attach to fbdev
instead of loading as a standalone driver. At that point we can work
on shared interrupt and buffer management code.

There are still some major unsettled issues:

1) where is the list of valid modes computed? in-kernel or user space.
Technically either will work but each has plus and minuses. Right now
radeonfb can do both.

1a) #1 is computing the mode list, not setting the mode. The mode is
always set in the kernel.

2) multiheads implies buffer management, this needs to be coordinated with DRM

3) fbdev needs to implement hardware cursors

4) The fb_info struct doesn't work too well for multiple heads. It
really should be split up into fb_device/fb_head.

5) driver initiated secondary card reset needs to be implement via a
user space helper.

6) fbcon is tied way too closely to fb_info. There should be an
interface instead of just letting it muck around in fbdev data
structures.

-- 
Jon Smirl
jonsmirl@gmail.com


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
