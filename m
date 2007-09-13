From: Timur Tabi <timur@freescale.com>
Subject: Re: Best way to support mulitple planes?
Date: Thu, 13 Sep 2007 16:29:31 -0500
Message-ID: <46E9ABBB.4040008@freescale.com>
References: <46E9949E.30908@freescale.com> <20070913211025.GB18714@sci.fi>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IVwFl-0002Ms-T4 for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 13 Sep 2007 14:29:38 -0700
Received: from az33egw01.freescale.net ([192.88.158.102])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IVwFk-0000oH-54
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 13 Sep 2007 14:29:37 -0700
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	l8DLTWZ1010440 for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 13 Sep 2007 14:29:32 -0700 (MST)
Received: from [10.82.19.119] (ld0169-tx32.am.freescale.net [10.82.19.119])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l8DLTVRA025045
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 13 Sep 2007 16:29:31 -0500 (CDT)
In-Reply-To: <20070913211025.GB18714@sci.fi>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net

Ville Syrj=E4l=E4 wrote:

> It is one way. At least omapfb does things the same way, and it has some
> custom ioctls to control the planes. =


Thanks, I'll take a look at it.

> Another way would be to have one
> fb device and implement support for the extra planes in user space.

Can you give me more details?  How exactly would I do that in user space?

> Perhaps return an error for any ioctls when the plane is not available,
> or implement a custom ioctl which carries that information. You could
> also leave that up to user space to know. It seems to me that you'll need
> a customized user space solution anyway (eg. a DirectFB gfx driver or a
> custom kdrive X server).

You might be right.

Would it be correct to say that applications expect the separate devices =

(/dev/fb0, /dev/fb1, etc) to represent different monitors?

As I said, our hardware does alpha-channel blending of the three planes ont=
o =

one display.  If an application opens /dev/fb1 and tries to draw on it, =

nothing appears because the alpha channel for each pixel defaults to 0, whi=
ch =

means full transparency.  So our hardware ignores the alpha channel for =

/dev/fb0 but not /dev/fb1 or /dev/fb2.

In addition, if the resolution is changed on /dev/fb0, it automatically =

changes for /dev/fb1 and /dev/fb2 as well.  Is there a mechanism for tellin=
g =

the application that the resolution has changed?

Do you know how DirectFB supports layers?  That is, what mechanism does =

DirectFB use to draw to one layer versus another layer?  I tried examining =
the =

DirectFB source, but I couldn't figure it out.

-- =

Timur Tabi
Linux Kernel Developer @ Freescale

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
