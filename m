From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Wed, 13 Apr 2011 23:05:49 +0000
Subject: Re: viafb: XO-1.5 video broken on 2.6.39
Message-Id: <4DA62C4D.8070407@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <BANLkTimFS0yC2629V0tBQQZG+9hJTkSctw@mail.gmail.com>
In-Reply-To: <BANLkTimFS0yC2629V0tBQQZG+9hJTkSctw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi Daniel,

Daniel Drake schrieb:
> Hi,
> 
> Commit fd3cc69848b7e1873e5f12bbcdd572b20277ecf3 breaks video on the
> XO-1.5 laptop on 2.6.39:

Sorry about that.

> commit fd3cc69848b7e1873e5f12bbcdd572b20277ecf3
> Author: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
> Date:   Fri Mar 11 00:04:01 2011 +0000
> 
>     viafb: remove duplicated clock storage
> 
> This is using the 1200x900 mode (DCON1200x900)
> 
> In the old code, the clock was hardcoded as value 57275000.
> In the new code, the clock gets calculated as 1264x912x60 = 69166080

Having a closer look at it the entire mode looks suspicious as it is neither CVT 
nor GTF compatible. But as it worked I assume the timings are correct and only 
the refresh rate is incorrect. If we reduce the refresh rate to 50Hz we get
1264x912x50 = 57638400 which is pretty close to the old value (and the 
documentation about DCON I found also suggests that it works at 50Hz). I will 
prepare a patch as soon as I have time (the driver tends to assume that 60Gz 
mode is always present and working).

> The result is that the screen gets filled with black and grey
> horizontal lines instead of anything readable.
> 
> Any ideas?
> 
> Thanks,
> Daniel
> 

Thanks a lot for your bug report,

Florian Tobias Schandinat

