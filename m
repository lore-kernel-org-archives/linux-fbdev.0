From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: EDID for radeonfb
Date: 21 Aug 2003 22:45:11 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1061498711.18043.10.camel@gaston>
References: <20030821203931.55804.qmail@web14910.mail.yahoo.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from amarseille-201-1-4-31.w217-128.abo.wanadoo.fr ([217.128.74.31] helo=gaston)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19pwfe-0004zB-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 21 Aug 2003 14:08:39 -0700
In-Reply-To: <20030821203931.55804.qmail@web14910.mail.yahoo.com>
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
Cc: kronos@kronoz.cjb.net, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, James Simmons <jsimmons@infradead.org>

On Thu, 2003-08-21 at 22:39, Jon Smirl wrote:
> The EDID code will allow the driver to ignore the BIOS copy in low RAM and use
> the ROM instead. Ben, could you make sure that the code to enable/access the
> ROM works on your Macs since I don't own one? Did you finish merging what was
> left of the Rage/Radeon PCI IDs from my patch?

The "Mac" cards don't have an x86 BIOS in ROM, they have an Open
Firmware instead, we need to fix proper detection of that, but that's
something I can try to do. I didn't finish merging it yet, I've been
quite busy with other drivers this week, radeonfb is on my todolist
for this week-end.

> EDID plus ROM will solve both problems: multiple adpaters and Mac portables
> needing EDID.

Yup (Note: the need for EDID in low RAM happened with x86 configs, on Macs,
I get it via the Open Firmware device tree).

Ben.




-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines
at the same time. Free trial click here:http://www.vmware.com/wl/offer/358/0
