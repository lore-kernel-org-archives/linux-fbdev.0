From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [PATCH] Provide control of active VGA device on PCI systems
Date: Sun, 20 Feb 2005 11:35:11 -0500
Message-ID: <9e4733910502200835130012d6@mail.gmail.com>
References: <9e47339105021921507545d084@mail.gmail.com>
	 <1108887831.19402.20.camel@gaston>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D2u37-0002VG-Vt
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 20 Feb 2005 08:35:13 -0800
Received: from rproxy.gmail.com ([64.233.170.196])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1D2u36-0006vm-ID
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 20 Feb 2005 08:35:13 -0800
Received: by rproxy.gmail.com with SMTP id z35so276367rne
        for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 20 Feb 2005 08:35:11 -0800 (PST)
In-Reply-To: <1108887831.19402.20.camel@gaston>
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Jesse Barnes <jbarnes@sgi.com>

On Sun, 20 Feb 2005 19:23:51 +1100, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> (The goal is to have X stop messing around with PCI at all, just probe
> things via sysfs or whatever new model we might provide, but not
> actually play with PCI resources directly nor modify bridge VGA enables,
> and have it properly arbitrate with anything else wanting to use the VGA
> IOs, including kernel services like vgacon).

That's the goal. Make X behave so that it will play nice with hotplug.
I also want to get it to run without needing root priv.

My goal is to provide a foundation for XGL/mesa-solo. That needs
support from fbdev for mode setting, cursors, reset, multiple heads.
Long term this provides a unified video driver model.

Check out the other thread about sysfs support for fbdev and let me
know what you think.



-- 
Jon Smirl
jonsmirl@gmail.com


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
