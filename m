From: Otto Solares <solca@guug.org>
Subject: Re: syncing to mainline kernel
Date: Wed, 8 Oct 2003 18:41:46 -0600
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20031009004146.GC31602@guug.org>
References: <Pine.LNX.4.44.0310081946520.24451-100000@phoenix.infradead.org> <1065639239.6518.29.camel@gaston>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A7OtZ-0008Q7-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 08 Oct 2003 17:43:09 -0700
Received: from guug.galileo.edu ([168.234.203.30])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 1A7OtY-0007Pm-Rk
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 08 Oct 2003 17:43:08 -0700
Content-Disposition: inline
In-Reply-To: <1065639239.6518.29.camel@gaston>
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
Cc: James Simmons <jsimmons@infradead.org>, Louis Garcia <louisg00@bellsouth.net>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Wed, Oct 08, 2003 at 08:53:59PM +0200, Benjamin Herrenschmidt wrote:
> On Wed, 2003-10-08 at 20:50, James Simmons wrote:
> > > On Sun, 2003-10-05 at 11:13, Louis Garcia wrote:
> > > > Any know when all this great new stuff is going to me merged with linus?
> > > 
> > > I've been waiting for this to happen for some time...
> > 
> > Very soon. I have new software cursor code that I'm debugging right now. 
> > This is the only thing holding back the syning.
> 
> Great. Note that I may send my new radeonfb to linus directly (though
> I'll CC you), same for other fbdev drivers I maintain. I think this
> is the right thing to do for driver updates, the fbdev-* trees should
> really be only for fbdev core changes imho...

Ben, i have problems with your new radeonfb driver, apart that i have
to update the pci_ids.h and r200.c in both stock 2.6 and your bk tree
to make work my radeon 9200 (rv280 Ya), in your new driver, spaces
becomes '_', and after a while all characteres get messy.  My normal
setup is 1024x768-32@75 but with your driver the only reliable mode is
640x480-8@60.  Any idea?

-solca



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
