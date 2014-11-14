From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
Date: Fri, 14 Nov 2014 14:42:52 +0000
Subject: Re: [PATCH] x86, ia64: Do not lose track of the EFI default VGA device
Message-Id: <20141114154252.0fb66bba@pluto.restena.lu>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1415969610-1469-1-git-send-email-rydberg@euromail.se>
In-Reply-To: <1415969610-1469-1-git-send-email-rydberg@euromail.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Peter Jones <pjones@redhat.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Bjorn Helgaas <bhelgaas@google.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, 14 Nov 2014 13:53:30 +0100 Henrik Rydberg wrote:
> Since commit 20cde694027e ("x86, ia64: Move EFI_FB
> vga_default_device() initialization to pci_vga_fixup()") in the 3.17
> merge window, the EFI framebuffer depends on the VGA arbitration
> layer. However, the configuration does not reflect this, which leads
> to a hard-to-find bug when FB_EFI is configured without VGA_ARB. Add a
> select clause to remedy this.

Could you be more verbose in why it depends on/needs VGA_ARB?

With EFI starting to show up on ARM this is not necessarily true
(no PCI -> no VGA_ARB arbitration).


So it would need to at least be select VGA_ARB if (PCI && !S390)
in order to not have broken kernel configuration (in more or less
exotic cases) while depends on VGA_ARB would be the only correct option
if the rule 'select only allowed for leafs' is enforced.

Bruno

> Cc: Bruno Pr=C3=A9mont <bonbons@linux-vserver.org>
> Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
> ---
> Hi Peter,
>=20
> I stumbled upon this bug from the 3.17 merge window when updating to
> Linus's 3.18 git head yesterday. The patch has been tested on two
> different EFI machines; one that needs the patch and one that does not.
>=20
> Thanks,
> Henrik
>=20
>  drivers/video/fbdev/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
> index c7bf606..81b21bc 100644
> --- a/drivers/video/fbdev/Kconfig
> +++ b/drivers/video/fbdev/Kconfig
> @@ -761,6 +761,7 @@ config FB_EFI
>  	select FB_CFB_FILLRECT
>  	select FB_CFB_COPYAREA
>  	select FB_CFB_IMAGEBLIT
> +	select VGA_ARB
>  	help
>  	  This is the EFI frame buffer device driver. If the firmware on
>  	  your platform is EFI 1.10 or UEFI 2.0, select Y to add support for
