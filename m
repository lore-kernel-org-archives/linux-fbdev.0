From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: EDID for radeonfb
Date: Thu, 21 Aug 2003 13:51:10 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030821205110.89821.qmail@web14912.mail.yahoo.com>
References: <1061498711.18043.10.camel@gaston>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from web14912.mail.yahoo.com ([216.136.225.248])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19pwOl-0007yF-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 21 Aug 2003 13:51:11 -0700
In-Reply-To: <1061498711.18043.10.camel@gaston>
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

Is GregKH designing the EDID thorough sysfs scheme? I haven't seen a proposal
on how it is going to work. We need to coordinate with that so that we don't
end up with a different EDID scheme for every card.

--- Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> On Thu, 2003-08-21 at 22:39, Jon Smirl wrote:
> > The EDID code will allow the driver to ignore the BIOS copy in low RAM and
> use
> > the ROM instead. Ben, could you make sure that the code to enable/access
> the
> > ROM works on your Macs since I don't own one? Did you finish merging what
> was
> > left of the Rage/Radeon PCI IDs from my patch?
> 
> The "Mac" cards don't have an x86 BIOS in ROM, they have an Open
> Firmware instead, we need to fix proper detection of that, but that's
> something I can try to do. I didn't finish merging it yet, I've been
> quite busy with other drivers this week, radeonfb is on my todolist
> for this week-end.
> 
> > EDID plus ROM will solve both problems: multiple adpaters and Mac portables
> > needing EDID.
> 
> Yup (Note: the need for EDID in low RAM happened with x86 configs, on Macs,
> I get it via the Open Firmware device tree).
> 
> Ben.
> 
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
