From: Antonino Daplas <adaplas@pol.net>
Subject: Re: fb and multiple adapters
Date: 03 Jan 2003 18:22:01 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1041589354.992.3.camel@localhost.localdomain>
References: <20021228003919.27894.qmail@web14910.mail.yahoo.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from panoramix.vasoftware.com ([198.186.202.147] ident=mail)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 18UQar-0006de-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 03 Jan 2003 04:06:29 -0800
Received: from willow.compass.com.ph ([202.70.96.38]:4787)
	by panoramix.vasoftware.com with esmtp (Exim 4.05-VA-mm1 #1 (Debian))
	id 18UQao-0004DK-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 03 Jan 2003 04:06:26 -0800
In-Reply-To: <20021228003919.27894.qmail@web14910.mail.yahoo.com>
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Sat, 2002-12-28 at 08:39, Jon Smirl wrote:
> I'm looking into running framebuffers on multiple
> video adapters. My current setup has an ATI AGP Radeon
> 9000 as the primary adapter and a ATI PCI Rage128 as
> the secondary. 
> 
> The Rage128 driver won't load in this config. So the
> first thing I did was to add my board's id to it, PD.
> Now I'm at the point where the expansion ROM isn't
> enabled and the adapter isn't initialized.
> 
> Should I add code to aty128fb to enable the ROM and
> execute the initialization code (like X does)? What
> the overall policy towards framebuffers initializing
> secondary adapters? 
> 

No policy really.  However, doing that will involve setting up a "real
mode" (bit 16) environment to intercept BIOS int10 calls which are
necessary to initialize the graphics ROM.

If I need too, I usually do this the hard way, I let X initialize the
secondary card, exit X, then load the framebuffer driver module.

Tony




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
