From: Daniel Drake <dsd@laptop.org>
Date: Thu, 11 Nov 2010 14:59:18 +0000
Subject: Re: [PATCH 2/2] viafb: Add OLPC XO-1.5 port configs
Message-Id: <AANLkTi=_q89Swquy8tpHbLnX50D37K6kUewm+WM94T4h@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20100921153726.21D609D401B@zog.reactivated.net>
In-Reply-To: <20100921153726.21D609D401B@zog.reactivated.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On 29 October 2010 15:03, Daniel Drake <dsd@laptop.org> wrote:
> I now realise that all the #ifdefs are unnecessary, the code should be
> there unconditionally and the compiler will remove it on non-OLPC
> kernels.
>
> The other option we have is to detect the XO-1.5 using DMI. That's the
> more conventional way of detecting a specific platform in the kernel.
> Florian, what do you think?

Bump

Florian, still hoping for your input on this, and a review of the S/R
infrastructure patches posted recently.

Thanks,
Daniel
