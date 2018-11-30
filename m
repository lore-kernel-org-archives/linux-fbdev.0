From: Dan Murphy <dmurphy@ti.com>
Date: Fri, 30 Nov 2018 15:37:26 +0000
Subject: Re: [PATCH 1/2] dt-bindings: trivial: add ti,lm3630a binding
Message-Id: <e29497f4-2c8d-378e-0f9b-9a5bcee3fb1b@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20181124141703.29232-1-masneyb@onstation.org>
 <20181127105642.uu56phxjfl7bjl2p@holly.lan> <20181130135927.GA27500@basecamp>
 <CAL_Jsq+-AZFf==911Pmf_ObUk+3VQgC+2+BvQ9q8LyQ_v=FdOA@mail.gmail.com>
In-Reply-To: <CAL_Jsq+-AZFf==911Pmf_ObUk+3VQgC+2+BvQ9q8LyQ_v=FdOA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rob Herring <robh+dt@kernel.org>, Brian Masney <masneyb@onstation.org>
Cc: Daniel Thompson <daniel.thompson@linaro.org>, Lee Jones <lee.jones@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, dri-devel <dri-devel@lists.freedesktop.org>, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jonathan Marek <jonathan@marek.ca>, Craig Tatlor <ctatlor97@gmail.com>

Rob/Brian

On 11/30/2018 08:13 AM, Rob Herring wrote:
> +Dan M
> 
> On Fri, Nov 30, 2018 at 7:59 AM Brian Masney <masneyb@onstation.org> wrote:
>>
>> On Tue, Nov 27, 2018 at 10:56:42AM +0000, Daniel Thompson wrote:
>>> On Sat, Nov 24, 2018 at 09:17:02AM -0500, Brian Masney wrote:
>>>> Add a trivial binding for the Texas Instruments LM3630A Backlight Chip.
> 
> How does this chip relate to ones Dan has been working on?
> 

This is a standard 8-bit white LED driver.  It looks like Brian is just adding DT
support to load the driver.

I would expect that the bindings need to be updated to be able to register one string or
another using the led-sources property.  There are a couple of examples in the kernel and
a couple of them in patch form.

This driver and binding need to be updated to the latest spec, as you pointed out with child nodes.

And Jacek has some new proposed bindings for the LED class so we may want to adopt those standards here
as well.  This is what I am waiting on for agreement so I can update my patch set.

Dan

>>>
>>> It's quite unusual for a backlight device to have a trivial binding.
>>>
>>> The driver supports fairly extensive parametrization via struct
>>> lm3530a_platform_data. It is really the case that none of these
>>> properties should ever be set via DT?
>>
>> Hi Daniel,
>>
>> I initially assumed that we would let user space configure these values
>> once the system has booted, but you are right that these should be
>> available in device tree.
>>
>> The driver has two different LED banks that can be configured
>> independently.
> 
> That is usually represented with child nodes which makes this anything
> but trivial. Plus, given that we have bindings for LEDs/backlights, no
> LED/backlight controller is a trivial device.
> 
>> How do you feel about having a single property in
>> device tree populate the initial values for both banks? I propose that
>> we could use the property default-brightness-level for leda_init_brt
>> and ledb_init_brt in struct lm3630a_platform_data. The max-brightness
>> property can populate leda_max_brt and ledb_max_brt.
>>
>> I need to look at other bindings this weekend to see if there are any
>> standard properties that I can use for leda_ctrl/ledb_ctrl, pwm_ctrl,
>> and pwm_period.
>>
>> Brian
>>


-- 
------------------
Dan Murphy
