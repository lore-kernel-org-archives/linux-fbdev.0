From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Subject: Re: Re: [macro@ds2.pg.gda.pl: Re: PMAG-A support?]
Date: Tue, 12 Aug 2003 10:40:09 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030812084009.GH23104@rembrandt.csv.ica.uni-stuttgart.de>
References: <20030812063707.GC23104@rembrandt.csv.ica.uni-stuttgart.de> <Pine.GSO.4.21.0308121014200.20533-100000@vervain.sonytel.be>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from iris1.csv.ica.uni-stuttgart.de ([129.69.118.2])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19mUi5-0002PO-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 12 Aug 2003 01:40:53 -0700
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0308121014200.20533-100000@vervain.sonytel.be>
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
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>, Karsten Merker <karsten@excalibur.cologne.de>, Martin Schulze <joey@infodrom.org>, "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

Geert Uytterhoeven wrote:
> On Tue, 12 Aug 2003, Thiemo Seufer wrote:
> > Karsten Merker wrote:
> > > ----- Forwarded message from "Maciej W. Rozycki" <macro@ds2.pg.gda.pl> -----
> > [snip]
> > > > What's missing is support *in* XFree86.  That where I lost time.
> > > 
> > >  That's the second step anyway.
> > 
> > The PMAG-AA basically works for me, but it is not too useful without
> > working keyboard support. XFree86 preprocesses the xkbd input in order
> > to handle PC keyboard's key sequences, this breaks the LK keyboard
> > support.
> 
> Ugh, so it sill uses RAW instead of MEDIUM_RAW?

AFAIK all XFree86/Linux flavours want RAW.

> > > > Thiemo said that he had a more recent patch which will more likely be
> > > > accepted upstream, iirc.
> > > 
> > >  Could one of you as the authors please resend the most recent patch to
> > > the <linux-fbdev-devel@lists.sourceforge.net> list?  I'm subscribed there,
> > > so I'll see comments and reply if needed. 
> > 
> > I already sent some parts earlier, but I don't know if they got lost
> > (is there an up-to-date CVS for fbdev?).
> 
> There's a BK, but only for 2.[56].x.

Mind to tell the URL? :-)

> > Anyway, the AA driver is appended as a diff against current linux-mips
> > CVS. I hope it doesn't deviate too much from whatever fbdev uses.
> 
> This is against 2.4.x, right?

Yes. There's currently no working DECstation support in 2.6. The ZS
serial driver is not yet ported forward.


Thiemo


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
