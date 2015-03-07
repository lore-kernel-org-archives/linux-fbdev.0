From: Greg KH <gregkh@linuxfoundation.org>
Date: Sat, 07 Mar 2015 00:36:51 +0000
Subject: Re: [PATCH] staging/sm7xxfb: Make 'struct vgamode' static
Message-Id: <20150307003651.GA27179@kroah.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1424690176-7966-1-git-send-email-peter.senna@gmail.com>
In-Reply-To: <1424690176-7966-1-git-send-email-peter.senna@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Peter Senna Tschudin <peter.senna@gmail.com>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org

On Mon, Feb 23, 2015 at 12:16:16PM +0100, Peter Senna Tschudin wrote:
> sparse was complaining that symbol 'vgamode' was not declared.
> 
> Declaring vgamode as static.
> 
> Signed-off-by: Peter Senna Tschudin <peter.senna@gmail.com>
> ---
> Tested by compilation only
> 
>  drivers/staging/sm7xxfb/sm7xx.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

As was mentioned, someone sent this before you did, sorry.
