From: rwhron@earthlink.net
Subject: Re: 2.6.0-test2 does not boot with matroxfb
Date: Thu, 14 Aug 2003 19:14:09 -0400
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030814231409.GA745@rushmore>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mallard.mail.pas.earthlink.net ([207.217.120.48])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19nRGP-0006S0-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 14 Aug 2003 16:12:13 -0700
Content-Disposition: inline
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
Content-Transfer-Encoding: 7bit
To: vandrove@vc.cvut.cz
Cc: linux-fbdev-devel@lists.sourceforge.net

> > > On 11 Aug 03 at 20:01, Jocelyn Mayer wrote:
> > > > So, there seems to be two issues:
> > > > - broken matrox fb: I lose the synchro when switching from X to fb.
> > > >   fbset configuration is lost when switching consoles.

> > > On Mon, 2003-08-11 at 20:29, Petr Vandrovec wrote:
> > > It is feature, not a bug. fbset does not work on 2.6.x kernels
> > > anymore. Apply
> > > ftp://platan.vc.cvut.cz/pub/linux/matrox-latest/matroxfb-2.6.0-t3-c1149.gz
> > > if you prefer 2.4.x behavior.

Thanks for updating the matroxfb 2.6 patch.

> On 11 Aug 03 at 21:00, Jocelyn Mayer wrote:
> > In fact, it works untill I switch to another console...
> > Did it become impossible (would be a severe bug, at least for me...) ?

Petr's patch is mandatory to get mga400 to do all this at the same time:

o multiple fast high res (240x90 char) virtual text consoles.
o graphics in console with "links -g"
o X11

I use matroxfb this way every day.

-- 
Randy Hron
http://home.earthlink.net/~rwhron/kernel/bigbox.html



-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
