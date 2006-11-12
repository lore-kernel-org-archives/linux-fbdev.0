From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Fwd: [Suspend-devel] resume not working on acer ferrari 4005 with radeonfb enabled
Date: Sun, 12 Nov 2006 13:13:35 +0100
Message-ID: <20061112121334.GC9989@elf.ucw.cz>
References: <D0233BCDB5857443B48E64A79E24B8CE6B5438@labex2.corp.trema.com> <1163285379.4982.233.camel@localhost.localdomain>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754225AbWKLMNr@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1163285379.4982.233.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Christian Hoffmann <Christian.Hoffmann@wallstreetsystems.com>, Andrew Morton <akpm@osdl.org>, Solomon Peachy <pizza@shaftnet.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-fbdev-devel@lists.sourceforge.net, LKML <linux-kernel@vger.kernel.org>, Christian@ogre.sisk.pl, Hoffmann@albercik.sisk.pl

Hi!

> > Then the radeonfb doesn't kick in at all (guess some pci ids are added
> > in that patch).
> > 
> > BTW: resume/suspend works ok if I have the vesa fb enabled.
> 
> In that case (vesafb), when does the screen come back precisely ? Do you
> get console mode back and then X ? Or it only comes back when going back
> to X ? Do you have some userland-type vbetool thingy that bring it
> back ?

He's using s3_bios+s3_mode, so kernel does some BIOS calls to reinit
the video. It should come out in text mode, too.

Christian, can you unload radeonfb before suspend/reload it after
resume?

Next possibility is setting up serial console and adding some printks
to radeon...
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
