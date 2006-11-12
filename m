From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Fwd: [Suspend-devel] resume not working on acer ferrari 4005 with radeonfb enabled
Date: Sun, 12 Nov 2006 13:28:35 +0100
Message-ID: <200611121328.36267.rjw@sisk.pl>
References: <D0233BCDB5857443B48E64A79E24B8CE6B5438@labex2.corp.trema.com> <1163285379.4982.233.camel@localhost.localdomain> <20061112121334.GC9989@elf.ucw.cz>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755091AbWKLMbM@vger.kernel.org>
In-Reply-To: <20061112121334.GC9989@elf.ucw.cz>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: Pavel Machek <pavel@ucw.cz>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Christian Hoffmann <Christian.Hoffmann@wallstreetsystems.com>, Andrew Morton <akpm@osdl.org>, Solomon Peachy <pizza@shaftnet.org>, linux-fbdev-devel@lists.sourceforge.net, LKML <linux-kernel@vger.kernel.org>

On Sunday, 12 November 2006 13:13, Pavel Machek wrote:
> Hi!
> 
> > > Then the radeonfb doesn't kick in at all (guess some pci ids are added
> > > in that patch).
> > > 
> > > BTW: resume/suspend works ok if I have the vesa fb enabled.
> > 
> > In that case (vesafb), when does the screen come back precisely ? Do you
> > get console mode back and then X ? Or it only comes back when going back
> > to X ? Do you have some userland-type vbetool thingy that bring it
> > back ?
> 
> He's using s3_bios+s3_mode, so kernel does some BIOS calls to reinit
> the video. It should come out in text mode, too.
> 
> Christian, can you unload radeonfb before suspend/reload it after
> resume?
> 
> Next possibility is setting up serial console and adding some printks
> to radeon...

I guess this box has no serial ports, but netconsole should do (provided
there's another box nearby on which netcat can be run).

Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
