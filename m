From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Subject: Re: [PATCH] neofb patches
Date: Thu, 29 Apr 2004 00:26:41 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1083191201.18413.73.camel@thor.asgaard.local>
References: <Pine.LNX.4.44.0404271938330.20536-100000@phoenix.infradead.org>
	 <408EE34F.8080106@undead.cc> <1083107454.16544.42.camel@gaston>
	 <20040428002037.GE22495@guug.org> <1083112565.20473.10.camel@gaston>
	 <20040428070832.GA23411@guug.org>
	 <1083147416.18416.24.camel@thor.asgaard.local>
	 <20040428163730.GA24448@guug.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BIxVu-00079e-Qi
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 28 Apr 2004 15:26:46 -0700
Received: from netline-mail1.netline.ch ([195.141.226.27])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1BIxVu-0008LE-6N
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 28 Apr 2004 15:26:46 -0700
In-Reply-To: <20040428163730.GA24448@guug.org>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="utf-8"
To: Otto Solares <solca@guug.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Wed, 2004-04-28 at 18:37, Otto Solares wrote:
> On Wed, Apr 28, 2004 at 12:16:56PM +0200, Michel Dänzer wrote:
> > On Wed, 2004-04-28 at 09:08, Otto Solares wrote:
> > > 
> > > I like the fbdev abstraction but it has too many limitations:
> > 
> > [...]
> > 
> > > - It dangerously coexists currently with the DRM queues and
> > >   SAREA areas.  
> > 
> > How does a DRM SAREA matter to a framebuffer device?
> 
> It matters as long as the SAREA have a hardware lock
> to synchronize access to the hardware.  That lock must
> be owned by a single entity in the kernel, or at least
> the fbdev drivers must be aware of that lock, 

Why? The purpose of the DRM lock is arbitration and state management
between DRM clients. It's not necessarily connected to direct hardware
access.

> it would be more simple if the fbdev drivers take care of it being
> the single entity in the kernel taking care of the hardware.

Jon Smirl thinks it should be the DRM...

> > > Both must merge in fbdev.
> > 
> > I agree that they should cooperate properly, but I don't see how it
> > follows that they must merge.
> 
> DRM and fbdev must merge so i repeat: just a single
> kernel entity should own FIFO queues, shared locks,
> DMA, the framebuffer, IO registers, interrupts, etc.

A small low-level driver could handle this, which both the framebuffer
device and the DRM use. Linus has proposed this approach, and I must say
I like it.


-- 
Earthling Michel Dänzer      |     Debian (powerpc), X and DRI developer
Libre software enthusiast    |   http://svcs.affero.net/rm.php?r=daenzer



-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE. 
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
