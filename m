From: Andrew Bresticker <abrestic@chromium.org>
Date: Thu, 11 Apr 2013 20:17:54 +0000
Subject: Re: [PATCH] backlight: platform_lcd: introduce probe callback
Message-Id: <CAL1qeaGjK0+hSTNbo0=zfSYtBJKcaKgi_Opi9ost4az96H=Cjg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1365705391-23181-1-git-send-email-abrestic@chromium.org>
	<CAD=FV=X6BBWJMDzJR9tnjKj8xTZ3Ng9oS7PYtNdUenW7_86vqw@mail.gmail.com>
In-Reply-To: <CAD=FV=X6BBWJMDzJR9tnjKj8xTZ3Ng9oS7PYtNdUenW7_86vqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Doug Anderson <dianders@chromium.org>
Cc: linux-fbdev@vger.kernel.org, Richard Purdie <rpurdie@rpsys.net>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

> It would probably be good not to print in the case of -EPROBE_DEFER?

Actually, I think I'll just kill the print all together since the
caller will print something anyways.

-Andrew
