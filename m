From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Re: fbdev cursor part 1.
Date: Mon, 23 Feb 2004 21:59:19 +1100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1077533958.5942.42.camel@gaston>
References: <Pine.LNX.4.44.0402222234120.2390-100000@phoenix.infradead.org>
	 <1077496550.5960.9.camel@gaston>
	 <Pine.GSO.4.58.0402231156040.14277@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AvE2s-00079O-AZ
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 23 Feb 2004 03:14:42 -0800
Received: from gate.crashing.org ([63.228.1.57] ident=root)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30)
	id 1AvDk5-0005VG-0H
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 23 Feb 2004 02:55:17 -0800
In-Reply-To: <Pine.GSO.4.58.0402231156040.14277@waterleaf.sonytel.be>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: James Simmons <jsimmons@infradead.org>, Alexander Kern <alex.kern@gmx.de>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> IIRC, there's a big difference between the number of commands you can queue up
> in the RAGE PRO and earlier chip. Perhaps the queue check always assumes a RAGE
> PRO?
> 
> Hope this helps... (No, I didn't look at the code)

The queue check looks for how many entries are free in the queue
by reading the appropriate register in the chip, I should double
check the specs to see if that's done correctly though (or compare
with X, though I do see some artifacts in X here or there, small
but small drawing errors that let me think that X driver isn't
perfect neither. At least it doesn't lockup).

Here's the code in atyfb:

static inline void wait_for_fifo(u16 entries, const struct atyfb_par *par)
{
	while ((aty_ld_le32(FIFO_STAT, par) & 0xffff) >
	       ((u32) (0x8000 >> entries)));
}

Ben.




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
