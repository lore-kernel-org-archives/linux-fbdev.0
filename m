From: Doug Anderson <dianders@chromium.org>
Date: Thu, 11 Apr 2013 20:30:20 +0000
Subject: Re: [PATCH v2] backlight: platform_lcd: introduce probe callback
Message-Id: <CAD=FV=UJ7rTa1VQXb=DT1MJkNGxQkkoYiQLXAx7+sg7u0E0gNg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1365705391-23181-1-git-send-email-abrestic@chromium.org>
	<1365711890-15168-1-git-send-email-abrestic@chromium.org>
In-Reply-To: <1365711890-15168-1-git-send-email-abrestic@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Bresticker <abrestic@chromium.org>
Cc: linux-fbdev@vger.kernel.org, Richard Purdie <rpurdie@rpsys.net>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Andrew,

On Thu, Apr 11, 2013 at 1:24 PM, Andrew Bresticker
<abrestic@chromium.org> wrote:
> Platform LCD devices may need to do some device-specific
> initialization before they can be used (regulator or GPIO setup,
> for example), but currently the driver does not support any way of
> doing this.  This patch adds a probe() callback to plat_lcd_data
> which platform LCD devices can set to indicate that device-specific
> initialization is needed.
>
> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
> ---
>  drivers/video/backlight/platform_lcd.c | 6 ++++++
>  include/video/platform_lcd.h           | 1 +
>  2 files changed, 7 insertions(+)

Reviewed-by: Doug Anderson <dianders@chromium.org>
