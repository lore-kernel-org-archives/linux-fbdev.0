From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: syncing to mainline kernel
Date: Wed, 08 Oct 2003 20:53:59 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1065639239.6518.29.camel@gaston>
References: <Pine.LNX.4.44.0310081946520.24451-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A7JSo-0000jm-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 08 Oct 2003 11:55:10 -0700
Received: from pentafluge.infradead.org ([213.86.99.235])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.22)
	id 1A7JSn-0004vU-Ex
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 08 Oct 2003 11:55:09 -0700
In-Reply-To: <Pine.LNX.4.44.0310081946520.24451-100000@phoenix.infradead.org>
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
Cc: Louis Garcia <louisg00@bellsouth.net>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Wed, 2003-10-08 at 20:50, James Simmons wrote:
> > On Sun, 2003-10-05 at 11:13, Louis Garcia wrote:
> > > Any know when all this great new stuff is going to me merged with linus?
> > 
> > I've been waiting for this to happen for some time...
> 
> Very soon. I have new software cursor code that I'm debugging right now. 
> This is the only thing holding back the syning.

Great. Note that I may send my new radeonfb to linus directly (though
I'll CC you), same for other fbdev drivers I maintain. I think this
is the right thing to do for driver updates, the fbdev-* trees should
really be only for fbdev core changes imho...

Ben.




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
