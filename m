From: James Simmons <jsimmons@infradead.org>
Subject: Re: [PATCH] matroxfb: Use kzalloc
Date: Tue, 6 Feb 2007 20:19:25 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0702062018110.9224@pentafluge.infradead.org>
References: <20061231170605.30fd7005.khali@linux-fr.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HEWnA-0000gW-4M for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 06 Feb 2007 12:19:52 -0800
Received: from pentafluge.infradead.org ([213.146.154.40])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HEWn8-0001jq-UC
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 06 Feb 2007 12:19:51 -0800
In-Reply-To: <20061231170605.30fd7005.khali@linux-fr.org>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Andrew Morton <akpm@osdl.org>, Petr Vandrovec <vandrove@vc.cvut.cz>


Acked-By: James Simmons <jsimmons@infradead.org>

On Sun, 31 Dec 2006, Jean Delvare wrote:

> Use kzalloc instead of kmalloc+memset, twice.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> ---
>  drivers/video/matrox/i2c-matroxfb.c   |    4 +---
>  drivers/video/matrox/matroxfb_crtc2.c |    3 +--
>  2 files changed, 2 insertions(+), 5 deletions(-)
> 
> --- linux-2.6.20-rc2.orig/drivers/video/matrox/i2c-matroxfb.c	2006-12-31 17:01:35.000000000 +0100
> +++ linux-2.6.20-rc2/drivers/video/matrox/i2c-matroxfb.c	2006-12-31 17:03:01.000000000 +0100
> @@ -146,7 +146,7 @@ static void* i2c_matroxfb_probe(struct m
>  	unsigned long flags;
>  	struct matroxfb_dh_maven_info* m2info;
>  
> -	m2info = kmalloc(sizeof(*m2info), GFP_KERNEL);
> +	m2info = kzalloc(sizeof(*m2info), GFP_KERNEL);
>  	if (!m2info)
>  		return NULL;
>  
> @@ -155,8 +155,6 @@ static void* i2c_matroxfb_probe(struct m
>  	matroxfb_DAC_out(PMINFO DAC_XGENIOCTRL, 0x00);
>  	matroxfb_DAC_unlock_irqrestore(flags);
>  
> -	memset(m2info, 0, sizeof(*m2info));
> -
>  	switch (ACCESS_FBINFO(chip)) {
>  		case MGA_2064:
>  		case MGA_2164:
> --- linux-2.6.20-rc2.orig/drivers/video/matrox/matroxfb_crtc2.c	2006-12-31 17:01:34.000000000 +0100
> +++ linux-2.6.20-rc2/drivers/video/matrox/matroxfb_crtc2.c	2006-12-31 17:03:01.000000000 +0100
> @@ -694,12 +694,11 @@ static void* matroxfb_crtc2_probe(struct
>  	/* hardware is CRTC2 incapable... */
>  	if (!ACCESS_FBINFO(devflags.crtc2))
>  		return NULL;
> -	m2info = kmalloc(sizeof(*m2info), GFP_KERNEL);
> +	m2info = kzalloc(sizeof(*m2info), GFP_KERNEL);
>  	if (!m2info) {
>  		printk(KERN_ERR "matroxfb_crtc2: Not enough memory for CRTC2 control structs\n");
>  		return NULL;
>  	}
> -	memset(m2info, 0, sizeof(*m2info));
>  	m2info->primary_dev = MINFO;
>  	if (matroxfb_dh_registerfb(m2info)) {
>  		kfree(m2info);
> 
> 
> 

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
