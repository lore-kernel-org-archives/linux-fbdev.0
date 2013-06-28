From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Fri, 28 Jun 2013 17:49:16 +0000
Subject: Re: imx-drm does not report correct info in fbset
Message-Id: <20130628174916.GG4283@n2100.arm.linux.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CAOMZO5A=JSHJrkXwXkYYxbkjtcFv3NU5W6F4hSb5Y7ZrpKij=A@mail.gmail.com>
In-Reply-To: <CAOMZO5A=JSHJrkXwXkYYxbkjtcFv3NU5W6F4hSb5Y7ZrpKij=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Fri, Jun 28, 2013 at 02:28:22PM -0300, Fabio Estevam wrote:
> Hi Philipp/Sascha,
> 
> When I enable the parallel display on a mx53qsb, I noticed that fbset
> does not report the correct information:
> 
> mode "800x480-0"
>         # D: 0.000 MHz, H: 0.000 kHz, V: 0.000 Hz
>         geometry 800 480 800 480 16
>         timings 0 0 0 0 0 0 0
>         accel true
>         rgba 5/11,6/5,5/0,0/0
> endmode

What do you think is missing?  This is what gets reported on my laptop:

mode "1280x800"
    geometry 1280 800 1280 1024 32
    timings 0 0 0 0 0 0 0
    accel true
    rgba 8/16,8/8,8/0,0/0
endmode

DRM doesn't provide full information via fbdev - its fbdev is just a
compatibility later nothing more.
