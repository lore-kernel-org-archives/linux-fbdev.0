From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Tue, 26 May 2015 07:25:26 +0000
Subject: Re: [PATCH 15/21] backlight: Probe backlight devices on demand
Message-Id: <20150526072526.GB6325@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1432565608-26036-1-git-send-email-tomeu.vizoso@collabora.com>
 <1432565608-26036-16-git-send-email-tomeu.vizoso@collabora.com>
 <20150526071850.GA11677@x1>
In-Reply-To: <20150526071850.GA11677@x1>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tue, May 26, 2015 at 08:18:50AM +0100, Lee Jones wrote:
> On Mon, 25 May 2015, Tomeu Vizoso wrote:
> 
> > When looking up a backlight device through its DT node, ensure that the
> > corresponding device has been registered.
> > 
> > Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> > ---
> >  drivers/video/backlight/backlight.c | 3 +++
> >  1 file changed, 3 insertions(+)
> 
> Looks reasonable.
> 
> Until anyone screams at me, applied thanks.

The compiler will scream at you when it realizes that
of_platform_device_ensure() doesn't exist in your kernel...

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
