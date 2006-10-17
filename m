From: Adrian Bunk <bunk@stusta.de>
Subject: Re: 2.6.19-rc2: known unfixed regressions (v2)
Date: Tue, 17 Oct 2006 18:29:05 +0200
Message-ID: <20061017162905.GD3502@stusta.de>
References: <Pine.LNX.4.64.0610130941550.3952@g5.osdl.org> <20061017155934.GC3502@stusta.de> <20061017162323.GA6467@aepfle.de>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751305AbWJQQ3L@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20061017162323.GA6467@aepfle.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Olaf Hering <olaf@aepfle.de>
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net

On Tue, Oct 17, 2006 at 06:23:23PM +0200, Olaf Hering wrote:
> On Tue, Oct 17, Adrian Bunk wrote:
> 
> > Subject    : monitor not active after boot
> > References : http://lkml.org/lkml/2006/10/5/338
> > Submitter  : Olaf Hering <olaf@aepfle.de>
> > Caused-By  : Antonino Daplas <adaplas@pol.net>
> >              commit 346bc21026e7a92e1d7a4a1b3792c5e8b686133d
> > Status     : unknown
> 
> The nvidiafb change was removed again. I will see if I can figure out
> why the EDID is lost.

Thanks for the information, I missed this patch.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed
