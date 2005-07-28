From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: Re: [PATCH] fbdev: colormap fixes
Date: Thu, 28 Jul 2005 16:21:19 -0400
Message-ID: <9e47339105072813213db7cee4@mail.gmail.com>
References: <200507280031.j6S0V3L3016861@hera.kernel.org>
	 <Pine.LNX.4.62.0507280952140.24391@numbat.sonytel.be>
	 <9e473391050728060741040424@mail.gmail.com>
	 <42E8F0CD.6070500@gmail.com>
	 <Pine.LNX.4.62.0507281758080.24391@numbat.sonytel.be>
	 <9e473391050728092936794718@mail.gmail.com>
	 <9e47339105072811183ac0f008@mail.gmail.com>
	 <Pine.LNX.4.62.0507282202450.29876@numbat.sonytel.be>
	 <9e4733910507281315419c3c12@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DyEsn-0003Mb-Sm
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 28 Jul 2005 13:21:33 -0700
Received: from wproxy.gmail.com ([64.233.184.201])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1DyEsn-0005Zd-0t
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 28 Jul 2005 13:21:34 -0700
Received: by wproxy.gmail.com with SMTP id i3so500250wra
        for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 28 Jul 2005 13:21:20 -0700 (PDT)
In-Reply-To: <9e4733910507281315419c3c12@mail.gmail.com>
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
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "Antonino A. Daplas" <adaplas@gmail.com>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Development <linux-kernel@vger.kernel.org>

On 7/28/05, Jon Smirl <jonsmirl@gmail.com> wrote:
> On 7/28/05, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Thu, 28 Jul 2005, Jon Smirl wrote:
> > > I can't see a way to query how long of cmap the device supports using
> > > the current fbdev ioctls.
> >
> > Look at the lengths of the color bitfields?
>=20
> Which color bitfields? Does hardware that supports 10bit cmap also
> support a 10:10:10 framebuffer? If you can't do 10:10:10 how do the
> 10bit cmaps work?  Does alpha matter in a 10:10:10 scanout buffer?

From the OpenGL headers I can see the answer to my questions...
#define GL_RGB10                                0x8052
#define GL_RGB10_A2                          0x8059

OpenGL supports all of these:
#define GL_RGB10                                0x8052
#define GL_RGB12                                0x8053
#define GL_RGB16                                0x8054
#define GL_RGB10_A2                          0x8059
#define GL_RGBA12                               0x805A
#define GL_RGBA16                               0x805B

Are there 12 and 16 bit cmaps too?

--=20
Jon Smirl
jonsmirl@gmail.com


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO September
19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
