From: Greg KH <gregkh@linuxfoundation.org>
Date: Fri, 24 Jul 2020 09:38:38 +0000
Subject: Re: [PATCH] newport_con: vc_color is now in state
Message-Id: <20200724093838.GA4169737@kroah.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <202007241318.wXYkumEO%lkp@intel.com>
 <20200724062735.18229-1-jslaby@suse.cz>
 <b1b9d90a-5fe3-947a-dc4e-8576cd143869@gmail.com>
In-Reply-To: <b1b9d90a-5fe3-947a-dc4e-8576cd143869@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sergei.shtylyov@gmail.com>
Cc: linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-mips@vger.kernel.org, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>

On Fri, Jul 24, 2020 at 12:30:59PM +0300, Sergei Shtylyov wrote:
> On 24.07.2020 9:27, Jiri Slaby wrote:
> 
> > Since commit 28bc24fc46f9 (vc: separate state), vc->vc_color is known as
> 
>    Cgit says "Bad object id: 28bc24fc46f9" (in Linus' repo). Also, you should
> enclose the commit summary in (""), not just ()...

I've added the proper "Fixes:" tag when committing this, no worries.

greg k-h
