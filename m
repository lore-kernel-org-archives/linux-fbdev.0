From: Daniel Vetter <daniel@ffwll.ch>
Date: Wed, 27 Jun 2018 09:15:20 +0000
Subject: Re: [PATCH v4 0/3] console/fbcon: Add support for deferred console takeover
Message-Id: <20180627091520.GI13978@phenom.ffwll.local>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180626183612.321-1-hdegoede@redhat.com>
In-Reply-To: <20180626183612.321-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Hans de Goede <hdegoede@redhat.com>
Cc: Petr Mladek <pmladek@suse.com>, linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Steven Rostedt <rostedt@goodmis.org>

On Tue, Jun 26, 2018 at 08:36:09PM +0200, Hans de Goede wrote:
> Hi All,
> 
> Here is v4 of my patch-set, to delay fbcon taking over the console (and
> binding to fbdev devices) until there actually is some text output to the
> console. This is intended for use with the "quiet" cmdline option, in
> combination with a bootloader which leaves the vendor's logo /
> EFI bootgraphics put up by the firmware intact on the EFI framebuffer.
> 
> The end goal here is a boot where the firmware shows its boot graphics
> and these stay in place for a couple of seconds until the GUI loads and
> the GUI then smoothly takes over the framebuffer without any distruptions.
> 
> This patch-set spans 2 subsystems.
> 
> Petr, the printk subsys change is really trivial (1 line addition) can we
> get your Acked-by for merging all 3 patches through the fbdev tree?
> 
> Changelog:
> 
> Changes in v4:
> -Keep the comments about which fbcon functions need locks in place
> 
> Changes in v3:
> -Export is_console_locke() for use in modules (as fbcon may be built as a .ko)
> -Use WARN_CONSOLE_UNLOCKED() in several places in the fbcon code to assert
>  proper locking (requested by Daniel)
> -Unregister the fbcon-dummycon-output-notifier on fbcon_exit() (req. by Daniel)
> -Document the fbcon=nodefer commandline option (req. by Emil)
> 
> Changes in v2:
> -Check the whole string when checking for erases in putcs, instead of just
>  the first char
> -Make dummycon_blank return 1, so that a redraw gets triggered and any text
>  rendered while blanked gets output so that it can trigger a deferred
>  takeover if one is pending

Wrt merging I think it'd be best if we stuff this into drm-misc-next -
that will increase testing by gpu drivers a lot, instead of a suprise when
the fbdev pull lands in upstream.

Bart, is that ok with you?

Hans, if Bart acks this you can directly push this imo.
-Daniel

> 
> Regards,
> 
> Hans
>  
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
