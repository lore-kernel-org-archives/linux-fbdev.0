From: "Luis R. Rodriguez" <mcgrof@suse.com>
Date: Thu, 14 May 2015 14:06:48 +0000
Subject: Re: [PATCH v4] staging: sm750fb: use arch_phys_wc_add() and ioremap_wc()
Message-Id: <20150514140648.GT23057@wotan.suse.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1430784951-16505-1-git-send-email-mcgrof@do-not-panic.com>
 <20150510130903.GA30824@kroah.com>
In-Reply-To: <20150510130903.GA30824@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: cocci@systeme.lip6.fr

On Sun, May 10, 2015 at 03:09:03PM +0200, Greg KH wrote:
> On Mon, May 04, 2015 at 05:15:51PM -0700, Luis R. Rodriguez wrote:
> > ---
> >  drivers/staging/sm750fb/sm750.c    | 36 ++++--------------------------------
> >  drivers/staging/sm750fb/sm750.h    |  3 ---
> >  drivers/staging/sm750fb/sm750_hw.c |  3 +--
> >  3 files changed, 5 insertions(+), 37 deletions(-)
> 
> Still doesn't apply to my tree:

I did base it on that day's staging tree, staging is just a fast
moving tree. In the future use of SmPL, when provided, to address merge
conflicts might help us on git.

Meanwhile I've addressed the conflict and will send v5 based on today's
tree outlook.

  Luis
