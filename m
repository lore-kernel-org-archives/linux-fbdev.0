From: James Simmons <jsimmons@infradead.org>
Subject: Re: Re: [PATCH] kyrofb support
Date: Thu, 15 Jan 2004 00:34:08 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0401150033430.335-100000@phoenix.infradead.org>
References: <Pine.GSO.4.58.0401141345100.9503@waterleaf.sonytel.be>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AgvSg-00008R-7E
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 14 Jan 2004 16:34:14 -0800
Received: from phoenix.infradead.org ([213.86.99.234])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1AgvSf-0004mD-QC
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 14 Jan 2004 16:34:14 -0800
In-Reply-To: <Pine.GSO.4.58.0401141345100.9503@waterleaf.sonytel.be>
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
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Paul Mundt <lethal@linux-sh.org>, Andrew Morton <akpm@osdl.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>


> On Tue, 13 Jan 2004, Paul Mundt wrote:
> > On Tue, Jan 13, 2004 at 06:09:26PM -0800, Andrew Morton wrote:
> > > In general, what are the fbdev drivers doing here btw?  It's very strange
> > > that some core file (fbmem.c) has to "know" about individual card drivers.
> > > It should be sufficient for the driver to just register itself with the core
> > > at the drivers's module_init() time.
> > >
> > This is done for device ordering as far as I recall. Devices listed first on
> > the command line are numbered first, with the rest coming up in the order that
> > they're listed in fb_drivers[].
> 
> Indeed. It's there so people can choose which is their primary display, if they
> have multiple cards.

Also cards that lack proper resource management can be initalized last.




-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
