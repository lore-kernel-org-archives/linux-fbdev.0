From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: Adding overlays
Date: Fri, 11 Feb 2005 07:32:23 +0200
Message-ID: <20050211053223.GA16480@sci.fi>
References: <20050210145634.34525.qmail@web53606.mail.yahoo.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CzTPo-00078W-8r
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 10 Feb 2005 21:32:28 -0800
Received: from gw01.mail.saunalahti.fi ([195.197.172.115])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CzTPm-0002lf-P4
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 10 Feb 2005 21:32:28 -0800
Received: from kuori.saunalahti.fi (kuori.saunalahti.fi [195.197.175.23])
	by gw01.mail.saunalahti.fi (Postfix) with ESMTP id 7A8E3D405C
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 11 Feb 2005 07:32:23 +0200 (EET)
Content-Disposition: inline
In-Reply-To: <20050210145634.34525.qmail@web53606.mail.yahoo.com>
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

On Thu, Feb 10, 2005 at 06:56:34AM -0800, Komal Shah wrote:
> Hi All,
>=20
> I am a newbie into this overlay stuff. Let me explain
> my confusion first:
>=20
> 1. I have a display controller hardware which support
> "primary buffer window", "video1 window", "video2
> window". video2 on top of -> video 1 on top of ->
> primary.
>=20
> Now primay buffer window is used by /dev/fb for normal
> framebuffer support.=20
>=20
> 2. Now I want to utilize overlay support given by
> "video1 and 2", to have two playbacks/previews.
>=20
> What should I do/use the interface to get this overlay
> support given my video1 and video2 windows?? Ofcourse
> I need to get around by setting lots of hardware
> specific values...

Userspace: DirectFB, VIDIX, XFree86/XOrg
Kernel: mga_vid style module

I'm not sure about v4l. Does it work as a purely output device? Even if=20
it does I don't think many apps support it as such.

--=20
Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
