From: Martin Hostettler <textshell@uchuujin.de>
Date: Mon, 28 Sep 2020 17:59:56 +0000
Subject: Re: [PATCH] vt_ioctl: make VT_RESIZEX behave like VT_RESIZE
Message-Id: <20200928175956.GF24673@neutronstar.dyndns.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <000000000000226d3f05b02dd607@google.com>
 <bbcef674-4ac6-c933-b55d-8961ada97f4c@i-love.sakura.ne.jp>
 <47907f77-b14b-b433-45c6-a315193f0c1a@i-love.sakura.ne.jp>
 <494395bc-a7dd-fdb1-8196-a236a266ef54@i-love.sakura.ne.jp>
 <20200927092701.GA1037755@PWN>
 <4933b81b-9b1a-355b-df0e-9b31e8280ab9@i-love.sakura.ne.jp>
In-Reply-To: <4933b81b-9b1a-355b-df0e-9b31e8280ab9@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: syzbot <syzbot+b308f5fd049fbbc6e74f@syzkaller.appspotmail.com>, linux-fbdev@vger.kernel.org, George Kennedy <george.kennedy@oracle.com>, b.zolnierkie@samsung.com, daniel.vetter@ffwll.ch, deller@gmx.de, syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Linus Torvalds <torvalds@linux-foundation.org>, gregkh@linuxfoundation.org, jirislaby@kernel.org, Peilin Ye <yepeilin.cs@gmail.com>

On Sun, Sep 27, 2020 at 08:46:30PM +0900, Tetsuo Handa wrote:
> VT_RESIZEX was introduced in Linux 1.3.3, but it is unclear that what
> comes to the "+ more" part, and I couldn't find a user of VT_RESIZEX.
> 

It seems this is/was used by "svgatextmode" which seems to be at
http://www.ibiblio.org/pub/Linux/utils/console/

Not sure if that kind of software still has a chance to work nowadays.

 - Martin Hostettler
