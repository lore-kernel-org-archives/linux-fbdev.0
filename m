From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Wed, 20 Mar 2019 12:36:23 +0000
Subject: Re: [RESEND][PATCH 2/2] staging: sm750fb: trivial Camel Case removal for setDisplayControl().
Message-Id: <20190320123622.GH2202@kadam>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190303165532.23727-1-tomli@tomli.me>
 <20190303165532.23727-3-tomli@tomli.me>
In-Reply-To: <20190303165532.23727-3-tomli@tomli.me>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yifeng Li <tomli@tomli.me>
Cc: Jiri Kosina <trivial@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, Jin Chen <nobijinc@gmail.com>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Teddy Wang <teddy.wang@siliconmotion.com>

On Mon, Mar 04, 2019 at 12:55:32AM +0800, Yifeng Li wrote:
> Rename the function setDisplayControl() to set_display_control().
> This fixes the following checkpatch.pl warning:
> 
>     CHECK: Avoid CamelCase: <setDisplayControl>
> 
> Suggested-by: Jin Chen <nobijinc@gmail.com>
> Signed-off-by: Jin Chen <nobijinc@gmail.com>
> [tomli@tomli.me: resent as trivial patch, reworded the commit message]
> Signed-off-by: Yifeng Li <tomli@tomli.me>
> ---

Apparently Greg already applied this earlier...  I don't know why the
original patch didn't reach me.  I'm on the devel@driverdev.osuosl.org
list.

Did Jin Chen write this?  If so why does it have a Suggested-by tag for
him?  If not then you should have preserved the authorship credit by
using the From: header in the first line on the commit message...

Anyway, it doesn't matter but hopefully this helps for next time.

regards,
dan carpenter
