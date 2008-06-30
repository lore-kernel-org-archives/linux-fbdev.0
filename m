From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: [PATCH 11/13] viafb: viafbdev.c, viafbdev.h
Date: Mon, 30 Jun 2008 21:56:11 +0200
Message-ID: <48693A5B.9040901@gmail.com>
References: <C80EF34A3D2E494DBAF9AC29C7AE4EB8074E7895@exchtp03.taipei.via.com.tw>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932459AbYF3T6I@vger.kernel.org>
In-Reply-To: <C80EF34A3D2E494DBAF9AC29C7AE4EB8074E7895@exchtp03.taipei.via.com.tw>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: JosephChan@via.com.tw
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, geert@linux-m68k.org

On 06/30/2008 09:46 AM, JosephChan@via.com.tw wrote:
> Initialization, remove and some other important functions of viafb.
> 
> Signed-off-by: Joseph Chan <josephchan@via.com.tw>
> 
> diff -Nur a/drivers/video/via/viafbdev.c b/drivers/video/via/viafbdev.c
> --- a/drivers/video/via/viafbdev.c	1970-01-01 08:00:00.000000000 +0800
> +++ b/drivers/video/via/viafbdev.c	2008-06-30 08:53:33.000000000 +0800
> @@ -0,0 +1,2659 @@
[...]
> +static int timer_on;
> +struct timer_list timer_for3D;

Well the timer is neither inited nor used... ?
