From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: Dual screen framebuffer development advice
Date: Fri, 10 Dec 2004 04:01:54 +0800
Message-ID: <200412100401.56026.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CcUUY-0005RV-5T
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 09 Dec 2004 12:02:22 -0800
Received: from smtp-out.hotpop.com ([38.113.3.71])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CcUUW-0008Fd-8u
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 09 Dec 2004 12:02:21 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id F0DFB1278213
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu,  9 Dec 2004 20:01:54 +0000 (UTC)
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
To: Andrew Walrond <andrew@walrond.org>, linux-fbdev-devel@lists.sourceforge.net

--- Andrew Walrond <andrew@walrond.org> wrote:

> On Monday 22 Nov 2004 22:14, Antonino A. Daplas
> wrote:
> > On Tuesday 23 November 2004 05:35, Andrew Walrond
> wrote:
> > >
> > > I've got this working nicely now. I have a
> recent agp nvidia card and an
> > > old pci matrox millenium in this dual opteron
> machine running 64bit
> > > linux. I boot into a console on the matrox using
> the built-in matroxfb
> > > driver, then startx which runs on the nvidia
> card using the nv driver. I
> > > can then work on my fb application in X, viewing
> the output on the second
> > > monitor via the matrox card. Nice!
> >
> 
> I've just done a bk pull from linus and build a new
> kernel (was using post rc2 
> before) and now this nice scheme (see above) fails
> to work:
> 
> When I 'startx', the X log complains about no core
> keyboard, my usb keyboard 
> stops responding and both screens go blank. I can
> only get access by ssh from 
> another machine.
> 
> Nothing changed other than kernel; using same
> .config.
> 
> If I boot on rivafb console instead of matroxfb,
> startx and keyboard work 
> fine.
> 
> Before I start hunting down the problem; Do any
> recent changes spring to mind?

-rc3 is bug-fix only, so no, I can't think of any changes in fbdev/fbcon
that will cause your problem, unless someone submitted changes without
passing through this list.

Anyway, here's linus' changelog between rc2 and rc3.

  o fbdev: Fix for using >16 pixel wide font in fb console*** 
  o fbdev: Support for bigger than 16x32 fonts in softcursor
  o fbdev: Support for bigger than 16x32 fonts in rivafb cursor
  o fbcon: Disable fbcon cursor if vt softcursor is enabled***
  o fbdev: Allow mode change even if EDID block is not found
  o fbdev: Fix cursor in doublescan mode in atyfb
  o fbdev: Fix typo in atyfb
  o fbdev: Change the find_mode behavior***
  o rivafb: fix broken burst length calculation
  o fbdev: Fix screen corruption in neofb
  o fbdev: Fix lockup when switching to/from X/console
  o fbdev: Fix module_param in rivafb
  o fbdev: Fix crash if fb_set_var() called before register_framebuffer()***
  o fbdev: fix wrong colors at 16 bpp in tridentfb

*** affects core fbcon/fbdev layer

Tony




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
