From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: [PATCH] fbdev: workaround for broken X servers
Date: Wed, 3 Nov 2004 21:09:29 +0800
Message-ID: <200411032109.29734.adaplas@hotpop.com>
References: <1099448020.900.25.camel@gaston> <20041103032613.GA3677@sci.fi>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CPKti-0002Hl-L5
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 03 Nov 2004 05:09:58 -0800
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CPKth-0006n8-T2
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 03 Nov 2004 05:09:58 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 2542298964E
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed,  3 Nov 2004 13:09:51 +0000 (UTC)
In-Reply-To: <20041103032613.GA3677@sci.fi>
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
To: linux-fbdev-devel@lists.sourceforge.net, Ville =?iso-8859-1?q?Syrj=E4l=E4?= <syrjala@sci.fi>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>

On Wednesday 03 November 2004 11:26, Ville Syrj=E4l=E4 wrote:
> On Wed, Nov 03, 2004 at 01:13:39PM +1100, Benjamin Herrenschmidt wrote:
> > Hi !
> >
> > +	/* Workaround for broken X servers */
> > +	if (blank > VESA_POWERDOWN)
> > +		blank =3D VESA_POWERDOWN;
> > +
> >  	if (info->fbops->fb_blank && !info->fbops->fb_blank(blank, info))
> >  		return 0;
>
> This goes against documented behaviour (see fb.h). Also drivers/char/vt.c
> seems to agree with fb.h, as do at least atyfb and matroxfb. I also used
> the vesa level+1 convention in DirectFB. So AFAICS this patch would
> confuse console power management, XFree86/X.Org, DirectFB and some fb
> drivers.

True enough. The convention is if the display is active, then suspend. If
it is suspended, then powerdown.  And if already powered down, then do
nothing.  It does so by by sending a blank flag of VESA_POWERDOWN + 1.

This is the convention used by the vt layer, I don't what is used by user a=
pps.
The above patch won't break console power management as the console calls
fbcon_blank(), not fb_blank().

Tony




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
