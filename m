From: Antonino Daplas <adaplas@pol.net>
Subject: Re: (no subject)
Date: 07 Feb 2003 05:55:07 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1044568401.1327.24.camel@localhost.localdomain>
References: <H9W89N$BB99264CDD033C15A1E92A4E2F5E0F29@libero.it>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from willow.compass.com.ph ([202.70.96.38])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18gtzl-0006YQ-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 06 Feb 2003 13:55:45 -0800
In-Reply-To: <H9W89N$BB99264CDD033C15A1E92A4E2F5E0F29@libero.it>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: "p.gilardetti@libero.it" <p.gilardetti@libero.it>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Thu, 2003-02-06 at 23:27, p.gilardetti@libero.it wrote:
> Hi,
> I have a problem when I change the bpp value, here is the code:
> 
> if( ioctl(fbd, FBIOGET_VSCREENINFO, &var_info) == -1){
> 	perror("\nError IOCTL 1");
> 	exit(0);
> }           
> printf("\n bpp: %d", var_info.bits_per_pixel);   // output is  bpp: 16
> var_info.bits_per_pixel = 24;
> if( ioctl(fbd, FBIOPUT_VSCREENINFO, &var_info) == -1){
> 	perror("\nError IOCTL 2");
> 	exit(0);
> }           
> The program exit with the following message error: 
> Error IOCTL 2: Invalid argument
> 
> How can I set the bpp value? Should I modify the file /etc/X11/XF86Config?

This will depend on the driver you are using.  vesafb does not support
any change to fb_var_screeninfo.  Other drivers, may not round off
invalid values:  ie bpp == 24 is not supported.  Also, increasing bpp
implies that more video memory will be required if var.xres_virtual and
var.yres_virtual remains the same.  So try to check xres, yres,
xres_virtual and yres_virtual against fix.smem_len and
var.bits_per_pixel.  

fix.smem_len >= (var.bits_per_pixel * var.xres_virtual)/8 *
var.yres_virtual.

/etc/X11/XF86Config has nothing to with fbdev.

> 
> I have another problem, I try to write a simple program that reads frame from framebuffer and then creates a Divx file of a few seconds.
> I map the framebuffer to a buffer, but the program crash with a segmentation fault:
>                                                  
>     screen_buffer = (char *)malloc(DIM_BUFFER * sizeof(char));

you don't need this step.

>     screen_buffer = (void *)mmap(0, DIM_BUFFER, PROT_READ, MAP_SHARED, fbd, 0);                 

check if mmap failed, (returns -1).
> 	
>     encFrame.image = (void *)screen_buffer;  <--- causes seg fault

memcpy(encFrame.image, screen_bufer, DIM_BUFFER) is a more appropriate
step to get the contents.

Tony




-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
