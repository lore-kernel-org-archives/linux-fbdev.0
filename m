From: Ralf Baechle <ralf@linux-mips.org>
Date: Wed, 28 Apr 2010 14:32:11 +0000
Subject: Re: [PATCH 1/4] cocbalt_lcdfb: correct sections
Message-Id: <20100428143211.GA25641@linux-mips.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1272450305-7284-1-git-send-email-henne@nachtwindheim.de>
In-Reply-To: <1272450305-7284-1-git-send-email-henne@nachtwindheim.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Henrik Kretzschmar <henne@nachtwindheim.de>
Cc: linux-fbdev@vger.kernel.org, arnaud.patard@rtp-net.org, jayakumar.lkml@gmail.com, gregkh@suse.de, yuasa@linux-mips.org, lethal@linux-sh.org, akpm@linux-foundation.org, adobriyan@gmail.com, support@simtec.co.uk, ben@simtec.co.uk, linux@simtec.co.uk, jkosina@suse.cz, pjones@redhat.com, linux-kernel@vger.kernel.org

On Wed, Apr 28, 2010 at 12:25:02PM +0200, Henrik Kretzschmar wrote:

> Since the drivers probe call was changed from .init.text
> to .devinit.text in commit c2e13037e6794bd0d9de3f9ecabf5615f15c160b
> the fb_fix_screeninfo structure must be
> changed from .init.data to .devinit.data, too.
> 
> Signed-off-by: Henrik Kretzschmar <henne@nachtwindheim.de>
> ---
> It would be nice if someone with a MIPS gcc could test this patch and
> give me some feedback if it works the way it should, since atm I'm lacking
> a crosscompiler setup.

Works as advertised.

Tested-by: Ralf Baechle <ralf@linux-mips.org>

  Ralf
