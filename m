From: ebiederm@xmission.com (Eric W. Biederman)
Date: Thu, 31 Oct 2019 22:12:10 +0000
Subject: Re: [PATCH] fbdev: potential information leak in do_fb_ioctl()
Message-Id: <87ftj8k1j9.fsf@x220.int.ebiederm.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20191029182320.GA17569@mwanda>
        <87zhhjjryk.fsf@x220.int.ebiederm.org> <20191030074321.GD2656@xps-13>
        <87r22ujaqq.fsf@x220.int.ebiederm.org> <20191030201201.GA3209@xps-13>
        <734ef2833e4e4e7bded92e9d964bc2415aadf3c4.camel@perches.com>
In-Reply-To: <734ef2833e4e4e7bded92e9d964bc2415aadf3c4.camel@perches.com> (Joe
        Perches's message of "Thu, 31 Oct 2019 11:16:39 -0700")
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Joe Perches <joe@perches.com>
Cc: Andrea Righi <andrea.righi@canonical.com>, Dan Carpenter <dan.carpenter@oracle.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Sam Ravnborg <sam@ravnborg.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Peter Rosin <peda@axentia.se>, Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, security@kernel.org, Kees Cook <keescook@chromium.org>, Julia Lawall <Julia.Lawall@lip6.fr>

Joe Perches <joe@perches.com> writes:

> On Wed, 2019-10-30 at 21:12 +0100, Andrea Righi wrote:
>> Then memset() + memcpy() is probably the best option,
>> since copying all those fields one by one looks quite ugly to me...
>
> A memset of an automatic before a memcpy to the same
> automatic is unnecessary.

You still need to guarantee that all of the holes in the
structure you are copying are initialized before you copy it.

Otherwise you are just changing which unitialized memory that
is being copied to userspace.

Which is my concern with your very simple suggestion.

Eric
