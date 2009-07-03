From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: 
	[linux-fbdev-devel][PATCH]fb_pan_display:add x/yoffset check
Date: Fri, 3 Jul 2009 18:30:29 +0300
Message-ID: <20090703153029.GK9980@sci.fi>
References: <4A4839CB.8020801@freescale.com> <20090629103936.GJ9980@sci.fi>
	<4A4985C0.2040800@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <syrjala@sci.fi>) id 1MMkiq-0000bO-2v
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 03 Jul 2009 15:30:44 +0000
Received: from smtp6.welho.com ([213.243.153.40])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MMkil-0005KP-9H for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 03 Jul 2009 15:30:44 +0000
Content-Disposition: inline
In-Reply-To: <4A4985C0.2040800@freescale.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Kai Jiang <b18973@freescale.com>
Cc: linux-fbdev-devel@lists.sourceforge.net

On Tue, Jun 30, 2009 at 11:25:52AM +0800, Kai Jiang wrote:
> =

> xres,yres,xres_virtual,yres_virtual will be set in the display driver, th=
ey have actual value which match the screen(will not very huge).
> =

> And here, these lines are not checking the overflowing, but checking whet=
her the virtual space display is beyond the real screen.
> =

> Take x boundary for example:(the screen x and virtual x relationship shou=
ld be:)
> xres+xoffset<xres_vritual && xoffset>0
> This insure that, in the real screen, there are virtual picture display i=
n the screen. When we move the virtual picture to the left, the xoffset wil=
l be smaller and smaller
> to indicate the virtual picture is moving to the left. Finally, the xoffs=
et will be zero when the screen left boundary and virtual picture left boun=
dary overlap. When virtual display is still moving to the left, the xoffset=
 will be negative. And what should be displayed in the gap between screen l=
eft boundary and virtual space left boundary?

If you're storing negative values into xoffset/yoffset your application
is buggy. Just fix it.

> So here we have to check the whether the x/yoffset is smaller than zero. =
If the offset is smaller than zero, in the driver, we should not move the v=
irtual screen any more.

Checking for overflow will catch you buggy application's negative
values too.

-- =

Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/

---------------------------------------------------------------------------=
---
