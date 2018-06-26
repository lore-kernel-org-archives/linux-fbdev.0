From: Steven Rostedt <rostedt@goodmis.org>
Date: Tue, 26 Jun 2018 19:14:40 +0000
Subject: Re: [PATCH v4 0/3] console/fbcon: Add support for deferred console takeover
Message-Id: <20180626151440.03749d0f@gandalf.local.home>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180626183612.321-1-hdegoede@redhat.com>
In-Reply-To: <20180626183612.321-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Hans de Goede <hdegoede@redhat.com>
Cc: Petr Mladek <pmladek@suse.com>, linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

On Tue, 26 Jun 2018 20:36:09 +0200
Hans de Goede <hdegoede@redhat.com> wrote:

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

For 1 and 2:

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

I'll let others handle patch 3.

-- Steve
