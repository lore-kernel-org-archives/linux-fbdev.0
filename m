From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Tue, 27 Jan 2015 13:20:04 +0000
Subject: Re: [PATCH] video: fbdev: sis: remove unused variables
Message-Id: <20150127130804.GA25333@sudip-PC>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1421940699-20670-1-git-send-email-sudipm.mukherjee@gmail.com>
 <54C63506.3020106@ti.com>
In-Reply-To: <54C63506.3020106@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Thomas Winischhofer <thomas@winischhofer.net>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Jan 26, 2015 at 02:37:26PM +0200, Tomi Valkeinen wrote:
> On 22/01/15 17:31, Sudip Mukherjee wrote:
> > removed some variables which were not used. Few calls to SiS_GetReg()
> > were left behind as they are reading from the hardare, removing them
> > might affect the overall functionality.
> > 
> > Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
> > ---
> > This patch will generate checkpatch error, to fix that error we need
> > to change the style of init.c and init301.c
> > 
> >  drivers/video/fbdev/sis/init.c     | 33 +++++----------------------------
> >  drivers/video/fbdev/sis/init301.c  | 10 ++--------
> >  drivers/video/fbdev/sis/sis_main.c |  9 ++++-----
> >  3 files changed, 11 insertions(+), 41 deletions(-)
> 
> Are you able to test this?
> 
> The patch doesn't look too complex, but it's still slightly too complex
> for me to comfortably merge it without any testing.

No. It is not tested on actual hardware.

Sudip

> 
>  Tomi
> 
> 


