From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [git patches] two warning fixes
Date: Wed, 18 Jul 2007 19:36:30 -0700
Message-ID: <20070718193630.d57affb0.akpm@linux-foundation.org>
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
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IBLsl-0001Ll-MR for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 18 Jul 2007 19:36:47 -0700
Received: from smtp2.linux-foundation.org ([207.189.120.14])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IBLsk-0003OH-Dn
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 18 Jul 2007 19:36:47 -0700
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
Cc: linux-fbdev-devel@lists.sourceforge.net, Jeff Garzik <jeff@garzik.org>, adaplas@gmail.com, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Andi Kleen <ak@suse.de>, LKML <linux-kernel@vger.kernel.org>

On Wed, 18 Jul 2007 18:50:28 -0700 (PDT) Linus Torvalds <torvalds@linux-foundation.org> wrote:

> So yes, I think we should ignore return values when they have absolutely 
> zero interest level to us.

Look at the reason why the sysfs must_check's were adding in the first
place.

We had a long string of mysterious crashes coming out of the
sysfs/driver/bus/kobject code which appeared to be due to corrupted data
structures and which were believed to be caused by incorrect callers but we
didn't have any idea _which_ callers were incorrect because the crashes
happened long after the error had occurred.

On examination we saw that a very large amount of the driver core was
_internally_ failing to check callee return values and was just proceeding
as if things had succeeded.  Also, many (most) external callers were
failing to check or report upon callee failures as well.

So we were basically left blind without any way to identify where the bugs
were.  We ended up tightening up all of the driver core (largely guided by
the must_check warnings which it emitted) and many callers were fixed as
well.

Now, it could be that we should have (or can now) relax the requirements
upon the callers, but we should still still be told when something has
unexpectedly failed.  Maybe not as a general rule - more of a special-case
for these interfaces because we have such a long history of failures in
there and because of how the lack of error checking caused those failures
to be so hard to fix.

Which is why I proposed new void-returning wrappers which will warn for the
caller when something failed.  If we were to remove the __must_checks then
we'd lose much of our checking ability within the sysfs/driver core, as
well as from callers.

This stuff has got better, and hopefully Tejun's work will make it better
still.  But I don't think it is exactly bulletproof yet.


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
