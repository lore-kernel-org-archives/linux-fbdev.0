From: James Simmons <jsimmons@infradead.org>
Subject: Re: [PATCH] notify fbcon if framebuffer registered
Date: Tue, 2 Mar 2004 17:41:39 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0403021720240.18264-100000@phoenix.infradead.org>
References: <40447251.3050801@gmx.net>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AyE6G-0006Ji-EI
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 02 Mar 2004 09:54:36 -0800
Received: from phoenix.infradead.org ([213.86.99.234])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1AyDto-00052G-D7
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 02 Mar 2004 09:41:44 -0800
In-Reply-To: <40447251.3050801@gmx.net>
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
To: Pattrick Hueper <pattyh@gmx.net>
Cc: linux-fbdev-devel@lists.sourceforge.net


> I am helping a team at handhelds.org to port linux to the ipaq h2210, i 
> was trying to get the framebuffer to start when i came across the 
> problem, that our fb device is initialized after fb_console_init. 

Is your driver built as a module? That is the only way that could happen 
that I know of. The new behavior is that the fbdev device doesn't not 
automatically take over the console. You use the app con2fb to do that.
The reason was so developers could debug there drivers easily. Alot of 
times there is a bug in the xxfb_init code and you end up with a blank 
display. Very hard to work with. Also some fbdev drivers can work with 
vgacon. So you could run a fbdev app on vgacon!!! In this case you don't 
want the fbdev device changing the hardware. 
   Actually you don't really need fbcon for embedded devices except for 
debugging output. If your device is embedded and without fbcon you can 
call fb_set_var before you register the device.

> I saw 
> that sometime between 2.6.1 and 2.6.3 you added a notifier_chain for 
> suspend/resume, so i added a new event for newly registered 
> framebuffers, this helps my ipaq fb to start, when the kernel starts.
> 
> Here is the patch i came up with: (it is a patch based on the 
> handhelds.org kernel sources, i hope that it still fits your sources. 
> Sorry!)
>
> I basically added a new event in fb.h and notified the event in 
> register_framebuffer. I had to move the fb_register_client call in 
> fb_console_init up, before "if (!num_registered_fb) because it otherwise 
> did not get called in my case. in fbcon_event_notify() i just call 
> take_over_console, which is what fb_console_init would have done, had 
> the framebuffer been registered before, if i understood it correctly.

This patch could come in handy for hotplug events :-) We would also need a 
unregister event. The only thing is you have to do some filtering here.
Say you have a multi-head system. If question you have is do you want to 
register this device to the fbcon system. The second question is to which 
VCs do you map this device. In fbcon you have a map for that. I have to 
think about how to do that. Your patch is a great start. I just need to 
go over the different possible cases we can have.
 
> Regards, Patty
> 
> Index: drivers/video/fbmem.c
> ===================================================================
> RCS file: /cvs/linux/kernel26/drivers/video/fbmem.c,v
> retrieving revision 1.13
> diff -u -b -r1.13 fbmem.c
> --- drivers/video/fbmem.c	29 Feb 2004 01:49:03 -0000	1.13
> +++ drivers/video/fbmem.c	1 Mar 2004 13:27:57 -0000
> @@ -167,6 +167,7 @@
>   extern int tcx_setup(char*);
>   extern int leo_init(void);
>   extern int leo_setup(char*);
> +extern int mq1100fb_init(void);
>   extern int kyrofb_init(void);
>   extern int kyrofb_setup(char*);
> 
> @@ -385,6 +386,9 @@
>   #ifdef CONFIG_FB_VOODOO1
>   	{ "sstfb", sstfb_init, sstfb_setup },
>   #endif
> +#ifdef CONFIG_FB_MQ1100
> +	{ "mq1100fb", mq1100fb_init, NULL },
> +#endif
>   #ifdef CONFIG_FB_KYRO
>   	{ "kyrofb", kyrofb_init, kyrofb_setup },
>   #endif
> @@ -1303,6 +1307,9 @@
> 
>   	devfs_mk_cdev(MKDEV(FB_MAJOR, i),
>   			S_IFCHR | S_IRUGO | S_IWUGO, "fb/%d", i);
> +
> +    notifier_call_chain (&fb_notifier_list, FB_EVENT_FB_REGISTERED, 
> fb_info);
> +
>   	return 0;
>   }
> 
> Index: drivers/video/console/fbcon.c
> ===================================================================
> RCS file: /cvs/linux/kernel26/drivers/video/console/fbcon.c,v
> retrieving revision 1.3
> diff -u -b -r1.3 fbcon.c
> --- drivers/video/console/fbcon.c	29 Feb 2004 01:49:04 -0000	1.3
> +++ drivers/video/console/fbcon.c	1 Mar 2004 13:27:57 -0000
> @@ -2295,6 +2295,10 @@
>   	case FB_EVENT_RESUME:
>   		fbcon_resumed(info);
>   		break;
> +    case FB_EVENT_FB_REGISTERED:
> +        /* a framebuffer was registered, try to take over the console */
> +        take_over_console(&fb_con, first_fb_vc, last_fb_vc, 
> fbcon_is_default);
> +        break;
>   	}
>   	return 0;
>   }
> @@ -2333,16 +2337,15 @@
> 
>   int __init fb_console_init(void)
>   {
> -	if (!num_registered_fb)
> -		return -ENODEV;
> -	take_over_console(&fb_con, first_fb_vc, last_fb_vc, fbcon_is_default);
>   	acquire_console_sem();
>   	if (!fbcon_event_notifier_registered) {
>   		fb_register_client(&fbcon_event_notifer);
>   		fbcon_event_notifier_registered = 1;
>   	}
>   	release_console_sem();
> -
> +    if (!num_registered_fb)
> +        return -ENODEV;
> +    take_over_console(&fb_con, first_fb_vc, last_fb_vc, fbcon_is_default);
>   	return 0;
>   }
> 
> Index: include/linux/fb.h
> ===================================================================
> RCS file: /cvs/linux/kernel26/include/linux/fb.h,v
> retrieving revision 1.2
> diff -u -b -r1.2 fb.h
> --- include/linux/fb.h	29 Feb 2004 01:49:22 -0000	1.2
> +++ include/linux/fb.h	1 Mar 2004 13:27:58 -0000
> @@ -353,6 +353,8 @@
>    *	if you own it
>    */
>   #define FB_EVENT_RESUME			0x03
> +/*	A new framebuffer registered */
> +#define FB_EVENT_FB_REGISTERED	0x04
> 
>   extern int fb_register_client(struct notifier_block *nb);
>   extern int fb_unregister_client(struct notifier_block *nb);
> 
> 
> -------------------------------------------------------
> SF.Net is sponsored by: Speed Start Your Linux Apps Now.
> Build and deploy apps & Web services for Linux with
> a free DVD software kit from IBM. Click Now!
> http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
> _______________________________________________
> Linux-fbdev-devel mailing list
> Linux-fbdev-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel
> 



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
