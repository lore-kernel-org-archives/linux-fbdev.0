From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 02 Aug 2017 11:45:07 +0000
Subject: Re: [PATCH] fbdev: matrox: hide unused 'hotplug' variable
Message-Id: <CAK8P3a3+5DQCwckCM1DTkaf3e9pqozK5y2ppRXwvJt0qBCxLzg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170802093722.3666961-1-arnd@arndb.de> <20170802100124.bcr3ux6bt4hnlu6r@phenom.ffwll.local>
 <ba8a1b02-913c-0873-9a98-7569080fd66d@gmail.com>
In-Reply-To: <ba8a1b02-913c-0873-9a98-7569080fd66d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Dan Carpenter <dan.carpenter@oracle.com>, Sean Paul <seanpaul@chromium.org>, linux-fbdev@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Wed, Aug 2, 2017 at 1:14 PM, Arvind Yadav <arvind.yadav.cs@gmail.com> wrote:
> Hi Arnd,
>
> With is change we can get below error. If MODULE is define.
>
> drivers/video/fbdev/matrox/matroxfb_base.c: In function ‘initMatrox2’:
> drivers/video/fbdev/matrox/matroxfb_base.c:1799:23: error: ‘hotplug’
> undeclared (first use in this function)
>   minfo->fbcon.flags = hotplug ? FBINFO_FLAG_MODULE : FBINFO_FLAG_DEFAULT;
>
> Please check this.

I think you are looking at an older tree, the patch only applies to today's
fbdev/fbdev-for-next branch, containing commit 376b3ff54c9a ("fbdev: Nuke
FBINFO_MODULE"), which was applied last night.

       Arnd
