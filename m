From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: radeonfb and newer radeons (Patch)
Date: Sat, 22 Jul 2006 19:20:36 +0200 (CEST)
Message-ID: <Pine.LNX.4.62.0607221919040.23027@pademelon.sonytel.be>
References: <44C23E93.2000805@users.sf.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1G4L9h-0002Wf-Ce for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 22 Jul 2006 10:20:45 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1G4L9f-0001kZ-PD
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 22 Jul 2006 10:20:45 -0700
Received: from pademelon.sonytel.be (mail.sonytel.be [43.221.60.197])
	by witte.sonytel.be (8.12.10/8.12.10) with ESMTP id k6MHKbQe026810
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sat, 22 Jul 2006 19:20:37 +0200 (MEST)
In-Reply-To: <44C23E93.2000805@users.sf.net>
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
To: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Sat, 22 Jul 2006, Claudio Ciccani wrote:
> the attached patch fixes some issues with R300 based chipsets and
> adds support for a number of new devices (mostly X800/X850).
> It also enlarges the mmio size to 0x8000 because many 3d registers
> of the R300 are located after offset 0x4000 and we need them for
> DirectFB (DRI needs too).
> The patch applies to linux-2.6.18-rc2, hope there have not been changes
> in the meanwhile.

> --- linux-2.6.18-rc2/drivers/video/aty/radeon_accel.c	2006-01-03 04:21:10.000000000 +0100
> +++ /usr/src/linux-2.6.18-rc2/drivers/video/aty/radeon_accel.c	2006-07-22 12:49:43.000000000 +0200
> @@ -203,9 +203,7 @@
>  	host_path_cntl = INREG(HOST_PATH_CNTL);
>  	rbbm_soft_reset = INREG(RBBM_SOFT_RESET);
>  
> -	if (rinfo->family == CHIP_FAMILY_R300 ||
> -	    rinfo->family == CHIP_FAMILY_R350 ||
> -	    rinfo->family == CHIP_FAMILY_RV350) {
> +	if (IS_R300_VARIANT(rinfo)) {
>  		u32 tmp;
>  
>  		OUTREG(RBBM_SOFT_RESET, (rbbm_soft_reset |
> @@ -241,9 +239,7 @@
>  	INREG(HOST_PATH_CNTL);
>  	OUTREG(HOST_PATH_CNTL, host_path_cntl);
>  
> -	if (rinfo->family != CHIP_FAMILY_R300 ||
                          ^^                  ^^
> -	    rinfo->family != CHIP_FAMILY_R350 ||
                          ^^                  ^^
> -	    rinfo->family != CHIP_FAMILY_RV350)
                          ^^
> +	if (IS_R300_VARIANT(rinfo))
            ^^
These trigger a warning in my head...

>  		OUTREG(RBBM_SOFT_RESET, rbbm_soft_reset);
>  
>  	OUTREG(CLOCK_CNTL_INDEX, clock_cntl_index);

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
