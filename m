From: =?iso-8859-1?q?alain=20volmat?= <avolmat@yahoo.fr>
Subject: Re: Framebuffer with banked memory
Date: Thu, 31 Oct 2002 05:02:28 +0100 (CET)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20021031040228.12091.qmail@web14205.mail.yahoo.com>
References: <1036024422.643.24.camel@daplas>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from web14205.mail.yahoo.com ([216.136.172.151])
	by usw-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 1876XN-0007ho-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 30 Oct 2002 20:02:29 -0800
In-Reply-To: <1036024422.643.24.camel@daplas>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="iso-8859-1"
To: Antonino Daplas <adaplas@pol.net>
Cc: linux-fbdev-devel@lists.sourceforge.net

> The safest solution is to create custom fb_write?
> and fb_read? routines.
> Maybe James will add these hooks for hardware like
> yours.
> Then disallow mmap's except probably for the MMIO
> regions.
>=20

What about adding fb_write / fb_read function in the
framebuffer (device dependant) driver. The same way as
for fb_mmap. I saw that at the beginning of fb_mmap in
fbmem.c, there is a test to see if the device driver
contains its own fb_mmap function, if so the device
driver fb_mmap will be used instead of the "generic"
fb_mmap. What about doing the same thing for fb_write
/ fb_read.

> PS:  What's your hardware?
Well actually it's a custom chip.

Alain

 --- Antonino Daplas <adaplas@pol.net> a =E9crit=A0: > On
Wed, 2002-10-30 at 18:49, alain volmat wrote:
> > Hi,
> >=20
> > As I said the video card I am now writing a
> > framebuffer for, doesn't have linear memory, which
> > means that I can only access a small part of the
> > memory at a time and then set offset registers in
> > order to access another part of the memory.
> >=20
> > I would like to know if there is such case in
> current
> > framebuffer drivers ?? If so, what is the common
> > solution to do that ??
> None in the current drivers. =20
>=20
> >=20
> > In fact the problem remains in the case of mmap
> (which
> > is the most common ;( of course), since the memory
> > seams to be accessed directly by pointer, there
> might
> > be no wait to detect if we need to set or not an
> > offset. In case of fb_read fb_write, it is
> possible to
> > do that before the actual write at the end (even
> if it
> > is not sooo beautiful ... ).
> The safest solution is to create custom fb_write?
> and fb_read? routines.
> Maybe James will add these hooks for hardware like
> yours.
> Then disallow mmap's except probably for the MMIO
> regions.
>=20
> Creating a bank-switching mechanism, besides
> entailing a lot of work, is
> not entirely safe.
>=20
> Tony
>=20
> PS:  What's your hardware?
>=20
>=20
>=20


___________________________________________________________
Do You Yahoo!? -- Une adresse @yahoo.fr gratuite et en fran=E7ais !
Yahoo! Mail : http://fr.mail.yahoo.com


-------------------------------------------------------
This sf.net email is sponsored by: Influence the future=20
of Java(TM) technology. Join the Java Community=20
Process(SM) (JCP(SM)) program now.=20
http://ads.sourceforge.net/cgi-bin/redirect.pl?sunm0004en
