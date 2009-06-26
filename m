From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 18/19] drivers/video: Use PCI_VDEVICE
Date: Fri, 26 Jun 2009 09:35:26 -0700
Message-ID: <1246034126.18587.19.camel@Joe-Laptop.home>
References: <cover.1245906151.git.joe@perches.com>
	 <198c226b3dfd003881e7f95b3fbbc8d433804b01.1245906153.git.joe@perches.com>
	 <20090626095454.GH9980@sci.fi>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1760888AbZFZQfr@vger.kernel.org>
In-Reply-To: <20090626095454.GH9980@sci.fi>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="utf-8"
To: Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Cc: linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Russell King <linux@arm.linux.org.uk>, Antonino Daplas <adaplas@gmail.com>, Petr Vandrovec <vandrove@vc.cvut.cz>, Thomas Winischhofer <thomas@winischhofer.net>, linux-fbdev-devel@lists.sourceforge.net

On Fri, 2009-06-26 at 12:54 +0300, Ville Syrj=C3=A4l=C3=A4 wrote:
> Perhaps there should be a PCI_VDDEVICE() or something for this type o=
f
> stuff? Would make things even shorter.

drivers/edac/edac_core.h has:

#define PCI_VEND_DEV(vend, dev) PCI_VENDOR_ID_ ## vend, \
	PCI_DEVICE_ID_ ## vend ## _ ## dev

Try submitting a patch and see what happens...

> Also PCI_VDEVICE() does not use named initializers for some reason.
> Might be worth fixing.

Perhaps that's to avoid mixing named and unnamed initializers.

> It seems your script missed atyfb. It could use PCI_VDEVICE() too.

Can you show an example please?
