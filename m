From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 28 Jun 2013 17:59:33 +0000
Subject: Re: imx-drm does not report correct info in fbset
Message-Id: <CAOMZO5CYTwCvi=JzcRDGWnkMggdLn4yOcoEq+wYpnCVy3Se6eQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CAOMZO5A=JSHJrkXwXkYYxbkjtcFv3NU5W6F4hSb5Y7ZrpKij=A@mail.gmail.com>
 <20130628174916.GG4283@n2100.arm.linux.org.uk>
In-Reply-To: <20130628174916.GG4283@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Fri, Jun 28, 2013 at 2:49 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:

> What do you think is missing?  This is what gets reported on my laptop:
>
> mode "1280x800"
>     geometry 1280 800 1280 1024 32
>     timings 0 0 0 0 0 0 0
>     accel true
>     rgba 8/16,8/8,8/0,0/0
> endmode

Yes, just saw the same on my PC.

I was thinking that the 'timings' line should show the correct display timings.

So the mx53 board is behaving the same as my laptop with regards to
'fbset' output.

> DRM doesn't provide full information via fbdev - its fbdev is just a
> compatibility later nothing more.

Ok, understood.

Thanks,

Fabio Estevam
