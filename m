From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Mon, 13 Sep 2010 07:17:04 +0000
Subject: locking inconsistency, when calling fb_ops::fb_release()
Message-Id: <Pine.LNX.4.64.1009130854280.24398@axis700.grange>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi

I do not know, whether this can be a problem for any existing driver, but 
such an inconsistency seems like a bad idea to me anyway. The struct 
fb_ops::fb_release() method can be called in following ways:

fbmem.c::fb_release() under the info->lock mutex (file.close("/dev/fbX") 
							operation)
fbcon.c::con2fb_release_oldinfo() under console semaphore
fbcon.c::fbcon_exit() from
	fbcon_deinit() from
		vt.c::vc_deallocate() under console semaphore (has 
			WARN_CONSOLE_UNLOCKED())
		bind_con_driver() under console semaphore
	fb_console_exit() under console semaphore

I.e., it can be either called within an acquire_console_sem() / 
release_console_sem() block, or within a mutex_lock(&info->lock) / 
mutex_unlock(&info->lock) block, which looks inconsistent to me.

The problem, this is causing me is, that I'd like to call the framebuffer 
notifier chain from my driver's fb_release() method. That chain has to be 
called under a console semaphore. So, I either have to rely on the caller 
holding the semaphore, or take it myself, none of which is possible due to 
the above inconsistency. Same holds for the info->lock mutex - you cannot 
rely on it being help and you cannot take it yourself... I believe, the 
same holds for fb_ops::fb_open(). Is this a featuer or a bug? If the 
latter - how best to fix it? If the former - how do I solve my problem?

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
