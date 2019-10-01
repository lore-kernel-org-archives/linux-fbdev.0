From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Tue, 01 Oct 2019 13:34:43 +0000
Subject: Re: [PATCH] Staging: fbtft: fix memory leak in fbtft_framebuffer_alloc
Message-Id: <20191001133408.GG22609@kadam>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190930030949.28615-1-navid.emamdoost@gmail.com>
In-Reply-To: <20190930030949.28615-1-navid.emamdoost@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Navid Emamdoost <navid.emamdoost@gmail.com>
Cc: Jan Sebastian =?iso-8859-1?Q?G=F6tte?= <linux@jaseg.net>, devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org, Nishad Kamdar <nishadkamdar@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, smccaman@umn.edu, kjlu@umn.edu, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, emamd001@umn.edu, Bhanusree Pola <bhanusreemahesh@gmail.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Phil Reid <preid@electromag.com.au>, Sam Ravnborg <sam@ravnborg.org>

On Sun, Sep 29, 2019 at 10:09:45PM -0500, Navid Emamdoost wrote:
> In fbtft_framebuffer_alloc the error handling path should take care of
> releasing frame buffer after it is allocated via framebuffer_alloc, too.
> Therefore, in two failure cases the goto destination is changed to
> address this issue.
> 
> Fixes: c296d5f9957c ("staging: fbtft: core support")
> Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>

Looks good.

Reviewed-by: Dan Carpenter <dan.carpenter@gmail.com>

regards,
dan carpenter
