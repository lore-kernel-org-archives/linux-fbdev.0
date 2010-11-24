From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 24 Nov 2010 06:26:15 +0000
Subject: Re: [PATCH 0/9] sisfb: remove cruft code
Message-Id: <20101124062615.GG11705@linux-sh.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1290203931-25188-1-git-send-email-aaro.koskinen@iki.fi>
In-Reply-To: <1290203931-25188-1-git-send-email-aaro.koskinen@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, thomas@winischhofer.net

On Fri, Nov 19, 2010 at 11:58:42PM +0200, Aaro Koskinen wrote:
> This series deletes unused/unneeded code from sisfb, while not changing
> the functionality.
> 
> Aaro Koskinen (9):
>   sisfb: delete obsolete PCI ROM bug workaround
>   sisfb: delete fallback code for pci_map_rom()
>   sisfb: delete dead SIS_XORG_XF86 code
>   sisfb: delete redudant #define SIS_LINUX_KERNEL
>   sisfb: use CONFIG_FB_SIS_301/315 instead of SIS301/315H
>   sisfb: remove InPort/OutPort wrappers
>   sisfb: replace SiS_SetMemory with memset_io
>   sisfb: move the CONFIG warning to sis_main.c
>   sisfb: delete osdef.h
> 
Applied, thanks.
