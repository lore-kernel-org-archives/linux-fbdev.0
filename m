From: James Simmons <jsimmons@infradead.org>
Subject: Re: Patch for review and testing
Date: Tue, 27 Jan 2004 22:09:32 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0401272159590.19265-100000@phoenix.infradead.org>
References: <1075239579.6296.211.camel@gaston>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AlbOw-0000fd-Kz
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 27 Jan 2004 14:09:42 -0800
Received: from phoenix.infradead.org ([213.86.99.234])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1AlbOw-0002jC-3v
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 27 Jan 2004 14:09:42 -0800
In-Reply-To: <1075239579.6296.211.camel@gaston>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Andrew Morton <akpm@osdl.org>


> > I like to submit this patch to linus today. Could you test it to see if it 
> > works on ppcs. 
> 
> Well... you didn't update the drivers calling get_EDID_from_OF (I think
> only rivafb at this point). 

The patch is against the vanilla tree. In the fbdev-2.5 tree I have to 
update rivafb for this. Actually I will remove that code from rivafb. 

> Also, I plan to deprecate that function in
> fbmon anyway, so don't bother, leave it alone for now. The way the
> display/EDID infos are laid out in the OF device tree isn't that
> generic and I'm considering letting each driver has its own version...

Then I will remove it.

> Also, that construct is plain wrong:
> 
> char *get_EDID_from_Firmware(struct device *dev)
> {
>         .../...
> 	pdev = to_pci_dev(dev);
> 
> Either pass a pci_dev in, or if not, at least check that you are
> dealing with a pci device before casting struct device...

That was to make the function generic. Well it doesn't matter as I'm going 
to remove the OF function so the pci stuff can go away.

> Finally, I don't see the point of submiting things to Linus at this
> point, especially this patch which isn't critical (and you didn't even
> submit driver changes for _using_ the new feature). 

Actually it is. The BIOS calls can hang some intel machines or make 
booting  up to 5 seconds longer waiting for the data. If this was not the 
case I wouldn't be submitting it.

> Andrew is the
> maintainer of current 2.6.x stable, patches have to go to him first,
> stage in -mm for a while to be tested, and then go to Linus.

This is just making the code conditional.  I will send another patch in a 
minute then.




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
