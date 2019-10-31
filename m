From: Joe Perches <joe@perches.com>
Date: Thu, 31 Oct 2019 18:16:39 +0000
Subject: Re: [PATCH] fbdev: potential information leak in do_fb_ioctl()
Message-Id: <734ef2833e4e4e7bded92e9d964bc2415aadf3c4.camel@perches.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20191029182320.GA17569@mwanda>
         <87zhhjjryk.fsf@x220.int.ebiederm.org> <20191030074321.GD2656@xps-13>
         <87r22ujaqq.fsf@x220.int.ebiederm.org> <20191030201201.GA3209@xps-13>
In-Reply-To: <20191030201201.GA3209@xps-13>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrea Righi <andrea.righi@canonical.com>, "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Sam Ravnborg <sam@ravnborg.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Peter Rosin <peda@axentia.se>, Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, security@kernel.org, Kees Cook <keescook@chromium.org>, Julia Lawall <Julia.Lawall@lip6.fr>

On Wed, 2019-10-30 at 21:12 +0100, Andrea Righi wrote:
> Then memset() + memcpy() is probably the best option,
> since copying all those fields one by one looks quite ugly to me...

A memset of an automatic before a memcpy to the same
automatic is unnecessary.
