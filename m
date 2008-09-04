From: krzysztof.h1@poczta.fm
Subject: Re: [PATCH] i.MX Framebuffer: Cleanup Coding
	style
Date: 04 Sep 2008 14:31:09 +0200
Message-ID: <20080904123109.65A6C860CE7@f23.poczta.interia.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
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
To: Juergen Beisert <juergen127@kreuzholzen.de>, "linux-fbdev-users@lists.sourceforge.net" <linux-fbdev-users@lists.sourceforge.net>
Cc: "linux-fbdev-devel@lists.sourceforge.net" <linux-fbdev-devel@lists.sourceforge.net>, Andrew Dyer <amdyer@gmail.com>

> On Mittwoch, 3. September 2008, Krzysztof Helt wrote:
> > On Tue,  2 Sep 2008 13:24:51 +0200
> >
> > Sascha Hauer <s.hauer@pengutronix.de> wrote:
> > > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > > ---
> > >  drivers/video/imxfb.c |   70
> > > +++++++++++++++++++++++------------------------- 1 files changed, 34
> > > insertions(+), 36 deletions(-)
> >
> > Acked-by: Krzysztof Helt <krzysztof.h1@wp.pl>
> >
> > One offtopic comment: do you really want the FBINFO_READS_FAST set?
> >
> > It means that the driver prefer copyarea to imgblit function. It is
> 
> Did you ever get the framework to use the copyarea function the driver 
> provides? I tried it several times and this function was never called. 
> Independent from any flags I set or clear.
> 
> jbe
> 

I do not have atmel hardware to test. I did used the copyarea on some other drivers (tridentfb, pm2fb). The tdfxfb driver uses now copyarea function for console scrolling. I will inspect out the atmel driver and give you some hints.

Regards,
Krzysztof
> 


---------------------------------------------------------------
Nasilaja sie kradzieze.
Mieszkancy osiedli zaniepokojeni.
Prosimy o pomoc w tej sprawie >>> http://link.interia.pl/f1eef



-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
