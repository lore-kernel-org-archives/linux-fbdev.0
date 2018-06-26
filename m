From: Hans de Goede <hdegoede@redhat.com>
Date: Tue, 26 Jun 2018 13:55:32 +0000
Subject: [PATCH v3 0/3] console/fbcon: Add support for deferred console takeover
Message-Id: <20180626135535.2990-1-hdegoede@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-fbdev@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org

Hi All,

Here is v3 of my patch, now patch-set, to delay fbcon taking over the
console (and binding to fbdev devices) until there actually is some text
output to the console. This is intended for use with the "quiet" cmdline
option, in combination with a bootloader which leaves the vendor's logo /
EFI bootgraphics put up by the firmware intact on the EFI framebuffer.

The end goal here is a boot where the firmware shows its boot graphics
and these stay in place for a couple of seconds until the GUI loads and
the GUI then smoothly takes over the framebuffer without any distruptions.

New in v3 are the following changes:
-Export is_console_locke() for use in modules (as fbcon may be built as a .ko)
-Use WARN_CONSOLE_UNLOCKED() in several places in the fbcon code to assert
 proper locking (requested by Daniel)
-Unregister the fbcon-dummycon-output-notifier on fbcon_exit() (req. by Daniel)
-Document the fbcon=nodefer commandline option (req. by Emil)

These changes mean that this patch-set now spans 2 subsystems.

Petr, the printk subsys change is really trivial (1 line addition) can we
get your Acked-by for merging all 3 patches through the fbdev tree?

Regards,

Hans


