From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [Dri-devel] Re: [Linux-fbdev-devel] DRM and pci_driver conversion
Date: Fri, 24 Oct 2003 10:59:07 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.44.0310241051450.8177-100000@home.osdl.org>
References: <20031024165718.GA4972@vana.vc.cvut.cz>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <20031024165718.GA4972@vana.vc.cvut.cz>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: Jeff Garzik <jgarzik@pobox.com>, Jon Smirl <jonsmirl@yahoo.com>, Eric Anholt <eta@lclark.edu>, kronos@kronoz.cjb.net, Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-fbdev-devel@lists.sourceforge.net, dri-devel <dri-devel@lists.sourceforge.net>


On Fri, 24 Oct 2003, Petr Vandrovec wrote:
> 
> It would be nice if it works... For matrox hardware I have to map ROM
> over framebuffer (it is solution recommended by datasheet), as there is
> no way to get memory range allocated for ROM unless ROM was left enabled
> all the time.

That's fine - it sounds like Matrox hardware is just buggy, and then you 
will never be able to use the generic "enable ROM" routines. That 
shouldn't detract from other drivers doing it, though. 

On the other hand, we might well be able to work around the matrox
behaviour if we really want to: writing all-ones to the register should
work, and that is the way we figure out the size of the allocation anyway.  

So this is one of those things where having a generic routine and knowing
a bit about some implementation oddities migth well work out. Maybe some
other cards have the same odd behaviour.

But since Matrox has a separate recommended solution in their datasheets,
I suspect the right thing is just to ignore Matrox when talking about the 
generic thing.

		Linus
