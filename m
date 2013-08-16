From: David Herrmann <dh.herrmann@gmail.com>
Date: Fri, 16 Aug 2013 13:45:50 +0000
Subject: Re: source code file for the generic vga driver?
Message-Id: <CANq1E4SnyPbZbUhp=kzcn7EeTsL+2yZMy6t6d2+WDa7Y1d13Qw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <7c86dd7e9e26494785ec5607b9e79440@DFM-DB3MBX15-06.exchange.corp.microsoft.com>
In-Reply-To: <7c86dd7e9e26494785ec5607b9e79440@DFM-DB3MBX15-06.exchange.corp.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Haiyang Zhang <haiyangz@microsoft.com>
Cc: "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "driverdev-devel@linuxdriverproject.org" <driverdev-devel@linuxdriverproject.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>

Hi

On Mon, Aug 5, 2013 at 9:12 PM, Haiyang Zhang <haiyangz@microsoft.com> wrote:
> Hi folks,
>
> I'm working on an issue of HyperV synthetic frame buffer driver, which seems to have
> a conflict with the generic vga driver (not the vesa driver). I hope to read and trace into
> the source code for the generic vga driver...
>
> Can anyone point me to the source code file for the generic vga driver in the kernel tree?

Everything lives in ./drivers/video/. The drivers you're probably
interested in are "vesafb.c" or "vga16fb.c". There is also the
"vgacon" driver in ./drivers/video/console/vgacon.c. I am not sure
which one you are talking about.

You might also want to have a look at the x86 sysfb infrastructure
which isn't merged, yet:
http://git.kernel.org/cgit/linux/kernel/git/tip/tip.git/log/?h=x86/fb
It provides proper platform-devices so drivers no longer conflict on
the vga/vesa/efi.. framebuffer resources. It's x86 only as all the
relevant drivers only work on x86.

If you give some more information on what you are trying to do, I can
point you to the relevant resources. My guess is that you want to have
a look at remove_conflicting_framebuffers() in
./drivers/video/fbmem.c.

Regards
David
