From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 13 Jan 2011 06:17:43 +0000
Subject: Re: [PATCH] fbdev: Implement simple blanking in pseudocolor modes for vt8500lcdfb
Message-Id: <20110113061743.GE12013@linux-sh.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20110112221443.GA574@alchark-u3s> <AANLkTimRVSB13X67vz_qg_CpTg1J2fNz5A0Oweq3MZp1@mail.gmail.com>
In-Reply-To: <AANLkTimRVSB13X67vz_qg_CpTg1J2fNz5A0Oweq3MZp1@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Alexey Charkov <alchark@gmail.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, vt8500-wm8505-linux-kernel@googlegroups.com

On Thu, Jan 13, 2011 at 07:03:43AM +0100, Geert Uytterhoeven wrote:
>     The third method is problematic for these reasons:
> 
>         - Setting the colormap to all black will not work in truecolor mode
>         - In directcolor or pseudocolor, it will overwrite the fb application's
>           color map, producing wrong colors.
> 
>     So, remove the generic implementation in fb_blank() and just return -EINVAL
>     if there is no hardware implementation.  This will be only used by apps doin
>     an FBIO_BLANK ioctl, and is a more robust approach.
> 
The in-tree drivers that implement the blacking out also don't really
seem to agree on the implementation, with some having more complex
requirements for prodding their controllers than others (such as pxafb).

I'm fairly ambivalent about it however. If people are actively testing X
on their drivers with these configurations and are willing to deal with
the potential issues and restrictions it comes along with, then I don't
mind plugging it in to individual drivers that wish to opt in.

Having a default -EINVAL remains the safest bet in terms of general
correctness, but if this results in an X fbdev driver that is unusable
for most people, then we're still going to have to come up with an
alternative solution.
