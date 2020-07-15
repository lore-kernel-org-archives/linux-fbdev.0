From: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Date: Wed, 15 Jul 2020 11:17:44 +0000
Subject: Re: [PATCH v2] fbdev: Detect integer underflow at "struct fbcon_ops"->clear_margins.
Message-Id: <9e6eac10-c5c3-f518-36cc-9ea32fb5d7fe@i-love.sakura.ne.jp>
List-Id: <linux-fbdev.vger.kernel.org>
References: <adff5d10-fe35-62d4-74c5-182958c5ada7@i-love.sakura.ne.jp>
 <20200715015102.3814-1-penguin-kernel@I-love.SAKURA.ne.jp>
 <20200715094836.GD2571@kadam>
In-Reply-To: <20200715094836.GD2571@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, syzbot <syzbot+e5fd3e65515b48c02a30@syzkaller.appspotmail.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, George Kennedy <george.kennedy@oracle.com>, Jiri Slaby <jslaby@suse.com>, Dmitry Vyukov <dvyukov@google.com>

On 2020/07/15 18:48, Dan Carpenter wrote:
>> @@ -216,7 +216,7 @@ static void bit_clear_margins(struct vc_data *vc, struct fb_info *info,
>>  	region.color = color;
>>  	region.rop = ROP_COPY;
>>  
>> -	if (rw && !bottom_only) {
>> +	if ((int) rw > 0 && !bottom_only) {
>>  		region.dx = info->var.xoffset + rs;
>                             ^^^^^^^^^^^^^^^^^^^^^^
> 
> If you choose a very high positive "rw" then this addition can overflow.
> info->var.xoffset comes from the user and I don't think it's checked...

Well, I think it would be checked by "struct fb_ops"->check_var hook.
For example, vmw_fb_check_var() has

	if ((var->xoffset + var->xres) > par->max_width ||
	    (var->yoffset + var->yres) > par->max_height) {
		DRM_ERROR("Requested geom can not fit in framebuffer\n");
		return -EINVAL;
	}

check. Of course, there might be integer overflow in that check...
Having sanity check at caller of "struct fb_ops"->check_var might be nice.
