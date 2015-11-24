From: Timur Tabi <timur@tabi.org>
Date: Tue, 24 Nov 2015 16:56:07 +0000
Subject: Re: [PATCH] video: fbdev: fsl: fix kernel crash when diu_ops is not implemented
Message-Id: <CAOZdJXU9JZd3U1r7Hxwy+6Yx7Tiu4=WpXHX9Rbbw51rJ1irkNA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1448346450-47403-1-git-send-email-dongsheng.wang@freescale.com>
In-Reply-To: <1448346450-47403-1-git-send-email-dongsheng.wang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Tue, Nov 24, 2015 at 11:54 AM, Timur Tabi <timur@tabi.org> wrote:
> Well, if you're concern is that there's no platform code, then there
> should be a check that says, "see if there's any platform code", not
> "let's check this obscure function and abort without explanation if
> it's not initialized."
>
> Alternatively, why can't you just do this, in update_lcdc():

[Stupid gmail sent my message before I was done typing]

if (diu_ops.set_pixel_clock)
   diu_ops.set_pixel_clock(var->pixclock);
