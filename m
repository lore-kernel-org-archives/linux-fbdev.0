From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: [PATCH] mach64
Date: Sun, 16 May 2004 19:03:32 +0300
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040516160332.GB18523@sci.fi>
References: <200405161513.15979.alex.kern@gmx.de>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BPO6x-0004xK-Me
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 16 May 2004 09:03:35 -0700
Received: from gw01.mail.saunalahti.fi ([195.197.172.115])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BPO6x-00068X-Dt
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 16 May 2004 09:03:35 -0700
Received: from kuori.saunalahti.fi (kuori.saunalahti.fi [195.197.175.23])
	by gw01.mail.saunalahti.fi (Postfix) with ESMTP id AA4571148A53
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 16 May 2004 19:03:32 +0300 (EEST)
Content-Disposition: inline
In-Reply-To: <200405161513.15979.alex.kern@gmx.de>
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
To: fbdev <linux-fbdev-devel@lists.sourceforge.net>

On Sun, May 16, 2004 at 03:13:15PM +0200, Alexander Kern wrote:
> Hello, this is an addition to js + ak2,
>=20
> includes three patches from Ville Syrj=E4l=E4 and my "remove assert". T=
ested with=20
> 2.6.6, no regression, but proposed fix for 16 bit don't fixes "no pingu=
in=20
> logo by booting" issue. Ville, have you an another idea?

I haven't used the boot logo in 2.6 before so I didn't even know it had=20
problems. I just tried it and it's broken for both 555 and 565 16bpp=20
modes. What is this fix you mention?

--=20
Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/


-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
