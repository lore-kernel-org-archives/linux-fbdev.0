From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 02 Jun 2011 08:26:28 +0000
Subject: Re: [TRIVIAL PATCH V2 next 12/15] video: Convert vmalloc/memset to vzalloc
Message-Id: <20110602082628.GI6087@linux-sh.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1306603968.git.joe@perches.com> <77538de911b8af99f68b7bcfbaaedce8e40db04f.1306603968.git.joe@perches.com> <201105281948.12941.heiko@sntech.de> <1306606413.20336.9.camel@Joe-Laptop>
In-Reply-To: <1306606413.20336.9.camel@Joe-Laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Joe Perches <joe@perches.com>
Cc: Heiko St?bner <heiko@sntech.de>, Jaya Kumar <jayalk@intworks.biz>, Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Jiri Kosina <trivial@kernel.org>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, xen-devel@lists.xensource.com, virtualization@lists.linux-foundation.org

On Sat, May 28, 2011 at 11:13:33AM -0700, Joe Perches wrote:
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
> Heiko St??bner <heiko@sntech.de> pointed out I can't type...
> s/vmalloc/vmalloc/ doesn't do much.
> 
>  drivers/video/arcfb.c        |    5 ++---
>  drivers/video/broadsheetfb.c |    4 +---
>  drivers/video/hecubafb.c     |    5 ++---
>  drivers/video/metronomefb.c  |    4 +---
>  drivers/video/xen-fbfront.c  |    3 +--
>  5 files changed, 7 insertions(+), 14 deletions(-)
> 
v2 applied.
