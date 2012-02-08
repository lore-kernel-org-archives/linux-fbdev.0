From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Wed, 08 Feb 2012 20:31:49 +0000
Subject: Re: [PATCH 00/16] rmk's patch series for fixing OMAP
Message-Id: <4F32DBB5.4010004@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20120208163546.GA15849@n2100.arm.linux.org.uk>
In-Reply-To: <20120208163546.GA15849@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Russell,

On 02/08/2012 04:35 PM, Russell King - ARM Linux wrote:
> commit c49d005b6cc8491fad5b24f82805be2d6bcbd3dd
> Author: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Date:   Tue Jan 17 11:09:57 2012 +0200
> 
>     OMAPDSS: HDMI: PHY burnout fix
>     
>     A hardware bug in the OMAP4 HDMI PHY causes physical damage to the board
>     if the HDMI PHY is kept powered on when the cable is not connected.

I agree this is a serious issue.

> which now has me wondering if, by trying to boot v3.3-rc2 on this board
> during the past week, I have a destroyed HDMI interface on it.

I am not sure as I don't keep track of all OMAP changes, but you make it sound
like a regression, is there any difference to 3.2 behavior?

> So, a big thanks for sitting on that fix and exposing peoples hardware
> to damage, that shows real professionalism.

Well, I am no professional to begin with, at least in the sense of getting paid
for it. That said I'm quite happy if I manage to find a few hours every weekend
to do the work. Given that the final thing should be tested in -next before I
ask Linus to pull, it is completely usual (and even quite fast) if things take
8-13 days on my end. If this isn't fast enough for Tomi, he'd better ask Linus
to pull directly for such issues.
This one was also somewhat special as I had to learn how to deal with PGP and
signed tags to make Linus happy.


Best regards,

Florian Tobias Schandinat
