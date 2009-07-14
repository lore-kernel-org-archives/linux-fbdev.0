From: Ali Gholami Rudi <ali@rudi.ir>
Subject: Re: [PATCH 0/2] fbdev: add fillrect and copyarea ioctls
Date: Tue, 14 Jul 2009 08:13:53 +0430
Message-ID: <20090714034353.GA1280@lilem.mirepesht>
References: <20090713151709.GA1297@lilem.mirepesht>
 <20090713084058.547e88f0@infradead.org>
 <20090713162559.GA1279@lilem.mirepesht>
 <21d7e9970907131746q4f1a34efw9d3e6efaa78aea34@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753337AbZGNDmK@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <21d7e9970907131746q4f1a34efw9d3e6efaa78aea34@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="iso-8859-1"
To: Dave Airlie <airlied@gmail.com>
Cc: Arjan van de Ven <arjan@infradead.org>, fbdev <linux-fbdev-devel@lists.sourceforge.net>, Andrew Morton <akpm@linux-foundation.org>, Andrea Righi <righi.andrea@gmail.com>, Krzysztof Helt <krzysztof.h1@wp.pl>, Greg Kroah-Hartman <gregkh@suse.de>, Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>, Philippe De Muyter <phdm@macqel.be>, linux-kernel@vger.kernel.org

Dave Airlie <airlied@gmail.com> wrote:
> On Tue, Jul 14, 2009 at 2:25 AM, Ali Gholami Rudi<ali@rudi.ir> wrote:
> > Arjan van de Ven <arjan@infradead.org> wrote:
> >> can we turn this around, is there a reason to add them?
> >> or in other words, how / where would these be used ?
> >
> > User-space programs that use framebuffer directly can use them. =A0=
I was
> > writing a simple framebuffer virtual terminal (using libfreetype fo=
r
> > fonts; like fbterm); scrolling and painting boxes would be faster i=
f
> > there was someway of using hardware accelerated operations. =A0I th=
ink
> > other similar programs can benefit, too.
>=20
> The general opinion is we should keep acceleration in userspace if at
> all possible.

I see.  The line between user- and kernel-space for graphic application=
s
is very blurred to me :-)

> Not all hw can implement these usefully in the kernel, directfb

AFAICT, many major ones like intelfb, radeonfb and nv implement them an=
d
those that can't, use a software implementation.  You mean they are
unreliable or that there is little performance improvement because of
the way those operations are implemented in the kernel?

> already does some
> things for this.

Sometime ago I did try running directfb on a radeon r300 and it failed.
I didn't try hard to see what's wrong but I got the impression that
userspace apps are not good at using the hardware directly.

	Ali
