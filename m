From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: Console unregistration questions
Date: Sat, 28 Apr 2007 00:10:48 +0800
Message-ID: <1177690248.4675.2.camel@daplas>
References: <200704241459.29297.jbarnes@virtuousgeek.org>
	<200704261830.22238.jbarnes@virtuousgeek.org>
	<1177654236.4683.27.camel@daplas>
	<200704270814.48865.jbarnes@virtuousgeek.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HhT27-0001Zs-M8 for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 27 Apr 2007 09:10:55 -0700
Received: from wx-out-0506.google.com ([66.249.82.231])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HhT27-0000wR-4c
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 27 Apr 2007 09:10:55 -0700
Received: by wx-out-0506.google.com with SMTP id i30so1630256wxd
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Fri, 27 Apr 2007 09:10:54 -0700 (PDT)
In-Reply-To: <200704270814.48865.jbarnes@virtuousgeek.org>
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

On Fri, 2007-04-27 at 08:14 -0700, Jesse Barnes wrote:
> On Thursday, April 26, 2007, Antonino A. Daplas wrote:
> > I have no problems with the purpose of this patch, but I would like what
> > other kernel developers, both fbdev and non-fbdev, think about this.
> >
> > The main problem with this version is it's possible to have more than 1
> > fb driver mapped to each console (and people do that).  So if one of
> > them unregisters, it will also unbind the other one. Code-wise, it's not
> > a problem.  But users will not expect that behavior.
> >
> > It's fixable though, as unbind_con_driver() also accepts the first and
> > last parameter.  fbcon_fb_unbind() will have to walk con2fbmap[], so
> > something like this untested code instead:
> >
> > static int fbcon_fb_unbind(int idx) {
> > 	for (i = 0; i < MAX_NR_CONSOLES; i++) {
> > 		/* Assure we do not unbind other drivers */
> > 		if (idx == con2fbmap[i])
> > 			/* can be optimize to minimize multiple calls to
> > 			 	unbind_con_driver() */
> > 			unbind_con_driver(&fb_con, i, i, 0);
> > 	}
> > ]
> >
> > Besides the above, we still have to make adjustments to fbcon so it can
> > handle one driver going away and while still managing other loaded
> > drivers.
> 
> Unbinding from specific consoles would indeed be much better, and provide 
> more intuitive behavior.  I just wasn't sure how to do it offhand in 
> fbcon; I'll try your snippet, looks like it should work nicely (at and 
> worst we'll have 64 calls to unbind_con_driver, so I don't think batching 
> is an issue).

I'll try modifying fbcon + your patch this weekend so we can selectively
unbind framebuffers.

Tony



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
