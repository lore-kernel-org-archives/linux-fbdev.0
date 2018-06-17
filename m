From: Hans de Goede <hdegoede@redhat.com>
Date: Sun, 17 Jun 2018 15:32:33 +0000
Subject: [PATCH 0/2] efifb: Copy the ACPI BGRT boot graphics to the
Message-Id: <20180617153235.16219-1-hdegoede@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-fbdev@vger.kernel.org, linux-efi@vger.kernel.org, dri-devel@lists.freedesktop.org

Hi All,

Here is a patch-set to make sure that the efifb contains the boot
graphics from the ACPI BGRT extension when the kernel is configured
to use the (new) deferred fbcon console takeover support.

Let me explain why this is desirable (same reason as for the deferred
fbcon console takeover support itself):

Various (desktop oriented) Linux distributions have spend a lot of time
to not show way too technial boot messages to end users during bootup.
What we would really like for the boot experience is something like
MacOS X / Windows 10 do. The (EFI) firmware boots up a logo and we
leave that in place until the login-manager (e.g. gdm) starts and then
the login-manager takes over the framebuffer including the current logo
contents and fades that into the login screen.

The deferred fbcon console takeover (combined with shim and grub)
patches makes the desired boot experience possible, but this assumes
that the firmware starts shim with the framebuffer containing the
boot graphics. This is not always the case, this patch ensures that the
boot graphics are in place.

Since the bgrt.status field is not exactly reliable, this commit simply
always copies over the bootgraphics. If they are already there this
effectively is a no-op.

The first patch in this series makes a trivial change to
drivers/firmware/efi/efi-bgrt.c, dropping __initdata from bgrt_image_size.

Ard, since the second patch depends on the first and the change is
really trivial, can we please have your ack for merging the efi-bgrt.c
change through the fbdev tree?

Regards,

Hans

