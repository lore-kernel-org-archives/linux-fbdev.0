From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Re: Usage of readb() and friends...
Date: Wed, 03 Mar 2004 10:49:28 +1100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1078271367.21573.212.camel@gaston>
References: <Pine.LNX.4.44.0403022334560.19874-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AyK1O-0002O9-TL
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 02 Mar 2004 16:13:58 -0800
Received: from gate.crashing.org ([63.228.1.57] ident=root)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30)
	id 1AyJWO-0002Ql-E8
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 02 Mar 2004 15:41:56 -0800
In-Reply-To: <Pine.LNX.4.44.0403022334560.19874-100000@phoenix.infradead.org>
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
To: James Simmons <jsimmons@infradead.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Kars de Jong <jongk@linux-m68k.org>, Richard Zidlicky <rz@linux-m68k.org>, Russell King <rmk@arm.linux.org.uk>, Linux/m68k kernel mailing list <linux-m68k@lists.linux-m68k.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

>  the code with imageblit calls. The new fb_write 
> code for some reson tho scrambles the console screen and then scrolls the 
> screen below where I'm writing. I haven't figured out way yet.

BTW. Have had a chance to look into those memory corruption issues
I told you about ? I've been rather busy lately...

Ben.





-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
