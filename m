From: James Simmons <jsimmons@infradead.org>
Subject: Re: fbdev driver and sysfs question.
Date: Fri, 13 Feb 2004 18:44:49 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0402131839040.17669-100000@phoenix.infradead.org>
References: <20040211225724.GN21151@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AriKy-00007w-1g
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 13 Feb 2004 10:46:52 -0800
Received: from phoenix.infradead.org ([213.86.99.234])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1AriJ6-0005N6-9r
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 13 Feb 2004 10:44:56 -0800
In-Reply-To: <20040211225724.GN21151@parcelfarce.linux.theplanet.co.uk>
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
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> > +	if (!info->screen_base) {
> >  		release_mem_region(vesafb_fix.smem_start, vesafb_fix.smem_len);
> >  		printk(KERN_ERR
> >  		       "vesafb: abort, cannot ioremap video memory 0x%x @ 0x%lx\n",
> 
> 	Who will free info?
...
> 	Who will undo allocations?  BTW, that applies to the old code too -
> even if fb_alloc_cmap() doesn't require any actions on cleanup, ioremap()
> definitely does.

release_fb_info in fbsysfs.c. That happens in the struct class release 
function. Also the fb_dealloc_cmap is called. No ioremap is called tho 
since this is driver specific. So I have the ioremap and cleanup of it 
done in the dev.remove function. 

This makes sense since we could have one driver for the hardware with 
multiple framebuffers on board. One driver and two devices. 






-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
