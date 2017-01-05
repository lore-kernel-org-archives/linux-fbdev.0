From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Thu, 05 Jan 2017 21:17:25 +0000
Subject: Re: Please add fbdev-for-next to linux-next
Message-Id: <20170106081725.2aab4e1e@canb.auug.org.au>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20170105114535epcas5p38b89f23a8fbfdc198f703eb226153961@epcas5p3.samsung.com>
 <3374870.z5x5pT8vjP@amdc3058>
In-Reply-To: <3374870.z5x5pT8vjP@amdc3058>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-fbdev@vger.kernel.org, linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org

Hi Bartlomiej,

On Thu, 05 Jan 2017 12:45:32 +0100 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com> wrote:
>
> Could you please add:
> 
> git://github.com/bzolnier/linux.git fbdev-for-next
> 
> To the linux-next tree?
> 
> Linus has recently accepted u pull request from the fbdev-v4.10-rc2
> tag that added fbdev subsystem back into Maintained mode (with me as
> Maintainer).

Added from today.

Thanks for adding your subsystem tree as a participant of linux-next.  As
you may know, this is not a judgement of your code.  The purpose of
linux-next is for integration testing and to lower the impact of
conflicts between subsystems in the next merge window. 

You will need to ensure that the patches/commits in your tree/series have
been:
     * submitted under GPL v2 (or later) and include the Contributor's
        Signed-off-by,
     * posted to the relevant mailing list,
     * reviewed by you (or another maintainer of your subsystem tree),
     * successfully unit tested, and 
     * destined for the current or next Linux merge window.

Basically, this should be just what you would send to Linus (or ask him
to fetch).  It is allowed to be rebased if you deem it necessary.

-- 
Cheers,
Stephen Rothwell 
sfr@canb.auug.org.au
