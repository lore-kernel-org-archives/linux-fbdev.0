From: "Wu, Aaron" <Aaron.Wu-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] [#7001] framebuffer: old image of
 last app would retain for a while after starting new app
Date: Thu, 15 Mar 2012 05:23:50 -0400
Message-ID: <DB904C5425BA6F4E8424B3B51A1414D16F24304A98@NWD2CMBX1.ad.analog.com>
References: <1331628439-12719-1-git-send-email-Aaron.Wu@analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
In-Reply-To: <1331628439-12719-1-git-send-email-Aaron.Wu-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
Content-Language: en-US
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://blackfin.uclinux.org/mailman/options/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=unsubscribe>
List-Archive: <http://blackfin.uclinux.org/pipermail/uclinux-dist-devel>
List-Post: <mailto:uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
List-Help: <mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=help>
List-Subscribe: <https://blackfin.uclinux.org/mailman/listinfo/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=subscribe>
Sender: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
Errors-To: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
To: "Wu, Aaron" <Aaron.Wu-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>, "linux-fbdev-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org" <linux-fbdev-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, "uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org" <uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
Cc: "Zhang, Sonic" <Sonic.Zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>



-----Original Message-----
From: Aaron Wu [mailto:Aaron.Wu-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org]
Sent: Tuesday, March 13, 2012 4:47 PM
To: linux-fbdev-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org; uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org; Wu, Aaron
Cc: Wu, Aaron
Subject: [PATCH] [#7001] framebuffer: old image of last app would retain for a while after starting new app

Old image of last application would retain for a while when starting a new application, this patch
clear the frambuffer before displaying every time the fb is opened.

Signed-off-by: Aaron Wu <Aaron.Wu-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
---
 drivers/video/bfin-lq035q1-fb.c  |    1 +
 drivers/video/bfin-t350mcqb-fb.c |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/video/bfin-lq035q1-fb.c b/drivers/video/bfin-lq035q1-fb.c
index c633068..676aa4e 100644
--- a/drivers/video/bfin-lq035q1-fb.c
+++ b/drivers/video/bfin-lq035q1-fb.c
@@ -399,6 +399,7 @@ static int bfin_lq035q1_fb_open(struct fb_info *info, int user)
                bfin_lq035q1_config_dma(fbi);
                bfin_lq035q1_config_ppi(fbi);
                bfin_lq035q1_init_timers(fbi);
+               memset(fbi->fb_buffer, 0, info->fix.smem_len);

                /* start dma */
                enable_dma(CH_PPI);
diff --git a/drivers/video/bfin-t350mcqb-fb.c b/drivers/video/bfin-t350mcqb-fb.c
index d5e1267..37f2df1 100644
--- a/drivers/video/bfin-t350mcqb-fb.c
+++ b/drivers/video/bfin-t350mcqb-fb.c
@@ -216,6 +216,7 @@ static int bfin_t350mcqb_fb_open(struct fb_info *info, int user)
                bfin_t350mcqb_config_dma(fbi);
                bfin_t350mcqb_config_ppi(fbi);
                bfin_t350mcqb_init_timers();
+               memset(fbi->fb_buffer, 0, info->fix.smem_len);

                /* start dma */
                enable_dma(CH_PPI);
--
1.7.0.4
