From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: [PATCH 7/8] fbdev: atyfb_base.c requires atyfb_cursor()
Date: Wed, 3 Nov 2004 00:26:45 +0200
Message-ID: <20041102222645.GA20934@sci.fi>
References: <200411021946.26862.adaplas@hotpop.com> <20041102135843.GA13761@sci.fi> <200411030531.36468.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CP771-0002xm-UY
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 02 Nov 2004 14:26:47 -0800
Received: from gw01.mail.saunalahti.fi ([195.197.172.115])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CP771-0008QN-04
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 02 Nov 2004 14:26:47 -0800
Received: from kuori.saunalahti.fi (kuori.saunalahti.fi [195.197.175.23])
	by gw01.mail.saunalahti.fi (Postfix) with ESMTP id 48FAA7E095
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed,  3 Nov 2004 00:26:45 +0200 (EET)
Content-Disposition: inline
In-Reply-To: <200411030531.36468.adaplas@hotpop.com>
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
To: linux-fbdev-devel@lists.sourceforge.net

On Wed, Nov 03, 2004 at 05:31:36AM +0800, Antonino A. Daplas wrote:
> On Tuesday 02 November 2004 21:58, Ville Syrj=E4l=E4 wrote:
> > On Tue, Nov 02, 2004 at 07:46:26PM +0800, Antonino A. Daplas wrote:
> > > atyfb_base.c requires atyfb_cursor, but it is only available for li=
nking
> > > if CONFIG_FB_ATY_CT=3Dy.
> > > This patch moves the .o file to the CONFIG_FB_ATY rule.
> >
> > Here's a better fix. It was a part of my swcursor patch which was
> > partially included. Looks like Alex accidentally dropped this part.
> >
> >
> > Fix atyfb cursor problems:
> > - oops with noaccel option
> > - CONFIG_FB_ATY_CT dependency problem
> >
>=20
> If I read Alex's patch correctly, it looks like the aty has a working
> hardware cursor implementation, is this correct?  Then a better patch m=
ay be
> to use soft_cursor if noaccel is true, and atyfb_cursor otherwise.

That is how things work with this patch. aty_init_cursor() sets fb_cursor=
=20
to atyfb_cursor.

--=20
Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
