From: Martin Schulze <joey@infodrom.org>
Subject: Re: Re: [macro@ds2.pg.gda.pl: Re: PMAG-A support?]
Date: Tue, 12 Aug 2003 19:28:12 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030812172812.GE8511@finlandia.infodrom.north.de>
References: <20030812155339.GC8511@finlandia.infodrom.north.de> <Pine.GSO.3.96.1030812183047.7029J-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from luonnotar.infodrom.org ([195.124.48.78])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19md5L-0000qd-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 12 Aug 2003 10:37:27 -0700
Content-Disposition: inline
In-Reply-To: <Pine.GSO.3.96.1030812183047.7029J-100000@delta.ds2.pg.gda.pl>
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
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>, Karsten Merker <karsten@excalibur.cologne.de>, linux-fbdev-devel@lists.sourceforge.net

Maciej W. Rozycki wrote:
> On Tue, 12 Aug 2003, Martin Schulze wrote:
> 
> > >  Hmm, I can only see PMAG-A-specific changes here -- does it mean the
> > > driver now works as is with no changes to the generic fb code?  If that is
> > > the case, I'll apply the patch to the MIPS CVS right now.
> > 
> > The changes to generic code were sent in a separate mail.  I've resent
> > it to an archive: http://www.infodrom.org/Mail-Archive/misc/2003/0010.html
> 
>  I've seen that, but as I understand it's needed just for the Penguin logo
> to be displayed correctly upon boot, right?  The logo might be nice to
> have, but it's secondary -- if the console tty output works without that
> part, I'd consider the driver ready to use and let the logo be fixed
> independently. 

Yes.  In that case you are absolutely correct.  The console works
without the logo, of course.

Regards,

	Joey

-- 
GNU GPL: "The source will be with you... always."

Please always Cc to me when replying to me on the lists.


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
