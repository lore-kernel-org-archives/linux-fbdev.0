From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 22 Mar 2011 06:14:25 +0000
Subject: Re: [PATCH 06/13] omap: use list_move() instead of list_del()/list_add() combination
Message-Id: <20110322061425.GC25925@linux-sh.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1300229605-14499-1-git-send-email-kirill@shutemov.name> <1300229605-14499-7-git-send-email-kirill@shutemov.name> <1300229605-14499-1-git-send-email-kirill@shutemov.name> <1300229605-14499-6-git-send-email-kirill@shutemov.name> <1300275829.1917.94.camel@lappyti>
In-Reply-To: <1300229605-14499-7-git-send-email-kirill@shutemov.name> <1300275829.1917.94.camel@lappyti>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Tomi Valkeinen <tomi.valkeinen@nokia.com>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tejun Heo <tj@kernel.org>

On Wed, Mar 16, 2011 at 05:13:49PM +0530, Tomi Valkeinen wrote:
> On Tue, 2011-03-15 at 17:53 -0500, Kirill A. Shutemov wrote:
> > Signed-off-by: Kirill A. Shutemov <kirill@shutemov.name>
> > Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>
> > Cc: linux-fbdev@vger.kernel.org
> > Cc: linux-omap@vger.kernel.org
> > ---
> >  drivers/video/omap/blizzard.c |    3 +--
> >  drivers/video/omap/hwa742.c   |    3 +--
> >  2 files changed, 2 insertions(+), 4 deletions(-)
> 
> Acked-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

On Wed, Mar 16, 2011 at 12:53:19AM +0200, Kirill A. Shutemov wrote:
> Signed-off-by: Kirill A. Shutemov <kirill@shutemov.name>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: linux-fbdev@vger.kernel.org
> ---
>  drivers/video/vermilion/vermilion.c |    3 +--
>  1 files changed, 1 insertions(+), 2 deletions(-)
> 
Both applied, thanks.
