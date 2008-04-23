From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 1/3] radeonfb: Fix 64 bits resources
 on 32 bits archs
Date: Wed, 23 Apr 2008 02:57:21 -0700 (PDT)
Message-ID: <20080423.025721.50367920.davem@davemloft.net>
References: <480E0A54.9010203@linux.vnet.ibm.com>
	<1208902903.9640.138.camel@pasglop>
	<1208943127.5632.324.camel@thor.sulgenrain.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Jobj6-0005RQ-Vi for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 23 Apr 2008 02:57:21 -0700
Received: from [74.93.104.97] (helo=sunset.davemloft.net)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Jobj6-00085W-Pm
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 23 Apr 2008 02:57:20 -0700
In-Reply-To: <1208943127.5632.324.camel@thor.sulgenrain.local>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: michel@tungstengraphics.com
Cc: linux-fbdev-devel@lists.sourceforge.net, hollisb@us.ibm.com, adaplas@gmail.com, benh@kernel.crashing.org, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, akpm@linux-foundation.org, dzu@denx.de

From: Michel D=E4nzer <michel@tungstengraphics.com>
Date: Wed, 23 Apr 2008 11:32:07 +0200

> On Wed, 2008-04-23 at 08:21 +1000, Benjamin Herrenschmidt wrote:
> > On Tue, 2008-04-22 at 17:55 +0200, Christian Ehrhardt wrote:
> > > I wanted to ask if there are any known workarounds atm that would
> > > allow me to use my X11 for now?
> > =

> > X is doing a mmap of /dev/mem instead of /dev/fb ?
> > =

> > You can normally map the fb mapping /dev/fb and then map the registers
> > using /dev/fb at an offset beyond the framebuffer (fix->smem_len).
> > =

> > If X is using /dev/mem instead, then it's being stupid and needs to be
> > fixed...
> =

> It's up to the driver, and again, the current radeon driver doesn't use
> radeonfb at all anymore...

The only portable thing is for X to use the PCI sysfs mmap() stuff,
which current Xorg servers using libpciaccess do.

I know because I'm typing this from a sparc64 using a Radeon
with current Xorg :-)

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference =

Don't miss this year's exciting event. There's still time to save $100. =

Use priority code J8TL2D2. =

http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/java=
one
