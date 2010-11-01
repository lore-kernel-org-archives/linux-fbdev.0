From: James Simmons <jsimmons@infradead.org>
Date: Mon, 01 Nov 2010 16:54:20 +0000
Subject: Re: fbcon: fbcon_fb_unbind() mixing up vc/fb indexes?
Message-Id: <alpine.LFD.2.00.1011011611110.24330@casper.infradead.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org


> Hi James,
> 
> What's your opinion regarding the code I marked in below quoted
> fbcon.c snipplet?
> 
> This looks wrong, setting 'new_idx' to 'i', I would rather see it set to
> con2fb_map[i] instead as it's used as index into registered_fb[] by
> set_con2fb_map(), 'i' itself being used as vc index!

Sorry I was on vacation but I'm back now.  

> drivers/video/console/fbcon.c:
> 2991 static int fbcon_fb_unbind(int idx)
> 2992 {
> 2993         int i, new_idx = -1, ret = 0;
> 2994
> 2995         if (!fbcon_has_console_bind)
> 2996                 return 0;
> 2997
> 2998         for (i = first_fb_vc; i <= last_fb_vc; i++) {
> 2999                 if (con2fb_map[i] != idx &&
> 3000                     con2fb_map[i] != -1) {
> 3001                         new_idx = i;
>                              ^^^^^^^^^^^
> 3002                         break;
> 3003                 }
> 3004         }
> 3005
> 3006         if (new_idx != -1) {
> 3007                 for (i = first_fb_vc; i <= last_fb_vc; i++) {
> 3008                         if (con2fb_map[i] = idx)
> 3009                                 set_con2fb_map(i, new_idx, 0);
>                                                        ^^^^^^^
> 3010                 }
> 3011         } else
> 3012                 ret = fbcon_unbind();
> 3013
> 3014         return ret;
> 3015 }

I personally don't like the any of the code. Its a mess. Look at how 
similar fbcon_fb_unregistered and fbcon_fb_unbind are. Plus both are 
called for the same event, the lost of a fbdev device. I just started to 
clean that mess up but have much more to go. My tree is currently broken 
tho for fbcon currently.

