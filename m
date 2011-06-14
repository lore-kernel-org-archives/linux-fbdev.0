From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 14 Jun 2011 07:33:42 +0000
Subject: Re: [PATCH] efifb: Fix call to wrong unregister function
Message-Id: <20110614073341.GG17891@linux-sh.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1307875953.1859.6.camel@Tux> <4DF57C29.4070601@mit.edu>
In-Reply-To: <4DF57C29.4070601@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andy Lutomirski <luto@MIT.EDU>
Cc: "wanlong.gao" <wanlong.gao@gmail.com>, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, Maarten Lankhorst <m.b.lankhorst@gmail.com>, Peter Jones <pjones@redhat.com>

On Sun, Jun 12, 2011 at 10:55:37PM -0400, Andy Lutomirski wrote:
> On 06/12/2011 06:52 AM, wanlong.gao wrote:
> ><snip>
> >
> >Hi Maarten:
> >It registered efifb_device but try to unregistered efifb_driver,
> >so I think you should fix it like this?
> >
> >Signed-off-by: Wanlong Gao<wanlong.gao@gmail.com>
> >---
> >  drivers/video/efifb.c |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> >
> >diff --git a/drivers/video/efifb.c b/drivers/video/efifb.c
> >index 69c49df..784139a 100644
> >--- a/drivers/video/efifb.c
> >+++ b/drivers/video/efifb.c
> >@@ -541,7 +541,7 @@ static int __init efifb_init(void)
> >  	 */
> >  	ret = platform_driver_probe(&efifb_driver, efifb_probe);
> >  	if (ret) {
> >-		platform_device_unregister(&efifb_driver);
> >+		platform_device_unregister(&efifb_device);
> >  		return ret;
> >  	}
> >
> 
> Acked-by: Andy Lutomirski <luto@mit.edu>
> 
Updated version applied, thanks.
