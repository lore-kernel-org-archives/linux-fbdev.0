From: Tony Lindgren <tony@atomide.com>
Date: Tue, 22 Jan 2019 23:07:08 +0000
Subject: Re: [PATCH] fbdev: omap2: no need to check return value of debugfs_create functions
Message-Id: <20190122230708.GE5720@atomide.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190122152151.16139-15-gregkh@linuxfoundation.org>
In-Reply-To: <20190122152151.16139-15-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org

* Greg Kroah-Hartman <gregkh@linuxfoundation.org> [190122 15:28]:
> When calling debugfs functions, there is no need to ever check the
> return value.  The function can work or not, but the code logic should
> never do something different based on this.

Acked-by: Tony Lindgren <tony@atomide.com>
