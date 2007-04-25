From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: Console unregistration questions
Date: Wed, 25 Apr 2007 08:04:24 +0800
Message-ID: <1177459464.4829.10.camel@daplas>
References: <200704241459.29297.jbarnes@virtuousgeek.org>
	<1177456787.10465.29.camel@daplas>
	<200704241642.39638.jbarnes@virtuousgeek.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HgUzr-0007LE-2d for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 24 Apr 2007 17:04:35 -0700
Received: from py-out-1112.google.com ([64.233.166.181])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HgUzq-0001T1-Kj
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 24 Apr 2007 17:04:34 -0700
Received: by py-out-1112.google.com with SMTP id a29so25875pyi
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Tue, 24 Apr 2007 17:04:33 -0700 (PDT)
In-Reply-To: <200704241642.39638.jbarnes@virtuousgeek.org>
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

On Tue, 2007-04-24 at 16:42 -0700, Jesse Barnes wrote:
> On Tuesday, April 24, 2007, Antonino A. Daplas wrote:
> > > But since we're using drmfb as a console, the unregister_framebuffer
> > > call silently fails.  fbcon is builtin to the kernel, so when drmfb
> > > exits, unregister_framebuffer will end up calling fbcon's
> > > fbcon_fb_unregistered() function via the notifier chain.  However,
> > > when fbcon_fb_unregistered calls unregister_con_driver(&fb_con) it
> > > ignores the return value, which is bad since unregister_con_driver
> > > left fbcon's routines active (due to fbcon still being bound to the
> > > console) even while unregister_framebuffer freed their underlying
> > > structures.
> >
> > Okay, we can do that. This was not done before because
> > unregister_framebuffer was only called on rmmod <module>.  But checking
> > for the return error and have it propagate to the driver should not be a
> > problem.
> >
> > I'll send a patch to you and to akpm soon.
> 
> Great!  Thanks.
> 
> > >   So when unregister_framebuffer returns, the
> > > very next console operation causes an oops or worse (I usually see
> > > hide_cursor->fbcon_cursor die when it tries to get at
> > > info->fbcon_par).
> > >
> > > However, it doesn't appear that there's a way for fb drivers to unbind
> > > themselves from the console at unload time, so we have to do it
> > > manually.
> >
> > You cannot unbind framebuffer drivers independently from the console
> > layer because the console is holding a reference count on them.
> >
> > FYI: this was what I did initially, but akpm objected :-).
> >
> > > Should there be a way to unbind it from driver code?  Maybe by
> > > exporting a wrapper to unbind_con_driver?
> >
> > Yes, you can expose unbind_con_driver(), I don't mind. You can do it
> > first in your tree, then when you need it for mainline, let me know.
> 
> So using unbind_con_driver is ok since we go through the console layer and 
> all the refcounting is kosher?

Yes.

>   The only other thing with 
> unbind_con_driver is I'm not sure about the other arguments (first, last, 
> & default) should be if called from a driver context.

No, they're only for the console.  So, if you're writing a pure fbdev
driver, then the user has to unbind the console from the VT layer
manually.  If you are writing an fbdev/console-combo driver, then you
can do that by calling unbind_con_driver() first before
unregister_framebuffer().

Tony


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
