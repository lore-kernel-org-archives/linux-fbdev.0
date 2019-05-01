From: Dan Murphy <dmurphy@ti.com>
Date: Wed, 01 May 2019 12:18:52 +0000
Subject: Re: [PATCH v3 3/3] backlight: lm3630a: add firmware node support
Message-Id: <fbf41c1b-21c7-a997-f88c-3d29ccd1b42a@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190415072905.2861-1-masneyb@onstation.org>
 <20190415072905.2861-4-masneyb@onstation.org>
 <0e5e26ba-cf98-913e-8e76-e988a86dc0d1@ti.com> <20190501082627.GA2971@amd>
In-Reply-To: <20190501082627.GA2971@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Pavel Machek <pavel@ucw.cz>
Cc: Brian Masney <masneyb@onstation.org>, lee.jones@linaro.org, daniel.thompson@linaro.org, jingoohan1@gmail.com, robh+dt@kernel.org, jacek.anaszewski@gmail.com, mark.rutland@arm.com, b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, jonathan@marek.ca

Pavel

On 5/1/19 3:26 AM, Pavel Machek wrote:
> Hi!
> 
>>> @@ -396,13 +506,20 @@ static int lm3630a_probe(struct i2c_client *client,
>>>  				     GFP_KERNEL);
>>>  		if (pdata = NULL)
>>>  			return -ENOMEM;
>>> +
>>>  		/* default values */
>>> -		pdata->leda_ctrl = LM3630A_LEDA_ENABLE;
>>> -		pdata->ledb_ctrl = LM3630A_LEDB_ENABLE;
>>> +		pdata->leda_ctrl = LM3630A_LEDA_DISABLE;
>>> +		pdata->ledb_ctrl = LM3630A_LEDB_DISABLE;
>>
>> This is not needed since default is disabled and kzalloc will set these to 0
> 
> Let compiler do this kind of optimalizations. Code makes sense as-is.
> 

Yes the code makes sense but it is unnecessary.

Dan

> 									Pavel
> 
