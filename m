From: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Date: Thu, 30 Jul 2020 11:27:26 +0000
Subject: Re: [PATCH] fbmem: pull fbcon_update_vcs() out of fb_set_var()
Message-Id: <d4c97785-467a-6e04-b8bb-c8aa4177882a@i-love.sakura.ne.jp>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1596000620-4075-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <CAKMK7uHeteS2+rKrZKrAM+zQO==hAX0XaVc9JfHPsdLTCtzKOw@mail.gmail.com>
 <a3bb6544-064d-54a1-1215-d92188cb4209@i-love.sakura.ne.jp>
 <CAKMK7uGTL02SHbEazu5YEnEncO6c-+P6DXt1GWSVQ28enqLx2g@mail.gmail.com>
In-Reply-To: <CAKMK7uGTL02SHbEazu5YEnEncO6c-+P6DXt1GWSVQ28enqLx2g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Daniel Vetter <daniel@ffwll.ch>
Cc: Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, Jiri Slaby <jslaby@suse.com>, syzbot <syzbot+c37a14770d51a085a520@syzkaller.appspotmail.com>

On 2020/07/30 20:16, Daniel Vetter wrote:
> Patch looks good, except ... does this compile? fbcon_update_vcs is
> defined in fbcon.h, and that doesn't seem to be included here ...
> Maybe what we want is an fb_set_var_ioctl in fbmem.c so that the fbcon
> interaction is a bit better hidden (but that's a bikeshed, feel free
> to ignore). Also I have no idea what trickery you need to compile-test
> ps3fb, that's why I'm asking :-)

Right. I didn't prepare environment for compiling powerpc kernel.
Kernel test robot found it and I already posted V2 patch as
https://lkml.kernel.org/r/075b7e37-3278-cd7d-31ab-c5073cfa8e92@i-love.sakura.ne.jp .
