From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: [Dri-devel] Re: [Linux-fbdev-devel] DRM and pci_driver conversion
Date: Thu, 23 Oct 2003 18:52:24 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <20031024015224.54982.qmail@web14905.mail.yahoo.com>
References: <3F987E18.9080606@pobox.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <3F987E18.9080606@pobox.com>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jeff Garzik <jgarzik@pobox.com>, Linus Torvalds <torvalds@osdl.org>
Cc: Jon Smirl <jonsmirl@yahoo.com>, Eric Anholt <eta@lclark.edu>, kronos@kronoz.cjb.net, Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-fbdev-devel@lists.sourceforge.net, dri-devel <dri-devel@lists.sourceforge.net>

Video drivers only enable the ROM long enough to get some values out it and
then disable it. You don't want to leave ROMs enabled because there is some
hardware that uses the same address decoder for ROM and RAM and you can't use
them both at the same time.

--- Jeff Garzik <jgarzik@pobox.com> wrote:
> Linus Torvalds wrote:
> > [ Jeff: is that PCI ROM enable _really_ that complicated? Ouch. Or is
> >   there some helper function I missed? ]
> 
> 
> The mechanics aren't complicated, but I seem to recall there being a 
> Real Good Reason why you want to leave it disabled 99% of the time.  No, 
> I don't recall that reason :(  But my fuzzy memory seems to think that 
> "enable, grab a slice o 'rom, disable" was viable.
> 
> 	Jeff
> 
> 
> 


=====
Jon Smirl
jonsmirl@yahoo.com

__________________________________
Do you Yahoo!?
The New Yahoo! Shopping - with improved product search
http://shopping.yahoo.com
