From: James Simmons <jsimmons@infradead.org>
Subject: Re: fbdev upstream
Date: Fri, 9 Jan 2004 20:05:11 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0401092004390.27985-100000@phoenix.infradead.org>
References: <Pine.GSO.4.58.0401061107350.5485@waterleaf.sonytel.be>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1Af2sd-0005bd-Tk
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 09 Jan 2004 12:05:15 -0800
Received: from phoenix.infradead.org ([213.86.99.234])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1Af2sd-00009f-9b
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 09 Jan 2004 12:05:15 -0800
In-Reply-To: <Pine.GSO.4.58.0401061107350.5485@waterleaf.sonytel.be>
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
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, John Zielinski <grim@undead.cc>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> > > Fixed screen size drivers should provide there own modedb.
> >
> > Or just single mode... currently drivers don't export a modedb, they
> > keep one internally and do the validation... though it would make sense
> > to expose a modedb to userland, so we can have some nice GUI tools
> > showing you the available modes :) It would make sense for MacOnLinux
> > too which currently rely on the user to setup the list of modes
> > available to MacOS.
> 
> And how to export it? Sysfs again, I guess...

Yeap. I have been looking at sysfs. Very nice. I have lots of ideas but 
that will be for later.




-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
