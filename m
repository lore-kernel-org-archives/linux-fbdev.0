From: Greg KH <gregkh@linuxfoundation.org>
Date: Mon, 12 Sep 2016 11:17:25 +0000
Subject: Re: [PATCH 2/2] staging: sm750fb: fix block comment style and spelling issues in ddk750_chip.c
Message-Id: <20160912111725.GA12224@kroah.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <523e16874da50855062fcc51b6754e2b9c42b9e5.1472932508.git.mgmoshes@gmail.com>
 <c90da1d298fa859130d1c6cab39d0034b09fe4d8.1472932508.git.mgmoshes@gmail.com>
In-Reply-To: <c90da1d298fa859130d1c6cab39d0034b09fe4d8.1472932508.git.mgmoshes@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Moshe Green <mgmoshes@gmail.com>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, Sep 04, 2016 at 09:04:10PM +0300, Moshe Green wrote:
> Fix the following warning types:
>  - line length
>  - block comment line * prefix
>  - trailing */ on a separate line
> found by the checkpatch.pl tool in multiple block comments.
> 
> Fix a single spelling error in a comment.
> 
> Signed-off-by: Moshe Green <mgmoshes@gmail.com>
> ---
>  drivers/staging/sm750fb/ddk750_chip.c | 49 +++++++++++++++++++----------------
>  1 file changed, 27 insertions(+), 22 deletions(-)

As I didn't take the first patch, this one didn't apply :(

Please resend when you send the first one again.

thanks,

greg k-h
