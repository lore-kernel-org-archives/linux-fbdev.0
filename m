From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: Move softcursor out of fbdev to fbcon
Date: Wed, 27 Jul 2005 10:32:50 -0400
Message-ID: <9e473391050727073269e33a44@mail.gmail.com>
References: <42E73C6E.1090205@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Dxocb-0006H1-6w
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 27 Jul 2005 09:19:05 -0700
Received: from wproxy.gmail.com ([64.233.184.193])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1Dxoca-0002Ob-Rm
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 27 Jul 2005 09:19:05 -0700
Received: by wproxy.gmail.com with SMTP id i3so218881wra
        for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 27 Jul 2005 09:18:58 -0700 (PDT)
In-Reply-To: <42E73C6E.1090205@gmail.com>
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
Content-Type: text/plain; charset="us-ascii"
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: James Simmons <jsimmons@infradead.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On 7/27/05, Antonino A. Daplas <adaplas@gmail.com> wrote:
> The changelog says it all. This is a modification of Jon's patch, but
> I have moved softcursor.c to the console directory.  Also I removed
> the "select FB_SOFTCURSOR" from video/Kconfig and made the compilation
> of softcursor unconditional, if framebuffer console is enabled.
>=20
> I don't think the fb_cursor hook is usable by other programs, so we
> should just restrict this hook for fbcon use only.  For userspace cursor
> support, we need a new one.  But instead of one function, I believe
> it's better to provide several.  Ie, something like below:
>=20
> fbcursor_show()
> fbcursor_move()
> fbcursor_loadimage()
> fbcursor_loadpalette()
> fbcursor_start()
> fbcursor_stop()

What does start/stop do?

>=20
> No need to pass all variables to just, say, move the cursor to x,y.
>=20
> And the next step is to eliminate all fbcon-specific fields from
> fb_info to another structure, such as fb_imageblit, fb_fillrect,
> fb_cursor, fb_copyarea.  We'll have a smaller kernel size for
> if fbcon is not enabled.

It has always bugged me that there was no real interface between
fbconsole and fbdev. For example I tried to write a wrapper for DRM so
that fbconsole could use DRM for accelerated console. But fbconsole is
so tied into the fbdev data structures writing the wrapper required me
to build most of an fbdev driver. I shouldn't need to do that,
fbconsole should not be poking at fb_info, it should use an API for
making changes.

>=20
> Comments?
>=20
> Tony

--=20
Jon Smirl
jonsmirl@gmail.com


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
