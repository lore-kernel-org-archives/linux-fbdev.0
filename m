From: Antonino Daplas <adaplas@pol.net>
Subject: Re: [PATCH]: EDID parser
Date: 03 Apr 2003 08:45:10 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1049330578.1029.38.camel@localhost.localdomain>
References: <Pine.LNX.4.44.0304022245520.2488-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from pine.compass.com.ph ([202.70.96.37])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 190sxb-0008Bf-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 02 Apr 2003 16:52:07 -0800
In-Reply-To: <Pine.LNX.4.44.0304022245520.2488-100000@phoenix.infradead.org>
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
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Petr Vandrovec <vandrove@vc.cvut.cz>

On Thu, 2003-04-03 at 05:55, James Simmons wrote:
> 
> > James,
> > 
> > Here's a revised patch.  I was able to receive source code from SciTech
> > (c/o Kendall Bennett) which allowed me to fix bugs and complete the
> > parser.  It's probably around 90-95% complete in terms of basic parsing.
> > 
> > It also fixes memory leaks which was present in the old patch.
> 
> Let really good. I applied it to my local tree but haven't passed it to BK 
> fbdev yet. The only thing I like to see changed is get_EDID. At present it 
> accepts a struct pci_dev. Now for generic support for the intel platform 
> we can get this from the BIOS. You already have a patch that does this. 
> It doesn't need a struct pci_dev in this case. It is possible to get this 
> info from the i2c bus but I never seen any drivers do this. What data would
> we have to pass in get the EDID inforamtion? So the question is how 
> generic will get_EDID end up being or will we have to have driver specfic 
> hooks since I don't pitcure i2c approaches being the same for each video 
> card. Petr didn't you attempt this with the matrox driver at one time?
> 

I think we just need an additional method in struct fb_ops. Something like 
this:

unsigned char *fb_get_edid(struct fb_info *info)
{
	if (info->fbops->fb_get_edid)
		return info->fbops->fb_get_edid(info);
	else 
		return fallback_get_edid_method();
}

We can get the EDID by different methods:

1. User uploads EDID to kernel via an ioctl.  This is always preferred,
as it gives the user the power to override machine settings, or if there
is no other method to get the EDID.  We can also have a userland utility
that encodes user-specified monitor information and modelines into EDID
info (a reverse EDID parser).  For instance, selected entries in
/etc/fb.modes can be easily converted to EDID which the user can upload
to fbdev.

2. Gets it through device-specific hooks (i2c, whatever), if available. 
This is second choice, as it can get the EDID anytime.  This is useful
when a user decides to change monitors without rebooting, or if the
device is a non-primary display.

3.  Some architecture specific methods, such as doing it via the BIOS. 
This is the last choice, our fallback method. as this EDID may be static
and represents only the display detected at boot time.

For supplementary functions, we also need some kind of control that
allows the user to tell fbdev "I've switched monitors, please reread the
EDID". We want to avoid doing DDC each time fbdev does an fb_set_var(),
especially for DDC1 which can be very slow. 

Also, a way to download the EDID from kernel to userland.

Tony

  





-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
