From: Komal Shah <komal_shah802003@yahoo.com>
Subject: Re: Adding overlays
Date: Thu, 10 Feb 2005 22:36:20 -0800 (PST)
Message-ID: <20050211063620.39583.qmail@web53603.mail.yahoo.com>
References: <20050211053223.GA16480@sci.fi>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CzUPj-0001Sn-Nn
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 10 Feb 2005 22:36:27 -0800
Received: from web53603.mail.yahoo.com ([206.190.37.36])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1CzUPi-0002TX-6h
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 10 Feb 2005 22:36:27 -0800
In-Reply-To: <20050211053223.GA16480@sci.fi>
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
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev-devel@lists.sourceforge.net

--- Ville Syrj=E4l=E4 <syrjala@sci.fi> wrote:
>=20
> Userspace: DirectFB, VIDIX, XFree86/XOrg
> Kernel: mga_vid style module
>=20
> I'm not sure about v4l. Does it work as a purely
> output device? Even if=20
> it does I don't think many apps support it as such.

Ok. I have downloaded mga_vid - matrox driver for YUV
video interface. It is similar to what I had thought
of like /dev/overlay1/2 as character devices and not
touching the primary buffer(fb memory) and to write
directly on video1 or video2 overlay buffer memory.=20

But is it possible to add "ioctls" base interface for
overlay (may be like in "kyro" fb driver) to get it
done, so we don't write separate driver.=20



=3D=3D=3D=3D=3D
---Komal Shah


	=09
__________________________________=20
Do you Yahoo!?=20
The all-new My Yahoo! - What will yours do?
http://my.yahoo.com=20


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=3D6595&alloc_id=3D14396&op=3Dclick
