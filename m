From: Antonino Daplas <adaplas@pol.net>
Subject: Re: Reading the EDID block for x86 machines
Date: 12 Mar 2003 07:02:37 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1047423718.1128.160.camel@localhost.localdomain>
References: <20030311225407.15850.qmail@web14905.mail.yahoo.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from pine.compass.com.ph ([202.70.96.37])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18ssoT-0004ja-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 11 Mar 2003 15:05:37 -0800
In-Reply-To: <20030311225407.15850.qmail@web14905.mail.yahoo.com>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Jon Smirl <jonsmirl@yahoo.com>
Cc: James Simmons <jsimmons@infradead.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Wed, 2003-03-12 at 06:54, Jon Smirl wrote:
> --- Antonino Daplas <adaplas@pol.net> wrote:
> > On Wed, 2003-03-12 at 06:05, Jon Smirl wrote:
> > > If your in messing with the early boot sequence,
> > why
> > > don't you make the kernel initialize all of the
> > video
> > > cards in the system instead of only the primary
> > one.
> > 
> > Because I don't know how to :)?  It basically just
> > involves a far call
> > no, if we know where the VBIOS code actually starts?
> 
> It is more complicated. You need to call the PCI Bios
> to find the video cards by their PCI class. There is
> already code in the kernel that calls PCIBios.
> arch/i386/pci/*
> 
> Then you need to one by one map their ROMs (via PCI
> config registers) into C000:0 and call C000:3. But as
> you swap out the other adapters you need to disable
> their VGA emulation as there can only be on VGA device
> per system.  By default the VBIOS code will enable VGA
> emulation on all of the adapters and they won't. You
> also need to record the INT vectors and make sure they
> get set back to the primary ones.
> 

Yikes!  No, it can't be done this way.  During the early boot sequence,
the kernel is not yet decompressed and loaded, so all the services the
kernel provides are still unavailable.  Unless you want to walk, detect,
enable, etc the PCI subsystem in pure 16-bit assembly...

Tony



-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
