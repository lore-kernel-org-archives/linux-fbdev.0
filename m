From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: Dual screen framebuffer development advice
Date: Tue, 23 Nov 2004 06:14:03 +0800
Message-ID: <200411230614.03946.adaplas@hotpop.com>
References: <200406191455.56574.andrew@walrond.org> <200406200425.48378.adaplas@hotpop.com> <200411222135.55027.andrew@walrond.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CWMRv-0005GY-Qb
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 22 Nov 2004 14:14:19 -0800
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CWMRu-0002op-MV
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 22 Nov 2004 14:14:19 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 3A74F9CEC03
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 22 Nov 2004 22:14:05 +0000 (UTC)
In-Reply-To: <200411222135.55027.andrew@walrond.org>
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
To: Andrew Walrond <andrew@walrond.org>, linux-fbdev-devel@lists.sourceforge.net, adaplas@pol.net

On Tuesday 23 November 2004 05:35, Andrew Walrond wrote:
> I asked this a few months ago:
>
> On Saturday 19 Jun 2004 21:25, Antonino A. Daplas wrote:
> > On Saturday 19 June 2004 21:55, Andrew Walrond wrote:
> > > I need to setup a machine to develop a framebuffer based application.
> > > I'd like to use two graphics devices; The first an ati agp chipset on
> > > the motherboard which will run X11 with X11's ati driver, the second a
> > > PCI card running a fb driver and displaying my framebuffer application.
> > >
> > > Is this possible/sensible?
> >
> > Sure, it's possible and actually not hard to do.  Just make sure that the
> > driver of your primary card is fbdev, and the secondary X11.  X happens
> > to do a fine job of initializing non-primary cards whereas fbdev is
> > mostly restricted to cards initialized by the firmware.
>
> I've got this working nicely now. I have a recent agp nvidia card and an
> old pci matrox millenium in this dual opteron machine running 64bit linux.
> I boot into a console on the matrox using the built-in matroxfb driver,
> then startx which runs on the nvidia card using the nv driver. I can then
> work on my fb application in X, viewing the output on the second monitor
> via the matrox card. Nice!
>
> > Note: You wont' be able to see both displays simultaneously, switching
> > from one blanks the other.   If you do want multi-seat, see the Ruby
> > project of linuxconsole.
>
> This is wrong; I can indeed see both displays simultaneously :)

That sounds very nice :-).  So I was wrong.  I probably should have said
that you cannot display multiple consoles simultaneously.

Tony




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
