From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Subject: Re: Re: [macro@ds2.pg.gda.pl: Re: PMAG-A support?]
Date: Tue, 12 Aug 2003 17:14:30 +0200 (MET DST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.3.96.1030812170254.7029H-100000@delta.ds2.pg.gda.pl>
References: <20030812063707.GC23104@rembrandt.csv.ica.uni-stuttgart.de>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from delta.ds2.pg.gda.pl ([213.192.72.1] ident=macro)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19marG-0003mc-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 12 Aug 2003 08:14:46 -0700
In-Reply-To: <20030812063707.GC23104@rembrandt.csv.ica.uni-stuttgart.de>
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

On Tue, 12 Aug 2003, Thiemo Seufer wrote:

> Anyway, the AA driver is appended as a diff against current linux-mips
> CVS. I hope it doesn't deviate too much from whatever fbdev uses.

 Hmm, I can only see PMAG-A-specific changes here -- does it mean the
driver now works as is with no changes to the generic fb code?  If that is
the case, I'll apply the patch to the MIPS CVS right now.

 One point to note -- iob() is a heavyweight barrier implying immediate
draining of buffers.  I don't think it's really needed here as the driver
only needs to enforce ordering.  Hence I'd change iob() to wmb() or mb()
as appropriate and add a few missing rmb() calls.  I can do that when
applying the patch or please prepare an update.

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
