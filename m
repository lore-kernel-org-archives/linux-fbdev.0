From: Mike Dunn <mikedunn@newsguy.com>
Date: Fri, 18 Oct 2013 19:53:41 +0000
Subject: Re: [PATCH v2] pwm-backlight: allow for non-increasing brightness levels
Message-Id: <526191C5.7060705@newsguy.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1379869196-19377-1-git-send-email-mikedunn@newsguy.com> <20131018074623.GA22291@ulmo.nvidia.com>
In-Reply-To: <20131018074623.GA22291-AwZRO8vwLAwmlAP/+Wk3EA@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Richard Purdie <rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org>, Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Jean-Christophe Plagniol-Villard <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>, Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>

On 10/18/2013 12:46 AM, Thierry Reding wrote:
> On Sun, Sep 22, 2013 at 09:59:56AM -0700, Mike Dunn wrote:
>> Currently the driver assumes that the values specified in the
>> brightness-levels device tree property increase as they are parsed from
>> left to right.  But boards that invert the signal between the PWM output
>> and the backlight will need to specify decreasing brightness-levels.
>> This patch removes the assumption that the last element of the array is
>> the maximum value, and instead searches the array for the maximum value
>> and uses that in the duty cycle calculation.
>>
>> Signed-off-by: Mike Dunn <mikedunn@newsguy.com>
>> ---
>> Changelog:
>> v2: 
>> - commit message reworded; correct line wrap used
>> - 'max_level' variable renamed to 'scale'
>> - loop counter variable type changed to unsigned int
>> - value held in scale changed from array index to actual maximum level
>> - blank lines added around loop for readability
>>
>>  drivers/video/backlight/pwm_bl.c | 12 ++++++++++--
>>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> Hey Mike,
> 
> I've pushed a slightly different version of this patch which gets rid of
> the intermediate max variable and uses the new scale field exclusively
> to pass the same information around. Could you look at the patch from my
> for-next branch in the PWM tree and see whether that still works for the
> specific hardware that you need this for?


Yes looks good.

I also tested the current HEAD of for-next on the Palm Treo 680, including the
enable-gpios DT node property.  I will have to do more work and investigation
before I will be able to try the power-supply property, though.

Thanks,
Mike

