From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: EDID for radeonfb
Date: 21 Aug 2003 23:10:46 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1061500246.18043.15.camel@gaston>
References: <20030821205110.89821.qmail@web14912.mail.yahoo.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from amarseille-201-1-4-31.w217-128.abo.wanadoo.fr ([217.128.74.31] helo=gaston)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19q64l-0001dD-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 22 Aug 2003 00:11:12 -0700
In-Reply-To: <20030821205110.89821.qmail@web14912.mail.yahoo.com>
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

On Thu, 2003-08-21 at 22:51, Jon Smirl wrote:
> Is GregKH designing the EDID thorough sysfs scheme? I haven't seen a proposal
> on how it is going to work. We need to coordinate with that so that we don't
> end up with a different EDID scheme for every card.

Imho, the fbdev should be a separate device from the monitor:

fbdev -> fbmon -> EDID

The EDID should be a property of the monitor

So fbdev should instanciate a monitor object for each head after
detection. It's still unclear for me how to deal with the various
types of monitors though

 - EDID available
 - Mac old style "sense code" available
 - fixed mode known based on motherboard (old mac laptops among others,
   probably some embedded)
 - unknown

The EDID shall be used to build a modedb of available modes for this
display, the driver doing validation based on that, though a flag to
set_var would still be useful to force a mode that doesn't pass
validation (EDIDs can be wrong...)


Ben.



-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines
at the same time. Free trial click here:http://www.vmware.com/wl/offer/358/0
