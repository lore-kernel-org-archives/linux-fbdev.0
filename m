From: Greg KH <gregkh@linuxfoundation.org>
Date: Tue, 13 Jun 2017 09:40:55 +0000
Subject: Re: [PATCH] Drivers: sm750fb - style fix
Message-Id: <20170613094055.GH5677@kroah.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170608081707.1825-1-robsonde@gmail.com>
In-Reply-To: <20170608081707.1825-1-robsonde@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Derek Robson <robsonde@gmail.com>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org

On Thu, Jun 08, 2017 at 08:17:07PM +1200, Derek Robson wrote:
> Fix checkpatch.pl warnings of the form "function definition argument
> 'foo' should also have an identifier name" in header files.
> 
> Signed-off-by: Derek Robson <robsonde@gmail.com>
> ---
>  drivers/staging/sm750fb/sm750.h | 24 ++++++++++++++++--------
>  1 file changed, 16 insertions(+), 8 deletions(-)

You sent a bunch of patches, with very vague subjects.  Please be more
specific, say what part of the kernel you are working on (i.e. staging),
and number your patches so I know what order they should be applied in.

Please fix up all of them and resend.

thanks,

greg k-h
