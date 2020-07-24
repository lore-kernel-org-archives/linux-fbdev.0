From: Sergei Shtylyov <sergei.shtylyov@gmail.com>
Date: Fri, 24 Jul 2020 09:30:59 +0000
Subject: Re: [PATCH] newport_con: vc_color is now in state
Message-Id: <b1b9d90a-5fe3-947a-dc4e-8576cd143869@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <202007241318.wXYkumEO%lkp@intel.com>
 <20200724062735.18229-1-jslaby@suse.cz>
In-Reply-To: <20200724062735.18229-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jiri Slaby <jslaby@suse.cz>, gregkh@linuxfoundation.org
Cc: linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-mips@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

On 24.07.2020 9:27, Jiri Slaby wrote:

> Since commit 28bc24fc46f9 (vc: separate state), vc->vc_color is known as

    Cgit says "Bad object id: 28bc24fc46f9" (in Linus' repo). Also, you should
enclose the commit summary in (""), not just ()...

> vc->state.color. Somehow both me and 0-day bot missed this driver during
> the conversion.
> 
> So fix the driver now.
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-fbdev@vger.kernel.org
> Cc: linux-mips@vger.kernel.org
[...]

MBR, Sergei
