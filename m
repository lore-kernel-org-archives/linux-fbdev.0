From: Daniel Vetter <daniel@ffwll.ch>
Date: Mon, 18 Jun 2018 09:23:06 +0000
Subject: Re: [PATCH 0/2] efifb: Copy the ACPI BGRT boot graphics to the
Message-Id: <20180618092306.GF22478@phenom.ffwll.local>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180617153235.16219-1-hdegoede@redhat.com>
In-Reply-To: <20180617153235.16219-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Hans de Goede <hdegoede@redhat.com>
Cc: linux-efi@vger.kernel.org, linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, dri-devel@lists.freedesktop.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>

On Sun, Jun 17, 2018 at 05:32:33PM +0200, Hans de Goede wrote:
> Hi All,
> 
> Here is a patch-set to make sure that the efifb contains the boot
> graphics from the ACPI BGRT extension when the kernel is configured
> to use the (new) deferred fbcon console takeover support.
> 
> Let me explain why this is desirable (same reason as for the deferred
> fbcon console takeover support itself):
> 
> Various (desktop oriented) Linux distributions have spend a lot of time
> to not show way too technial boot messages to end users during bootup.
> What we would really like for the boot experience is something like
> MacOS X / Windows 10 do. The (EFI) firmware boots up a logo and we
> leave that in place until the login-manager (e.g. gdm) starts and then
> the login-manager takes over the framebuffer including the current logo
> contents and fades that into the login screen.
> 
> The deferred fbcon console takeover (combined with shim and grub)
> patches makes the desired boot experience possible, but this assumes
> that the firmware starts shim with the framebuffer containing the
> boot graphics. This is not always the case, this patch ensures that the
> boot graphics are in place.
> 
> Since the bgrt.status field is not exactly reliable, this commit simply
> always copies over the bootgraphics. If they are already there this
> effectively is a no-op.
> 
> The first patch in this series makes a trivial change to
> drivers/firmware/efi/efi-bgrt.c, dropping __initdata from bgrt_image_size.
> 
> Ard, since the second patch depends on the first and the change is
> really trivial, can we please have your ack for merging the efi-bgrt.c
> change through the fbdev tree?

Random side-comment ... plans to roll out the same for drm drivers? With
the client infrastructure Noralf is working on doing that should be fairly
straight-forward. Interim step would be to add it to the shared fbdev
emulation layer (but that's a bit a hack, and precludes the use of this on
fbcon-less systems).
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
