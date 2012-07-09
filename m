From: Alex Courbot <acourbot@nvidia.com>
Date: Mon, 09 Jul 2012 05:27:38 +0000
Subject: Re: [PATCH] pwm_backlight: pass correct brightness to callback
Message-Id: <4FFA6BCA.2040101@nvidia.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1341807700-7103-1-git-send-email-acourbot@nvidia.com> <20120709051001.GA10108@avionic-0098.mockup.avionic-design.de>
In-Reply-To: <20120709051001.GA10108@avionic-0098.mockup.avionic-design.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thierry Reding <thierry.reding@avionic-design.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>

On 07/09/2012 02:10 PM, Thierry Reding wrote:
> I had to actually read this patch a number of times and then realized I
> was completely missing the context. Looking at the whole function makes
> it more obvious what you mean.
>
> However I think it'd be much clearer if we just passed the value of
> bl->props.brightness into the callbacks, that way we can avoid the
> additional variable.

This won't work I'm afraid, as brightness can be modified prior to being 
passed to the callback function:

	if (bl->props.power != FB_BLANK_UNBLANK)
		brightness = 0;

	if (bl->props.fb_blank != FB_BLANK_UNBLANK)
		brightness = 0;

	if (pb->notify)
		brightness = pb->notify(pb->dev, brightness);

Alex.
