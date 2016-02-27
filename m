From: "Maciej W. Rozycki" <macro@linux-mips.org>
Date: Sat, 27 Feb 2016 22:23:09 +0000
Subject: Re: [PATCH 0/7] PMAG-AA frame buffer driver rework
Message-Id: <alpine.LFD.2.20.1602261423120.28664@eddie.linux-mips.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <alpine.LFD.2.20.1602220110330.7431@eddie.linux-mips.org> <56D033EB.7010506@ti.com>
In-Reply-To: <56D033EB.7010506@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Ralf Baechle <ralf@linux-mips.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Tomi,

> >  This is an update to the PMAG-AA frame buffer driver to adapt it to our 
> > current APIs, which I promised a while ago (too much of a while, which I 
> > apologise for).
> 
> Interesting hardware. I like the names of these things. "Monolithic CMOS
> 64 x 64 Pixel Cursor Generator", "TURBOchannel Color Frame Buffer".

 Indeed, it sounds so 1980s, doesn't it?  It took me a while too to figure 
out how to wire it to a monitor as the adapter has a TNC connector for its 
output (the colour adapters from the line have a DA-3W3 connector each 
instead).  Fortunately at least video signalling is standard -- EIA-343A 
-- so a modern VGA monitor can be used as long as it does sync-on-green.

> Also interesting to see the git history of a file going almost directly
> to the initial git commit.

 FYI, for anything beyond you'd have to get at LMO's GIT history, e.g.:

$ git blame 66f0a432564b -- drivers/video/fbdev/pmag-aa-fb.c

on a checkout from <git://git.linux-mips.org/pub/scm/ralf/linux>.

 Ralf had been running his MIPS tree in CVS since forever and consequently 
had a slightly more detailed history of changes than Linus had with his 
master copy.  When the move from BitKeeper to GIT was made Ralf was kind 
enough to go through the pain and converted his CVS repository to GIT 
before merging with Linus.

 There are older branches there as well, namely: linux-2.4, linux-2.2, and 
linux-2.0 (anything beyond these is linear on master).  Most operations on 
the master branch are cut through at the initial Linus's commit though, 
you need to name a commit preceding that point -- such as one immediately 
before, which I referred to above -- to go past.

> Thanks, queued for 4.6.

 Thanks.

 I've since noticed blanking will need an update to interpret VESA modes 
correctly, i.e. return errors for the unsupported ones.  This is a minor 
issue, so I'll group it with blanking support for the other two boards 
which is missing for the Bt459 RAMDAC they use.  The Bt459 can switch sync 
generation off, so the full powerdown mode can be supported too in 
addition to plain screen blanking (obviously you can't switch individual 
sync signals in a composite signal).

 Cursor support for the Bt459 would be good to have too; noted as a future 
enhancement possibility.

  Maciej
