From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: [PATCH 18/19] drivers/video: Use PCI_VDEVICE
Date: Fri, 26 Jun 2009 20:31:05 +0300
Message-ID: <20090626173105.GI9980@sci.fi>
References: <cover.1245906151.git.joe@perches.com> <198c226b3dfd003881e7f95b3fbbc8d433804b01.1245906153.git.joe@perches.com> <20090626095454.GH9980@sci.fi> <1246034126.18587.19.camel@Joe-Laptop.home>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1760701AbZFZRbT@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1246034126.18587.19.camel@Joe-Laptop.home>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="iso-8859-1"
To: Joe Perches <joe@perches.com>
Cc: linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Russell King <linux@arm.linux.org.uk>, Antonino Daplas <adaplas@gmail.com>, Petr Vandrovec <vandrove@vc.cvut.cz>, Thomas Winischhofer <thomas@winischhofer.net>, linux-fbdev-devel@lists.sourceforge.net

On Fri, Jun 26, 2009 at 09:35:26AM -0700, Joe Perches wrote:
> On Fri, 2009-06-26 at 12:54 +0300, Ville Syrj=E4l=E4 wrote:
> > Perhaps there should be a PCI_VDDEVICE() or something for this type=
 of
> > stuff? Would make things even shorter.
>=20
> drivers/edac/edac_core.h has:
>=20
> #define PCI_VEND_DEV(vend, dev) PCI_VENDOR_ID_ ## vend, \
> 	PCI_DEVICE_ID_ ## vend ## _ ## dev
>=20
> Try submitting a patch and see what happens...

Too lazy. I was thinking that since you're already looking at
this stuff you might be tricked into doing some more work.

> > It seems your script missed atyfb. It could use PCI_VDEVICE() too.
>=20
> Can you show an example please?

I didn't read you script and didn't look at the patches too closely. It
seems you only converted the open-coded stuff and not stuff already
using the PCI_DEVICE() macro. atyfb falls into this category.

--=20
Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/
