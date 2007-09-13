From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: Best way to support mulitple planes?
Date: Fri, 14 Sep 2007 00:10:25 +0300
Message-ID: <20070913211025.GB18714@sci.fi>
References: <46E9949E.30908@freescale.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IVvxH-0000Q9-HK for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 13 Sep 2007 14:10:31 -0700
Received: from smtp5.pp.htv.fi ([213.243.153.39])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IVvxF-0008BE-NY
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 13 Sep 2007 14:10:31 -0700
Content-Disposition: inline
In-Reply-To: <46E9949E.30908@freescale.com>
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

On Thu, Sep 13, 2007 at 02:50:54PM -0500, Timur Tabi wrote:
> Hi, I'm new to the framebuffer subsystem, so forgive me if this is a FAQ. =

> I've spent the past couple hours scouring web sites and sample code, but =
I =

> don't have a definitive answer to my question.
> =

> I have a device that supports three planes - memory areas that the hardwa=
re =

> reads from to generate the physical image.  Each plane supports an alpha =

> channel for each pixel, and the hardware just blends all three planes tog=
ether =

> when it draws the image.
> =

> Currently, our driver create three framebuffer devices, /dev/fb0, /dev/fb=
1, =

> and /dev/fb2, which means three calls to register_framebuffer().  Is this=
 the =

> correct way to do it?

It is one way. At least omapfb does things the same way, and it has some
custom ioctls to control the planes. Another way would be to have one
fb device and implement support for the extra planes in user space.

> The reason I ask is that our hardware can only handle three planes if the =

> resolution is 1024x768 or below.  I can't figure out any way of telling t=
he =

> framebuffer subsystem that if it switches to 1280x1024 in plane 0, that p=
lane =

> 1 and 2 no longer exist.  Any suggestions on how to handle that?

Perhaps return an error for any ioctls when the plane is not available,
or implement a custom ioctl which carries that information. You could
also leave that up to user space to know. It seems to me that you'll need
a customized user space solution anyway (eg. a DirectFB gfx driver or a
custom kdrive X server).

-- =

Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
