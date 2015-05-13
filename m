From: "Kim, Milo" <milo.kim@ti.com>
Date: Wed, 13 May 2015 23:31:29 +0000
Subject: Re: [PATCH] backlight/lp855x: Don't clear level on suspend/blank
Message-Id: <5553DED1.1050800@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1431376325-25741-1-git-send-email-seanpaul@chromium.org>
In-Reply-To: <1431376325-25741-1-git-send-email-seanpaul@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi Sean,

On 5/14/2015 4:33 AM, Sean Paul wrote:
>
>
> On Mon, May 11, 2015 at 3:48 PM, Kim, Milo <milo.kim@ti.com
> <mailto:milo.kim@ti.com>> wrote:
>
>     Hi Sean,
>
>     On 5/12/2015 5:32 AM, Sean Paul wrote:
>
>         Don't clear the backlight level when we're going into suspend or
>         blanking. Instead, just temporarily set the level to 0 so we retain
>         the value when we resume.
>
>
>     Could you describe what the problem is? I wrote same code in other
>     backlight drivers. So maybe I need to look into them as well.
>
>
> Hi Milo,
> Well, I'm not sure what the expected behavior is, but our userspace
> expects the driver to maintain its brightness across suspend/resume. The
> way things are coded now, the driver will clear the brightness value on
> suspend such that when we resume, the backlight is restored to 0.

Got it. Your patch makes sense. Thanks for catching this.

Best regards,
Milo
