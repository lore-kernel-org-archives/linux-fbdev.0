From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
Date: Fri, 14 Nov 2014 22:11:26 +0000
Subject: Re: [PATCH] x86, ia64: Do not lose track of the EFI default VGA device
Message-Id: <20141114231126.7a0d45c1@neptune.home>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1415969610-1469-1-git-send-email-rydberg@euromail.se>
	<20141114154252.0fb66bba@pluto.restena.lu>
	<20141114191157.GA1648@polaris.bitmath.org>
In-Reply-To: <20141114191157.GA1648@polaris.bitmath.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Henrik Rydberg <rydberg@euromail.se>
Cc: linux-fbdev@vger.kernel.org, Peter Jones <pjones@redhat.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org

Hi Hendrick,

On Fri, 14 November 2014 Henrik Rydberg <rydberg@euromail.se> wrote:
> > So it would need to at least be select VGA_ARB if (PCI && !S390)
> > in order to not have broken kernel configuration (in more or less
> > exotic cases) while depends on VGA_ARB would be the only correct option
> > if the rule 'select only allowed for leafs' is enforced.
>=20
> Here is a tested patch that does just that, thanks for the suggestion.

Sure it will cover your case but with a few issues.

As you might have noted, VGA_ARB can only be disabled if you select
EXPERT. In that case you kind of give up warranty.

In addition, prior to the patches that landed in 3.17, just selecting
X86_SYSFB would runtime-disable EFI_FB disabling boot_vga tagging
based on screen_info as well.

Stating in the commit message that EFI_FB depends on VGA_ARB is pretty
wrong. A more correct phrasing would be that before the commit EFI_FB
included boot_vga detection which has been moved around, but that
feature is not inherent to EFI_FB. Doing the select only keeps
`make oldconfig` provide the same feature set.




As boot_vga is a PCI thing maybe the whole detection should effectively
be fully dissociated from runtime GPU switching and be adjusted to
really only flag the boot GPU (even when there is no VGA around).

Unfortunately this attribute is not explicitly documented so drawing the
line one way or another may trip on some user's feet.

We have some more or less conflicting information in commit messages though:

217f45de3d2 by Dave Airlie introducing boot_vgain 2009:
    PCI: expose boot VGA device via sysfs.
   =20
    X really would like to know which VGA device was considered the boot
    device by the system. The x86 PCI fixups have support for discovering
    this but we provide no way to expose it to userspace.
   =20
    This adds a sysfs file per VGA class device which has the value 0 for
    non the boot device or unknown, and 1 if the VGA device is the boot
    device.

1a39b310e92 by Matthew Garrett making it variable in 2012:
    vgaarb: Add support for setting the default video device (v2)
   =20
    The default VGA device is a somewhat fluid concept on platforms with
    multiple GPUs. Add support for setting it so switching code can update
    things appropriately, and make sure that the sysfs code returns the rig=
ht
    device if it's changed.

So should boot_vga now represent the main GPU of the system or should
it represent the one(s) that were used for booting? (I've not heard
of systems with more than one active firmware GPU... but why not!

Matthew covered the case where multiple GPUs are in a set where only one
of them can be active as in driving displays. Maybe this would need some
alternative sysfs attribute kind of "preferred_gpu".

Bruno


> From 43c16bbc7adbcb17aac73d09f046bf2779771c4c Mon Sep 17 00:00:00 2001
> From: Henrik Rydberg <rydberg@euromail.se>
> Date: Fri, 14 Nov 2014 20:01:21 +0100
> Subject: [PATCH v2] x86, ia64: Do not lose track of the EFI default VGA d=
evice
> MIME-Version: 1.0
> Content-Type: text/plain; charset=3DUTF-8
> Content-Transfer-Encoding: 8bit
>=20
> Since commit 20cde694 in the 3.17 merge window, the EFI framebuffer
> depends on the VGA arbitration layer. However, the configuration does
> not reflect this, which leads to a hard-to-find bug when FB_EFI is
> configured without VGA_ARB. Add a select clause to remedy this.
>=20
> Cc: Bruno Pr=C3=A9mont <bonbons@linux-vserver.org>
> Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
> ---
>  drivers/video/fbdev/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
> index c7bf606..1615a1b 100644
> --- a/drivers/video/fbdev/Kconfig
> +++ b/drivers/video/fbdev/Kconfig
> @@ -761,6 +761,7 @@ config FB_EFI
>  	select FB_CFB_FILLRECT
>  	select FB_CFB_COPYAREA
>  	select FB_CFB_IMAGEBLIT
> +	select VGA_ARB if (PCI && !S390)
>  	help
>  	  This is the EFI frame buffer device driver. If the firmware on
>  	  your platform is EFI 1.10 or UEFI 2.0, select Y to add support for
