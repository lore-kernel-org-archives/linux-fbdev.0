From: Pavel Machek <pavel@ucw.cz>
Date: Wed, 30 Jul 2014 06:50:30 +0000
Subject: Re: [PATCH] video: fbdev: intelfb: intelfb_i2c.c:  Cleaning up variable that is never used
Message-Id: <20140730065030.GA8024@amd.pavel.ucw.cz>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1404563048-19690-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
In-Reply-To: <1404563048-19690-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Rickard Strandqvist <rickard.strandqvist@sonymobile.com>, Jingoo Han <jg1.han@samsung.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Rob Clark <robdclark@gmail.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat 2014-07-05 14:24:08, Rickard Strandqvist wrote:
> From: Rickard Strandqvist <rickard.strandqvist@sonymobile.com>
> 
> Variable ar assigned a value that is never used.
> I have also removed all the code that thereby serves no purpose.
> 
> This was found using a static code analysis program called cppcheck

Are you sure this is the right fix?

Do we need to read the register in case we don't care about return
value?


> index 3300bd3..4df2f1f 100644
> --- a/drivers/video/fbdev/intelfb/intelfb_i2c.c
> +++ b/drivers/video/fbdev/intelfb/intelfb_i2c.c
> @@ -55,22 +55,20 @@ static void intelfb_gpio_setscl(void *data, int state)
>  {
>  	struct intelfb_i2c_chan *chan = data;
>  	struct intelfb_info *dinfo = chan->dinfo;
> -	u32 val;
>  
>  	OUTREG(chan->reg, (state ? SCL_VAL_OUT : 0) |
>  	       SCL_DIR | SCL_DIR_MASK | SCL_VAL_MASK);
> -	val = INREG(chan->reg);
> +	INREG(chan->reg);
>  }

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
