From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: framebuffer ioctl
Date: Wed, 8 Sep 2004 18:47:54 -0400
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <9e47339104090815477e1adb14@mail.gmail.com>
References: <Pine.GSO.4.58.0409041304080.3434@waterleaf.sonytel.be>
	 <413B4925.5000706@comcast.net> <200409060926.07163.adaplas@hotpop.com>
	 <413CC0EA.8070709@comcast.net>
	 <9e4733910409061402372095b1@mail.gmail.com>
	 <1094505860.31465.211.camel@admin.tel.thor.asgaard.local>
	 <9e47339104090707172cdc258d@mail.gmail.com>
	 <1094572321.6095.10.camel@admin.tel.thor.asgaard.local>
	 <9e47339104090722437b81b373@mail.gmail.com>
	 <20040908135935.GA4661@sci.fi>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C5BEM-0007g1-J3
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 08 Sep 2004 15:47:58 -0700
Received: from rproxy.gmail.com ([64.233.170.206] helo=mproxy.gmail.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1C5BEL-0007eH-TF
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 08 Sep 2004 15:47:58 -0700
Received: by mproxy.gmail.com with SMTP id 79so8462rnl
        for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 08 Sep 2004 15:47:54 -0700 (PDT)
In-Reply-To: <20040908135935.GA4661@sci.fi>
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

On Wed, 8 Sep 2004 16:59:35 +0300, Ville Syrj=E4l=E4 <syrjala@sci.fi> wrote=
:
> I welcome you work on the drm since it appears to reduce the amount of
> unnecessary user space init code. When the drm gets easier to use other
> projects may adopt it.

Direct use of DRM will satisfy the goal of keeping all of the drivers
from stomping on each other. I would encourage you to consider using
mesa but there is no requirement to do so. There is a 300KB open
source OpenGL-ES implementation that could be ported to DRM if the
size of mesa is a problem.

I would encourage people with the skills to write video drivers to
come help with DRM instead of creating more conflicting drivers. A
short term goal for DRM is to integrate enough of fbdev in order to be
able to draw the console from kernel space. We also need help
implementing Alan's universal mode setting API since it doesn't exist
yet in any driver.

Most of the conflicts between DRM don't occur from base functionality
in fbdev and DRM, they originate in the chip specific drivers. It's
the chip specific drivers that need to be merged.

Merging DRM into fbdev instead of fbdev into DRM was also considered,
but the complexity of the DRM video memory manager made that too hard.
On the other hand, if I had known what I know now about how many
political problems merging fbdev into DRM was going to cause I would
have just rewritten the DRM memory manager for fbdev and done the
merge the other way. End result would be the same either way.

--=20
Jon Smirl
jonsmirl@gmail.com


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
