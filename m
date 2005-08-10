From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: cursor maddnes and a solution
Date: Wed, 10 Aug 2005 11:51:24 -0400
Message-ID: <9e47339105081008517561bfbc@mail.gmail.com>
References: <Pine.LNX.4.56.0508090115420.2749@pentafluge.infradead.org>
	 <42F99B5E.1070309@gmail.com>
	 <9e4733910508092358360f8bc8@mail.gmail.com>
	 <42F9B1C3.2030201@gmail.com>
	 <9e473391050810062531d77aa7@mail.gmail.com>
	 <42FA1F55.5010801@varma-el.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E2srg-0005Uu-FJ
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 10 Aug 2005 08:51:36 -0700
Received: from wproxy.gmail.com ([64.233.184.201])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1E2srf-0004vy-9O
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 10 Aug 2005 08:51:36 -0700
Received: by wproxy.gmail.com with SMTP id i3so153105wra
        for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 10 Aug 2005 08:51:24 -0700 (PDT)
In-Reply-To: <42FA1F55.5010801@varma-el.com>
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
To: Andrey Volkov <avolkov@varma-el.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, "Antonino A. Daplas" <adaplas@gmail.com>, James Simmons <jsimmons@infradead.org>

On 8/10/05, Andrey Volkov <avolkov@varma-el.com> wrote:
>=20
>=20
> Jon Smirl wrote:
> > On 8/10/05, Antonino A. Daplas <adaplas@gmail.com> wrote:
> >
> >>struct fb_cursor_ops {
> >>        int (*cursor_move)(int x, int y);
> >>        int (*cursor_show)(int show);
> >>        int (*cursor_load_image)(u32 *image, int width, int height);
> >>        int (*cursor_load_color)(struct fb_cmap *cmap);
> >>        int (*cursor_set_size)(int width, int height);
> >>        int (*cursor_capabilities)(int set, int caps);
> >>};
> >
> >
> > Doen't fb already support an image format with embedded color map? Can
> > we use it and merge:
> >
> >>        int (*cursor_load_image)(u32 *image, int width, int height);
> >>        int (*cursor_load_color)(struct fb_cmap *cmap);
> >
> >
> > The size can also be computed from the image so the size call can be el=
iminated.
> >
> You are omit hwd cursor size problem - very few (possible no one)
> graphics chips could support cursor with any size. Usually they support
> 32x32/64x64 pixels cursors only. For kernel fb its have not meaning,
> 'cause we always could fallback to the soft_cursor (in the fbcon or
> directly in a driver), BUT what to do with such crazy user who will wish
> to use, ex. 100x100 pix cursor in user space?

You would just get an error back if the hardware cursor doesn't
support the big size. Your user space app would then have to implement
a fallback software one. You always have to implement the software
fallback since not all hardware may expose the cursor.

You can't implement the software cursor for user space in the kernel
because there is no way to synchronize it with user space drawing. I
think the better solution is for user space apps to handle it than to
try and build a synchronization system into fbdev.

If you are writing X apps you don't have to deal with any of this, X
handles it all for you.

--=20
Jon Smirl
jonsmirl@gmail.com


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
