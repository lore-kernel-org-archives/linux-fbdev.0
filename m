From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Subject: Re: Re: [macro@ds2.pg.gda.pl: Re: PMAG-A support?]
Date: Thu, 14 Aug 2003 14:19:18 +0200 (MET DST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.3.96.1030814140520.14241D-100000@delta.ds2.pg.gda.pl>
References: <20030814022906.GH10792@rembrandt.csv.ica.uni-stuttgart.de>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from delta.ds2.pg.gda.pl ([213.192.72.1] ident=macro)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19nH5G-0000Fz-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 14 Aug 2003 05:20:02 -0700
In-Reply-To: <20030814022906.GH10792@rembrandt.csv.ica.uni-stuttgart.de>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Cc: Karsten Merker <karsten@excalibur.cologne.de>, Martin Schulze <joey@infodrom.org>, linux-fbdev-devel@lists.sourceforge.net

On Thu, 14 Aug 2003, Thiemo Seufer wrote:

> >  I've looked at the patch and have changed the barriers as I deem
> > appropriate.  But while doing this, I've noticed the code is insonsistent
> > in a few places -- has it been successfully verified on real hardware?
> 
> It works on my /260. Which parts look weird to you?

1. bt431_write_reg_inc() uses u16 for value, even though it only uses 8
bits (which of course makes all the calls in bt431_init_cursor() dubious). 

2. bt431_load_cursor_sprite() loads control registers instead of the
cursor map. 

 See the patch for details.  You may use `diff -b' to get rid of spacing
clean-ups -- this makes my updates quite clear. 

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +



-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
