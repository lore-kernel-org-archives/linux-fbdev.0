From: Andrew Walrond <andrew@walrond.org>
Subject: Re: Dual screen framebuffer development advice
Date: Thu, 9 Dec 2004 09:25:10 +0000
Message-ID: <200412090925.10768.andrew@walrond.org>
References: <200406191455.56574.andrew@walrond.org> <200411222135.55027.andrew@walrond.org> <200411230614.03946.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Cet2e-0003EH-ES
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 16 Dec 2004 02:39:28 -0800
Received: from [62.24.231.113] (helo=cenedra.walrond.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1Cet2d-0001tr-Gp
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 16 Dec 2004 02:39:28 -0800
Received: from [62.24.231.115] (helo=orac.walrond.org)
	by cenedra.walrond.org with esmtp (Exim 4.34)
	id 1CcKXu-0001EM-Td
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 09 Dec 2004 09:25:11 +0000
In-Reply-To: <200411230614.03946.adaplas@hotpop.com>
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
To: linux-fbdev-devel@lists.sourceforge.net

On Monday 22 Nov 2004 22:14, Antonino A. Daplas wrote:
> On Tuesday 23 November 2004 05:35, Andrew Walrond wrote:
> >
> > I've got this working nicely now. I have a recent agp nvidia card and an
> > old pci matrox millenium in this dual opteron machine running 64bit
> > linux. I boot into a console on the matrox using the built-in matroxfb
> > driver, then startx which runs on the nvidia card using the nv driver. I
> > can then work on my fb application in X, viewing the output on the second
> > monitor via the matrox card. Nice!
>

I've just done a bk pull from linus and build a new kernel (was using post rc2 
before) and now this nice scheme (see above) fails to work:

When I 'startx', the X log complains about no core keyboard, my usb keyboard 
stops responding and both screens go blank. I can only get access by ssh from 
another machine.

Nothing changed other than kernel; using same .config.

If I boot on rivafb console instead of matroxfb, startx and keyboard work 
fine.

Before I start hunting down the problem; Do any recent changes spring to mind?

Thanks

Andrew


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
