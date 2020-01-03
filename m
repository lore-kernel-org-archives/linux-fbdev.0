From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Fri, 03 Jan 2020 13:07:16 +0000
Subject: Re: [PATCH] fbdev: potential information leak in do_fb_ioctl()
Message-Id: <fd4e6f01-074b-def7-7ffb-9a9197930c31@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20191029182320.GA17569@mwanda>
 <CGME20191029190229epcas3p4e9b24bd8cde962681ef3dc4644ed2c2e@epcas3p4.samsung.com>
 <87zhhjjryk.fsf@x220.int.ebiederm.org>
In-Reply-To: <87zhhjjryk.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Eric W. Biederman" <ebiederm@xmission.com>, Joe Perches <joe@perches.com>
Cc: linux-fbdev@vger.kernel.org, security@kernel.org, Kees Cook <keescook@chromium.org>, kernel-janitors@vger.kernel.org, Daniel Vetter <daniel.vetter@ffwll.ch>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Julia Lawall <Julia.Lawall@lip6.fr>, Gerd Hoffmann <kraxel@redhat.com>, Sam Ravnborg <sam@ravnborg.org>, Peter Rosin <peda@axentia.se>, Dan Carpenter <dan.carpenter@oracle.com>, Andrea Righi <righi.andrea@gmail.com>


On 10/29/19 8:02 PM, Eric W. Biederman wrote:
> Dan Carpenter <dan.carpenter@oracle.com> writes:
> 
>> The "fix" struct has a 2 byte hole after ->ywrapstep and the
>> "fix = info->fix;" assignment doesn't necessarily clear it.  It depends
>> on the compiler.
>>
>> Fixes: 1f5e31d7e55a ("fbmem: don't call copy_from/to_user() with mutex held")
>> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>> ---
>> I have 13 more similar places to patch...  I'm not totally sure I
>> understand all the issues involved.
> 
> What I have done in a similar situation with struct siginfo, is that
> where the structure first appears I have initialized it with memset,
> and then field by field.
> 
> Then when the structure is copied I copy the structure with memcpy.
> 
> That ensures all of the bytes in the original structure are initialized
> and that all of the bytes are copied.
> 
> The goal is to avoid memory that has values of the previous users of
> that memory region from leaking to userspace.  Which depending on who
> the previous user of that memory region is could tell userspace
> information about what the kernel is doing that it should not be allowed
> to find out.
> 
> I tried to trace through where "info" and thus presumably "info->fix" is
> coming from and only made it as far as  register_framebuffer.  Given

"info" (and thus "info->fix") comes from framebuffer_alloc() (which is
called by fbdev device drivers prior to registering "info" with
register_framebuffer()). framebuffer_alloc() does kzalloc() on "info".

Therefore shouldn't memcpy() (as suggested by Jeo Perches) be enough?

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> that I suspect a local memset, and then a field by field copy right
> before copy_to_user might be a sound solution.  But ick.  That is a lot
> of fields to copy.
> 
> 
> Eric
> 
> 
> 
>>  drivers/video/fbdev/core/fbmem.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
>> index 6f6fc785b545..b4ce6a28aed9 100644
>> --- a/drivers/video/fbdev/core/fbmem.c
>> +++ b/drivers/video/fbdev/core/fbmem.c
>> @@ -1109,6 +1109,7 @@ static long do_fb_ioctl(struct fb_info *info, unsigned int cmd,
>>  			ret = -EFAULT;
>>  		break;
>>  	case FBIOGET_FSCREENINFO:
>> +		memset(&fix, 0, sizeof(fix));
>>  		lock_fb_info(info);
>>  		fix = info->fix;
>>  		if (info->flags & FBINFO_HIDE_SMEM_START)
