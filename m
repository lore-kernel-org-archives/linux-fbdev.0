From: James Simmons <jsimmons@infradead.org>
Subject: Re: Re: Current discussion about the future of
 free software graphics
Date: Wed, 12 May 2004 17:45:20 +0100 (BST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0405121705550.30331-100000@phoenix.infradead.org>
References: <20040512033045.16034.qmail@web14921.mail.yahoo.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
In-Reply-To: <20040512033045.16034.qmail@web14921.mail.yahoo.com>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jon Smirl <jonsmirl@yahoo.com>
Cc: Ian Romanick <idr@us.ibm.com>, linux-fbdev-devel@lists.sourceforge.net, dri-devel@lists.sourceforge.net


> What this is saying is that very early in the boot process the graphics driver
> will be initialized. At this point it will generate a hotplug event. This event
> will be handled by an app and lib that live in initramfs.  This is not saying
> that mode-setting will be delayed until normal user space starts. The initial
> hotplug event occurs very early in the boot process, almost as early as the
> current device driver based code runs. 

  Right now alot of application including commerical depend on setting the 
video mode via /dev/fb. I like to have /sys do that in the future. If that 
goes away it will break alot of software. Hurt alot of companies. 
  Now consider these apps in the future and how with the above will work.

app   -> /dev/fb to change mode 
      -> context switch to kernel 
      -> send hot plug event 
      -> userland app grabs event 
      -> loads library to execute the code if it hasn't done so already 
      -> set mode in userland library 
      -> via a ioctl creates a event packet to send back to kernel to let 
         them know it worked. Also we need to send back detail data on the 
         new mode for the app. We might of not got the exact mode we wanted
	 so we send back the closes thing we wanted.
      -> context switch to kernel 
      -> store new data kernel side.
      -> call library to grab new resolution data for a app.

Now you could say we could remove the fbdev interface completely and move 
to the library. But then you have the below case.
      	
Now consider the case of a VC switch where two VC's are at different 
resolutions. Say one is at 80x30 and the other is 128x48

You press   Alt-Fx -> VT code call console_callback  
                   -> send a hotplug event to userland 
                   -> a userland app gets the event
	           -> loads the userland library  
                   -> executes the code to set the video mode 
                   -> send back a ok from userland. Again we need to send
		      a packet back to kernel to let them know if it was 
		      successful. Also we need to let them know the exact 
		      details of the mode we actually got.
		   -> context switch to kernel
		   -> write new data to struct vc_data. 	

This is a really expensive solution. 

I understand you point of the mode switching code being huge. The embedded 
guys require really lean kernels. I have no problem making the mode switching
code modular. I just want to avoid the above overhead.

> This is very similar to the way udev works. Udev is a user space replacement for
> devfs. Instead of having a /dev with 40,000 devices in it, udev builds one on
> the fly at each boot with exactly your devices in it. Now that I have used udev
> instead of devfs I have to agree that it is a much better solution. In fact the
> udev app will run before the mode-setting app since it's the udev app that
> creates the devices in /dev now by detecting additions to sysfs. udev FAQ:
> http://www.kernel.org/pub/linux/utils/kernel/hotplug/udev-FAQ
> We all know Linux is non-functional without a /dev directory, and now /dev is
> being build in user space.

I also like udev much more than devfs. The difference is that userland 
doesn't modify device nodes. You create them and you remove them. Very 
basic. Fbdev is a bit more complex than that. You can see that in the 
above arguments.

> Andrew, akpm, has also explained to me that even the current fbdev is not 
> really active at boot. Instead those initial printk's are queued until 
> the fbdev driver initialized and prints them.

That is true and I consider it a bug. The true is that the fbdev layer 
could be started right away for most of the drivers. Most fbdev devices 
are embedded devices which don't need a bus initialized first. Even on 
intel you could have the vga16 driver started at the exact same time as
vgacon. The limitation is only for devices like pci. Personally I like to 
see fbcon start at the same time as vgacon and the rest and if the 
graphics card is pci then when it initializes then start drawing the data.




-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to 
deliver higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
