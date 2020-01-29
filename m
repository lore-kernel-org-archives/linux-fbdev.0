From: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Date: Wed, 29 Jan 2020 17:34:57 +0000
Subject: Re: KASAN: slab-out-of-bounds Write in vgacon_scroll
Message-Id: <0f852429-c69d-1520-2db5-6f2370799566@i-love.sakura.ne.jp>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CAA=061EoW8AmjUrBLsJy5nTDz-1jeArLeB+z6HJuyZud0zZXug@mail.gmail.com>
 <CGME20200128124918eucas1p1f0ce2b2b7b33a5d63d33f876ef30f454@eucas1p1.samsung.com>
 <20200128124912.chttagasucdpydhk@pathway.suse.cz>
 <4ab69855-6112-52f4-bee2-3358664d0c20@samsung.com>
 <20200129141517.GA13721@jagdpanzerIV.localdomain>
 <20200129141759.GB13721@jagdpanzerIV.localdomain>
 <20200129143754.GA15445@jagdpanzerIV.localdomain>
 <CACT4Y+bavHG8esK3jsv0V40+9+mUOFaSdOD1+prpw6L4Wv816g@mail.gmail.com>
 <CACT4Y+arS5GsyUa0A0s51OAWj7eJohZsCoY-7cuoU0HVsyeZ6Q@mail.gmail.com>
In-Reply-To: <CACT4Y+arS5GsyUa0A0s51OAWj7eJohZsCoY-7cuoU0HVsyeZ6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dmitry Vyukov <dvyukov@google.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Petr Mladek <pmladek@suse.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, LKML <linux-kernel@vger.kernel.org>, anon anon <742991625abc@gmail.com>, syzkaller <syzkaller@googlegroups.com>, DRI <dri-devel@lists.freedesktop.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>

A fbcon bug found that allocation size was wrong.
  https://groups.google.com/d/msg/syzkaller-bugs/TVGAFDeUKJo/uchTlvbFAQAJ
You can try adding printk() for examining values because you have reproducers.
