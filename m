From: Greg KH <gregkh@linuxfoundation.org>
Date: Wed, 27 May 2015 22:03:28 +0000
Subject: Re: [PATCH] fixing code style in sm750_accel.c
Message-Id: <20150527220328.GA7589@kroah.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1432762183-8411-1-git-send-email-mario.bambagini@gmail.com>
In-Reply-To: <1432762183-8411-1-git-send-email-mario.bambagini@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mario Bambagini <mario.bambagini@gmail.com>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org

On Wed, May 27, 2015 at 11:29:43PM +0200, Mario Bambagini wrote:
> From: mbambagini <mario.bambagini@gmail.com>

That doesn't match up with the name you used above, or in the
signed-off-by line.

> 
> Signed-off-by: Mario Bambagini <mario.bambagini@gmail.com>
> ---

You are going to have to be really specific as to exactly what you
changed and why you changed it, in the body of the patch.  And remember,
you can only do one-thing-per-patch, and that doesn't mean "fix all the
issues!" is one thing.

please fix up and resend.

thanks,

greg k-h
