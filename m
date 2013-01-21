From: Mark Zhang <markz@nvidia.com>
Date: Mon, 21 Jan 2013 08:55:53 +0000
Subject: Re: [PATCH 2/3] tegra: pwm-backlight: add tegra pwm-bl driver
Message-Id: <50FD0299.2090408@nvidia.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1358591420-7790-1-git-send-email-acourbot@nvidia.com> <1358591420-7790-3-git-send-email-acourbot@nvidia.com> <50FCEFDE.8000705@gmail.com> <2440319.UsvGAcXXBp@fb07-iapwap2>
In-Reply-To: <2440319.UsvGAcXXBp@fb07-iapwap2>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Marc Dietrich <marvin24@gmx.de>
Cc: Mark Zhang <nvmarkzhang@gmail.com>, Alex Courbot <acourbot@nvidia.com>, Thierry Reding <thierry.reding@avionic-design.de>, Stephen Warren <swarren@wwwdotorg.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "gnurou@gmail.com" <gnurou@gmail.com>

On 01/21/2013 04:52 PM, Marc Dietrich wrote:
> Hi,
> 
>>> diff --git a/drivers/video/backlight/pwm_bl_tegra.c
>>> b/drivers/video/backlight/pwm_bl_tegra.c new file mode 100644
>>> index 0000000..8f2195b
>>> --- /dev/null
>>> +++ b/drivers/video/backlight/pwm_bl_tegra.c
>>
>> So according to the filename, I think we can put all tegra boards codes
>> here, right? Just like what you do for Ventana, if I wanna add support
>> for cardhu, I can define similar functions -- let's say "init_cardhu",
>> "exit_cardhu", "notify_cardhu" and "notify_after_cardhu", right?
>>
>> But I think if we do in this way, the file will become very long soon.
>> And there are a lot of redundant codes in it. So do you have any
>> suggestions?
> 
> I think we (for PAZ00) will just reuse the ventana code which is sufficient 
> for us. But adding "pwm-backlight-ventana" to our DTS may look a bit strange. 
> On the other hand, I guess that's why the property is called "compatible".
> 

Ah, yeah, that looks strange. :)
Okay, so I know why Alex wants to use panel name while not board name...

> Marc
> 
