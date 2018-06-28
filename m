From: Hans de Goede <hdegoede@redhat.com>
Date: Thu, 28 Jun 2018 09:03:48 +0000
Subject: [PATCH v5 0/3] console/fbcon: Add support for deferred console takeover
Message-Id: <20180628090351.15581-1-hdegoede@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-fbdev@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org

Hi All,

Here is v5 of my patch-set, to delay fbcon taking over the console (and
binding to fbdev devices) until there actually is some text output to the
console. This is intended for use with the "quiet" cmdline option, in
combination with a bootloader which leaves the vendor's logo /
EFI bootgraphics put up by the firmware intact on the EFI framebuffer.

The end goal here is a boot where the firmware shows its boot graphics
and these stay in place for a couple of seconds until the GUI loads and
the GUI then smoothly takes over the framebuffer without any distruptions.

Bartlomiej, I believe that this patch-set is ready for merging now and
the first patch has Petr's ack, so can we get this merged now?

Also please create an inmutable (or topic) branch for this, so that the
drm people can merge it into drm-tip for additional testing.

Changelog:

Changes in v5:
-Improve commit message, explain why dummy_con.c is used to detect the
 first printout, instead of handling this entirely inside the fbcon code
 (no code changes, only updated the commit message)

Changes in v4:
-Keep the comments about which fbcon functions need locks in place

Changes in v3:
-Export is_console_locke() for use in modules (as fbcon may be built as a .ko)
-Use WARN_CONSOLE_UNLOCKED() in several places in the fbcon code to assert
 proper locking (requested by Daniel)
-Unregister the fbcon-dummycon-output-notifier on fbcon_exit() (req. by Daniel)
-Document the fbcon=nodefer commandline option (req. by Emil)

Changes in v2:
-Check the whole string when checking for erases in putcs, instead of just
 the first char
-Make dummycon_blank return 1, so that a redraw gets triggered and any text
 rendered while blanked gets output so that it can trigger a deferred
 takeover if one is pending

Regards,

Hans

