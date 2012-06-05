From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Tue, 05 Jun 2012 14:10:14 +0000
Subject: Re: Circular locking (and possible deadlock), when exiting from mplayer -vo fbdev2
Message-Id: <20120605141014.GB4297@mwanda>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20120604173702.GZ16584@smp.if.uj.edu.pl>
In-Reply-To: <20120604173702.GZ16584@smp.if.uj.edu.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

My patch can't cause this.  I'd be surprised if my patch has any
effect beyond silencing a static checker warning, honestly.

I'm not sure this is a new bug.

The problem is we hold ->mmap_sem when we call fb_release() which
takes the info->lock.

We take the info->lock in do_fb_ioctl() before we call fb_set_var()
which calls drm_fb_helper_set_par() which takes the
mode_config.mutex.

In drm_mode_getresources() we take the mode_config.mutex() and call
put_user() which takes the ->mmap_sem.

So on one CPU we are holding the ->mmap_sem and want the info->lock.
On another CPU we are holding the info->lock and want the
config.mutex.  On the other CPU we hold the config.mutex and want
the ->mmap_sem.

Deadlock.

I'm not sure how to make this work with just two CPUs...  Or how to
fix it.  But I'm going to disclaim all responsibility and hope the
fbdev people can take a look.  ;)

regards,
dan carpenter

