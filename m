From: Thomas =?UTF-8?B?TmllZGVycHLDvG0=?= <niederp@physik.uni-kl.de>
Date: Fri, 20 Mar 2015 21:16:50 +0000
Subject: Re: [PATCHv4 07/10] fbdev: ssd1307fb: Add a module parameter to set the refresh rate
Message-Id: <20150320221650.7be5f4b7@maestro.intranet>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1423261694-5939-1-git-send-email-niederp@physik.uni-kl.de>
	<1426525918-12745-1-git-send-email-niederp@physik.uni-kl.de>
	<1426525918-12745-8-git-send-email-niederp@physik.uni-kl.de>
	<20150319131824.GB4255@lukather>
In-Reply-To: <20150319131824.GB4255@lukather>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, kernel@pengutronix.de, shawn.guo@linaro.org, robh+dt@kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

Am Thu, 19 Mar 2015 14:18:24 +0100
schrieb Maxime Ripard <maxime.ripard@free-electrons.com>:

> On Mon, Mar 16, 2015 at 06:11:55PM +0100, Thomas Niederprüm wrote:
> > This patch adds the module parameter "refreshrate" to set delay for
> > the deferred io. The refresh rate is given in units of Hertz. The
> > default refresh rate is 1 Hz. The refresh rate set through the
> > newly introduced parameter applies to all instances of the driver
> > and for now it is not possible to change it individually.
> > 
> > Signed-off-by: Thomas Niederprüm <niederp@physik.uni-kl.de>
> > ---
> >  drivers/video/fbdev/ssd1307fb.c | 23 +++++++++++++++++------
> >  1 file changed, 17 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/video/fbdev/ssd1307fb.c
> > b/drivers/video/fbdev/ssd1307fb.c index 6fecec8..8a8d305 100644
> > --- a/drivers/video/fbdev/ssd1307fb.c
> > +++ b/drivers/video/fbdev/ssd1307fb.c
> > @@ -42,6 +42,11 @@
> >  #define	SSD1307FB_SET_COM_PINS_CONFIG	0xda
> >  #define	SSD1307FB_SET_VCOMH		0xdb
> >  
> > +#define REFRASHRATE 1
> > +
> > +static u_int refreshrate = REFRASHRATE;
> 
> s/REFRASH/REFRESH/ :)

It's written the wrong way and the right way in the same line :) Of
course I will fix that.

Thanks,
Thomas
