From: Rob Clark <robdclark@gmail.com>
Date: Mon, 13 May 2013 13:48:25 +0000
Subject: Re: Introduce a new helper framework for buffer synchronization
Message-Id: <CAF6AEGvWazezZdLDn5=H8wNQdQSWV=EmqE1a4wh7QwrT_h6vKQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CAAQKjZNNw4qddo6bE5OY_CahrqDtqkxdO7Pm9RCguXyj9F4cMQ@mail.gmail.com>
	<51909DB4.2060208@canonical.com>
	<025201ce4fbb$363d0390$a2b70ab0$%dae@samsung.com>
	<5190B7D8.3010803@canonical.com>
	<027a01ce4fcc$5e7c7320$1b755960$%dae@samsung.com>
	<5190D14A.7050904@canonical.com>
	<028a01ce4fd4$5ec6f000$1c54d000$%dae@samsung.com>
In-Reply-To: <028a01ce4fd4$5ec6f000$1c54d000$%dae@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Inki Dae <inki.dae@samsung.com>
Cc: Maarten Lankhorst <maarten.lankhorst@canonical.com>, Daniel Vetter <daniel@ffwll.ch>, DRI mailing list <dri-devel@lists.freedesktop.org>, linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org, linux-fbdev <linux-fbdev@vger.kernel.org>, Kyungmin Park <kyungmin.park@samsung.com>, "myungjoo.ham" <myungjoo.ham@samsung.com>, YoungJun Cho <yj44.cho@samsung.com>

On Mon, May 13, 2013 at 8:21 AM, Inki Dae <inki.dae@samsung.com> wrote:
>
>> In that case you still wouldn't give userspace control over the fences. I
>> don't see any way that can end well.
>> What if userspace never signals? What if userspace gets killed by oom
>> killer. Who keeps track of that?
>>
>
> In all cases, all kernel resources to user fence will be released by kernel
> once the fence is timed out: never signaling and process killing by oom
> killer makes the fence timed out. And if we use mmap mechanism you mentioned
> before, I think user resource could also be freed properly.


I tend to agree w/ Maarten here.. there is no good reason for
userspace to be *signaling* fences.  The exception might be some blob
gpu drivers which don't have enough knowledge in the kernel to figure
out what to do.  (In which case you can add driver private ioctls for
that.. still not the right thing to do but at least you don't make a
public API out of it.)

BR,
-R
