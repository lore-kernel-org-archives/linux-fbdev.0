From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Mon, 30 Jan 2017 15:32:45 +0000
Subject: Re: [PATCH RESEND 0/2] DEC frame buffer modular driver cleanups
Message-Id: <1765517.z4u5k8gkaW@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20170112125500epcas2p423954fadaee7296e3a34f9a6307001c5@epcas2p4.samsung.com>
 <alpine.LFD.2.20.1701120212430.19339@eddie.linux-mips.org>
In-Reply-To: <alpine.LFD.2.20.1701120212430.19339@eddie.linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org


Hi,

On Thursday, January 12, 2017 12:54:57 PM Maciej W. Rozycki wrote:
> Hi,
> 
>  This is a pair of small cleanups for `__init' annotation issues in PMAG-B 
> and PMAGB-B frame buffer drivers discovered in a modular build, which is a 
> seldom used, but supported configuration.
> 
>  Resending this series now that the framebuffer subsystem is looked after 
> again (thanks for your commitment!); please apply.

I queued both patches for 4.11, thanks!

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

