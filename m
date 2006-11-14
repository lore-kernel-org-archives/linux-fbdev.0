From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [Linux-fbdev-devel] Fwd: [Suspend-devel] resume not working on acer ferrari 4005 with radeonfb enabled
Date: Tue, 14 Nov 2006 23:57:59 +0100
Message-ID: <200611142358.00616.rjw@sisk.pl>
References: <D0233BCDB5857443B48E64A79E24B8CE6B544C@labex2.corp.trema.com> <200611142247.55137.chrmhoffmann@gmail.com> <20061114225629.GA2676@elf.ucw.cz>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S966443AbWKNXAy@vger.kernel.org>
In-Reply-To: <20061114225629.GA2676@elf.ucw.cz>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: Pavel Machek <pavel@ucw.cz>
Cc: Christian Hoffmann <chrmhoffmann@gmail.com>, linux-fbdev-devel@lists.sourceforge.net, Christian Hoffmann <Christian.Hoffmann@wallstreetsystems.com>, Andrew Morton <akpm@osdl.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, LKML <linux-kernel@vger.kernel.org>, Solomon Peachy <pizza@shaftnet.org>

On Tuesday, 14 November 2006 23:56, Pavel Machek wrote:
> Hi!
> 
> > > > I tried netconsole, and it somehow works, but when suspending it says in
> > > > an "infinite" loop:
> > > >
> > > > unregister_netdevice: waiting for eth2 to become free. Usage count = 1
> > >
> > > Hm.  Is your kernel compiled with CONFIG_DISABLE_CONSOLE_SUSPEND set?
> > >
> > > Rafael
> > 
> > I tried that patch, but the last message I see over netconsole (using tg3) is:
> > Suspending console(s)
> > and then nothing. Nothing on resume at all :(
> > 
> > Adding some printks in the radeonfb_pci_suspend and radeonfb_pci_resume 
> > (radeon_pm.c) didn't help: I don't see them. But I am not a kernel programmer 
> > at all, so I might do something wrong or in the wrong place.
> 
> Linus has crazy "write some info to CMOS" hack... which should be
> usable here.

No, it's i386-only.

Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
