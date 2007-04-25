From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: Console unregistration questions
Date: Wed, 25 Apr 2007 08:07:11 +0800
Message-ID: <1177459631.4829.14.camel@daplas>
References: <200704241459.29297.jbarnes@virtuousgeek.org>
	<1177456787.10465.29.camel@daplas> <1177458135.4829.5.camel@daplas>
	<200704241646.34556.jbarnes@virtuousgeek.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HgV2U-0007dZ-8x for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 24 Apr 2007 17:07:18 -0700
Received: from py-out-1112.google.com ([64.233.166.180])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HgV2T-00026U-UY
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 24 Apr 2007 17:07:18 -0700
Received: by py-out-1112.google.com with SMTP id a29so26422pyi
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Tue, 24 Apr 2007 17:07:17 -0700 (PDT)
In-Reply-To: <200704241646.34556.jbarnes@virtuousgeek.org>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Dave Airlie <airlied@linux.ie>, Jakob Bornecrantz <wallbraker@gmail.com>, linux-fbdev-devel@lists.sourceforge.net

On Tue, 2007-04-24 at 16:46 -0700, Jesse Barnes wrote:
> On Tuesday, April 24, 2007, Antonino A. Daplas wrote:
> > > >  Also, shouldn't callers of
> > > > unregister_con_driver be checking return values?  That would have
> > > > made this bug a lot easier to find at least. :)
> >
> > Replying to myself:
> >
> > At this point, if unregister_con_driver() fails, it is too late for
> > fbcon, the best thing to do is issue a BUG().
> 
> I guess there's no way to propagate the error back to 
> unregister_framebuffer?  If we did, then it could return -EBUSY or 
> something, keeping the module loaded instead of unsafely allowing it to be 
> removed...

We can, by doing the method mentioned below.  By the time fbcon is
notified of the unregistration, it's too late and the error is
unrecoverable.

> 
> > However, I'll add extra code to unregister_framebuffer() that will check
> > if it's safe for the driver to unload.  The drivers may then choose to
> > check it or not.

Yes, this should not be too hard to implement.

Tony



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
