From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Re: New radeonfb 0.2.0 (take 2)
Date: Tue, 09 Sep 2003 09:58:30 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1063094309.675.11.camel@gaston>
References: <20030909031908.58173.qmail@web14903.mail.yahoo.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19wdOp-0006Ri-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 09 Sep 2003 00:58:55 -0700
Received: from pentafluge.infradead.org ([213.86.99.235])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.22)
	id 19wdOo-0000B3-G7
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 09 Sep 2003 00:58:54 -0700
In-Reply-To: <20030909031908.58173.qmail@web14903.mail.yahoo.com>
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Kronos <kronos@kronoz.cjb.net>

On Tue, 2003-09-09 at 05:19, Jon Smirl wrote:
> Just a thought, but what do you think about splitting radeonfb into two peices?
> Sort of like the way this Rage128 driver is split, http://www.saftware.de/.
> 
> First piece does PCI IDs, EDID, mode setting, command parsing, maybe hardware
> cursor.
> Second does fbcon support such as mapping fb to kernel space, fb accels, etc.
> 
> My idea is that this model could evolve over time into having a base driver for
> each card, and then the FB or DRI drivers would plug into the base. This would
> provide a common place to put locking and state saving code.

Currently, I have split it in:

 - radeon_base : basic PCI registration, CRTC setting (CRTC1 only for now,
if/when I implement CRTC2, I'll move it to a spearate file), and all other
normal driver operations

 - radeon_i2c : the i2c interface low level & EDID DDC2 code

 - radeon_monitor : monitor probing logic & modedb building. This code probes
both heads, eventually uses the i2c code and/or BIOS/OF provided informations

 - radeon_pm : the power management code (mostly used on PowerBooks for now)

I suppose radeon_base could be further split, though you may now that there
is no longer any dependency on fbcon in the fbdev driver per se, most of this
have been removed from 2.6 drivers, so there isn't much point in splitting
the fbcon related part outside of the driver...

What I want to do though is, if/when I add accel back, a separate radeon_accel
file with the accelerated primitives.

Ben.



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
