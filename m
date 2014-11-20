From: David Ung <davidu@nvidia.com>
Date: Thu, 20 Nov 2014 21:00:39 +0000
Subject: RE: [PATCH] video: fbdev: Add CVT timing calculations.
Message-Id: <b8529a8473ec4a69994ac85d7766ba13@HQMAIL102.nvidia.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1415746455-28701-1-git-send-email-davidu@nvidia.com>
In-Reply-To: <1415746455-28701-1-git-send-email-davidu@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

> On 12/11/14 00:54, David Ung wrote:
> > Currently fbmon is still relying on the old GTF timings when parsing
> > the standard timings of the EDID.
> > This causes problem with some monitor eg DELL U2410 which advertises
> > high resolutions like 1920x1200@60 and GTF timing gives it 193mhz
> > clock which is out of spec of the monitor which has dclkmax of 170mhz.
> > This patch address the above problem by adding support for CVT with
> > reduced timings.
> 
> These timings are quite complex, and I don't claim to fully understand all
> the details, so I have a few questions:
> 
> So you say the monitor has a standard timing for 1920x1200@60. If I read the
> EDID standard right, a standard timing entry either has to match a timing
> from VESA DMT, or it shall be calculated using GTF.
> 
> Don't we have or shouldn't we have a table for the VESA DMT modes, from
> which to search for standard timings? 1920x1200@60 should be found there.

Agree, there ought to be a DMT table of modes that it should match against, though this table does not exist currently in fbdev.
After reading your comment, I had a look at the edid again for DELL U2410 and in the standard timing, it defines - (D1, 00)h
According to the DMT document, that matches DMT ID 45h - which the table defines as 193.25mhz pixel clock.

Clearly my patch is wrong in this approach which tries to correct the problem with cvt reduce timing.
The correct approach should be to invalidate this mode since the monspec defines a max clock of 170mhz.

This should make the patch much more simpler.  I shall abandon this patch and post a different one.

David

