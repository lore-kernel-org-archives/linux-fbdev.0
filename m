From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: [PATCH 0/8] Some atyfb patches
Date: Fri, 18 Mar 2005 04:18:08 +0800
Message-ID: <200503180418.08333.adaplas@hotpop.com>
References: <20050317023054.2B0DB7A@kuori.saunalahti.fi> <200503180345.53067.adaplas@hotpop.com> <20050317200842.GB29118@sci.fi>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DC1Ri-0001LD-GV
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 17 Mar 2005 12:18:18 -0800
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DC1Rg-00079m-Hg
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 17 Mar 2005 12:18:18 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 6FFEFFD1D11
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 17 Mar 2005 20:18:01 +0000 (UTC)
In-Reply-To: <20050317200842.GB29118@sci.fi>
Content-Disposition: inline
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="iso-8859-1"
To: Ville =?iso-8859-1?q?Syrj=E4l=E4?= <syrjala@sci.fi>, adaplas@pol.net
Cc: linux-fbdev-devel@lists.sourceforge.net, Ville SyrjXlX <syrjala@kotilo.saunalahti.fi>, alex.kern@gmx.de, Luigi Gangitano <luigi@debian.org>

On Friday 18 March 2005 04:08, Ville Syrj=E4l=E4 wrote:
> On Fri, Mar 18, 2005 at 03:45:53AM +0800, Antonino A. Daplas wrote:
> > On Thursday 17 March 2005 10:30, Ville SyrjXlX wrote:
> > > Here's a collection of patches for atyfb.
> > >
> > > I'm pretty sure patches 1-5 are fine as is.
> > >
> > > Patches 6 and 7 change some of the chip descriptions. I'm not 100% su=
re
> > > about the changes so I'd appreciate any comments.
> > >
> > > Patch 8 changes the power management code so I really need some
> > > comments on it. I don't want to break any working setups.
> >
> > Let me know if you want this to go to the mm tree.
>
> I'd like to see what people have to say first.

Ok.

BTW, since you and Alex are the atyfb experts, can you suggest something
about this bug, a regression in atyfb for sparc.

http://marc.theaimsgroup.com/?l=3Dlinux-fbdev-devel&m=3D111088247318947&w=
=3D2

Tony




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
