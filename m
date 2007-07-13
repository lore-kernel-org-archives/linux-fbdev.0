From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [patch 0/4] Cell SPE logos
Date: Fri, 13 Jul 2007 22:30:58 +1000
Message-ID: <1184329858.6059.217.camel@localhost.localdomain>
References: <20070710122702.765654000@pademelon.sonytel.be>
	<20070712160621.644d78d2.akpm@linux-foundation.org>
	<Pine.LNX.4.62.0707131051190.18802@pademelon.sonytel.be>
	<20070713020621.e8f2e4ce.akpm@linux-foundation.org>
	<Pine.LNX.4.62.0707131108320.18802@pademelon.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1I9KJL-0000kj-5Z for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 13 Jul 2007 05:31:51 -0700
Received: from gate.crashing.org ([63.228.1.57]
	ident=[U2FsdGVkX180HWtP/if4bdJjDH7pgzxG5GOPJGmcfP4=])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1I9KJJ-000068-Lx
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 13 Jul 2007 05:31:51 -0700
In-Reply-To: <Pine.LNX.4.62.0707131108320.18802@pademelon.sonytel.be>
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: James Simmons <jsimmons@infradead.org>, "Antonino A. Daplas" <adaplas@gmail.com>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>, Andrew Morton <akpm@linux-foundation.org>, cbe-oss-dev@ozlabs.org

On Fri, 2007-07-13 at 11:09 +0200, Geert Uytterhoeven wrote:
> On Fri, 13 Jul 2007, Andrew Morton wrote:
> > On Fri, 13 Jul 2007 10:52:10 +0200 (CEST) Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com> wrote:
> > 
> > > > > Summaries:
> > > > >   [1] fbdev: extract fb_show_logo_line()
> > > > >   [2] fbdev: Add fb_append_extra_logo()
> > > > 
> > > > This one does give additional code and data to all fbdev users while only
> > > > being useful to cell machines.  Should we fix that?
> > > 
> > > I can protect it by #ifdef CONFIG_PPC_CELL (as long as there are no other
> > > users). Would that be OK?
> > 
> > umm, your call.  If that makes sense, sure.
> 
> I just don't like putting platform-specific checks in common code.
> 
> Perhaps I better add CONFIG_FB_LOGO_EXTRA and make it depend on
> CONFIG_PPC_CELL?

I hate depends when it's not a dependency... the logo extra code doesn't
-depend- technically on cell (it doesn't call cell only stuff). However,
cell wants it enabled, thus I'd rather use either the "default y if
PP_CELL" construct or select it from the cell option.

Ben.
 


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
