From: Dan Murphy <dmurphy@ti.com>
Date: Tue, 02 Apr 2019 17:07:22 +0000
Subject: Re: [PATCH v2 3/3] backlight: lm3630a: add device tree supprt
Message-Id: <6717928c-0531-cc36-d22b-a53cc359fb97@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190401103034.21062-1-masneyb@onstation.org>
 <20190401103034.21062-4-masneyb@onstation.org>
 <7bcd94ee-a4f8-c91b-697d-cc4c6337ec88@ti.com> <20190402164533.GA21197@amd>
In-Reply-To: <20190402164533.GA21197@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Pavel Machek <pavel@ucw.cz>
Cc: Brian Masney <masneyb@onstation.org>, lee.jones@linaro.org, daniel.thompson@linaro.org, jingoohan1@gmail.com, robh+dt@kernel.org, jacek.anaszewski@gmail.com, mark.rutland@arm.com, b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, jonathan@marek.ca

On 4/2/19 11:45 AM, Pavel Machek wrote:
> On Tue 2019-04-02 08:45:40, Dan Murphy wrote:
>> Hello
>>
>> On 4/1/19 5:30 AM, Brian Masney wrote:
>>> Add device tree support to the lm3630a driver and allow configuring
>>> independently on both banks the mapping mode (linear or exponential),
>>> initial and maximum LED brightness.
>>>
>>> Driver was tested on a LG Nexus 5 (hammerhead) phone.
>>>
>>
>> Don't need this in the commit message.
> 
> Actually yes, we want that in commit message.
> 

Noted for future patches.

Dan

> 									Pavel
> 


-- 
------------------
Dan Murphy
