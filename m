From: Mike Dunn <mikedunn@newsguy.com>
Date: Thu, 19 Sep 2013 16:13:11 +0000
Subject: Re: [PATCH] pwm-backlight: allow for non-increasing brightness levels
Message-Id: <523B2297.8000602@newsguy.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1379010952-8928-1-git-send-email-mikedunn@newsguy.com> <20130919115650.GE10852@ulmo>
In-Reply-To: <20130919115650.GE10852@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Richard Purdie <rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org>, Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Jean-Christophe Plagniol-Villard <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>, Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>

On 09/19/2013 04:56 AM, Thierry Reding wrote:
> On Thu, Sep 12, 2013 at 11:35:52AM -0700, Mike Dunn wrote:
>> Currently the driver assumes that the values specified in the brightness-levels
>> device tree property increase as they are parsed from left to right.  But boards
>> that invert the signal between the PWM output and the backlight will need to
>> specify decreasing brightness-levels.  This patch removes the assumption that
>> the last element of the array is the max value, and instead searches the array
>> for the max value and uses that as the normalizing value when determining the
>> duty cycle.
> 
> "maximum value", "... and uses that as the scale to normalize the duty
> cycle"?


It's been a while since my last math class... is "normalizing value" not the
correct term?  Maybe just "uses that in the duty cycle calculation"?


> 
> Also please wrap commit messages at 72 characters.


OK.  Sorry, didn't know.


> 
>> diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
>> index 1fea627..d66aaa0 100644
>> --- a/drivers/video/backlight/pwm_bl.c
>> +++ b/drivers/video/backlight/pwm_bl.c
>> @@ -27,6 +27,7 @@ struct pwm_bl_data {
>>  	unsigned int		period;
>>  	unsigned int		lth_brightness;
>>  	unsigned int		*levels;
>> +	unsigned int		max_level;
> 
> Perhaps call this "scale"? Otherwise there some potential to mix it up
> with max_brightness.


Yes, this name is thorny.  The code was somewhat confusing to me until I
realized that for the DT case, brightness and max_brightness are indices into
the levels[] array, whereas they are actual values for the platform_data case.
I'll go with "scale" if you prefer.


> 
>> @@ -195,7 +196,15 @@ static int pwm_backlight_probe(struct platform_device *pdev)
>>  	}
>>  
>>  	if (data->levels) {
>> -		max = data->levels[data->max_brightness];
>> +		int i, max_value = 0, max_idx = 0;
> 
> i should be unsigned int to match the type of data->max_brightness.


Yes, thanks.  I'm surprised there's no warning from the compiler.  I'm also
assigning an unsigned to a signed.


> 
>> +		for (i = 0; i <= data->max_brightness; i++) {
> 
> There should be a blank line above this one to increase readability.
> 
>> +			if (data->levels[i] > max_value) {
>> +				max_value = data->levels[i];
>> +				max_idx = i;
>> +			}
>> +		}
>> +		pb->max_level = max_idx;
> 
> Some here.
> 
> Also I suggest to just drop the max_ prefix from the local variables.
> Perhaps also simplify all of it to something like:
> 
> 	for (i = 0; i <= data->max_brightness; i++)
> 		if (data->levels[i] > pb->scale)
> 			pb->scale = data->levels[i];
> 
> And get rid of the index altogether. That way you can use pb->scale
> directly during the computation of the duty cycle and don't have to
> index the levels array over and over again.


Ok, if you prefer.  The reason I made max_level an index is for consistency.
For the DT case, brightness and max_brightness are indices, and I had already
been confused by the value-versus-index issue.

Thanks much for the review!  I'll ready a v2 patch.

Mike

