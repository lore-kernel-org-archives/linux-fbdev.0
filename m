From: Hans de Goede <hdegoede@redhat.com>
Date: Mon, 18 Jun 2018 09:30:53 +0000
Subject: Re: [PATCH 0/2] efifb: Copy the ACPI BGRT boot graphics to the
Message-Id: <6c3df020-1e7a-b4ce-7e5e-e7a4f759bc63@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180617153235.16219-1-hdegoede@redhat.com>
 <20180618092306.GF22478@phenom.ffwll.local>
In-Reply-To: <20180618092306.GF22478@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Daniel Vetter <daniel@ffwll.ch>
Cc: linux-efi@vger.kernel.org, linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, dri-devel@lists.freedesktop.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>

Hi,

On 18-06-18 11:23, Daniel Vetter wrote:
> On Sun, Jun 17, 2018 at 05:32:33PM +0200, Hans de Goede wrote:
>> Hi All,
>>
>> Here is a patch-set to make sure that the efifb contains the boot
>> graphics from the ACPI BGRT extension when the kernel is configured
>> to use the (new) deferred fbcon console takeover support.
>>
>> Let me explain why this is desirable (same reason as for the deferred
>> fbcon console takeover support itself):
>>
>> Various (desktop oriented) Linux distributions have spend a lot of time
>> to not show way too technial boot messages to end users during bootup.
>> What we would really like for the boot experience is something like
>> MacOS X / Windows 10 do. The (EFI) firmware boots up a logo and we
>> leave that in place until the login-manager (e.g. gdm) starts and then
>> the login-manager takes over the framebuffer including the current logo
>> contents and fades that into the login screen.
>>
>> The deferred fbcon console takeover (combined with shim and grub)
>> patches makes the desired boot experience possible, but this assumes
>> that the firmware starts shim with the framebuffer containing the
>> boot graphics. This is not always the case, this patch ensures that the
>> boot graphics are in place.
>>
>> Since the bgrt.status field is not exactly reliable, this commit simply
>> always copies over the bootgraphics. If they are already there this
>> effectively is a no-op.
>>
>> The first patch in this series makes a trivial change to
>> drivers/firmware/efi/efi-bgrt.c, dropping __initdata from bgrt_image_size.
>>
>> Ard, since the second patch depends on the first and the change is
>> really trivial, can we please have your ack for merging the efi-bgrt.c
>> change through the fbdev tree?
> 
> Random side-comment ... plans to roll out the same for drm drivers? With
> the client infrastructure Noralf is working on doing that should be fairly
> straight-forward. Interim step would be to add it to the shared fbdev
> emulation layer (but that's a bit a hack, and precludes the use of this on
> fbcon-less systems).

I had not really thought about this yet.

AFAICT the ACPI BGRT table is part of UEFI, so having it also means
having an UEFI framebuffer and I expect us to always use that to be
able to show error messages initializing the real drm/kms driver.

But I guess in the future the plan it to stop using the efifb
linux driver and instead use simple drm, then we will certainly
want this in drm.

And thinking more about this, currently I'm relying (for a
flickerfree experience) on the kms driver taking over the fb
setup by the firmware.  But I guess it may not always succeed and
if it does not succeed, then restoring the bootgraphics
(on a quiet boot) would be good too.

Once I've everything upstream to make flickerfree work for i915 I plan
to look at the amd / nouveau cases next. For those adding BGRT graphics
restoration to the drm drivers might make for a good quick fix. We
would still get a flicker from the modeset but at least the screen
would not be just black until the gui loads if we restore the boot
graphics from the drm driver and I guess we could prime the fb with
the bootgraphics before the modeset to make the flicker as small
as possible.

Regards,

Hans
