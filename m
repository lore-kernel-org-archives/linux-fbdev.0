From: Thomas =?UTF-8?B?TmllZGVycHLDvG0=?= <niederp@physik.uni-kl.de>
Date: Sat, 07 Feb 2015 16:49:31 +0000
Subject: Re: [PATCH 8/8] fbdev: ssd1307fb: Turn off display on driver unload.
Message-Id: <20150207174931.0d8a4e79@maestro.intranet>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1423261694-5939-1-git-send-email-niederp@physik.uni-kl.de>
	<1423261694-5939-9-git-send-email-niederp@physik.uni-kl.de>
	<20150207114534.GR2079@lukather>
In-Reply-To: <20150207114534.GR2079@lukather>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: linux-fbdev@vger.kernel.org, plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, linux-kernel@vger.kernel.org

Am Sat, 7 Feb 2015 12:45:34 +0100
schrieb Maxime Ripard <maxime.ripard@free-electrons.com>:

> On Fri, Feb 06, 2015 at 11:28:14PM +0100, niederp@physik.uni-kl.de
> wrote:
> > From: Thomas Niederprüm <niederp@physik.uni-kl.de>
> > 
> 
> A commit log is always nice :)

Will be added.

> 
> > Signed-off-by: Thomas Niederprüm <niederp@physik.uni-kl.de>
> > ---
> >  drivers/video/fbdev/ssd1307fb.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/drivers/video/fbdev/ssd1307fb.c
> > b/drivers/video/fbdev/ssd1307fb.c index 02931c7..be91dfc 100644
> > --- a/drivers/video/fbdev/ssd1307fb.c
> > +++ b/drivers/video/fbdev/ssd1307fb.c
> > @@ -762,6 +762,11 @@ static int ssd1307fb_remove(struct i2c_client
> > *client) {
> >  	struct fb_info *info = i2c_get_clientdata(client);
> >  	struct ssd1307fb_par *par = info->par;
> > +	int ret = 0;
> > +
> > +	ret = ssd1307fb_write_cmd(par->client,
> > SSD1307FB_DISPLAY_OFF);
> > +	if (ret < 0)
> > +		return ret;
> 
> I don't think we really care about the return value here.
> 
> It might be even worse actually, since you'll end up in a intermediate
> state, where you won't have freed everything, but your remove method
> has been called still.

I agree. I will remove the check for the return statement.

> 
> Maxime
> 

