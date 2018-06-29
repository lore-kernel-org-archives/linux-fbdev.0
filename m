From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Fri, 29 Jun 2018 10:08:41 +0000
Subject: Re: [PATCH v5 0/3] console/fbcon: Add support for deferred console takeover
Message-Id: <3340294.YySDL1Tsl7@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20180628090357epcas5p28361ab4b3ce11c179a167548f4851983@epcas5p2.samsung.com>
 <2462549.rLSfW9kX99@amdc3058>
 <1dc75ca2113d9809299fbfb60be097758003b3f2.camel@padovan.org>
In-Reply-To: <1dc75ca2113d9809299fbfb60be097758003b3f2.camel@padovan.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Gustavo Padovan <gustavo@padovan.org>
Cc: Petr Mladek <pmladek@suse.com>, linux-fbdev@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Hans de Goede <hdegoede@redhat.com>, dri-devel@lists.freedesktop.org


Hi Gustavo,

On Thursday, June 28, 2018 07:44:38 PM Gustavo Padovan wrote:
> Hi Bartlomiej,
> 
> On Thu, 2018-06-28 at 15:50 +0200, Bartlomiej Zolnierkiewicz wrote:
> > On Thursday, June 28, 2018 11:03:48 AM Hans de Goede wrote:
> > > Hi All,
> > > 
> > > Here is v5 of my patch-set, to delay fbcon taking over the console
> > > (and
> > > binding to fbdev devices) until there actually is some text output
> > > to the
> > > console. This is intended for use with the "quiet" cmdline option,
> > > in
> > > combination with a bootloader which leaves the vendor's logo /
> > > EFI bootgraphics put up by the firmware intact on the EFI
> > > framebuffer.
> > > 
> > > The end goal here is a boot where the firmware shows its boot
> > > graphics
> > > and these stay in place for a couple of seconds until the GUI loads
> > > and
> > > the GUI then smoothly takes over the framebuffer without any
> > > distruptions.
> > > 
> > > Bartlomiej, I believe that this patch-set is ready for merging now
> > > and
> > > the first patch has Petr's ack, so can we get this merged now?
> > 
> > Done, thanks for patches (also for reviews & acks).
> > 
> > > Also please create an inmutable (or topic) branch for this, so that
> > > the
> > > drm people can merge it into drm-tip for additional testing.
> > 
> > Daniel,
> > 
> > The following changes since commit
> > 7daf201d7fe8334e2d2364d4e8ed3394ec9af819:
> > 
> >   Linux 4.18-rc2 (2018-06-24 20:54:29 +0800)
> > 
> > are available in the git repository at:
> > 
> >   https://github.com/bzolnier/linux.git tags/ib-fbdev-drm-v4.19-
> > deferred-console-takeover
> > 
> > for you to fetch changes up to
> > 83d83bebf40132e2d55ec58af666713cc76f9764:
> > 
> >   console/fbcon: Add support for deferred console takeover (2018-06-
> > 28 15:20:30 +0200)
> > 
> > ----------------------------------------------------------------
> > Immutable branch between fbdev and drm for the v4.19 merge window
> > (contains the deferred console takeover feature)
> > 
> > ----------------------------------------------------------------
> > Hans de Goede (3):
> >       printk: Export is_console_locked
> >       fbcon: Call WARN_CONSOLE_UNLOCKED() where applicable
> >       console/fbcon: Add support for deferred console takeover
> > 
> >  Documentation/fb/fbcon.txt       |  7 ++++
> >  drivers/video/console/Kconfig    | 11 ++++++
> >  drivers/video/console/dummycon.c | 67 ++++++++++++++++++++++++++++
> > ----
> >  drivers/video/fbdev/core/fbcon.c | 83
> > ++++++++++++++++++++++++++++++++++++++++
> >  include/linux/console.h          |  5 +++
> >  kernel/printk/printk.c           |  1 +
> >  6 files changed, 166 insertions(+), 8 deletions(-)
> 
> Pulled into drm-misc-next, thanks

Please also apply fixup branch:

The following changes since commit 83d83bebf40132e2d55ec58af666713cc76f9764:

  console/fbcon: Add support for deferred console takeover (2018-06-28 15:20:30 +0200)

are available in the git repository at:

  https://github.com/bzolnier/linux.git tags/ib-fbdev-drm-v4.19-deferred-console-takeover-fixup

for you to fetch changes up to 334bb8972a131e604a741e9b284d8867190c723e:

  console: dummycon: export dummycon_[un]register_output_notifier (2018-06-29 11:46:19 +0200)

----------------------------------------------------------------
Immutable branch between fbdev and drm for the v4.19 merge window
(contains build fixup for the deferred console takeover feature)

----------------------------------------------------------------
Hans de Goede (1):
      console: dummycon: export dummycon_[un]register_output_notifier

 drivers/video/console/dummycon.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/video/console/dummycon.c b/drivers/video/console/dummycon.c
index 45ad925..0254251 100644
--- a/drivers/video/console/dummycon.c
+++ b/drivers/video/console/dummycon.c
@@ -38,11 +38,13 @@ void dummycon_register_output_notifier(struct notifier_block *nb)
 	if (dummycon_putc_called)
 		nb->notifier_call(nb, 0, NULL);
 }
+EXPORT_SYMBOL_GPL(dummycon_register_output_notifier);
 
 void dummycon_unregister_output_notifier(struct notifier_block *nb)
 {
 	raw_notifier_chain_unregister(&dummycon_output_nh, nb);
 }
+EXPORT_SYMBOL_GPL(dummycon_unregister_output_notifier);
 
 static void dummycon_putc(struct vc_data *vc, int c, int ypos, int xpos)
 {


Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

