From: Dave Airlie <airlied@gmail.com>
Date: Tue, 12 May 2020 20:03:38 +0000
Subject: Re: bug: kernel bug when unbinding EFI framebuffer
Message-Id: <CAPM=9tx1ASp3ubnyRWk-zM0ppyW-pWE=o4jHAxOkT9oGU+Yx-g@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <45B8BCE9-2156-4248-8102-58736D02752D@gmail.com>
In-Reply-To: <45B8BCE9-2156-4248-8102-58736D02752D@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Sat, 2 May 2020 at 22:36, Fabian Mastenbroek <mail.fabian.m@gmail.com> wrote:
>
> Hi,
>
> When I try to unbind the EFI framebuffer via:
>
>         echo -n efi-framebuffer.0 > /sys/bus/platform/drivers/efi-framebuffer/unbind

Can I ask why?

nouveau kicks the efifb off the hw, and unregisters it, but when you
unbind it it tries to unregister again.

It might be possible to block this, but not sure of the point, efifb
is a built-in, you can't unload the module to save memory.

Dave.
