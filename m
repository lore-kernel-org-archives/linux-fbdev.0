From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: EDID for radeonfb
Date: Thu, 21 Aug 2003 14:21:07 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030821212107.55742.qmail@web14915.mail.yahoo.com>
References: <1061500246.18043.15.camel@gaston>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from web14915.mail.yahoo.com ([216.136.225.228])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19pwrk-00083L-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 21 Aug 2003 14:21:08 -0700
In-Reply-To: <1061500246.18043.15.camel@gaston>
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
Content-Transfer-Encoding: 7bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: kronos@kronoz.cjb.net, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, James Simmons <jsimmons@infradead.org>

The list of modes supported by the board has to get worked into this too. Who
should do the diff'ing to determine valid modes? The list of legal monitor
modes might be from EDID or the fbmode database.

Should sysfs have one entry for legal board modes and one for legal monitor
modes? Or should it just have a single entry for legal combos?

--- Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> On Thu, 2003-08-21 at 22:51, Jon Smirl wrote:
> > Is GregKH designing the EDID thorough sysfs scheme? I haven't seen a
> proposal
> > on how it is going to work. We need to coordinate with that so that we
> don't
> > end up with a different EDID scheme for every card.
> 
> Imho, the fbdev should be a separate device from the monitor:
> 
> fbdev -> fbmon -> EDID
> 
> The EDID should be a property of the monitor
> 
> So fbdev should instanciate a monitor object for each head after
> detection. It's still unclear for me how to deal with the various
> types of monitors though
> 
>  - EDID available
>  - Mac old style "sense code" available
>  - fixed mode known based on motherboard (old mac laptops among others,
>    probably some embedded)
>  - unknown
> 
> The EDID shall be used to build a modedb of available modes for this
> display, the driver doing validation based on that, though a flag to
> set_var would still be useful to force a mode that doesn't pass
> validation (EDIDs can be wrong...)
> 
> 
> Ben.
> 


=====
Jon Smirl
jonsmirl@yahoo.com

__________________________________
Do you Yahoo!?
Yahoo! SiteBuilder - Free, easy-to-use web site design software
http://sitebuilder.yahoo.com


-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines
at the same time. Free trial click here:http://www.vmware.com/wl/offer/358/0
