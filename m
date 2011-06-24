From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 24 Jun 2011 08:07:21 +0000
Subject: Re: [PATCH] ARM: amba: Link fb device to its parent
Message-Id: <20110624080721.GC24184@linux-sh.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1308602657-28783-1-git-send-email-loic.minier@linaro.org>
In-Reply-To: <1308602657-28783-1-git-send-email-loic.minier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Mon, Jun 20, 2011 at 10:44:17PM +0200, Lo??c Minier wrote:
> Some pieces of userspace like debian-installer expect to find the fb0
> driver name by readlink-ing /sys/class/graphics/fb0/device/driver but
> this was broken with amba-clcd as it sets up fb_info manually and missed
> the .device parent pointer.
> 
> Signed-off-by: Lo??c Minier <loic.minier@linaro.org>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Paul Mundt <lethal@linux-sh.org>
> ---
>  drivers/video/amba-clcd.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
While this is titled as an ARM patch it's certainly fbdev-specific. I'll
apply it barring any objections from Russell.
