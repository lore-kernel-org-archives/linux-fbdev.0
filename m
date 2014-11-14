From: Henrik Rydberg <rydberg@euromail.se>
Date: Fri, 14 Nov 2014 15:07:00 +0000
Subject: Re: [PATCH] x86, ia64: Do not lose track of the EFI default VGA device
Message-Id: <54661A94.4000107@euromail.se>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1415969610-1469-1-git-send-email-rydberg@euromail.se> <20141114154252.0fb66bba@pluto.restena.lu>
In-Reply-To: <20141114154252.0fb66bba@pluto.restena.lu>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: =?UTF-8?B?QnJ1bm8gUHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
Cc: Peter Jones <pjones@redhat.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Bjorn Helgaas <bhelgaas@google.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On 11/14/2014 03:42 PM, Bruno Pr=C3=A9mont wrote:
> On Fri, 14 Nov 2014 13:53:30 +0100 Henrik Rydberg wrote:
>> Since commit 20cde694027e ("x86, ia64: Move EFI_FB
>> vga_default_device() initialization to pci_vga_fixup()") in the 3.17
>> merge window, the EFI framebuffer depends on the VGA arbitration
>> layer. However, the configuration does not reflect this, which leads
>> to a hard-to-find bug when FB_EFI is configured without VGA_ARB. Add a
>> select clause to remedy this.
>=20
> Could you be more verbose in why it depends on/needs VGA_ARB?

When the EFI framebuffer is configured but not VGA_ARB, the kernel manages =
to
lose track of the default VGA device in some cases. As a result, the X11
nouveau driver fails on my MacBookAir3,1 (GeForce 320M, nv50, 0xaf), which
is booting in EFI_STUB mode.

The code to select the right PCI device was literally moved from efifb.c to=
 the
internals of vgaarb. The PCI sysfs layer seems to depend on
vga_default_device(), which is only defined when VGA_ARB is set.

> With EFI starting to show up on ARM this is not necessarily true
> (no PCI -> no VGA_ARB arbitration).
>=20
> So it would need to at least be select VGA_ARB if (PCI && !S390)
> in order to not have broken kernel configuration (in more or less
> exotic cases) while depends on VGA_ARB would be the only correct option
> if the rule 'select only allowed for leafs' is enforced.

I agree that the tie probably should be somewhere else. I am fine with any
combination of flags that respects the fact that efifb used to define
vga_default_device(), apparently for good reason.

Thanks,
Henrik

