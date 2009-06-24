From: "Rajashekhara, Sudhakar" <sudhakar.raj@ti.com>
Subject: Re: [PATCH] Frame Buffer driver for TI
	DA8xx/OMAP-L1xx
Date: Wed, 24 Jun 2009 16:52:51 +0530
Message-ID: <31722.3594444387$1245842822@news.gmane.org>
References: <1245336154-11554-1-git-send-email-sudhakar.raj@ti.com>
	<20090619113552.6c4f7b04.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <sudhakar.raj@ti.com>) id 1MJQav-0000gu-N7
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 24 Jun 2009 11:24:49 +0000
Received: from devils.ext.ti.com ([198.47.26.153])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MJQa0-0003Gu-H4
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 24 Jun 2009 11:24:49 +0000
In-Reply-To: <20090619113552.6c4f7b04.krzysztof.h1@poczta.fm>
Content-Language: en-us
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: 'Krzysztof Helt' <krzysztof.h1@poczta.fm>
Cc: 'Steve Chen' <schen@mvista.com>, linux-fbdev-devel@lists.sourceforge.net, 'Pavel Kiryukhin' <pkiryukhin@ru.mvista.com>

Hi,

On Fri, Jun 19, 2009 at 15:05:52, Krzysztof Helt wrote:
> HI,
> 
> This version of the driver is much cleaner however major issues still
remains.
> 
> 1. The driver seems not able to change graphics mode (depth or resolution)
> but check_var() and set_par() are defined. The set_par() function does not
> modify any register. You should move this few settings done there to
> lcd initialization functions and just remove the check_var() and
set_par().

Though I was able to get rid of set_par() function inside the driver,
removing
check_var() function turned out to be little tough as based on
"var.activate"
flags the fb_set_var function is performing lot of things which will not be
done
if check_var() function is NULL. Hence I have retained the check_var()
function
as of now.

> 
> 2. The driver does not set pseudo palette entries but uses true color mode
> (16-bit). See other driver show to do this (I advice tdfxfb.c).
> 

DA8XX/OMAP-L1xx LCD controller expects the first 2 bytes of palette to be
0x4000
for TRUECOLOR mode and I am doing this in fb_setcolreg. For further details,
please
refer to the controller spec which can be found at
http://www.ti.com/litv/pdf/sprufm0a. 

> 3. The request_mem_region() should be accompanied by the
release_mem_region()
> (I have not noticed it in my previous review).
> 
> 4. Check error paths in the probing functions. Not all already
requested/allocated
> resources are released correctly (e.g. the in one path there is no
clk_put() called).
> 
> Minor issues are in comments below.
> 
> If any of above issues is false let me know. I am not specialist in all
types of 
> embedded lcd controllers.
> 
> Kind regards,
> Krzysztof
> 

I have taken care of all other review comments and I'll be submitting the
version 3 of
this patch shortly.

Thanks for spending time to review the patches.

Regards, Sudhakar



------------------------------------------------------------------------------
