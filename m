From: "Luis R. Rodriguez" <mcgrof@suse.com>
Date: Wed, 29 Apr 2015 19:18:06 +0000
Subject: Re: [PATCH v3 00/17] framebuffer: simple conversions to arch_phys_wc_add()
Message-Id: <CAB=NE6WhVUa-seXOWeY+ELY5v=Rt_6DBfr==GKjP7AH3CTWJAQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1429647398-16983-1-git-send-email-mcgrof@do-not-panic.com>
In-Reply-To: <1429647398-16983-1-git-send-email-mcgrof@do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: cocci@systeme.lip6.fr

On Tue, Apr 21, 2015 at 1:16 PM, Luis R. Rodriguez
<mcgrof@do-not-panic.com> wrote:
> From: "Luis R. Rodriguez" <mcgrof@suse.com>
>
> This series addresses simple changes to framebuffer drivers to use
> arch_phys_wc_add() and ioremap_wc() as well as fixing gbefb to add
> missing mtrr_del() calls. These changes are pretty straight forward.
>
> Luis R. Rodriguez (17):
>   video: fbdev: radeonfb: use arch_phys_wc_add() and ioremap_wc()
>   video: fbdev: gbefb: add missing mtrr_del() calls
>   video: fbdev: gbefb: use arch_phys_wc_add() and devm_ioremap_wc()
>   video: fbdev: intelfb: use arch_phys_wc_add() and ioremap_wc()
>   video: fbdev: matrox: use arch_phys_wc_add() and ioremap_wc()
>   video: fbdev: neofb: use arch_phys_wc_add() and ioremap_wc()
>   video: fbdev: nvidia: use arch_phys_wc_add() and ioremap_wc()
>   video: fbdev: savagefb: use arch_phys_wc_add() and ioremap_wc()
>   video: fbdev: sisfb: use arch_phys_wc_add() and ioremap_wc()
>   video: fbdev: aty: use arch_phys_wc_add() and ioremap_wc()
>   video: fbdev: i810: use arch_phys_wc_add() and ioremap_wc()
>   video: fbdev: pm2fb: use arch_phys_wc_add() and ioremap_wc()
>   video: fbdev: pm3fb: use arch_phys_wc_add() and ioremap_wc()
>   video: fbdev: rivafb: use arch_phys_wc_add() and ioremap_wc()
>   video: fbdev: tdfxfb: use arch_phys_wc_add() and ioremap_wc()
>   video: fbdev: atmel_lcdfb: use ioremap_wc() for framebuffer
>   video: fbdev: geode gxfb: use ioremap_wc() for framebuffer

Hey folks, these are all pretty straight forward, can anyone take them?

 Luis
