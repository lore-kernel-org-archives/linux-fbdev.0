From: "Robert T. Johnson" <rtjohnso@eecs.berkeley.edu>
Subject: Re: PATCH: 2.6.7-rc3 drivers/video/fbmem.c: user/kernel pointer bugs
Date: 09 Jun 2004 22:00:56 -0700
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1086843656.32057.390.camel@dooby.cs.berkeley.edu>
References: <1086821199.32054.111.camel@dooby.cs.berkeley.edu>
	<20040610012441.GY12308@parcelfarce.linux.theplanet.co.uk>
	<1086839438.14179.340.camel@dooby.cs.berkeley.edu> 
	<20040610041529.GD12308@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BYHgR-0001HP-E0
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 09 Jun 2004 22:00:59 -0700
Received: from relay2.eecs.berkeley.edu ([169.229.60.28])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1BYHgR-0005ML-3v
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 09 Jun 2004 22:00:59 -0700
Received: from relay3.EECS.Berkeley.EDU (localhost [127.0.0.1])
	by relay2.EECS.Berkeley.EDU (8.12.10/8.9.3) with ESMTP id i5A50uGt005635
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 9 Jun 2004 22:00:56 -0700 (PDT)
In-Reply-To: <20040610041529.GD12308@parcelfarce.linux.theplanet.co.uk>
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
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: linux-fbdev-devel@lists.sourceforge.net, Linux Kernel <linux-kernel@vger.kernel.org>

On Wed, 2004-06-09 at 21:15, viro@parcelfarce.linux.theplanet.co.uk
wrote:
> On Wed, Jun 09, 2004 at 08:50:33PM -0700, Robert T. Johnson wrote:
> > static int pty_write(struct tty_struct * tty, int from_user,
> > 		       const unsigned char __user   *ubuf, 
> >                        const unsigned char __kernel *kbuf,
> >                        int count)
> 
> So I suspect that it in the long run the proper fix will be to sanitize
> the locking and move all copy_from_user() to the (only) caller.

I agree this is the ideal fix.  I can see advantages and disadvantages
to all the approaches.  I'm not familiar with the locking issues, so I
can't comment on that.

> > I fear that completely separating ioctl and kernel data structures would
> > result in lots of redundant structure definitions, which will lead to
> > code maintainence problems and their own host of bugs.  Would it be
> > better to just design a bug finding tool that's capable of keeping track
> > of different structure instances separately?
> 
> I doubt it.  Most of the ioctl data structures do not survive past the
> decoding; fb layer is ugly that way, but that's a local problem and it
> can be fixed.
> 
> Keep in mind that anything containing userland pointers needs to be explicitly
> dealt with on 32/64 platforms - otherwise 32bit code won't be able to issue
> that ioctl anyway.
> 
> 	Besides, kernel data structures should not be tied by ABI stability
> requirements - and ioctl arguments have to.  Which leads to far worse bug
> potential than explict decoding.

These are design issues outside the scope of what I'm doing, but they
are important.  I'll try to keep these considerations in mind as I
continue to improve cqual.  Thanks for the helpful feedback.

Best,
Rob




-------------------------------------------------------
This SF.Net email is sponsored by: GNOME Foundation
Hackers Unite!  GUADEC: The world's #1 Open Source Desktop Event.
GNOME Users and Developers European Conference, 28-30th June in Norway
http://2004/guadec.org
