From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] fb_ddc: Fix DDC lines quirk
Date: Sat, 24 Nov 2007 08:00:04 +1100
Message-ID: <1195851604.7195.10.camel@pasglop>
References: <20071118142141.22a1e753@hyperion.delvare>
	<1195675129.6970.98.camel@pasglop>
	<20071123205309.7c40a931@hyperion.delvare>
Reply-To: benh@kernel.crashing.org,
	linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IvfdN-0001aO-Ag for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 23 Nov 2007 13:00:23 -0800
Received: from gate.crashing.org ([63.228.1.57]
	ident=[U2FsdGVkX18XK2c0R0TenuXrjCKH9sktj8/kabuXUoE=])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IvfdL-0008SM-Pq
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 23 Nov 2007 13:00:21 -0800
In-Reply-To: <20071123205309.7c40a931@hyperion.delvare>
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
Cc: Antonino Daplas <adaplas@gmail.com>


On Fri, 2007-11-23 at 20:53 +0100, Jean Delvare wrote:
> On Thu, 22 Nov 2007 06:58:49 +1100, Benjamin Herrenschmidt wrote:
> > 
> > On Sun, 2007-11-18 at 14:21 +0100, Jean Delvare wrote:
> > > The code in fb_ddc_read() is said to be based on the implementation
> > > of the radeon driver:
> > > http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=fc5891c8a3ba284f13994d7bc1f1bfa8283982de
> > > 
> > > However, comparing the old radeon driver code with the new fb_ddc code
> > > reveals some differences. Most notably, the I2C bus lines are held at
> > > the end of the function, while the original code was releasing them
> > > (as the comment above correctly says.)
> > 
> >  .../...
> > 
> > > Signed-off-by: Jean Delvare <khali@linux-fr.org>
> > 
> > Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> 
> Thanks. Antonino, this patch fixes two reported regressions. Can you
> please send it to Linus before 2.6.24 is released? Thanks.

It should also be send to -stable I believe and possibly distros.

Cheers,
Ben.



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
