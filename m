From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [git patches] two warning fixes
Date: Thu, 19 Jul 2007 12:05:34 +1000
Message-ID: <1184810734.25235.299.camel@localhost.localdomain>
References: <20070718235504.GA9601@havoc.gtf.org>
	<200707190159.22654.ak@suse.de> <469EAABD.4010504@garzik.org>
	<1184807945.25235.289.camel@localhost.localdomain>
	<20070718184101.1d31db9c.akpm@linux-foundation.org>
	<alpine.LFD.0.999.0707181848060.27353@woody.linux-foundation.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IBLOu-0006jV-R9 for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 18 Jul 2007 19:05:58 -0700
Received: from gate.crashing.org ([63.228.1.57]
	ident=[U2FsdGVkX18dLFNeUoqgtNBsFAO/Xb4BDkr0kVIwZ4A=])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IBLOu-0001IL-9b
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 18 Jul 2007 19:05:56 -0700
In-Reply-To: <alpine.LFD.0.999.0707181848060.27353@woody.linux-foundation.org>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fbdev-devel@lists.sourceforge.net, Jeff Garzik <jeff@garzik.org>, adaplas@gmail.com, Andi Kleen <ak@suse.de>, LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>

On Wed, 2007-07-18 at 18:50 -0700, Linus Torvalds wrote:
> > Now, we can talk about making those sysfs core functions generate warnings
> > themselves, and we can talk about generating new wrappers around them which
> > generate warnings and which return void, then migrating code over to use
> > those.
> 
> If the only valid reason to fail is a kernel bug, it damn well should be 
> that sysfs function itself that should complain. It's the only thing that 
> knows and cares.

That's pretty much what Paulus and I have been advocating all along.

There -might- be a couple of cases where something has a good reason to
do a call that may fail and want to test the result code. For those few
rare cases (though none comes to mind at the moment), then I suppose we
could provide some kind of _try version of the function (or whatever you
want to call it) that doesn't warn and just returns an error.

But as I said, I can't see any such case out of the blue.

Cheers,
Ben.



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
