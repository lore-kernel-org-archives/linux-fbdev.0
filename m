From: Martin Hostettler <textshell@uchuujin.de>
Date: Tue, 29 Sep 2020 10:52:03 +0000
Subject: Re: [PATCH] vt_ioctl: make VT_RESIZEX behave like VT_RESIZE
Message-Id: <20200929105203.GG24673@neutronstar.dyndns.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <000000000000226d3f05b02dd607@google.com>
 <bbcef674-4ac6-c933-b55d-8961ada97f4c@i-love.sakura.ne.jp>
 <47907f77-b14b-b433-45c6-a315193f0c1a@i-love.sakura.ne.jp>
 <494395bc-a7dd-fdb1-8196-a236a266ef54@i-love.sakura.ne.jp>
 <20200927092701.GA1037755@PWN>
 <4933b81b-9b1a-355b-df0e-9b31e8280ab9@i-love.sakura.ne.jp>
 <20200928175956.GF24673@neutronstar.dyndns.org>
 <100dfd3f-3415-80ae-a6cf-30d15f7ca49f@i-love.sakura.ne.jp>
In-Reply-To: <100dfd3f-3415-80ae-a6cf-30d15f7ca49f@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: syzbot <syzbot+b308f5fd049fbbc6e74f@syzkaller.appspotmail.com>, linux-fbdev@vger.kernel.org, George Kennedy <george.kennedy@oracle.com>, b.zolnierkie@samsung.com, gregkh@linuxfoundation.org, deller@gmx.de, syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Martin Hostettler <textshell@uchuujin.de>, Linus Torvalds <torvalds@linux-foundation.org>, daniel.vetter@ffwll.ch, jirislaby@kernel.org, Peilin Ye <yepeilin.cs@gmail.com>

On Tue, Sep 29, 2020 at 10:12:46AM +0900, Tetsuo Handa wrote:
> On 2020/09/29 2:59, Martin Hostettler wrote:
> > On Sun, Sep 27, 2020 at 08:46:30PM +0900, Tetsuo Handa wrote:
> >> VT_RESIZEX was introduced in Linux 1.3.3, but it is unclear that what
> >> comes to the "+ more" part, and I couldn't find a user of VT_RESIZEX.
> >>
> > 
> > It seems this is/was used by "svgatextmode" which seems to be at
> > http://www.ibiblio.org/pub/Linux/utils/console/
> > 
> > Not sure if that kind of software still has a chance to work nowadays.
> > 
> 
> Thanks for the information.
> 
> It seems that v.v_vlin = curr_textmode->VDisplay / (MOFLG_ISSET(curr_textmode, ATTR_DOUBLESCAN) ? 2 : 1)
> and v.v_clin = curr_textmode->FontHeight . Thus, v.v_clin is font's height and seems to be non-zero.
> But according to https://bugs.gentoo.org/19485 , people are using kernel framebuffer instead.
> 

Yes, this seems to be from pre framebuffer times.

Back in the days "svga" was the wording you got for "pokes svga card
hardware registers from userspace drivers". And textmode means font
rendering is done via (fixed function in those times) hardware scanout
engine. Of course having only to update 2 bytes per character was a huge
saving early on. Likely this is also before vesa VBE was reliable.

So i guess the point where this all starts going wrong allowing the X parts
of the api to be combined with FB based rendering at all? Sounds the only
user didn't use that combination and so it was never tested?

Then again, this all relates to hardware from 20 years ago...

 - Martin Hostettler
