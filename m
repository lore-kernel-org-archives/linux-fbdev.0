From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Subject: Re: Re: [macro@ds2.pg.gda.pl: Re: PMAG-A support?]
Date: Sat, 30 Aug 2003 02:57:21 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030830005721.GF27332@rembrandt.csv.ica.uni-stuttgart.de>
References: <20030814022906.GH10792@rembrandt.csv.ica.uni-stuttgart.de> <Pine.GSO.3.96.1030814140520.14241D-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19su4V-000118-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 29 Aug 2003 17:58:31 -0700
Received: from iris1.csv.ica.uni-stuttgart.de ([129.69.118.2])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19su4T-00052w-QK
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 29 Aug 2003 17:58:30 -0700
Content-Disposition: inline
In-Reply-To: <Pine.GSO.3.96.1030814140520.14241D-100000@delta.ds2.pg.gda.pl>
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
Cc: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>, Karsten Merker <karsten@excalibur.cologne.de>, Martin Schulze <joey@infodrom.org>, linux-fbdev-devel@lists.sourceforge.net

Maciej W. Rozycki wrote:
> On Thu, 14 Aug 2003, Thiemo Seufer wrote:
> 
> > >  I've looked at the patch and have changed the barriers as I deem
> > > appropriate.  But while doing this, I've noticed the code is insonsistent
> > > in a few places -- has it been successfully verified on real hardware?

There are some mb() calls in your patch, I believe a rmb()/wmb() is
enough in those cases.

> > It works on my /260. Which parts look weird to you?
> 
> 1. bt431_write_reg_inc() uses u16 for value, even though it only uses 8
> bits (which of course makes all the calls in bt431_init_cursor() dubious). 
>
> 2. bt431_load_cursor_sprite() loads control registers instead of the
> cursor map. 

The hardware cursor is still unused. The code there is very experimental,
and your version is surely an imporvement. :-)


Thiemo


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
