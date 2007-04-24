From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: Console unregistration questions
Date: Tue, 24 Apr 2007 16:46:34 -0700
Message-ID: <200704241646.34556.jbarnes@virtuousgeek.org>
References: <200704241459.29297.jbarnes@virtuousgeek.org>
	<1177456787.10465.29.camel@daplas> <1177458135.4829.5.camel@daplas>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HgUiX-0005W6-2C for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 24 Apr 2007 16:46:41 -0700
Received: from outbound-mail-24.bluehost.com ([69.89.21.19])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1HgUiV-0007Il-Oz
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 24 Apr 2007 16:46:41 -0700
In-Reply-To: <1177458135.4829.5.camel@daplas>
Content-Disposition: inline
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
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: Dave Airlie <airlied@linux.ie>, Jakob Bornecrantz <wallbraker@gmail.com>, linux-fbdev-devel@lists.sourceforge.net

On Tuesday, April 24, 2007, Antonino A. Daplas wrote:
> > >  Also, shouldn't callers of
> > > unregister_con_driver be checking return values?  That would have
> > > made this bug a lot easier to find at least. :)
>
> Replying to myself:
>
> At this point, if unregister_con_driver() fails, it is too late for
> fbcon, the best thing to do is issue a BUG().

I guess there's no way to propagate the error back to 
unregister_framebuffer?  If we did, then it could return -EBUSY or 
something, keeping the module loaded instead of unsafely allowing it to be 
removed...

> However, I'll add extra code to unregister_framebuffer() that will check
> if it's safe for the driver to unload.  The drivers may then choose to
> check it or not.

Sounds good.

Jesse

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
