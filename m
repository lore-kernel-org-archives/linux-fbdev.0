From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [patch] radeonfb: FB_WAITFORVSYNC
	implementation
Date: Sun, 13 Mar 2005 10:33:22 +1100
Message-ID: <1110670402.19810.54.camel@gaston>
References: <1110636406.5997.86.camel@atlantis.netenviron.com>
	 <20050312151318.GA27200@sci.fi> <1110647422.4004.456.camel@localhost>
	 <1110647557.5997.98.camel@atlantis.netenviron.com>
	 <1110655224.4010.469.camel@localhost>
	 <9e473391050312113532327a46@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DAG7J-00010v-Pm
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 12 Mar 2005 15:33:57 -0800
Received: from gate.crashing.org ([63.228.1.57])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1DAG7J-0002Uu-Au
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 12 Mar 2005 15:33:57 -0800
In-Reply-To: <9e473391050312113532327a46@mail.gmail.com>
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


> When we get merged my thought was to let fbdev catch the vsync IRQ and
> then chain into DRM. In that model fbdev becomes the mini-driver.
> Right now I don't think there is any other solution than merging
> fbdev/DRM that doesn't result in some kind of dead on VT switch
> scenario.

A VT switch should stop all asynchronous activity (interrupt, DRM,
etc...). X already stops the DRM on switch-out, this could be enforced
by the kernel.

> Also, I have the hotplug monitor change interrupt hookup in my local
> code but I'm waiting for BenH to finish his dual head radeonfb first.
> He has said it will probably be ready this week, patches are starting
> to appear on lkml from him.

Those are just fixes to the existing code base. The new one isn't ready
yet. I'll give it one more week unfortunately, I've been pressured by
other issues those past few days.

Ben.




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
