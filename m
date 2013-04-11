From: Doug Anderson <dianders@chromium.org>
Date: Thu, 11 Apr 2013 19:14:40 +0000
Subject: Re: [PATCH] backlight: platform_lcd: introduce probe callback
Message-Id: <CAD=FV=X6BBWJMDzJR9tnjKj8xTZ3Ng9oS7PYtNdUenW7_86vqw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1365705391-23181-1-git-send-email-abrestic@chromium.org>
In-Reply-To: <1365705391-23181-1-git-send-email-abrestic@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Bresticker <abrestic@chromium.org>
Cc: linux-fbdev@vger.kernel.org, Richard Purdie <rpurdie@rpsys.net>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Andrew,

On Thu, Apr 11, 2013 at 11:36 AM, Andrew Bresticker
<abrestic@chromium.org> wrote:
> +       if (pdata->probe) {
> +               err = pdata->probe(pdata);
> +               if (err) {
> +                       dev_err(dev, "platform probe failed: %d\n", err);

It would probably be good not to print in the case of -EPROBE_DEFER?

Otherwise this looks good to me.

-Doug
