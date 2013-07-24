From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 24 Jul 2013 18:32:03 +0000
Subject: Re: [PATCH 01/15] drivers: phy: add generic PHY framework
Message-Id: <201307242032.03597.arnd@arndb.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <Pine.LNX.4.44L0.1307231708020.1304-100000@iolanthe.rowland.org>
 <5977067.8rykRgjgre@flatron>
In-Reply-To: <5977067.8rykRgjgre@flatron>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tuesday 23 July 2013, Tomasz Figa wrote:
> On Tuesday 23 of July 2013 17:14:20 Alan Stern wrote:
> > On Tue, 23 Jul 2013, Tomasz Figa wrote:
> > > Where would you want to have those phy_address arrays stored? There
> > > are no board files when booting with DT. Not even saying that you
> > > don't need to use any hacky schemes like this when you have DT that
> > > nicely specifies relations between devices.
> > 
> > If everybody agrees DT has a nice scheme for specifying relations
> > between devices, why not use that same scheme in the PHY core?
> 
> It is already used, for cases when consumer device has a DT node attached. 
> In non-DT case this kind lookup translates loosely to something that is 
> being done in regulator framework - you can't bind devices by pointers, 
> because you don't have those pointers, so you need to use device names.
> 

Sorry for jumping in to the middle of the discussion, but why does a *new*
framework even bother defining an interface for board files?

Can't we just drop any interfaces for platform data passing in the phy
framework and put the burden of adding those to anyone who actually needs
them? All the platforms we are concerned with here (exynos and omap,
plus new platforms) can be booted using DT anyway.

	Arnd
