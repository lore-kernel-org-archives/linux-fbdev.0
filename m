From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Date: Mon, 14 Sep 2020 23:09:45 +0000
Subject: Re: KASAN: slab-out-of-bounds Read in fbcon_scrolldelta
Message-Id: <6488cad8-cb86-90c2-c696-e498b7b5836e@I-love.SAKURA.ne.jp>
List-Id: <linux-fbdev.vger.kernel.org>
References: <0000000000002e90d405af42bd38@google.com>
In-Reply-To: <0000000000002e90d405af42bd38@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: syzbot <syzbot+9381e25e04a6ea4f2a20@syzkaller.appspotmail.com>, syzkaller-bugs@googlegroups.com
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org

fbcon_scrolldelta() was removed by commit 50145474f6ef4a9c ("fbcon: remove soft scrollback code").

#syz fix: fbcon: remove soft scrollback code
