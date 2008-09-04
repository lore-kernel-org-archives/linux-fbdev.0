From: Juergen Beisert <juergen127@kreuzholzen.de>
Subject: Re: [PATCH] i.MX Framebuffer: Cleanup Coding
	style
Date: Thu, 4 Sep 2008 17:08:49 +0200
Message-ID: <200809041708.51439.juergen127@kreuzholzen.de>
References: <20080904123109.65A6C860CE7@f23.poczta.interia.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KbGSH-0006zD-VN for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 04 Sep 2008 08:09:06 -0700
Received: from bender.weihenstephan.org ([62.245.246.226])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KbGSF-00062r-Mw
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 04 Sep 2008 08:09:05 -0700
Received: from MailerDaemon by bender.weihenstephan.org with local-bsmtp (Exim
	4.63) (envelope-from <juergen127@kreuzholzen.de>) id 1KbGS7-00086h-Gp
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 04 Sep 2008 17:08:55 +0200
In-Reply-To: <20080904123109.65A6C860CE7@f23.poczta.interia.pl>
Content-Disposition: inline
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
To: krzysztof.h1@poczta.fm
Cc: "linux-fbdev-devel@lists.sourceforge.net" <linux-fbdev-devel@lists.sourceforge.net>, Andrew Dyer <amdyer@gmail.com>, "linux-fbdev-users@lists.sourceforge.net" <linux-fbdev-users@lists.sourceforge.net>

On Donnerstag, 4. September 2008, krzysztof.h1@poczta.fm wrote:
> > On Mittwoch, 3. September 2008, Krzysztof Helt wrote:
> > > On Tue,  2 Sep 2008 13:24:51 +0200
> > >
> > > Sascha Hauer <s.hauer@pengutronix.de> wrote:
> > > > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > > > ---
> > > >  drivers/video/imxfb.c |   70
> > > > +++++++++++++++++++++++------------------------- 1 files changed, 34
> > > > insertions(+), 36 deletions(-)
> > >
> > > Acked-by: Krzysztof Helt <krzysztof.h1@wp.pl>
> > >
> > > One offtopic comment: do you really want the FBINFO_READS_FAST set?
> > >
> > > It means that the driver prefer copyarea to imgblit function. It is
> >
> > Did you ever get the framework to use the copyarea function the driver
> > provides? I tried it several times and this function was never called.
> > Independent from any flags I set or clear.
> >
> > jbe
>
> I do not have atmel hardware to test.

Its not architecture specific.

> I did used the copyarea on some other drivers (tridentfb, pm2fb).

How did you use them?

> The tdfxfb driver uses now copyarea function for console scrolling.

Are you sure, this function will be called? I wrote two drivers for ARM and 
x86 graphics hardware and provide a copyarea function for both of them. The 
console framework ignores both. Only the fillrect and imageblit function is 
used from the frambuffer console code.

In driver/video/console/fbcon.c I always fail in function fbcon_scroll(). 
The "dir" switch/case never reaches one of the "switch (p->scrollmode)" 
statements.

jbe

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
