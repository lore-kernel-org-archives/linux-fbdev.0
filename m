From: Thomas =?UTF-8?B?TmllZGVycHLDvG0=?= <niederp@physik.uni-kl.de>
Date: Wed, 25 Mar 2015 20:33:47 +0000
Subject: Re: [PATCHv5 11/11] fbdev: ssd1307fb: Add blank mode
Message-Id: <20150325213347.5e78132b@maestro.intranet>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1423261694-5939-1-git-send-email-niederp@physik.uni-kl.de>
	<1427232238-21099-1-git-send-email-niederp@physik.uni-kl.de>
	<1427232238-21099-12-git-send-email-niederp@physik.uni-kl.de>
	<5512D92D.3020809@schinagl.nl>
In-Reply-To: <5512D92D.3020809@schinagl.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Olliver Schinagl <oliver@schinagl.nl>
Cc: plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, maxime.ripard@free-electrons.com, kernel@pengutronix.de, shawn.guo@linaro.org, robh+dt@kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

Am Wed, 25 Mar 2015 16:50:05 +0100
schrieb Olliver Schinagl <oliver@schinagl.nl>:

> Hey Thomas,
> 
> On 24-03-15 22:23, Thomas Niederprüm wrote:
> > This patch adds ssd1307fb_blank() to make the framebuffer capable
> > of blanking.
> >
> > Signed-off-by: Thomas Niederprüm <niederp@physik.uni-kl.de>
> > ---
> >   drivers/video/fbdev/ssd1307fb.c | 13 +++++++++++++
> >   1 file changed, 13 insertions(+)
> >
> > diff --git a/drivers/video/fbdev/ssd1307fb.c
> > b/drivers/video/fbdev/ssd1307fb.c index 061cc95..9101b27 100644
> > --- a/drivers/video/fbdev/ssd1307fb.c
> > +++ b/drivers/video/fbdev/ssd1307fb.c
> > @@ -238,6 +238,18 @@ static ssize_t ssd1307fb_write(struct fb_info
> > *info, const char __user *buf, return count;
> >   }
> >
> > +static int ssd1307fb_blank(int blank_mode, struct fb_info *info)
> > +{
> > +	struct ssd1307fb_par *par = info->par;
> > +	int ret;
> > +
> > +	if (blank_mode != FB_BLANK_UNBLANK)
> > +		ret = ssd1307fb_write_cmd(par->client,
> > SSD1307FB_DISPLAY_OFF);
> > +	else
> > +		ret = ssd1307fb_write_cmd(par->client,
> > SSD1307FB_DISPLAY_ON);
> I'd probably add an extra return, or drop the ret var at all and just 
> return the function.
> 
> or even shorter :)
> return sd1307fb_write_cmd(par->client, (blank_mode !> FB_BLANK_UNBLANK) ? SSD1307FB_DISPLAY_OFF : SSD1307FB_DISPLAY_ON;

Wow, short and elegant. Thanks for the hint, I will include it in v6.

Thomas


