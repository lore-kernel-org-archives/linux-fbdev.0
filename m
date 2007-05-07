From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH] pm3fb: preliminary support for
	2.6	kernel
Date: Tue, 08 May 2007 05:07:54 +0800
Message-ID: <1178572074.4674.3.camel@daplas>
References: <463e3edaad7a2@wp.pl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HlAR8-0005jQ-9C for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 07 May 2007 14:08:03 -0700
Received: from py-out-1112.google.com ([64.233.166.183])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HlAR7-00010N-3e
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 07 May 2007 14:08:02 -0700
Received: by py-out-1112.google.com with SMTP id a29so1308818pyi
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 07 May 2007 14:08:00 -0700 (PDT)
In-Reply-To: <463e3edaad7a2@wp.pl>
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

On Sun, 2007-05-06 at 22:47 +0200, Krzysztof Helt wrote:
> From: Krzysztof Helt <krzysztof.h1@wp.pl>
> 
> This is a basic port from 2.4 kernel to 2.6. Acceleration is lost
> and big endian support probably too. The driver works in 8, 16
> and 32 bit mode.
> 

Thanks for doing this.  I change the VESA_* constants to FB_BLANK_*
constants. It's just a simple substitution, but let me know if it's
correct. (I don't know what to do with FB_BLANK_UNBLANK.)

Tony

static int pm3fb_blank(int blank_mode, struct fb_info *info)
{
	struct pm3_par *par = info->par;
	u32 video = par->video;

	/*
	 * Oxygen VX1 - it appears that setting PM3VideoControl and
	 * then PM3RD_SyncControl to the same SYNC settings undoes
	 * any net change - they seem to xor together.  Only set the
	 * sync options in PM3RD_SyncControl.  --rmk
	 */
	video &= ~(PM3VideoControl_HSYNC_MASK |
		   PM3VideoControl_VSYNC_MASK);
	video |= PM3VideoControl_HSYNC_ACTIVE_HIGH |
		 PM3VideoControl_VSYNC_ACTIVE_HIGH;

	switch (blank_mode) {
	case FB_BLANK_NORMAL:	/* FIXME */
		video = video & ~(PM3VideoControl_ENABLE);
		break;
		
	case FB_BLANK_HSYNC_SUSPEND:
		video = video & ~(PM3VideoControl_HSYNC_MASK |
				  PM3VideoControl_BLANK_ACTIVE_LOW);
		break;
	case FB_BLANK_VSYNC_SUSPEND:
		video = video & ~(PM3VideoControl_VSYNC_MASK |
				  PM3VideoControl_BLANK_ACTIVE_LOW);
		break;
	case FB_BLANK_POWERDOWN:
		video = video & ~(PM3VideoControl_HSYNC_MASK |
				  PM3VideoControl_VSYNC_MASK |
				  PM3VideoControl_BLANK_ACTIVE_LOW);
		break;
	default:
		DPRINTK("Unsupported blanking %d\n", blank_mode);
		return 1;
	}
	
	PM3_SLOW_WRITE_REG(par,PM3VideoControl, video);

	return 0;
}




-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
