From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: Re: Move softcursor out of fbdev to fbcon
Date: Wed, 27 Jul 2005 15:05:14 -0400
Message-ID: <9e47339105072712055044d08e@mail.gmail.com>
References: <42E73C6E.1090205@gmail.com>
	 <9e473391050727073269e33a44@mail.gmail.com>
	 <42E7D77F.6020005@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DxrEV-0000F3-AO
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 27 Jul 2005 12:06:23 -0700
Received: from externalmx-1.sourceforge.net ([12.152.184.25])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1DxrET-0003Rk-V7
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 27 Jul 2005 12:06:23 -0700
Received: from wproxy.gmail.com ([64.233.184.199])
	by externalmx-1.sourceforge.net with esmtp (Exim 4.41)
	id 1DxrES-0004UL-VY
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 27 Jul 2005 12:06:21 -0700
Received: by wproxy.gmail.com with SMTP id i3so250354wra
        for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 27 Jul 2005 12:05:14 -0700 (PDT)
In-Reply-To: <42E7D77F.6020005@gmail.com>
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
To: linux-fbdev-devel@lists.sourceforge.net, "Antonino A. Daplas" <adaplas@hotpop.com>
Cc: James Simmons <jsimmons@infradead.org>

On 7/27/05, Antonino A. Daplas <adaplas@gmail.com> wrote:
> Jon Smirl wrote:
> > On 7/27/05, Antonino A. Daplas <adaplas@gmail.com> wrote:
> >> The changelog says it all. This is a modification of Jon's patch, but
> >> I have moved softcursor.c to the console directory.  Also I removed
> >> the "select FB_SOFTCURSOR" from video/Kconfig and made the compilation
> >> of softcursor unconditional, if framebuffer console is enabled.
> >>
> >> I don't think the fb_cursor hook is usable by other programs, so we
> >> should just restrict this hook for fbcon use only.  For userspace curs=
or
> >> support, we need a new one.  But instead of one function, I believe
> >> it's better to provide several.  Ie, something like below:
> >>
> >> fbcursor_show()
> >> fbcursor_move()
> >> fbcursor_loadimage()
> >> fbcursor_loadpalette()
> >> fbcursor_start()
> >> fbcursor_stop()
> >
> > What does start/stop do?
>=20
> Wrong choice of words, this is just an example.  But start() should tell
> the driver that the cursor is going to be used, and perhaps do some locki=
ng (so
> another app does not try to grab the device).  It can also return the
> capabilities of the cursor: maximum dimensions, color depth of image,
> caps such as alpha, transparency, etc.  stop() will release the cursor.

In the sysfs model I'd do something like this. Most attributes are read/wri=
te.
cursor_visible -- 0/1 hide/show
cursor_location -- x,y
cursor_image -- image bitmap
cursor_palette -- pallete data
cursor_capabilities -- read only

An owner could have a lot of problems, what if the owning apps dies?
There is no open file handle in the sysfs model. I would just assume
that ownership is handled in the upper layers.

Sysfs is still an experiment to see if it really can handle everything
the IOCTLs do.

--=20
Jon Smirl
jonsmirl@gmail.com


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO September
19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
