From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Subject: Re: Re: [macro@ds2.pg.gda.pl: Re: PMAG-A support?]
Date: Tue, 12 Aug 2003 17:26:47 +0200 (MET DST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.3.96.1030812171748.7029I-100000@delta.ds2.pg.gda.pl>
References: <Pine.GSO.4.21.0308121602420.20533-100000@vervain.sonytel.be>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from delta.ds2.pg.gda.pl ([213.192.72.1] ident=macro)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19mb3C-0006vQ-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 12 Aug 2003 08:27:06 -0700
In-Reply-To: <Pine.GSO.4.21.0308121602420.20533-100000@vervain.sonytel.be>
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
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>, Michel =?iso-8859-1?Q?D=E4nzer?= <michel@daenzer.net>, Karsten Merker <karsten@excalibur.cologne.de>, Martin Schulze <joey@infodrom.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Tue, 12 Aug 2003, Geert Uytterhoeven wrote:

> > Ah, I haven't heard about this option yet. Well, the LK keymaps as
> 
> It was added in 1995 to support various m68k boxes :-)
> 
> > distributed with X seem to want RAW, I'll just try what happens with
> > CustomKeycodes enabled.
> 
> So far everyone who tried MEDIUM_RAW mode on PC said it worked fine, and that
> he wanted to make it the default mode, but apparently that never happened ;-(

 Well, X11 seems to have quite an extensive knowledge of various keyboards
out there, so the advantage of using MEDIUM_RAW is epsilon.  OTOH, using
the RAW mode gives the X-server a possibility to fully control the
keyboard, beyond what is sufficient for the kernel for console operation. 
And all the world is not a PC (nor a VAX, which the LK201, etc. keyboards
might seem to imply ;-) ). 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +



-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
