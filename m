From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 23 Aug 2012 10:40:16 +0000
Subject: Re: [PATCHv4 0/9] *** ARM: Update arch-vt8500 to Devicetree ***
Message-Id: <201208231040.16702.arnd@arndb.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1345707346-9035-1-git-send-email-linux@prisktech.co.nz>
In-Reply-To: <1345707346-9035-1-git-send-email-linux@prisktech.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thursday 23 August 2012, Tony Prisk wrote:
> Patchset based on Arnd's arm-soc/for-next branch.
> 
> 
> Could I get this reviewed, hopefully for inclusion into v3.7.

I can take them into the arm-soc tree if there are no new comments.
For the last two patches, you need to get an Acked-by comment from the
gpio and clk maintainers, respectively, or you should send them
the patches for inclusion in those subsystem trees.

	Arnd
