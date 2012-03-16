From: "Zhang, Sonic" <Sonic.Zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] [#7001] framebuffer: old image of
 last app would retain for a while after starting new app
Date: Thu, 15 Mar 2012 23:34:08 -0400
Message-ID: <DB904C5425BA6F4E8424B3B51A1414D16F24304D28@NWD2CMBX1.ad.analog.com>
References: <1331628439-12719-1-git-send-email-Aaron.Wu@analog.com>
	<DB904C5425BA6F4E8424B3B51A1414D16F24304A98@NWD2CMBX1.ad.analog.com>
	<201203151508.04564.vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
In-Reply-To: <201203151508.04564.vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
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
To: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>, "uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org" <uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
Cc: "Wu, Aaron" <Aaron.Wu-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>, "linux-fbdev-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org" <linux-fbdev-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>



-----Original Message-----
From: Mike Frysinger [mailto:vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org]
Sent: Friday, March 16, 2012 3:08 AM
To: uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
Cc: Wu, Aaron; linux-fbdev-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org; Zhang, Sonic
Subject: Re: [uclinux-dist-devel] [PATCH] [#7001] framebuffer: old image of last app would retain for a while after starting new app

On Thursday 15 March 2012 05:23:50 Wu, Aaron wrote:
> Old image of last application would retain for a while when starting a
> new application, this patch clear the frambuffer before displaying
> every time the fb is opened.

i'm not sure the behavior you describe is wrong.  in fact, i'm pretty sure it sounds correct.  if an app writes an image to the framebuffer and then quits, that image should stay there indefinitely until something else opens the framebuffer and draws their own image.
-mike

Before the second application draws its own image, the image of last application has already been displayed on the LCD when the second application opens the FB device(PPI is enabled when it is opened). This is not a correct behavior.

Sonic
