From: Greg KH <greg@kroah.com>
Subject: Re: [stable] [PATCH] atyfb: Replace busy loop
	with mdelay()
Date: Tue, 6 Mar 2007 17:13:58 -0800
Message-ID: <20070307011358.GB13624@kroah.com>
References: <20070222002033.GA26166@sci.fi>
	<20070305155318.23fff053.akpm@linux-foundation.org>
	<20070306002943.GA9193@sci.fi>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HOkkj-0006Ao-Fj for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 06 Mar 2007 17:15:37 -0800
Received: from mail.suse.de ([195.135.220.2] helo=mx1.suse.de)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HOkkh-0000LS-Px
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 06 Mar 2007 17:15:37 -0800
Content-Disposition: inline
In-Reply-To: <20070306002943.GA9193@sci.fi>
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
To: linux-fbdev-devel@lists.sourceforge.net, jsimmons@infradead.org, stable@kernel.org, adaplas@gmail.com, alex.kern@gmx.de

On Tue, Mar 06, 2007 at 02:29:43AM +0200, Ville Syrj?l? wrote:
> On Mon, Mar 05, 2007 at 03:53:18PM -0800, Andrew Morton wrote:
> > @@ -614,7 +613,7 @@ static void aty_resume_pll_ct(const stru
> >                  * helps for Rage Mobilities that sometimes crash when
> >                  * we switch to sclk. (Daniel Mantione, 13-05-2003)
> >                  */
> > -               for (i=0;i<=0x1ffff;i++);
> > +               udelay(500);
> 
> I'm not sure if 500 us is enough. The programmer's guide says you should 
> allow 5 ms for the PLL to lock.

Then can you correct the patch in mainline, and forward what gets
accepted there to the stable team if you wish the change to also be made
there?

thanks,

greg k-h

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
