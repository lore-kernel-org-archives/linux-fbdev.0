From: Adrian Bunk <bunk@stusta.de>
Subject: Re: [2.6 patch] drivers/video/: misc cleanups
Date: Sun, 21 Nov 2004 16:58:11 +0100
Message-ID: <20041121155811.GA2961@stusta.de>
References: <20041121153702.GB2829@stusta.de>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S261767AbUKUQBn@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20041121153702.GB2829@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Antonino Daplas <adaplas@pol.net>
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net

On Sun, Nov 21, 2004 at 04:37:02PM +0100, Adrian Bunk wrote:

> The patch below does the following cleanups under drivers/video/ :
> - make some needlessly global code static
> - the following was needlessly EXPORT_SYMBOL'ed:
>   - fbcon.c: fb_con
>   - mdacon.c: fb_blank
>   - fbmon.c: get_EDID_from_firmware (completely unused)
>...

I forgot one thing:

Please review my global_mode_option removal in modedb.c .

It was always NULL and I'd say the only usage was wrong (although it 
had no practical effect).

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed
