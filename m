From: James Simmons <jsimmons@infradead.org>
Subject: Re: fb: modedb uses wrong default_mode
Date: Mon, 20 Nov 2006 20:37:08 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0611202033460.26386@pentafluge.infradead.org>
References: <Pine.LNX.4.64.0611151933070.12799@jalava.cc.jyu.fi>
	<20061115152952.0e92c50d.akpm@osdl.org>
	<20061115234456.GB3674@cosmic.amd.com>
	<Pine.LNX.4.64.0611171919090.9851@pentafluge.infradead.org>
	<20061117124013.b6e4183d.akpm@osdl.org>
	<Pine.LNX.4.64.0611201643460.17639@pentafluge.infradead.org>
	<20061120120521.68724342.akpm@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GmFtE-0002LP-T8 for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 20 Nov 2006 12:37:16 -0800
Received: from pentafluge.infradead.org ([213.146.154.40])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1GmFtD-0004V9-4x
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 20 Nov 2006 12:37:16 -0800
In-Reply-To: <20061120120521.68724342.akpm@osdl.org>
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
To: Andrew Morton <akpm@osdl.org>
Cc: Tero Roponen <teanropo@jyu.fi>, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org


> > I really don't trust dbsize. The driver writer can pass in the wrong 
> > number.
> 
> That would be a bug.

Excuse my paranoia about what driver writers will do :-/

> > Whereas ARRAY_SIZE will always be correct. Lets take the position 
> > that we use dbsize then we need to test if dbsize is greater than the 
> > really size of the modedb. The dbsize parameter was for the days before we
> > had ARRAY_SIZE.
> > 
> > > int fb_find_mode(struct fb_var_screeninfo *var,
> > > 		 struct fb_info *info, const char *mode_option,
> > > 		 const struct fb_videomode *db, unsigned int dbsize,
> > > 		 const struct fb_videomode *default_mode,
> > > 		 unsigned int default_bpp)
> > > {
> > >     int i;
> > > 
> > >     /* Set up defaults */
> > >     if (!db) {
> > > 	db = modedb;
> > > 	dbsize = ARRAY_SIZE(modedb);
> > >     }
> > 
> >       if (dbsize > ARRAY_SIZE(db))
> > 	dbsize = ARRAY_SIZE(db);
> 
> We can't do ARRAY_SIZE on a random pointer like this: the compiler needs to
> see the full definition of the array itself, and that is back in the
> caller's compilation unit.

Good point about the pointer being valid. In that case we have to deal 
with dbsize. Still nervous about going out of bounds of the array.


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
