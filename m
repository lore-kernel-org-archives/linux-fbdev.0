From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Re: Unifying radeon.h constant files
Date: Mon, 01 Sep 2003 21:38:12 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1062445091.724.14.camel@gaston>
References: <20030901155647.84255.qmail@web14901.mail.yahoo.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19tuVz-0000Jh-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 01 Sep 2003 12:39:03 -0700
Received: from pentafluge.infradead.org ([213.86.99.235])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.22)
	id 19tuVy-0005yo-Ku
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 01 Sep 2003 12:39:02 -0700
In-Reply-To: <20030901155647.84255.qmail@web14901.mail.yahoo.com>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Jon Smirl <jonsmirl@yahoo.com>
Cc: kronos <kronos@kronoz.cjb.net>, fb-devel <linux-fbdev-devel@lists.sourceforge.net>

On Mon, 2003-09-01 at 17:56, Jon Smirl wrote:
> --- Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> > I'm all for doing that, but not until I've finished the new version of
> > the driver ;) Also, I have a bunch of additional constants used by the
> > Power Management code that don't have the RADEON_ prefix neither and are
> > not in XFree, we would have to fixup that too. 
> > 
> Do you want to try doing the fixups for XFree H file then? 

> Have you merged with Luca and me from mesa3d.bkbit.net/linux-2.5 yet? There
> will probably be conflicts where I rewrote the error handling in the
> intialization code. The old code made mistakes freeing resource when errors
> ocurred.

I've done the merge in my WIP tree where i'm working on a split version
of the driver, I did some other changes to the EDID stuff (probing all
ports and using a slightly different logic to pick the main one, also
I'm trying to pave the way to full multihead).

It's not ready yet, hopefully I'll have that up before next week.

> Send me an rsa1 key and I can add you as a writer.

Talk to you about this later.

Ben.




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
