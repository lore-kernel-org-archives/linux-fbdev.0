From: Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: [PATCH] add NULL short circuit to fb_dealloc_cmap()
Date: Sun, 17 Jul 2005 23:35:34 +0200 (MEST)
Message-ID: <Pine.LNX.4.61.0507172335110.18775@yvahk01.tjqt.qr>
References: <200507172043.41473.jesper.juhl@gmail.com>
 <9e473391050717132233347d25@mail.gmail.com> <Pine.LNX.4.62.0507172314000.4553@numbat.sonytel.be>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S261281AbVGQVft@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.62.0507172314000.4553@numbat.sonytel.be>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Jon Smirl <jonsmirl@gmail.com>, Jesper Juhl <jesper.juhl@gmail.com>, Linux Kernel Development <linux-kernel@vger.kernel.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

>> struct fb_super_cmap {
>>    struct fb_cmap cmap;
>>    __u16 red[255];
>>    __u16 blue[255];
>>    __u16 green[255];
>>    __u16 transp[255];
>                  ^^^
>I assume you meant 256?

Even if it really was 255, it should probably be made 256 to have things 
aligned <-- if that matters.


Jan Engelhardt
-- 
