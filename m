From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Subject: Re: Re: [macro@ds2.pg.gda.pl: Re: PMAG-A support?]
Date: Mon, 1 Sep 2003 14:03:06 +0200 (MET DST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.3.96.1030901135218.6646C-100000@delta.ds2.pg.gda.pl>
References: <20030830005721.GF27332@rembrandt.csv.ica.uni-stuttgart.de>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19tnP2-0001jZ-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 01 Sep 2003 05:03:24 -0700
Received: from delta.ds2.pg.gda.pl ([213.192.72.1] ident=macro)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19tnP1-0007Jm-OE
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 01 Sep 2003 05:03:24 -0700
In-Reply-To: <20030830005721.GF27332@rembrandt.csv.ica.uni-stuttgart.de>
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

On Sat, 30 Aug 2003, Thiemo Seufer wrote:

> > > >  I've looked at the patch and have changed the barriers as I deem
> > > > appropriate.  But while doing this, I've noticed the code is insonsistent
> > > > in a few places -- has it been successfully verified on real hardware?
> 
> There are some mb() calls in your patch, I believe a rmb()/wmb() is
> enough in those cases.

 They are there because you don't really know if the previous access (if
any) to the addressed chip was a read or a write.  So you need to use a
barrier that works for both.  Please let me know if I got any specific
ones wrong, though.

> > > It works on my /260. Which parts look weird to you?
> > 
> > 1. bt431_write_reg_inc() uses u16 for value, even though it only uses 8
> > bits (which of course makes all the calls in bt431_init_cursor() dubious). 
> >
> > 2. bt431_load_cursor_sprite() loads control registers instead of the
> > cursor map. 
> 
> The hardware cursor is still unused. The code there is very experimental,
> and your version is surely an imporvement. :-)

 Hmm, but doesn't it lead to a garble where cursor is expected to be? 

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
