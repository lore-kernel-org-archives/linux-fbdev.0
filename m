From: Daniel Kurtz <djkurtz@chromium.org>
Date: Mon, 07 Dec 2015 04:20:26 +0000
Subject: Re: [PATCH v5] pwm-backlight: Avoid backlight flicker when probed from DT
Message-Id: <CAGS+omCD3MLB+hf4R1aD+YZuB4SV8nu71oAm6V_bkfoE2im49A@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1447866745-21567-1-git-send-email-p.zabel@pengutronix.de>
 <20151124162658.GJ807@x1>
In-Reply-To: <20151124162658.GJ807@x1>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Lee,

On Wed, Nov 25, 2015 at 12:26 AM, Lee Jones <lee.jones@linaro.org> wrote:
> On Wed, 18 Nov 2015, Philipp Zabel wrote:
>
>> If the driver is probed from the device tree, and there is a phandle
>> property set on it, and the enable GPIO is already configured as output,
>> and the backlight is currently disabled, keep it disabled.
>> If all these conditions are met, assume there will be some other driver
>> that can enable the backlight at the appropriate time.
>>
>> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
>> Reviewed-by: Christian Gmeiner <christian.gmeiner@gmail.com>
>> Tested-by: Heiko Stuebner <heiko@sntech.de>
>> ---
>>  - Rebased onto v4.4-rc1
>>  - Added Heiko's Tested-by
>> ---
>>  drivers/video/backlight/pwm_bl.c | 23 ++++++++++++++++++++++-
>>  1 file changed, 22 insertions(+), 1 deletion(-)
>
> Applied, thanks.

Hmm, where was this applied?  I do not see it in:
 * v4.4-rc4
 * linux-next next-20151203 (dcccebc - Add linux-next specific files
for 20151203)

Nor do I see it in any branch in:
 * git://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight
Is this the right git?
By the way this repository has a git tag called "HEAD", which is a bit
annoying since every time I "git remote update" from here, git gets
confused until I manually delete it (git tag -d HEAD).

Thanks,
-Dan
