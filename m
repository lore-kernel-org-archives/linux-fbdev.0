From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Fri, 07 Apr 2017 15:21:00 +0000
Subject: Re: [PATCH] fbdev/ssd1307fb: fix optional VBAT support
Message-Id: <2681648.EBUsxr9zfa@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170403135344.31091-1-bst@pengutronix.de>
In-Reply-To: <20170403135344.31091-1-bst@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-fbdev@vger.kernel.org


Hi,

On Monday, April 03, 2017 03:53:44 PM Bastian Stender wrote:
> SSD1306 needs VBAT when it is wired in charge pump configuration only.
> Other controllers of the SSD1307 family do not need it at all. This was
> introduced by commit ba14301e0356c99803e07db60e129a2ca9e50ff0.

checkpatch.pl complained about this:

ERROR: Please use git commit description style 'commit <12+ chars of sha1> ("<title line>")' - ie: 'commit ba14301e0356 ("fbdev/ssd1307fb: add support to enable VBAT")'
#6: 
introduced by commit ba14301e0356c99803e07db60e129a2ca9e50ff0.

I fixed this while applying the patch.

> Without VBAT configuration the driver now fails with:
> 
> 	failed to get VBAT regulator: -19
> 
> This is caused by misinterpretation of devm_regulator_get_optional
> which "returns a struct regulator corresponding to the regulator
> producer or IS_ERR() condition".
> 
> Handle -ENODEV without bailing out and making VBAT support really
> optional.
> 
> Signed-off-by: Bastian Stender <bst@pengutronix.de>

[...]

> @@ -578,10 +578,14 @@ static int ssd1307fb_probe(struct i2c_client *client,
>  
>  	par->vbat_reg = devm_regulator_get_optional(&client->dev, "vbat");
>  	if (IS_ERR(par->vbat_reg)) {
> -		dev_err(&client->dev, "failed to get VBAT regulator: %ld\n",
> -			PTR_ERR(par->vbat_reg));
>  		ret = PTR_ERR(par->vbat_reg);
> -		goto fb_alloc_error;
> +		if (ret = -ENODEV) {
> +			par->vbat_reg = NULL;
> +		} else {
> +			dev_err(&client->dev, "failed to get VBAT regulator: %ld\n",
> +				ret);

gcc complained after this change:

drivers/video/fbdev/ssd1307fb.c: In function ‘ssd1307fb_probe’:
drivers/video/fbdev/ssd1307fb.c:586:5: warning: format ‘%ld’ expects argument of type ‘long int’, but argument 3 has type ‘int’ [-Wformat]

I fixed this while applying the patch.

[...]

Patch queued for 4.11, thanks!

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

