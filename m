From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: Re: [2.6.11 Permedia-2 Framebuffer] driver
 broken (?).
Date: Thu, 10 Mar 2005 00:48:17 +0100 (CET)
Message-ID: <Pine.LNX.4.60.0503100040450.6356@poirot.grange>
References: <XFMail.20050308230823.jim.hague@acm.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D9AvU-0000w8-8j
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 09 Mar 2005 15:49:16 -0800
Received: from pop.gmx.net ([213.165.64.20] helo=mail.gmx.net)
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1D9AvQ-0001v9-IZ
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 09 Mar 2005 15:49:16 -0800
In-Reply-To: <XFMail.20050308230823.jim.hague@acm.org>
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
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jim Hague <jim.hague@acm.org>
Cc: linux-fbdev-devel@lists.sourceforge.net

On Tue, 8 Mar 2005, Jim Hague wrote:

> Hi Guennadi,
> 
> On 07-Mar-2005 Jim Hague wrote:
> >> As for colours / graphics, disabling CONFIG_FB_PM2_FIFO_DISCONNECT fixes
> >> that too, but it worked under 2.6.10-rc2 with that option on too. What does
> >> it do and why I cannot use it under 2.6.11 any more? The help text to this 
> >> option is not very enlightening...
> > [..]
> > to turn it on, which probably shows how much I know. As to why it's suddenly
> > stopped working, I have no idea. I'll try it out and see if I see the same
> > problems.
> 
> I can't reproduce problems with FIFO Disconnect on my machine. To check I'm
> looking at the right thing, what resolution and colour depth did you have
> problems with?

Hm, not sure how I get it. Is this what you need:

ap400:~# fbset

mode "640x480-60"
    # D: 25.176 MHz, H: 31.469 kHz, V: 59.942 Hz
    geometry 640 480 640 480 8
    timings 39721 40 24 32 11 96 2
    rgba 8/0,8/0,8/0,0/0
endmode

?

Thanks
Guennadi
---
Guennadi Liakhovetski



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
