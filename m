From: Sebastian Frias <sf84@laposte.net>
Date: Wed, 30 Dec 2015 09:31:56 +0000
Subject: Re: [RFC PATCH] fbdev: add support for Sigma Designs' smp8xxxfb.ko
Message-Id: <5683A48C.80203@laposte.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <56828767.4050302@laposte.net> <CAH6sp9NrvapSMnPq5aagUFG2upf6-H9QJL1bkhMSscDL21Q-EQ@mail.gmail.com> <5682936E.2040904@laposte.net> <CAH6sp9OvJB+OPDPMWkEyNADcwO19N2=8U-5q49GrCmQTYObb_A@mail.gmail.com> <5682BA0B.9060001@laposte.net> <5683908C.5040001@ti.com>
In-Reply-To: <5683908C.5040001@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, laurent.pinchart@ideasonboard.com, David Airlie <airlied@linux.ie>
Cc: Frans Klaver <fransklaver@gmail.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-fbdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, mason <slash.tmp@free.fr>, =?UTF-8?B?TcOlbnMgUnVsbGfDpXJk?= <mans@mansr.com>, dri-devel@lists.freedesktop.org

Hi,

On 12/30/2015 09:06 AM, Tomi Valkeinen wrote:
>
> Also note that I don't want new fbdev drivers into the mainline kernel.
> You should implement a DRM based driver instead.
>

Thanks, is there a porting guide to go from fbdev to DRM?
Does DRM provides a "fbdev" backward compatible API? Would that be feasible?
I did not find much about that.

Currently our stack is something like:

    Qt -> eglfs -> Mali -> fbdev -> mem -> output
                   (HW)                     (HW)

We don't control the eglfs/Mali (GPU) part.
 From what I could see, Mali uses DRM with X11 which we do not need 
(note: I'm not a Mali expert and just took a quick look at the code so I 
may be wrong), which could be a problem.

If "implement a DRM driver" is a lot of work, it would end up as a 
business decision and probably would not happen.
Would you say there are good solid arguments to shake our current stack 
(other than for dusting it off)?

By the way, does DRM improves 2D acceleration support over fbdev?

Thanks,

Sebastian
