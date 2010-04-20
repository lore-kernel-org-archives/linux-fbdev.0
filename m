From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Date: Tue, 20 Apr 2010 14:40:08 +0000
Subject: Re: [PATCHv3 0/5] OMAP: RX51: Add LCD Panel Support for N900
Message-Id: <1271774408.2433.25.camel@tubuntu.research.nokia.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1271333181-23609-1-git-send-email-roger.quadros@nokia.com>
	 <4BCDA3DF.5010906@nokia.com>
In-Reply-To: <4BCDA3DF.5010906@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Quadros Roger (Nokia-D/Helsinki)" <roger.quadros@nokia.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>

On Tue, 2010-04-20 at 14:53 +0200, Quadros Roger (Nokia-D/Helsinki)
wrote:
> Hi Tomi,
> 
> Quadros Roger (Nokia-D/Helsinki) wrote:
> > Tomi,
> > 
> > Resending the patchset.
> > 
> > Checkpatch was not complaining at my end. Probably the mail server is
> > mangling the patches. I will send a tarball separately.
> > 
> > The only change in this version is that i've put the Video memory
> > initialization code in the board file.
> > 
> > The TSC2005 stuff is still thereas without it panel is not detected.
> > The merge conflict with TSC2005 patches if happens is very trivial to resolve.
> > 
> 
> I don't see his patches in your git tree yet.
> When do you plan to have this in?

I pushed them to master branch.

I need to find some time to go through them a bit better before moving
them to for-next branch.

 Tomi


