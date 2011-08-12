From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Fri, 12 Aug 2011 12:06:06 +0000
Subject: Re: How should .fb_check_var adjust parameters ?
Message-Id: <4E45172E.3020409@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <201108121308.59532.laurent.pinchart@ideasonboard.com>
In-Reply-To: <201108121308.59532.laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi Laurent,

On 08/12/2011 11:08 AM, Laurent Pinchart wrote:
> Hi everybody,
>
> I'm implementing support for fb_set_par() in a driver, and came to think about
> how fb_check_var should behave.
>
> The purpose of that operation is to let drivers verify and adjust a given set
> of fb_var_screeninfo parameters. Looking at various fbdev drivers, the
> function behaviour is clearly left to the author's preferences. Some drivers
> return an error when the parameters don't match the hardware capabilities
> exactly, other drivers adjust them in pretty much non-standardized ways, and
> some other drivers mix both behaviours.
>
> Is anyone aware of guidelines regarding how .fb_char_var should be implemented
> ? Under which conditions should it return an error, and under which conditions
> should it adjust parameters ? When adjusting parameters, how should it do so ?
> For instance, if xres>  xres_virtual, should xres be lowered or xres_virtual
> raised ?

I try to stick to
drivers/video/skeletonfb.c

  *	If the var passed in is slightly
  *	off by what the hardware can support then we alter the var PASSED in
  *	to what we can do.
  *
  *      For values that are off, this function must round them _up_ to the
  *      next value that is supported by the hardware.  If the value is
  *      greater than the highest value supported by the hardware, then this
  *      function must return -EINVAL.

Sure that still allows a lot of differences in implementation.


Best regards,

Florian Tobias Schandinat
