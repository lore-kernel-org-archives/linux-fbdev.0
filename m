From: Jani Nikula <jani.nikula@linux.intel.com>
Date: Mon, 28 May 2018 13:56:46 +0000
Subject: Re: [PATCH 0/1] console/fbcon: Add support for deferred console takeover
Message-Id: <87fu2bj2wv.fsf@intel.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180528133042.29675-1-hdegoede@redhat.com>
In-Reply-To: <20180528133042.29675-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org

On Mon, 28 May 2018, Hans de Goede <hdegoede@redhat.com> wrote:
> Various (desktop oriented) Linux distributions have spend a lot of time
> to not show way too technial boot messages to end users during bootup.
> What we would really like for the boot experience is something like
> MacOS X / Windows 10 do. The (EFI) firmware boots up a logo and we
> leave that in place until the login-manager (e.g. gdm) starts and then
> the login-manager takes over the framebuffer including the current logo
> contents and fades that into the login screen.
>
> I've already written and upstreamed a patch for shim to not switch the
> EFI framebuffer to text-mode, unless it has some error message to display
> this is upstream now:
> https://github.com/rhboot/shim/commit/1ff4a36a23ac5c17144275ccb3e1e1061750a137
>
> I've written a similar patch for grub2 to not switch to text-mode when
> using timeout_style=hidden for the menu and no key to show the menu is
> pressed. This has been posted upstream and I need to do a v2 addressing
> some small remarks.
>
> This brings us to the next piece of software taking over control of
> the framebuffer, the kernel.
>
> I already have a patch in -next to fix the i915 driver not taking over
> the BIOS used framebuffer (and thus loosing the vendor logo) on newer
> hardware:
> https://cgit.freedesktop.org/drm-intel/commit?id1f22eb545a35f972036bb6a245c95c2e7e15a0
>
> But this is only useful if we don't get fbcon binding to any fbdev
> devices showing up and replacing there contents with a black screen
> right away.
>
> That is where this patch comes in it defers fbcon binding to any registered
> fbdevs, until some output, any output at all, is send to the console (tty0),
> this way error messages will still get shown, but a well behaved userspace
> which does not spam the console with messages will retain the vendor logo
> from the EFI firmware all the way to the login screen.

FWIW I think the main idea here is sound: just preserve whatever image
the firmware decided to display until something noteworthy happens or
gdm takes over. (And you could perhaps override the image in grub if you
like, and preserve that until gdm instead.)

BR,
Jani.

-- 
Jani Nikula, Intel Open Source Graphics Center
