From: Stephane Wirtel <stephane.wirtel@belgacom.net>
Subject: Re: why not put LOGO_W and LOGO_H in linux_logo.h ?
Date: Thu, 22 Aug 2002 20:56:00 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20020822185600.GA17996@debian>
References: <20020817175835.GB7078@debian> <Pine.LNX.4.33.0208221144110.9077-100000@maxwell.earthlink.net>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from 212.68.254.82.brutele.be ([212.68.254.82] helo=debian)
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17hx7m-000834-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 22 Aug 2002 11:56:07 -0700
Received: from root by debian with local (Exim 3.35 #1 (Debian))
	id 17hx7h-0004gf-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 22 Aug 2002 20:56:01 +0200
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0208221144110.9077-100000@maxwell.earthlink.net>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux Frame Buffer Devel Mailing List <linux-fbdev-devel@lists.sourceforge.net>


On Thu, Aug 22, 2002 at 11:44:25AM -0700, James Simmons wrote:
> 
> Good question. Is there any reason why this is?
it's more easy to change the logo if it is in linux_logo.h

i modified fblogo, to make a linux_logo.h with LOGO_W and LOGO_H.

> 
> MS: (n) 1. A debilitating and surprisingly widespread affliction that
> renders the sufferer barely able to perform the simplest task. 2. A disease.
> 
> James Simmons  [jsimmons@users.sf.net] 	                ____/|
> fbdev/console/gfx developer                             \ o.O|
> http://www.linux-fbdev.org                               =(_)=
> http://linuxgfx.sourceforge.net                            U
> http://linuxconsole.sourceforge.net
> 
> On Sat, 17 Aug 2002, Stephane Wirtel wrote:
> 
> >
> > --
> > Stephane Wirtel <stephane.wirtel@belgacom.net>
> > Web : www.linux-mons.be	 "Linux Is Not UniX !!!"
> >
> >
> > -------------------------------------------------------
> > This sf.net email is sponsored by: OSDN - Tired of that same old
> > cell phone?  Get a new here for FREE!
> > https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
> > _______________________________________________
> > Linux-fbdev-devel mailing list
> > Linux-fbdev-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel
> >
> 
> 
> 
> -------------------------------------------------------
> This sf.net email is sponsored by: OSDN - Tired of that same old
> cell phone?  Get a new here for FREE!
> https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
> _______________________________________________
> Linux-fbdev-devel mailing list
> Linux-fbdev-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

-- 
Stephane Wirtel <stephane.wirtel@belgacom.net>
Web : www.linux-mons.be	 "Linux Is Not UniX !!!"


-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
