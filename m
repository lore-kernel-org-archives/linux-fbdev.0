From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Tue, 05 Jun 2012 18:37:59 +0000
Subject: Re: Circular locking (and possible deadlock), when exiting from mplayer -vo fbdev2
Message-Id: <4FCE5207.6020501@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20120604173702.GZ16584@smp.if.uj.edu.pl>
In-Reply-To: <20120604173702.GZ16584@smp.if.uj.edu.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi,

On 06/05/2012 05:18 PM, Witold Baryluk wrote:
> On 06-05 17:10, Dan Carpenter wrote:
>> My patch can't cause this.  I'd be surprised if my patch has any
>> effect beyond silencing a static checker warning, honestly.
>>
> 
> Yes, you are right. Your patch cannot be cause of it. Sorry for
> confusion.
> 
>> I'm not sure this is a new bug.
>>
> 
> Indeed, last time I used mplayer -vo fbdev2 was years ago, so bug could
> appear anywhere in this period, or it is a more a matter of my
> configuration.
> 
>> The problem is we hold ->mmap_sem when we call fb_release() which
>> takes the info->lock.
>>
>> We take the info->lock in do_fb_ioctl() before we call fb_set_var()
>> which calls drm_fb_helper_set_par() which takes the
>> mode_config.mutex.
>>
>> In drm_mode_getresources() we take the mode_config.mutex() and call
>> put_user() which takes the ->mmap_sem.
>>
>> So on one CPU we are holding the ->mmap_sem and want the info->lock.
>> On another CPU we are holding the info->lock and want the
>> config.mutex.  On the other CPU we hold the config.mutex and want
>> the ->mmap_sem.
>>
>> Deadlock.
> 
> Temporary solution would be to break a cycle, and for example take
> info->lock first on first processor before taking ->mmap_sem and calling
> fb_release - it is just fb release, so performance doesn't matter so
> much. Other possibility is to protect this code paths by separate common
> lock, but it will increase memory and make it slower probably in this
> function and other ones. I do not know which subsystems use
> drm_mode_getresources, and if this is important performance wise.
> 
> There is probably other possibilities, but only fbdev people can tell
> which is best.

That's not true. This is the wrong mailing list as this happens only
with DRM-based framebuffers (in drivers/gpu/drm/ not drivers/video/) and
therefore you should resend your initial mail to
dri-devel@lists.freedesktop.org.


Best regards,

Florian Tobias Schandinat

>>
>> I'm not sure how to make this work with just two CPUs...  Or how to
>> fix it.  But I'm going to disclaim all responsibility and hope the
>> fbdev people can take a look.  ;)
>>
>> regards,
>> dan carpenter
>>
> 
> 
> thanks for analysis,
> 
> Regards,
> Witek
> 

