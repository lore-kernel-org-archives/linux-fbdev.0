From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Subject: Re: Framebuffer support for HTC Dream
Date: Mon, 26 Oct 2009 23:11:29 +0100
Message-ID: <20091026221129.GB23415@game.jcrosoft.org>
References: <20090629111029.GA15514@elf.ucw.cz>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754384AbZJZWbC@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20090629111029.GA15514@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-fbdev-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>, Brian Swetland <swetland@google.com>

On 13:10 Mon 29 Jun     , Pavel Machek wrote:
> I cleaned up dead code, a lot of debugging infastructure and horrific
> logo code. I had to remove earlysuspend support, because neccessary
> headers are not in mainline. The driver still works :-).
> 
> I'd like to see it applied, working framebuffer is quite important for
> debugging / getting other drivers into working state.
> 
the include/linux/msm_mdp.h is missing

could you send a patch to add it?

Best Regards,
J.
