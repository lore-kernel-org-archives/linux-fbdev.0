From: Otto Solares <solca@guug.org>
Subject: Re: [PATCH] neofb patches
Date: Wed, 28 Apr 2004 01:08:32 -0600
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040428070832.GA23411@guug.org>
References: <Pine.LNX.4.44.0404271938330.20536-100000@phoenix.infradead.org> <408EE34F.8080106@undead.cc> <1083107454.16544.42.camel@gaston> <20040428002037.GE22495@guug.org> <1083112565.20473.10.camel@gaston>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BIjB3-000196-A5
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 28 Apr 2004 00:08:17 -0700
Received: from guug.galileo.edu ([168.234.203.30] helo=guug.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BIjB2-0006gF-RI
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 28 Apr 2004 00:08:16 -0700
Content-Disposition: inline
In-Reply-To: <1083112565.20473.10.camel@gaston>
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
Content-Transfer-Encoding: 7bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Wed, Apr 28, 2004 at 10:36:06AM +1000, Benjamin Herrenschmidt wrote:
> On Wed, 2004-04-28 at 10:20, Otto Solares wrote:
> > On Wed, Apr 28, 2004 at 09:10:55AM +1000, Benjamin Herrenschmidt wrote:
> > > Jon Smirl has been working on embedded mesa & moving DRI outside of
> > > X. Unfortunately, last I heard, he was still on his trip of re-inventing
> > > everything including replacing the fbdev's with his own stuff instead
> > > of moving from what we have ...
> > 
> > Ooops! that will break my software that relies on fbdev and
> > mesa-solo!
> 
> Well, I'm sure there is some good in what he is doing too, I don't 
> have time to deal with that at the moment, it would be interesting
> to synchronise properly though.

Yea, I remember he was trying to solve the very same problems
I currently have now.  I like the fbdev abstraction but it has
too many limitations:

- Improper video mode handling.  Simply the device driver should
  hint about valid modes, EDID, etc.
- When an app crashes the layer is unable to recover it's
  previous state even when proper semantics exist (KD_TEXT/GRAPH),
  when the kernel closes the fbdev it must trigger a return to
  KD_TEXT if in KD_GRAPHICS and set the fix and var settings
  remembering that settings before leaving KD_TEXT.
- It should exist a field in the fixed info for the bus_id, so
  intelligent apps will realize which card is attached to a fbdev.
- Cards with various display ports must be handled by the layer,
  with a new API just to handle ports.
- It dangerously coexists currently with the DRM queues and
  SAREA areas.  Both must merge in fbdev.
- VCs mess.
- Wasted effort in accel engines handling is only useful to fbcon,
  nobody needs acceleration to drive a X x Y character matrix
  in fbcon.  The argument that hw without a framebuffer will
  exist and that's why the accel engine must be used is BS,
  the PC, the BIOS and the video framebuffers will never die,
  framebuffer exists in the best video cards money can buy
  today and it exists in planned cards from major manufacturers
  for tomorrow, probably the framebuffer can't be accessed when
  the accel engine is being used in forthcoming cards but that
  is completely a different story.

IMHO this must be addressed ASAP if we want to compete with
Longhorn and MacOSX.  People should realize that fbdev is a
linux standard that needs to be modernized and it must be fixed,
we should not devote more resources to implement complex accel
engines in the fbdev drivers, acceleration has it's place in
userspace layers like DirectFB or DRI (mesa-solo), not in the
kernel where a light, simple and elegant solution for graphics
should exists.

I now understand why Jon Smirl took that hard but neccesary
path.  Even if we start this for 2.7 it will be too late as
linux 2.8/3.0 will ship 2-3 years late.

C'mon James, Ben, Geert, driver writers, let's fix the layer!

-otto



-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE. 
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
