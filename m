From: Ondrej Zajicek <santiago@crfreenet.org>
Subject: Re: [PATCH 7/9] viafb: VIA Frame Buffer Device
	Driver
Date: Thu, 8 May 2008 09:41:34 +0200
Message-ID: <20080508074134.GB11121@localhost.localdomain>
References: <C80EF34A3D2E494DBAF9AC29C7AE4EB806F6775A@exchtp03.taipei.via.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Ju0lA-0001JM-DD for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 08 May 2008 00:41:48 -0700
Received: from smtp1.kolej.mff.cuni.cz ([78.128.192.10])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Ju0l9-0003J1-Nu
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 08 May 2008 00:41:48 -0700
Content-Disposition: inline
In-Reply-To: <C80EF34A3D2E494DBAF9AC29C7AE4EB806F6775A@exchtp03.taipei.via.com.tw>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: JosephChan@via.com.tw
Cc: linux-fbdev-devel@lists.sourceforge.net, akpm@linux-foundation.org, geert@linux-m68k.org, linux-kernel@vger.kernel.org

On Wed, May 07, 2008 at 07:09:44PM +0800, JosephChan@via.com.tw wrote:
> +static int viafb_ioctl(struct fb_info *info, u_int cmd, u_long arg)
> +{
> +	switch (cmd) {
> +	case VIAFB_GET_CHIP_INFO:	/*struct chip_information chip_info ; */
> +	if (copy_to_user((void __user *)arg, &chip_info, sizeof(chip_info)))
> +		return -EFAULT;
> +		break;
> +	case VIAFB_GET_INFO_SIZE:
> +		return put_user(sizeof(viainfo), argp);
> +	case VIAFB_GET_INFO:
> +		return ioctl_get_viafb_info(arg);
...
> +	case VIAFB_GET_RESOLUTION:

Some of these ioctls looks like they duplicate standard fbdev ioctls.
What is a reason for that?

> +int get_mode_index(int hres, int vres, int flag)
> +{
> +	DEBUG_MSG(KERN_INFO "get_mode_index!\n");
> +
> +	if (flag == 0) {
> +		if (hres == 480 && vres == 640) {
> +			resMode = VIA_RES_480X640;
> +			mode = "480x640";
> +		} else if (hres == 640 && vres == 480) {
> +			resMode = VIA_RES_640X480;
> +			mode = "640x480";
> +		} else if (hres == 800 && vres == 480) {
> +			resMode = VIA_RES_800X480;
> +			mode = "800x480";
> +		} else if (hres == 800 && vres == 600) {
> +			resMode = VIA_RES_800X600;
> +			mode = "800x600";
> +		} else if (hres == 1024 && vres == 768) {
> +			resMode = VIA_RES_1024X768;
> +			mode = "1024x768";
...

This is particularly ugly function. Some loop through a table is perhaps
better than 250 lines of such if statements, isn't it?

> +		if (!strncmp(this_opt, "mode=", 5)) {
> +			mode = kmalloc(strlen(this_opt + 4), GFP_KERNEL);
> +			strcpy(mode, this_opt + 5);
> +		} else if (!strncmp(this_opt, "mode1=", 6)) {
> +			mode1 = kmalloc(strlen(this_opt + 5), GFP_KERNEL);
> +			strcpy(mode1, this_opt + 6);
> +		} else if (!strncmp(this_opt, "bpp=", 4)) {
> +			via_fb_bpp = simple_strtoul(this_opt + 4, NULL, 0);
> +		} else if (!strncmp(this_opt, "bpp1=", 5)) {
> +			via_fb_bpp1 = simple_strtoul(this_opt + 5, NULL, 0);
> +		} else if (!strncmp(this_opt, "refresh=", 8)) {
> +			refresh = simple_strtoul(this_opt + 8, NULL, 0);
> +		} else if (!strncmp(this_opt, "refresh1=", 9)) {
> +			refresh1 = simple_strtoul(this_opt + 9, NULL, 0);

Most drivers accept default mode specification like 1024x768-16@60
(see Documentation/fb/modedb.txt). Is there a reason to have separate
bpp= and refresh= ?

-- 
Elen sila lumenn' omentielvo

Ondrej 'SanTiago' Zajicek (email: santiago@crfreenet.org)
OpenPGP encrypted e-mails preferred (KeyID 0x11DEADC3, wwwkeys.pgp.net)
"To err is human -- to blame it on a computer is even more so."

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
