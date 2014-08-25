From: Hans de Goede <hdegoede@redhat.com>
Date: Mon, 25 Aug 2014 13:47:43 +0000
Subject: Re: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
Message-Id: <53FB3E7F.4000503@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1407914239-12054-1-git-send-email-libv@skynet.be>
 <1407914239-12054-5-git-send-email-libv@skynet.be>
 <53EB9471.3090204@wwwdotorg.org> <20140813170106.GT15297@lukather>
 <20140825121228.GB4163@ulmo.nvidia.com> <20140825124410.GZ15297@lukather>
 <20140825133953.GJ4163@ulmo.nvidia.com>
In-Reply-To: <20140825133953.GJ4163@ulmo.nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi,

On 08/25/2014 03:39 PM, Thierry Reding wrote:
> On Mon, Aug 25, 2014 at 02:44:10PM +0200, Maxime Ripard wrote:
>> On Mon, Aug 25, 2014 at 02:12:30PM +0200, Thierry Reding wrote:
>>> On Wed, Aug 13, 2014 at 07:01:06PM +0200, Maxime Ripard wrote:
>>>> On Wed, Aug 13, 2014 at 10:38:09AM -0600, Stephen Warren wrote:
>>> [...]
>>>>> If not, perhaps the clock driver should force the clock to be
>>>>> enabled (perhaps only if the DRM/KMS driver isn't enabled?).
>>>>
>>>> I'm sorry, but I'm not going to take any code that will do that in our
>>>> clock driver.
>>>>
>>>> I'm not going to have a huge list of ifdef depending on configuration
>>>> options to know which clock to enable, especially when clk_get should
>>>> have the consumer device as an argument.
>>>
>>> Are you saying is that you want to solve a platform-specific problem by
>>> pushing code into simple, generic drivers so that your platform code can
>>> stay "clean"?
>>
>> Are you saying that this driver would become "dirty" with such a patch?
> 
> Yes. Others have said the same and even provided alternative solutions
> on how to solve what's seemingly a platform-specific problem in a
> platform-specific way.

This is not platform specific, any platform with a complete clock driver
will suffer from the same problem (the clock driver disabling unclaimed
ahb gates, and thus killing the video output) if it wants to use simplefb
for early console support.

I can only assume that this problem was never hit on tegra because when
kms support (and thus also a clock driver for the video plls) was introduced
simplefb support was dropped at the same time, or the gates are not being
disabled for some other reason.

As for the suggestion to simply never disable the plls / ahb gates by blocking
them from ever being disabled in the sunxi clock driver, that is not really
a solution either, as we want to be able to turn these things off to safe
power on screen blank once control has been turned over to the kms driver.

And while at it let me also tackle the don't use simplefb only use kms argument,
that means that the clocks will be turned off until the kms module loads, which
will cause noticable screen flicker / video output resync, something which we've
been trying to get rid of for years now.

And no, build in the kms driver is not an answer either. That works nicely for
firmware, but not for generic Linux distributions supporting a wide range
of boards.

Regards,

Hans
